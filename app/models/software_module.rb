class SoftwareModule < ApplicationRecord
  validates :name, presence: true
  validates :version, presence: true
  validates :technology, presence: true
  validates :min_age, presence: true
  validates :max_age, presence: true
  validates :image, presence: true

  enum technology: { virtual_reality: 0, two_dimensional: 1 }

  mount_uploader :image, PhotoUploader

  has_many :software_module_skills, dependent: :destroy
  has_many :targeted_skills, through: :software_module_skills
  has_many :center_software_modules, dependent: :destroy
  has_many :centers, through: :center_software_modules
  has_many :child_software_modules, dependent: :destroy
  has_many :children, through: :child_software_modules
  has_many :session_modules, dependent: :destroy
  has_many :sessions, through: :session_modules
end
