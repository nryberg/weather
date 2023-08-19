curl  https://www.aviationweather.gov/cgi-bin/json/MetarJSON.php?bbox=-93.271681,44.839788,-93.141143,44.920127 > "/home/nick/Develop/GitHub/nryberg/weather/wx.$(date +%Y-%m-%d_%H:%M).json"

s3cmd put "/home/nick/Develop/GitHub/nryberg/weather/wx.$(date +%Y-%m-%d_%H:%M).json" s3://weather
