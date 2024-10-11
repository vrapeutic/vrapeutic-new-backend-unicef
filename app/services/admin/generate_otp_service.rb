class Admin::GenerateOtpService
  def initialize(email:, expires_at: Time.now + (Rails.env.production? ? 60.minutes : 180.minutes))
    @email = email
    @admin = Admin.find_by(email: email)
    @expires_at = expires_at
  end

  def call
    Admin.transaction { generate_otp }
  end

  private

  def generate_otp
    return @admin.otp if valid_admin?

    otp = generate_unique_otp_code
    create_or_update_admin(otp)
    otp
  end

  def valid_admin?
    @admin.present? && @admin.expires_at >= Time.now
  end

  def create_or_update_admin(otp)
    options = { otp: otp, expires_at: @expires_at }
    @admin.nil? ? Admin.create!(email: @email, **options) : @admin.update!(options)
  end

  def generate_unique_otp_code
    loop do
      otp = SecureRandom.hex(3)
      return otp if Admin.find_by(otp: otp).nil?
    end
  end
end
