curl "https://aviationweather.gov/api/data/metar?ids=KMSP&format=json&hours=2&sep=true" -o "/home/nick/Develop/GitHub/nryberg/weather/data/wx.$(date +%Y-%m-%d_%H:%M).json"

s3cmd put "/home/nick/Develop/GitHub/nryberg/weather/data/wx.$(date +%Y-%m-%d_%H:%M).json" s3://weather
