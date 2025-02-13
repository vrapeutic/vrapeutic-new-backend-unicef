class Specialty < ApplicationRecord
  default_scope { order(name: :asc) }

  validates :name, presence: true

  has_many :doctor_specialties, dependent: :destroy
  has_many :doctors, through: :doctor_specialties
  has_many :center_specialties, dependent: :destroy
  has_many :centers, through: :center_specialties

  # specialties names
  SPEECH_AND_LANGUAGE_THERAPY = 'Speech and Language Therapy'.freeze
  OCCUPATIONAL_THERAPY = 'Occupational Therapy'.freeze
  PHYSICAL_THERAPY = 'Physical Therapy'.freeze
  SENSORY_INTEGRATION = 'Sensory Integration'.freeze
  COGNITIVE_BEHAVIORAL_THERAPY = 'Cognitive Behavioral Therapy'.freeze
end
