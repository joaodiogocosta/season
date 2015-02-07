module Season
  module Scopes

    POPULAR_SUFFIXES = ['_at', '_on']

    def self.included(base)
      base.extend(ClassMethods)

      base.class_eval do
        # DEFINE SCOPES DINAMICALLY
        base.datetime_column_names.each do |column_name|
          # BEFORE
          define_singleton_method build_method_name(column_name, '_before') do |date|
            before_query(table_name, column_name, date)
          end

          # AFTER
          define_singleton_method build_method_name(column_name, '_after') do |date|
            after_query(table_name, column_name, date)
          end

          # BETWEEN
          define_singleton_method build_method_name(column_name, '_between') do |start_date, end_date|
            between_query(table_name, column_name, start_date, end_date)
          end
        end
      end
    end

    private

      module ClassMethods
        def datetime_column_names
          columns.map { |c| c.name if c.type == :datetime }.compact
        end

        def build_method_name(column_name, suffix)
          remove_old_suffix(column_name) + suffix
        end

        def before_query(table_name, column_name, date)
          where("#{table_name}.#{column_name} < ?", date)
        end

        def after_query(table_name, column_name, date)
          where("#{table_name}.#{column_name} > ?", date)
        end

        def between_query(table_name, column_name, start_date, end_date)
          where("#{table_name}.#{column_name} > ? AND \#{table_name}.#{column_name} < ?", start_date, end_date)
        end

        def remove_old_suffix(text)
          text.sub(/(#{POPULAR_SUFFIXES.join('|')})$/, '') || text
        end
      end
  end
end
