class DoctorCenter < ApplicationRecord
  # constant variables
  RANSACKABLE_ATTRIBUTES = %w[id role center_id doctor_id created_at updated_at].freeze
  RANSACKABLE_ASSOCIATIONS = %w[doctor center].freeze

  belongs_to :doctor
  belongs_to :center

  enum role: { admin: 0, worker: 1 }, _default: :worker
end
