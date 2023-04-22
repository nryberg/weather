mlr --ijson --ocsv flatten then cut -r -f '^features.2.properties' ./wx.json > ./wx_properties.csv
mlr --csv rename -g -r '^features.2.properties.,' ./wx_properties.csv > wx_field_short.csv
mlr --csv cut -f data,id,site,obsTime,temp,dewp,wspd,wdir,cover,rawOb ./wx_field_short.csv > ./wx_select_fields.csv
mlr --csv label data_s,id_s,site_name,observation_Time,temp_celsius,dewpoint_celsius,wind_speed,wind_direction,cover,metar_text ./wx_select_fields.csv > wx_final.csv
mlr --c2n cat ./wx_final.csv >> wx.csv