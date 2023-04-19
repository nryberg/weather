with fix_date as (
    SELECT
        substr(observed_timestamp_s, 1, 10) as obs_date,
        temp_celsius
    from
        wx_load
),
daily_max as (
    SELECT
        obs_date,
        max(temp_celsius) as max_temp_celsius
    FROm
        fix_date
    GROUP BY
        obs_date
)
SELECT
    obs_date,
    max_temp_celsius,
    round((max_temp_celsius * 9 / 5)) + 32 as max_temp_fahrenheit
from
    daily_max
LIMIT
    10