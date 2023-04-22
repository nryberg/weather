--- drop table wx_obs;
create table wx_obs as
SELECT
    *,
    substr(observed_timestamp_s, 1, 10) as observed_date,
    substr(capture_timestamp_s, 1, 10) as captured_date,
    round((temp_celsius * 9 / 5)) + 32 as temp_fahrenheit,
    round((dewpoint_celsius * 9 / 5)) + 32 as dewpoint_fahrenheit,
from
    wx_load;