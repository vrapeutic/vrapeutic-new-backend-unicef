class Child < ApplicationRecord
  # constant variables
  RANSACKABLE_ATTRIBUTES = %w[id name email ago created_at updated_at].freeze
  RANSACKABLE_ASSOCIATIONS = %w[diagnoses centers software_modules doctors sessions].freeze

  validates :name, presence: true
  validates :photo, presence: true
  validates :email, presence: true, uniqueness: true
  validates :age, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 6,
    less_than_or_equal_to: 40,
    allow_nil: true
  }

  mount_uploader :photo, PhotoUploader

  has_many :child_diagnoses, dependent: :destroy
  has_many :diagnoses, through: :child_diagnoses
  has_many :child_centers, dependent: :destroy
  has_many :centers, through: :child_centers
  has_many :child_software_modules, dependent: :destroy
  has_many :software_modules, through: :child_software_modules
  has_many :child_doctors, dependent: :destroy
  has_many :doctors, through: :child_doctors
  has_many :sessions, dependent: :destroy
end
