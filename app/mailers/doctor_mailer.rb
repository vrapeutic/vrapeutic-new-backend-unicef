class DoctorMailer < ApplicationMailer
  def forget_password(doctor:, otp_code:)
    @doctor = doctor
    @otp_code = otp_code

    mail(to: doctor.email, subject: 'Reset Password')
  end
end
