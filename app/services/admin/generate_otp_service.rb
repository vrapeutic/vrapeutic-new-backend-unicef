class Admin::GenerateOtpService
  def initialize(expires_at: Time.now + (Rails.env.production? ? 60.minutes : 48.hours))
    @expires_at = expires_at
  end

  def call
    Admin.transaction do
      generate_otp
      @otp
    end
  end

  private

  def generate_otp
    @otp = SecureRandom.hex(3)
    options = { otp: @otp, expires_at: @expires_at }
    admin = Admin.first
    admin.update!(options)
  end
end
