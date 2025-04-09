-- Get username
local username = os.getenv("USERNAME") or os.getenv("USER") or "Unknown"

-- Get date/time
local date = os.date("%Y-%m-%d %H:%M:%S")

-- Random log ID
math.randomseed(os.time())
local logEntry = math.random(1, 999999)

-- Create JSON payload
local jsonData = string.format([[
{
  "username": "Zenith_Bot",
  "embeds": [{
    "title": "Execution Log Entry",
    "color": 16753920,
    "fields": [
      {"name": "Username", "value": "%s", "inline": true},
      {"name": "Date Executed", "value": "%s", "inline": false},
      {"name": "Log Entry", "value": "%d", "inline": false}
    ]
  }]
}
]], username, date, logEntry)

-- Save JSON to a temporary file
local tmpFile = "tmp_payload.json"
local file = io.open(tmpFile, "w")
file:write(jsonData)
file:close()

-- Send to Discord webhook using curl
local webhook_url = "https://discord.com/api/webhooks/1359461379152678984/sI_yfYnTSRuCZuZehPgdfSHOHHjf30ZDOzRizZzRvDbupQ5lIgKgMWrqaGN5Vazzchjy"
os.execute(string.format([[curl -X POST -H "Content-Type: application/json" -d @%s %s]], tmpFile, webhook_url))

-- Clean up
os.remove(tmpFile)

print("✅ Webhook sent to Discord!")
