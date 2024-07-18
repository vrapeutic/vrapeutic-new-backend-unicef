class DoctorMailer < ApplicationMailer
  def forget_password(doctor:, token:)
    @doctor = doctor
    @token = token

    mail(to: doctor.email, subject: 'Reset Password')
  end
end
