---
name: How Did I Do Dashboard Reference
description: Endpoint, payload format, and bash/python helpers for reporting pipeline status to the How Did I Do dashboard
type: reference
---

## Endpoint

`POST http://bigbox.tail37abc.ts.net:8000/status`

## Payload

```json
{
  "source":    "your-app-name",
  "condition": "what-you-are-checking",
  "status":    "ok",
  "message":   "Optional detail",
  "hostname":  "$(hostname)"
}
```

`hostname` is optional but should always be included — use `$(hostname)` in bash, `socket.gethostname()` in Python.

## Bash helper (weather-pipeline)

```bash
HDID="http://bigbox.tail37abc.ts.net:8000/status"
hdid_report() {
  curl -s -X POST "$HDID" \
    -H "Content-Type: application/json" \
    -d "{\"source\":\"weather-pipeline\",\"condition\":\"$1\",\"status\":\"$2\",\"message\":\"${3:-}\",\"hostname\":\"$(hostname)\"}" \
    > /dev/null
}
```

## Python helper

```python
import socket, requests
HDID = "http://bigbox.tail37abc.ts.net:8000/status"

def report(condition, status, message="", source="weather-pipeline"):
    try:
        requests.post(HDID, json={
            "source": source, "condition": condition,
            "status": status, "message": message,
            "hostname": socket.gethostname(),
        }, timeout=5)
    except Exception:
        pass
```

## Status values

`ok` / `warn` / `error` — include counts and context in `message`.

Full reference: `/Users/nick/Documents/GitHub/nryberg/How_did_I_do/SKILLS.md`
