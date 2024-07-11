class AdminOtpMailer < ApplicationMailer
  def send_otp(email, otp)
    @otp = otp
    mail(to: email, subject: 'Your Admin OTP Code')
  end
end
