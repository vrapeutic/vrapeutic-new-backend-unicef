class Performance < ApplicationRecord
  belongs_to :session_module
  belongs_to :targeted_skill
  belongs_to :performanceable, polymorphic: true
end
