class Admin::GenerateOtpService
  def initialize(expires_at: Time.now + (Rails.env.production? ? 60.minutes : 180.minutes))
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
    admin = Admin.first

    if admin.expires_at < Time.now
      @otp = Rails.env.production? ? SecureRandom.hex(3) : admin&.otp || SecureRandom.hex(3)

      options = { otp: @otp, expires_at: @expires_at }
      admin.update!(options)
    else
      @otp = admin.otp
    end
  end
end
