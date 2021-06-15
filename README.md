# shop-rails-api

```bash
rails new shop-rails-api --api -d postgresql
puma
bin/rails s
bin/rails g model User email:string password_digest:string role:integer
bin/rails db:migrate
```