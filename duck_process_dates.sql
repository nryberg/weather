select
    observed_timestamp_s,
    strptime(observed_timestamp_s, '%Y-%m-%dT%H:%M:%SZ') as observed_ts
from
    wx_load
limit
    5;