class ChildSoftwareModule < ApplicationRecord
  belongs_to :software_module
  belongs_to :child
end
