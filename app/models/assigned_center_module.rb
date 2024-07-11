class AssignedCenterModule < ApplicationRecord
  # define constants
  END_DATE = Time.now

  belongs_to :center
  belongs_to :software_module

  validates :center_id, presence: true, uniqueness: { scope: :software_module_id }
end
