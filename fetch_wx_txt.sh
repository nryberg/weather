HDID="http://bigbox.tail37abc.ts.net:8000/status"
hdid_report() {
  curl -s -X POST "$HDID" \
    -H "Content-Type: application/json" \
    -d "{\"source\":\"weather-pipeline\",\"condition\":\"$1\",\"status\":\"$2\",\"message\":\"${3:-}\",\"hostname\":\"$(hostname)\"}" \
    > /dev/null
}

OUTFILE="./data/wx.$(date +%Y-%m-%d_%H:%M).json"

curl "https://aviationweather.gov/api/data/metar?ids=KMSP&format=json&hours=2&sep=true" -o "$OUTFILE"

if [ $? -eq 0 ]; then
  SIZE=$(du -sh "$OUTFILE" | cut -f1)
  hdid_report "fetch_metar" "ok" "Saved $OUTFILE ($SIZE)"
else
  hdid_report "fetch_metar" "error" "curl failed for KMSP fetch"
  exit 1
fi

s3cmd put "$OUTFILE" s3://weather

if [ $? -eq 0 ]; then
  hdid_report "upload_s3" "ok" "Uploaded $OUTFILE to s3://weather"
else
  hdid_report "upload_s3" "error" "s3cmd put failed for $OUTFILE"
fi
