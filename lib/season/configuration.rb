module Season
  
  class << self
    attr_reader :configuration
  end

  def self.configure
    @configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration

    attr_accessor :include_by_default

    def initialize
      @include_by_default = true
    end
  end
end