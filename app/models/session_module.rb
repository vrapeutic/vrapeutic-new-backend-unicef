class SessionModule < ApplicationRecord
  belongs_to :session
  belongs_to :software_module
  has_many :performances, dependent: :destroy
end
