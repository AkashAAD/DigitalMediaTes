# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.5.1

* System dependencies

* Configuration

* Database creation
  ```rake db:create```

* Database initialization
  ```rake db:migrate db:seed RAILS_ENV=development```
  ```rake db:migrate db:seed RAILS_ENV=test```
* How to run the test suite
  ```rspec spec/controller/api/v1/```

* Services (job queues, cache servers, search engines, etc.)
  ```Cron job setup:```
  ```bundle exec whenever && whenever --update-crontab --set environment='development'```

* Deployment instructions
  NA
* NOTE
  ```Please refer api_json/DigitalMediaTest.postman_collection.json file for api details. You can import it into api testing tool ex., postman```
