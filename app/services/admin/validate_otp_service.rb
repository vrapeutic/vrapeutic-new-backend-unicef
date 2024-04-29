class Admin::ValidateOtpService
  def initialize(entered_otp:)
    @entered_otp = entered_otp
  end

  def call
    validate_otp
  end

  private

  def validate_otp
    admin = Admin.first
    return false unless admin.otp.present?

    return false if admin.expires_at < Time.now

    admin.otp == @entered_otp
  end
end
