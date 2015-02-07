# Season
[![Gem Version](https://badge.fury.io/rb/season.svg)](http://badge.fury.io/rb/season) [![Code Climate](https://codeclimate.com/github/joaodiogocosta/season/badges/gpa.svg)](https://codeclimate.com/github/joaodiogocosta/season) [![Build Status](https://travis-ci.org/joaodiogocosta/season.svg?branch=master)](https://travis-ci.org/joaodiogocosta/season)

Season let's you easily query your Models by a specific date/time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'season', '~> 0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install season

## Requirements

In this first version Season only supports ActiveRecord, but we plan to also support Mongoid in a very short period of time.

## Usage

Season assumes your models have timestamps columns (created_at and updated_at) and uses these to do its magic.

Right now, Season gives you the following helper methods:

```ruby
# Include it in your models

class User < ActiveRecord::Base
  include Season::Scopes
  ...
end

# And then use it as:
# (Time/DateTime/String instances are allowed as arguments)

User.created_before(Time.now)
User.created_after(DateTime.now)
User.created_between(Time.now - 1.week, '31-01-2015')

User.updated_before(DateTime.now)
User.updated_after('01-01-2015')
User.updated_between(Time.now - 1.week, Time.now)
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
- Support user-defined date/time columns (through configuration)

## Contributing

1. Fork it ( https://github.com/joaodiogocosta/season/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
