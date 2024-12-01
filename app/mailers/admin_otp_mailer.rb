class AdminOtpMailer < ApplicationMailer
  def send_otp(email, otp)
    @otp_code = otp
    mail(to: email, subject: 'Admin OTP Code')
  end
end
