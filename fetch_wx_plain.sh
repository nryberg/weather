curl https://aviationweather.gov/cgi-bin/data/metar.php?ids=KMSP&hours=2&order=id%2C-obs&sep=true > "/home/nick/Develop/GitHub/nryberg/weather/wx.$(date +%Y-%m-%d_%H:%M).txt"

s3cmd put "/home/nick/Develop/GitHub/nryberg/weather/wx.$(date +%Y-%m-%d_%H:%M).txt" s3://weather
