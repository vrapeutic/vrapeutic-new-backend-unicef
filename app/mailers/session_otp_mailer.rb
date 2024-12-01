class SessionOtpMailer < ApplicationMailer
  def send_otp(email, otp)
    @otp_code = otp
    mail(to: email, subject: 'Session OTP Code')
  end
end
