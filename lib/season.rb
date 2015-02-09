require "season/version"
require "season/configuration"
require "season/legacy"
require "season/scope_builder"
require "season/query_builder"

module Season

  QUERY_VERBS = ['before', 'after', 'between']

  def self.included(base)
    base.extend(ClassMethods)

    mb = ScopeBuilder.new(base)

    base.class_eval do
      # DEFINE SCOPES DINAMICALLY
      base.datetime_column_names.each do |column_name|
        QUERY_VERBS.each do |query_verb|
          mb.build(table_name, column_name, query_verb)
        end
      end
    end
  end

  module ClassMethods
    def datetime_column_names
      columns.map { |c| c.name if c.type == :datetime }.compact
    end
  end
end

