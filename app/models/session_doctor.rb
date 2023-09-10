class SessionDoctor < ApplicationRecord
  belongs_to :session
  belongs_to :doctor
end
