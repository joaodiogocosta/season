module Season

  class Configuration

    attr_accessor :include_by_default

    def initialize
      @include_by_default = true
    end

  end
  
  class << self
    
    def configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

  end
end