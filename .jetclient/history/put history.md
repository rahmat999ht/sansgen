```toml
name = 'put history'
method = 'PUT'
url = 'https://teknodipani.com/api/history/books/0034d983-aad7-4db8-929d-739989e1419d/chapters/2'
sortWeight = 3000000
id = '79e4537b-b7fb-4b46-aee1-a4cac0da5ccc'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '85b06f5e-274b-4623-bc9d-3168fe6de855'

[body]
type = 'JSON'
raw = '''
// users/current
{
  "isFinished" : true,
  "lastChapter" : 1,
//  "listChapter" : []
}'''
```
