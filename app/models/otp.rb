class Otp < ApplicationRecord
  belongs_to :doctor

  enum code_type: {email_verification: 0, session_verification: 1 }, _default: :email_verification

  # define constants
  EMAIL_VERIFICATION = "email_verification".freeze
  SESSION_VERIFICATION = "session_verification".freeze

end
