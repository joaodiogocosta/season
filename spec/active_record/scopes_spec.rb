require 'spec_helper'
require 'active_record'
require 'season/active_record/scopes'

silence_warnings do
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Base.logger = Logger.new(nil)
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3', database: ':memory:')
end

ActiveRecord::Base.connection.instance_eval do
  create_table :users do |t|
    t.datetime :created_at
    t.datetime :updated_on
    t.datetime :locked
    t.timestamp :confirmed_at
  end
end

class User < ActiveRecord::Base
  include Season::Scopes
end

RSpec.describe Season::Scopes do
  subject { User }

  it 'has scopes to datetime columns of datetime type' do
    expect(subject).to respond_to(:created_before, :created_after)
      .with(1).argument
    expect(subject).to respond_to(:created_between).with(2).arguments
  end

  it 'has scopes to datetime columns of timestamp type' do
    expect(subject).to respond_to(:confirmed_before, :confirmed_after)
      .with(1).argument
    expect(subject).to respond_to(:confirmed_between).with(2).arguments
  end
  
  it 'has scopes to datetime columns with _at suffixs' do
    expect(subject).to respond_to(:created_before, :created_after)
      .with(1).argument
    expect(subject).to respond_to(:created_between).with(2).arguments
  end

  it 'has scopes to datetime columns with _on suffixs' do
    expect(subject).to respond_to(:updated_before, :updated_after)
          .with(1).argument
    expect(subject).to respond_to(:updated_between).with(2).arguments
  end

  it 'has scopes to datetime columns without suffixs' do
    expect(subject).to respond_to(:locked_before, :locked_after)
          .with(1).argument
    expect(subject).to respond_to(:locked_between).with(2).arguments
  end
end
