class SoftwareModule < ApplicationRecord
    validates :name, presence: true
    validates :version, presence: true
    validates :technology, presence: true

    enum technology: { virtual_reality: 0, two_dimensional: 1 }

    has_many :software_module_skills, dependent: :destroy
    has_many :targeted_skills, through: :software_module_skills
    has_many :center_software_modules, dependent: :destroy
    has_many :centers, through: :center_software_modules
end
