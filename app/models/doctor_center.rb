class DoctorCenter < ApplicationRecord
  # constant variables
  RANSACKABLE_ATTRIBUTES = %w[id role status center_id doctor_id created_at updated_at].freeze
  RANSACKABLE_ASSOCIATIONS = %w[doctor center].freeze

  belongs_to :doctor
  belongs_to :center

  enum role: { admin: 0, worker: 1 }, _default: :worker
  enum status: { invited: 0, approved: 1, rejected: 2 }, _default: :invited
end
