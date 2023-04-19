CREATE TABLE wx_load (
    data_n STRING,
    station_n STRING,
    observed_timestamp_s STRING,
    temp_celsius DECIMAL(4, 2),
    dewpoint_celsius DECIMAL(4, 2),
    ind_speed INT,
    ind_direction INT,
    coverage STRING,
    visibility INT,
    metar_text STRING,
    capture_timestamp_s STRING
)