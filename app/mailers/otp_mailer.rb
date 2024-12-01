class OtpMailer < ApplicationMailer
  def send_otp(doctor, otp)
    @otp_code = otp
    mail(to: doctor.email, subject: 'Email OTP Code')
  end
end
