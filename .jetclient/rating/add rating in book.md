```toml
name = 'add rating in book'
method = 'POST'
url = 'https://teknodipani.com/api/books/d0f02260-4c1f-47ec-bb27-25054df30b92/rate'
sortWeight = 1000000
id = '0ba319ef-802f-468c-8270-f9c8414c4a69'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '8aa5b3bc-404a-4bf4-83a7-227901806fbe'

[body]
type = 'JSON'
raw = '''
{
  "rate": 4.5,
}'''
```
