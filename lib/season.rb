require "season/version"
require "season/active_record/scopes"

module Season
  
  if defined? ActiveRecord
    class ActiveRecord::Base
      include Scopes
    end
  end

end
