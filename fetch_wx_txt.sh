OUTFILE="./data/wx.$(date +%Y-%m-%d_%H:%M).json"

curl "https://aviationweather.gov/api/data/metar?ids=KMSP&format=json&hours=2&sep=true" -o "$OUTFILE"

s3cmd put "$OUTFILE" s3://weather
