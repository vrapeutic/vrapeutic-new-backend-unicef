class Admin::GenerateOtpService
  def initialize(email:, expires_at: Time.now + (Rails.env.production? ? 60.minutes : 180.minutes))
    @email = email
    @expires_at = expires_at
  end

  def call
    Admin.transaction do
      generate_otp
    end
  end

  private

  def generate_otp
    admin = Admin.find_by(email: @email)

    if admin.nil? || admin.expires_at < Time.now
      otp = Rails.env.production? ? generate_uniq_otp_code : admin&.otp || generate_uniq_otp_code

      if admin.nil?
        options = { email: @email, otp: otp, expires_at: @expires_at }
        Admin.create!(options)
      else
        options = { otp: otp, expires_at: @expires_at }
        admin.update!(options)
      end
    end

    otp
  end

  def generate_uniq_otp_code
    otp = SecureRandom.hex(3)

    otp = SecureRandom.hex(3) until Admin.find_by(otp: otp).nil?

    otp
  end
end
