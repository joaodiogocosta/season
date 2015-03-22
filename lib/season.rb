require 'season/version'
require 'season/configuration'
require 'season/legacy'
require 'season/scope_builder'
require 'season/query_builder'
require 'season/instance_method_builder'

module Season
  QUERY_VERBS = %w(before after between)

  def self.included(base)
    base.extend(ClassMethods)

    # Define scopes
    sb = ScopeBuilder.new(base)
    base.class_eval do
      base.date_or_time_column_names.each do |column_name|
        QUERY_VERBS.each do |query_verb|
          sb.build(table_name, column_name, query_verb)
        end
      end
    end

    # Define instance methods
    imb = InstanceMethodBuilder.new(base)
    base.class_eval do
      base.date_or_time_column_names.each do |column_name|
        QUERY_VERBS.each do |query_verb|
          imb.build(table_name, column_name, query_verb)
        end
      end
    end
  end

  module ClassMethods
    def date_or_time_column_names
      columns.map { |c| c.name if c.type == :datetime || c.type == :date }.compact
    end
  end

  def self.root
    File.expand_path '../..', __FILE__
  end
end
