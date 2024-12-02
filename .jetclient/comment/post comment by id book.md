```toml
name = 'post comment by id book'
method = 'POST'
url = 'https://teknodipani.com/api/books/0034d983-aad7-4db8-929d-739989e1419d/comments'
sortWeight = 2000000
id = '4fc3298b-18cd-4247-ad46-1805a88d57d0'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '9510c38d-42bb-442c-bbf5-5755fe4dd6a5'

[body]
type = 'JSON'
raw = '''
{
  "comment": "buku yang sangat bagus"
}'''
```
