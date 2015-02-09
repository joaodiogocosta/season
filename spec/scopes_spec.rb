require 'spec_helper'
require 'active_record'

silence_warnings do
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Base.logger = Logger.new(nil)
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3', database: ':memory:')
end

ActiveRecord::Base.connection.instance_eval do
  create_table :users do |t|
    t.datetime :created_at
    t.datetime :updated_at
    t.timestamp :confirmed_at
  end
end

Season.configure do |config|
  config.include_by_default = true
end

class User < ActiveRecord::Base
  include Season
end

RSpec.describe Season do
  subject { User }

  it 'has scopes to datetime columns of datetime type' do
    expect(subject).to respond_to(:created_at_before, :created_at_after)
      .with(1).argument
    expect(subject).to respond_to(:created_at_between).with(2).arguments
  end

  it 'has scopes to datetime columns of timestamp type' do
    expect(subject).to respond_to(:confirmed_at_before, :confirmed_at_after)
      .with(1).argument
    expect(subject).to respond_to(:confirmed_at_between).with(2).arguments
  end

  it 'has legacy scopes' do
    expect(subject).to respond_to(:created_before, :created_after)
      .with(1).argument
    expect(subject).to respond_to(:created_between).with(2).arguments
    expect(subject).to respond_to(:updated_before, :updated_after)
      .with(1).argument
    expect(subject).to respond_to(:updated_between).with(2).arguments
  end

  it 'has legacy scopes' do
    expect(subject.created_at_before(Time.now)).to eq([])
  end
end
