class DoctorCenter < ApplicationRecord
  belongs_to :doctor
  belongs_to :center

  enum role: { admin: 0, worker: 1 }, _default: :worker
end
