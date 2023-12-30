curl "https://aviationweather.gov/cgi-bin/data/metar.php?ids=KMSP&hours=2&order=id%2C-obs&sep=true" -o "/home/nick/Develop/GitHub/nryberg/weather/data/wx.$(date +%Y-%m-%d_%H:%M).txt"

s3cmd put "/home/nick/Develop/GitHub/nryberg/weather/data/wx.$(date +%Y-%m-%d_%H:%M).txt" s3://weather
