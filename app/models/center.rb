class Center < ApplicationRecord
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true
  validates :name, presence: true
  validates :website, uniqueness: true
  validates :logo, presence: true
  validates :certificate, presence: true
  validates :registration_number, presence: true, uniqueness: true
  validates :tax_id, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

  mount_uploader :logo, PhotoUploader
  mount_uploader :certificate, CertificateUploader

  has_many :doctor_centers, dependent: :destroy
  has_many :doctors, through: :doctor_centers
  has_many :center_specialties, dependent: :destroy
  has_many :specialties, through: :center_specialties
  has_many :center_social_links, dependent: :destroy
  has_many :child_centers, dependent: :destroy
  has_many :children, through: :child_centers
  has_many :headsets, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :center_software_modules, dependent: :destroy
  has_many :assigned_center_modules, -> { where('end_date > ?', AssignedCenterModule::END_DATE) }, dependent: :destroy
  has_many :software_modules, through: :assigned_center_modules
end
