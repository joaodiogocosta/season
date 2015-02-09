module Season
  class ScopeBuilder

    def initialize(klass)
      @klass = klass
      @query_builder = QueryBuilder.new(adapter_class_name)
    end

    def build(table_name, column_name, query_verb)
      unless method_exists?(column_name)
        query_str = @query_builder.build(table_name, column_name, query_verb)
        
        @klass.define_singleton_method "#{column_name}_#{query_verb}" do |*args|
          eval(query_str)
        end
      end
    end

    private

      def method_exists?(column_name)
        defined? @klass.column_name
      end

      def adapter_class_name
        return 'active_record' if @klass < ActiveRecord::Base
        raise "Database adapter not supported."
      end

      # def remove_old_suffix(text)
      #   text.sub(/(#{POPULAR_SUFFIXES.join('|')})$/, '') || text
      # end
  end  
end
