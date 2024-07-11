class SoftwareModuleSkill < ApplicationRecord
  belongs_to :software_module
  belongs_to :targeted_skill
end
