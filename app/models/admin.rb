class Admin < ApplicationRecord
  PERMITTED_EMAILS = ([ENV['ADMIN_EMAILS']&.split(',')].flatten + [ENV['ADMIN_EMAIL']] + Admin.pluck(:email)).uniq.compact.freeze

  validates :otp, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
