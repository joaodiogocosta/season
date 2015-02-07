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
    t.timestamps null: true
  end
end

class User < ActiveRecord::Base
  include Season::Scopes
end

RSpec.describe Season::Scopes do
  subject { User }

  describe 'class methods' do
    describe 'with default timestamps' do
      it 'responds to created_(before/after/between)' do
        expect(subject).to respond_to(:created_before, :created_after)
          .with(1).argument
        expect(subject).to respond_to(:created_between).with(2).arguments
      end

      it 'responds to updated_(before/after/between)' do
        expect(subject).to respond_to(:updated_before, :updated_after)
          .with(1).argument
        expect(subject).to respond_to(:updated_between).with(2).arguments
      end
    end
  end
end
