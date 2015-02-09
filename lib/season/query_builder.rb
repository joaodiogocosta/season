module Season
  class QueryBuilder

    def initialize(adapter_class_name)
      @adapter_class_name = adapter_class_name
    end

    def build(table_name, column_name, *args)
      self.send("#{adapter_class_name}_#{query_verb}", *args)
    end

    private

      def active_record_before(date)
        where("#{table_name}.#{column_name} < ?", date)
      end

      def active_record_between(start_date, end_date)
        where("#{table_name}.#{column_name} > ? AND #{table_name}.#{column_name} < ?", start_date, end_date)
      end

      def active_record_after(date)
        where("#{table_name}.#{column_name} > ?", date)
      end
  end
end