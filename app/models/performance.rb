class Performance < ApplicationRecord
  validates :level, presence: true

  belongs_to :session_module
  belongs_to :performanceable, polymorphic: true
end
