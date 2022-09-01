# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 3.0.2

* Rails version 6.1.4

* Database used: Postgresql

You can put your email credentail in ```application.yml``` file

    development
        KEY: 'our_key'
        SECRET: 'our_secret'

This file can be generated using ```figaro``` gem

    gem 'figaro'

    bundle install

    bundle exec figaro install