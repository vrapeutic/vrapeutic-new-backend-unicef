class Admin < ApplicationRecord
  PERMITTED_EMAILS = ([ENV['ADMIN_EMAILS']&.split(',')].flatten + [ENV['ADMIN_EMAIL']]).compact.freeze

  validates :otp, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :email, inclusion: { in: PERMITTED_EMAILS }
end
