module Season

  class Configuration

    attr_accessor :include_by_default

    def initialize
      @include_by_default = false
    end

  end
    
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
    auto_include_scopes
  end

  private

    def self.auto_include_scopes
      if configuration.include_by_default
        ActiveRecord::Base.send(:include, Season::Scopes) if defined? ActiveRecord
      end
    end
end