class Performance < ApplicationRecord
  belongs_to :session_module
  belongs_to :performanceable, polymorphic: true
end
