module Season
  class QueryBuilder

    def initialize(adapter_class_name)
      @adapter_class_name = adapter_class_name
    end

    def build(table_name, column_name, query_verb)
      self.send("#{@adapter_class_name}_#{query_verb}", table_name, column_name)
    end

    private

      def active_record_before(table_name, column_name)
        "where(" + "\"#{table_name}.#{column_name} < ?\"" + ", *args)"
      end

      def active_record_between(table_name, column_name)
        "where(" + "\"#{table_name}.#{column_name} > ? AND #{table_name}.#{column_name} < ?\"" + ", *args)"
      end

      def active_record_after(table_name, column_name)
        "where(" + "\"#{table_name}.#{column_name} > ?\"" + ", *args)"
      end
  end
end