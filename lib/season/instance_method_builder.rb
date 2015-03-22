module Season
  class InstanceMethodBuilder

    def initialize(klass)
      @klass = klass
    end

    def build(table_name, column_name, query_verb)
      method_val = self.send(query_verb, column_name)

      @klass.class_eval %Q{
        def #{column_name}_#{query_verb}?(*args)
          #{method_val}
        end
      }
    end

    private

      def parse_input(date_input)
        date_input= case date_input.class
                    when Time || Date || ActiveSupport::TimeWithZone
                      date_input.to_i
                    when DateTime
                      date_input
                    when String
                      DateTime.parse(date_input)
                    else
                      raise ArgumentError, 'Invalid date_to_compare to compare.'
                    end
      end

      def before(column_name)
        "#{column_name} < args.first"
      end

      def after(column_name)
        "#{column_name} > args.first"
      end

      def between(column_name)
        "#{column_name} > args.first || #{column_name} < args.last"
      end
  end  
end
