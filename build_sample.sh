mlr --csv cut -f Observed_Date,Temp_Celsius,Wind_Speed,Wind_Direction,Cover,Visibility ./weather_log.csv > sample_wx.csv

mlr --csv join -j Cover_Type -r Cover  -f ./cover_types.csv ./sample_wx.csv > sample_wx_cover.csv

mlr --csv --from ./sample_wx_cover.csv  put '$Date = substr($Observed_Date,0, 9)'   then cut -x -f Observed_Date > sample_wx_cover_date.csv
