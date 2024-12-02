```toml
name = 'post update user'
method = 'POST'
url = 'https://teknodipani.com/api/users/current'
sortWeight = 3000000
id = 'c2543fcf-4c03-4b1a-82c4-dc99c4443479'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '05e27511-5148-410c-80df-526939a0a9cb'

[body]
type = 'JSON'
raw = '''
{
  "idCategory": [
    1,2,
  ]
}'''
```
