```toml
name = 'patch user'
method = 'POST'
url = 'https://teknodipani.com/api/users/current'
sortWeight = 2000000
id = '9fb69c1d-e569-4011-8398-4a593d374e4c'

[[headers]]
key = 'Content-Type'
value = 'multipart/form-data'

[auth.bearer]
token = '05e27511-5148-410c-80df-526939a0a9cb'

[[body.formData]]
type = 'FILE'
key = 'image'
value = '/home/yayat/Unduhan/Beranda.png'
disabled = true

[[body.formData]]
key = 'dateOfBirth'
value = '2024-09-27 00:00:00.000'
disabled = true

[[body.formData]]
key = 'hobby'
value = 'sxbskdba'
disabled = true

[[body.formData]]
key = 'categories'
value = '[ 2]'
```
