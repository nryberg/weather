.mode csv
select
    max(temp_fahrenheit) as max_temp
from
    wx_obs
group by
    observed_date
limit 10;