class Center < ApplicationRecord
  # constant variables
  RANSACKABLE_ATTRIBUTES = %w[id name website tax_id registration_number email phone_number created_at updated_at].freeze
  RANSACKABLE_ASSOCIATIONS = %w[doctors specialties children headsets sessions software_modules].freeze

  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true
  validates :name, presence: true
  validates :website, uniqueness: true
  validates :registration_number, presence: true, uniqueness: true
  validates :tax_id, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
  validates :logo, presence: true, unless: -> { logo_url.present? }
  validates :certificate, presence: true, unless: -> { certificate_url.present? }

  mount_uploader :logo, PhotoUploader
  mount_uploader :certificate, CertificateUploader

  has_many :doctor_centers, dependent: :destroy
  has_many :doctors, through: :doctor_centers
  has_many :center_specialties, dependent: :destroy
  has_many :specialties, through: :center_specialties
  has_many :center_social_links, dependent: :destroy
  has_many :child_centers, dependent: :destroy
  has_many :children, through: :child_centers
  has_many :headsets, -> { kept }, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :assigned_center_modules, -> { where('end_date > ?', AssignedCenterModule::END_DATE) }, dependent: :destroy
  has_many :software_modules, through: :assigned_center_modules

  def evaluation_stats
    total_sessions = sessions.empty? ? 1.0 : sessions.count.to_f
    total_unevaluated = sessions.where(evaluation: nil).count
    total_poor_evaluation = sessions.where(evaluation: :poor).count
    total_average_evaluation = sessions.where(evaluation: :average).count
    total_good_evaluation = sessions.where(evaluation: :good).count
    total_very_good_evaluation = sessions.where(evaluation: :very_good).count
    total_excellent_evaluation = sessions.where(evaluation: :excellent).count

    {
      total_sessions: sessions.count,
      total_unevaluated: ((total_unevaluated / total_sessions) * 100).round(2),
      total_poor_evaluation: ((total_poor_evaluation / total_sessions) * 100).round(2),
      total_average_evaluation: ((total_average_evaluation / total_sessions) * 100).round(2),
      total_good_evaluation: ((total_good_evaluation / total_sessions) * 100).round(2),
      total_very_good_evaluation: ((total_very_good_evaluation / total_sessions) * 100).round(2),
      total_excellent_evaluation: ((total_excellent_evaluation / total_sessions) * 100).round(2)
    }
  end
end
