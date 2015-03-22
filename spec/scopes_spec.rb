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
    t.date :birthdate
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

  describe 'defined datetime scopes' do
    it 'of datetime type' do
      expect(subject).to respond_to(:created_at_before, :created_at_after)
        .with(1).argument
      expect(subject).to respond_to(:created_at_between).with(2).arguments
    end

    it 'of date type' do
      expect(subject).to respond_to(:birthdate_before, :birthdate_after)
        .with(1).argument
      expect(subject).to respond_to(:birthdate_between).with(2).arguments
    end

    it 'of timestamp type' do
      expect(subject).to respond_to(:confirmed_at_before, :confirmed_at_after)
        .with(1).argument
      expect(subject).to respond_to(:confirmed_at_between).with(2).arguments
    end

    it ' - legacy' do
      expect(subject).to respond_to(:created_before, :created_after)
        .with(1).argument
      expect(subject).to respond_to(:created_between).with(2).arguments
      expect(subject).to respond_to(:updated_before, :updated_after)
        .with(1).argument
      expect(subject).to respond_to(:updated_between).with(2).arguments
    end
  end

  describe 'datetime scopes' do

    let(:instant) { DateTime.parse('01-01-2015') }

    before do
      User.create!(created_at: instant - 1.year)
      User.create!(created_at: instant + 1.year)
    end

    it "shows correct results for 'before'" do
      expect(subject.created_at_before(instant).count).to eq(1)
    end

    it "shows correct results for 'after'" do
      expect(subject.created_at_after(instant).count).to eq(1)
    end

    it "shows correct results for 'between'" do
      expect(subject.created_at_between(instant - 2.year, instant + 2.year).count).to eq(2)
    end
  end

  describe 'defined datetime instance methods' do

    let(:user) { User.new }

    it 'of datetime type' do
      expect(user).to respond_to(:created_at_before?, :created_at_after?)
        .with(1).argument
      expect(user).to respond_to(:created_at_between?).with(2).arguments
    end

    it 'of date type' do
      expect(user).to respond_to(:birthdate_before?, :birthdate_after?)
        .with(1).argument
      expect(user).to respond_to(:birthdate_between?).with(2).arguments
    end

    it 'of timestamp type' do
      expect(user).to respond_to(:confirmed_at_before?, :confirmed_at_after?)
        .with(1).argument
      expect(user).to respond_to(:confirmed_at_between?).with(2).arguments
    end
  end

  describe 'datetime instance methods' do

    let(:instant) { DateTime.parse('01-01-2015') }
    let(:user) { User.create!(created_at: instant) }

    it "shows correct results for 'before'" do
      expect(user.created_at_before?(instant + 1.day)).to eq(true)
    end

    it "shows correct results for 'after'" do
      expect(user.created_at_after?(instant - 1.day)).to eq(true)
    end

    it "shows correct results for 'between'" do
      expect(user.created_at_between?(instant - 1.day, instant + 1.day)).to eq(true)
    end
  end
end
