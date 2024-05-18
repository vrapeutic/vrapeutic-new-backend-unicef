class Otp < ApplicationRecord
  # define constants
  EMAIL_VERIFICATION = 'email_verification'.freeze
  SESSION_VERIFICATION = 'session_verification'.freeze

  validates :code, presence: true
  validates :code_type, presence: true
  validates :code_type, inclusion: { in: ['email_verification'] }

  enum code_type: { email_verification: 0 }, _default: :email_verification

  belongs_to :doctor
end
