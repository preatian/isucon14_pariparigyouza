#!/usr/bin/env bash

# TODO 引数に {{ ansible_check_mode }} (多分 true / false)  を取って、check modeの時は変更しない にしたい

go fmt main.go

cp main.go main_update.go

declare -A insert_dict=(
  ["import"]="\"github.com/kaz/pprotein/integration/echov4\""
  ["main()"]="echov4.EnableDebugHandler(e)"
  ["func initializeHandler"]='
go func() {
  if _, err := http.Get("http://localhost:9000/api/group/collect"); err != nil {
	  log.Printf("failed to communicate with pprotein: %v", err)
  }
}()'
)

for insert_word in "${!insert_dict[@]}"
do
  # TODO bug: same word in other places
  if [ "$(grep -F ${insert_dict[${insert_word}]} main.go)" != "" ];then
    continue
  fi
  num=$(grep -nF "${insert_word}" main_update.go | cut -d: -f 1)

  insert=$(( num+1 ))
  sed -i -e "${insert}i ${insert_dict[${insert_word}]}" main_update.go

done

go fmt main_update.go

if [ "$(diff main.go main_update.go)" != "" ];then
  mv main_update.go main.go
  CHANGED=true
  exit 254
else
  rm main_update.go
fi

