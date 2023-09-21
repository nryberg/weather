create table wx_raw as
select
    *
from
    read_csv(
        'sample_wx.csv',
        header = True,
        columns = { 'Observed_Date' :VARCHAR,
        'Temp_Celsius' : INT,
        'Wind_Speed': INT,
        'Wind_Direction': VARCHAR,
        'Cover': VARCHAR,
        'Visibility' : INT },
        ignore_errors = True
    )
;