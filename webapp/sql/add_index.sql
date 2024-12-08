ALTER TABLE `ride_statuses` ADD INDEX idx_ride_statuses_ride_id(ride_id);
ALTER TABLE `chair_locations` ADD INDEX idx_chair_locations_chair_id(chair_id);
ALTER TABLE `rides` ADD INDEX idx_rides_chair_id(chair_id);
ALTER TABLE `chairs` ADD INDEX idx_chairs_access_token(access_token);
ALTER TABLE `rides` ADD INDEX idx_rides_user_id(user_id);
ALTER TABLE `coupons` ADD INDEX idx_coupons_used_by(used_by);
