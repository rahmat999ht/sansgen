```toml
name = 'add subcriber'
method = 'POST'
url = 'https://teknodipani.com/api/subscribe/current'
sortWeight = 2000000
id = 'e26a004a-6793-4a78-beb9-b8316033427a'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '81bc451c-dcaf-476c-8e0b-079521e6e604'

[body]
type = 'JSON'
raw = '''
{
  "price": "10000",
  "type": "bulanan",
  "rangeTime": "2023-12-07T15:45:00Z",
}'''
```
