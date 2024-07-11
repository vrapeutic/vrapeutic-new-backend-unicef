class OtpMailer < ApplicationMailer
  def send_otp(doctor, otp)
    @otp = otp
    mail(to: doctor.email, subject: 'Your OTP Code')
  end
end
