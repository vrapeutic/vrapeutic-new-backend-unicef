class SessionModule < ApplicationRecord
  belongs_to :session
  belongs_to :software_module
end
