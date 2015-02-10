# Season
[![Gem Version](https://badge.fury.io/rb/season.svg)](http://badge.fury.io/rb/season) [![Code Climate](https://codeclimate.com/github/joaodiogocosta/season/badges/gpa.svg)](https://codeclimate.com/github/joaodiogocosta/season) [![Build Status](https://travis-ci.org/joaodiogocosta/season.svg?branch=master)](https://travis-ci.org/joaodiogocosta/season)

Season automatically creates scopes for your models' datetime columns.
How many times have you done ugly things like `where("users.created_at" > ?", some_date)`? If you ever built an REST API with endpoints that return a list of records, I'm sure you've done plenty of this, and that's why Season exists.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'season', '~> 0.2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install season

## Requirements

In this first version Season only supports ActiveRecord, but we plan to also support Mongoid in a very short period of time.

## Usage

To use Season scopes just append `_before`, `_after` or `_between` to your datetime column names and pass the arguments accordingly. See this:

1. First, include Season in your model(s):
```ruby
class User < ActiveRecord::Base
  include Season
  ...
end

2. And considering that our `User` class has three datetime columns named `:created_at`, `:updated_at` and `:confirmed_at`, the following scopes will be automatically available: 
```ruby
# * Time/DateTime/String instances are allowed as arguments.

User.created_at_before(Time.now)
User.created_at_after(DateTime.now)
User.created_at_between(Time.now - 1.week, '31-01-2015')

User.updated_at_before(DateTime.now)
User.updated_at_after('01-01-2015')
User.updated_at_between(Time.now - 1.week, Time.now)

User.confirmed_at_before(DateTime.now)
User.confirmed_at_after('01-01-2015')
User.confirmed_at_between(Time.now - 1.week, Time.now)
```

They are chainable, so you can also do things like this:
```ruby
User.where(id: [1, 2, 3]).created_before(Time.now)
User.updated_after('01-01-2015').order(created_at: :asc)
```


## Configuration

The scopes are not included by default in your models. To use them you need to include it yourself:

```ruby
class User < ActiveRecord::Base
  include Season::Scopes
  ...
end 
```

If you want them to be available on all of your models by default, add the following code within an initializer - `config/initializers/season.rb`:

```ruby
Season.configure do |config|
  config.include_by_default = true
end 
``` 

## To Do

- Even more tests
- Support other ORMs (Mongoid, 'insert-more-here')
- Add Error Handling
- Add helpers for instances (like `User.first.created_before?('01-02-2015')`)
- Add support for queries with joins
- Support user-defined date/time columns

## Contributing

1. Fork it ( https://github.com/joaodiogocosta/season/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
