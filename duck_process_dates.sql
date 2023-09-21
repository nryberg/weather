Select Cover,
    count(*) as count_rows,
    max(Wind_Speed) as max_wind_speed,
    FROM wx_raw
GROUP BY Cover;