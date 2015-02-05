require "season/version"
require "season/active_record/scopes" if defined? ActiveRecord

if Season.configuration.include_by_default
  ActiveRecord::Base.send(:include, Scopes)
end