# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A weather data pipeline that fetches METAR aviation weather observations from aviationweather.gov (Minneapolis-St. Paul area), transforms them into structured records, stores them in DuckDB, and analyzes trends with SQL and Python.

## Commands

### Fetch Weather Data
```bash
./fetch_wx_txt.sh        # Fetch current METAR data → data/ directory
./fetch_wx_json.sh       # Fetch JSON format → raw_data/ + S3 upload
```

### Go: Build and Run the JSON Processor
```bash
cd process_wx_json
go build ./...
go run process_wx_json.go <input_directory>   # processes JSON files → CSV
```

No tests exist in this project.

### Miller (mlr) Data Transformation
```bash
./miller_process.sh      # JSON → CSV with field extraction and relabeling
./build_sample.sh        # Creates sample dataset joined with cover_types.csv
```

### DuckDB Queries
SQL files in the root follow a logical pipeline order:
1. `duck_create_tables.sql` — schema for `wx_load`
2. `duck_read_csv.sql` — load CSV into `wx_raw`
3. `duck_clean_values.sql` — creates `wx_obs` with derived fields (Fahrenheit, dates)
4. `duck_daily_stat.sql` / `duck_daily_max.sql` — aggregations
5. `duck_group_by_cover.sql` — group by cloud cover type

### Python Analysis
```bash
python dfg_example.py    # Requires pandas, matplotlib
```

## Architecture

**Data Flow:**
```
aviationweather.gov API
  → fetch_wx_*.sh (shell)
    → raw_data/ or data/ (JSON files)
      → process_wx_json.go (Go) OR miller_process.sh
        → CSV
          → DuckDB (duck_*.sql)
            → dfg_example.py (analysis + charts)
```

**Go processor** (`process_wx_json/process_wx_json.go`): Reads GeoJSON FeatureCollection files, extracts weather properties from `features[1]` (the observation record), and writes CSV with columns: `obsTime, Temp, Dewp, Wspd, Wdir, Cover, Visib, Fltcat, Altim, Slp, RawOb`.

**DuckDB database**: `weather.db` in the project root (excluded from git). The `wx_obs` table is the primary cleaned table with Fahrenheit conversions and parsed dates.

**Cloud cover lookup**: `cover_types.csv` maps cover codes (CLR, FEW, SCT, BKN, OVC) to coverage percentages — used in joins for analysis.

## How Did I Do Dashboard

Report pipeline status to `http://bigbox.tail37abc.ts.net:8000/status` (POST JSON). Use `source: "weather-pipeline"` and snake_case condition names like `fetch_metar`, `process_json`, `load_duckdb`.

```bash
HDID="http://bigbox.tail37abc.ts.net:8000/status"
hdid_report() {
  curl -s -X POST "$HDID" \
    -H "Content-Type: application/json" \
    -d "{\"source\":\"weather-pipeline\",\"condition\":\"$1\",\"status\":\"$2\",\"message\":\"${3:-}\"}" \
    > /dev/null
}
# hdid_report "fetch_metar" "ok" "Fetched 42 stations in 1.3s"
# hdid_report "load_duckdb" "error" "CSV missing — skipped"
```

Status values: `ok` / `warn` / `error`. Include counts and context in `message`. See `/Users/nick/Documents/GitHub/nryberg/How_did_I_do/SKILLS.md` for full reference.

## Key Notes

- Database files (`*.db`) and CSV/Parquet outputs are gitignored — only source code and scripts are tracked.
- The API endpoint changed (see commits); current endpoint is in `fetch_wx_txt.sh`.
- `raw_data/` contains timestamped JSON snapshots; `data/` contains processed outputs.
