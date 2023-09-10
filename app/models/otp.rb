class Otp < ApplicationRecord

  # define constants
  EMAIL_VERIFICATION = "email_verification".freeze
  SESSION_VERIFICATION = "session_verification".freeze

  validates :code, presence: true
  validates :code_type, presence: true

  enum code_type: {email_verification: 0, session_verification: 1 }, _default: :email_verification

  belongs_to :doctor

end
