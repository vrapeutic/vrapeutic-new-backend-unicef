class Otp < ApplicationRecord
  # define constants
  EMAIL_VERIFICATION = 'email_verification'.freeze
  SESSION_VERIFICATION = 'session_verification'.freeze
  FORGET_PASSWORD = 'forget_password'.freeze

  OTP_CODE_TYPES = {
    email_verification: Otp::EMAIL_VERIFICATION,
    session_verification: Otp::SESSION_VERIFICATION,
    forget_password: Otp::FORGET_PASSWORD
  }.freeze

  validates :code, presence: true
  validates :code_type, presence: true
  validates :code_type, inclusion: { in: %w[email_verification forget_password] }

  enum code_type: { email_verification: 0, forget_password: 1 }, _default: :email_verification

  belongs_to :doctor
end
