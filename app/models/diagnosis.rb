class Diagnosis < ApplicationRecord
  default_scope { order(name: :asc) }

  validates :name, presence: true, uniqueness: true

  # diagnoses names
  ADHD = 'ADHD'.freeze
  ADD = 'ADD'.freeze
  SPEECH_AND_COMMUNICATIONS_DISORDER = 'Speech and Communications Disorder'.freeze
  DOWN_SYNDROME = 'Down Syndrome'.freeze
  AUTISM = 'Autism'.freeze
  ASPERGER = 'Asperger'.freeze

  has_many :child_diagnoses, dependent: :destroy
  has_many :children, through: :child_diagnoses
end
