class Admin::ValidateOtpService
  def initialize(entered_otp:)
    @entered_otp = entered_otp
  end

  def call
    validate_otp
  end

  private

  def validate_otp
    admin = Admin.find_by(otp: @entered_otp)

    admin.present? && admin.expires_at >= Time.now
  end
end
