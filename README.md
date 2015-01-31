# Season

Season let's you easily query your Models by a specific date/time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'season'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install season

## Requirements

In this first version Season only supports ActiveRecord, but we plan to also support MongoID in a very short period of time.

## Usage

Season assumes your models have timestamps columns (created_at and updated_at) and uses these to do its magic.

Right now, Season gives you the following helper methods:

```ruby
# You can pass instances of Time/DateTime/String as arguments

MyModel.created_before(Time.now)
MyModel.created_after(DateTime.now)
MyModel.created_between(Time.now - 1.week, '31-01-2015')

MyModel.updated_before(DateTime.now)
MyModel.updated_after('01-01-2015')
MyModel.updated_between(Time.now - 1.week, Time.now)
``` 

## To Do

- Tests!
- Support other ORMs (Mongoid, <insert-more-here>)
- Add Error Handling
- Support user-defined date/time columns (through configuration)
- Support configuration for enabling/disabling Season for all models

## Contributing

1. Fork it ( https://github.com/[my-github-username]/season/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
