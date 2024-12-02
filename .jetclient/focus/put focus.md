```toml
name = 'put focus'
method = 'POST'
url = 'https://teknodipani.com/api/focus'
sortWeight = 2000000
id = 'f52e5358-20ee-4045-bf0e-fd4fe3e146f3'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '05e27511-5148-410c-80df-526939a0a9cb'

[body]
type = 'JSON'
raw = '{readings: "00:00:24", focus: "00:03:00"}'
```
