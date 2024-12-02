```toml
name = 'post redirect payment'
method = 'POST'
url = 'https://teknodipani.com/api/payment'
sortWeight = 2000000
id = '0d8b6bfd-3165-47ed-9110-000349856072'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = 'a13f3abe-7a72-4ae2-ba2a-5a20179a61ca'

[body]
type = 'JSON'
raw = '''
{
}'''
```
