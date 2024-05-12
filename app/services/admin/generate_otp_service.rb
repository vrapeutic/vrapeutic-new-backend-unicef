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
    admin = Admin.first

    if admin.expires_at > Time.now
      @otp = SecureRandom.hex(3)

      options = { otp: @otp, expires_at: @expires_at }
      admin.update!(options)
    else
      @otp = admin.otp
    end
  end
end
