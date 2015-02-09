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
        warn "[DEPRECATED] Include season scopes by default is deprecated and will be removed before v0.5 - See https://github.com/joaodiogocosta/season for more"
        ActiveRecord::Base.send(:include, Season::Legacy) if defined? ActiveRecord
      end
    end
end