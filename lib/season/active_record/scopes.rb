module Season
  module Scopes
    def self.included(base)
      base.class_eval do
        def self.created_before( date )
          scoped( :conditions => [ "#{table_name}.created_at < ?", date ] )
        end

        def self.created_between( start_date, end_date )
          scoped( :conditions => [ "#{table_name}.created_at > ? AND #{table_name}.created_at < ?", start_date, end_date ] )
        end

        def self.created_after( date )
          scoped( :conditions => [ "#{table_name}.created_at > ?", date ] )
        end


        def self.updated_before( date )
          scoped( :conditions => [ "#{table_name}.updated_at < ?", date ] )
        end

        def self.updated_between( start_date, end_date )
          scoped( :conditions => [ "#{table_name}.updated_at > ? AND #{table_name}.updated_at < ?", start_date, end_date ] )
        end

        def self.updated_after( date )
          scoped( :conditions => [ "#{table_name}.updated_at > ?", date ] )
        end
      end
    end
  end
  
  ActiveRecord::Base.send(:include, Scopes)
end