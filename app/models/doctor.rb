class Doctor < ApplicationRecord
  RANSACKABLE_ATTRIBUTES = %w[id name email university degree created_at updated_at].freeze
  RANSACKABLE_ASSOCIATIONS = %w[specialties centers children sessions].freeze

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password
  validates :university, presence: true
  validates :degree, presence: true
  validates :photo, presence: true, unless: -> { photo_url.present? }
  validates :certificate, presence: true, unless: -> { certificate_url.present? }

  mount_uploader :photo, PhotoUploader
  mount_uploader :certificate, CertificateUploader

  has_many :doctor_specialties, dependent: :destroy
  has_many :specialties, through: :doctor_specialties
  has_many :otps, dependent: :destroy
  has_many :doctor_centers, dependent: :destroy
  has_many :centers, through: :doctor_centers
  has_many :child_doctors, dependent: :destroy
  has_many :children, through: :child_doctors
  has_many :session_doctors, dependent: :destroy
  has_many :sessions, through: :session_doctors
end
