class AssignedCenterModule < ApplicationRecord
  # define constants
  END_DATE = Time.now

  belongs_to :center
  belongs_to :software_module
end
