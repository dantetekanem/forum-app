This is a Forum Application written with Rails 5.1. It uses ActionCable integration for real-time notifications, and turbolinks for fast rendering.

Posts accepts markdown texts, also an almost WYSIWYG editor (simpleMDE) is used to help writing the text. It accepts mentions of user `@username` (which sends a notification to the mentioned user).

## Requirements
- PostgreSQL 9.6+
- Redis
- Ruby 2.3.1+

## How to install
- `bundle install`
- `rails s`

## Production
This application is running on heroku: http://leo-forum-app.herokuapp.com
It uses SendGrid integration to send e-mails.

## Tests
Run `rspec`.
