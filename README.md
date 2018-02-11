# System Requirements:
* PostgreSQL >= 10.0
* Ruby >= 2.5.0
* Ruby on Rails >= 5.1.4
* ImageMagick >= 7.0.7-7

# Presettings
1. run `CREATE EXTENSION IF NOT EXISTS "pgcrypto"` in PostgreSQL console;

# Setting up:
1. run `git clone https://github.com/tksasha/shop-backend shop`;
2. run `cd shop/`;
3. run `rake db:create`;
4. run `rake db:migrate`;
5. run specs `rake spec`;
7. run `rails s`;

`.env`

```ruby
#
# it needs for Mailers
#
HOST                 = 'localhost:3000'

#
# credentials to send email
#
SES_SMTP_USERNAME    = ''
SES_SMTP_PASSWORD    = ''

#
# Amazon S3 Settings
#
S3_REGION             = 'eu-central-1'
S3_HOST_NAME          = 's3.eu-central-1.amazonaws.com'
S3_BUCKET             = ''
S3_ACCESS_KEY_ID      = ''
S3_SECRET_ACCESS_KEY  = ''

#
# Appsignal Settings
#
APPSIGNAL_PUSH_API_KEY = ''
```

# How to deploy
```
git push heroku master
```

# Swagger Documentation
http://petstore.swagger.io/?url=https://dry-hollows-65202.herokuapp.com/swagger.yml
