# 注意
* wsl環境で本リポジトリを利用すると権限の問題でansible.cfgが読み込まれないので`export ANSIBLE_CONFIG=$(pwd)`を実行する

# 初手やること(誰かひとり)
* サーバにsshして下記を確認
  * `/home/isucon/webapp`と`/home/isucon/env.sh`が存在することを確認する
  * アプリケーションのUnitファイルを確認する
    - `systemctl list-unit-files -t service|grep isu`
    - `systemctl cat isu*****`
* 手元の端末に本リポジトリをクローン
* インベントリに競技用サーバのすべてのipアドレス、ホスト名(ホスト名は使う人の頭文字kwとかkzとかigとかkiとかokとか)を記入
* `ansible-playbook -l [自分のサーバ] download.yml`を実行し、コードを持ってくる
* Unit名をdeply.ymlに記載する
* main.goのimportに`"github.com/kaz/pprotein/integration/echov4"`を追加し、main関数の最初のほうに`echov4.EnableDebugHandler(e)`を追加する(eはechoインスタンス)
* main.goのinitialize関数の最後に下記を追加
```
	go func() {
		if _, err := http.Get("http://127.0.0.1:9000/api/group/collect"); err != nil {
			log.Printf("failed to communicate with pprotein: %v", err)
		}
	}()
```
* webapp/goディレクトリで`go mod tidy`を実行する
* deploy.ymlがこのままで動きそうか確認する
* mainにpush

# 初期設定(全員が各々のサーバにやる)
* ローカルに本リポジトリをgit cloneする
* build.ymlを流してツールのインストールとかを行う
* deploy.ymlを流す

# 開発の仕方
* ベンチを実行する
* appサーバの:9000にwebアクセスし、pprotenの結果を確認し改善するところを考える
* mainが最新であることを確認したのちブランチを切ってコードを編集する
* deploy.ymlを流して反映させる
* benchを回して問題なければマージする
  - コンフリクトが発生したらリベースして解消する
* 以降繰り返し
