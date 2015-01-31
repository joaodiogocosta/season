require "season/version"
require "season/active_record/scopes"

module Season

end

if defined? ActiveRecord
  class ActiveRecord::Base
    include Scopes
  end
end
