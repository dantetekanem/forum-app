This is a Forum Application written with Rails 5.1. It uses ActionCable integration for real-time notifications, and turbolinks for fast rendering.

## Requirements
PostgreSQL 9.6+
Redis
Ruby 2.3.1+

## How to install
`bundle install`
`rails s`

## Production
This application is running on heroku: http://leo-forum-app.herokuapp.com
It uses SendGrid integration to send e-mails.

## Tests
Run `rspec`.
