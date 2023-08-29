class InviteDoctorMailer < ApplicationMailer
    def send_invitation_link(email, center, token_data)
        @center = center
        @token_data = token_data
        mail(to: email, subject: 'Invitation link')
    end
end
