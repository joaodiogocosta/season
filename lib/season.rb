require "season/version"
require 'season/configuration'

if defined? ActiveRecord
  require "season/active_record/scopes"

  if Season.configuration.include_by_default
    ActiveRecord::Base.send(:include, Season::Scopes)
  end
end