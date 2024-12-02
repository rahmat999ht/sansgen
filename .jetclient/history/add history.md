```toml
name = 'add history'
method = 'POST'
url = 'https://teknodipani.com/api/history/books/5e04e574-ba49-446c-a748-c7a275704bbb/chapters/1'
sortWeight = 2000000
id = 'bfcd92b8-b3b7-4cb8-85e2-5120bc03d9bb'

[[headers]]
key = 'Content-Type'
value = 'application/json'

[auth.bearer]
token = '48b3f7d0-6fe9-4401-bc10-4c71483b6f54'

[body]
type = 'JSON'
raw = '''
// users/current
{
//  "isFinished" : false,
//  "lastChapter" : 1,
}'''
```
