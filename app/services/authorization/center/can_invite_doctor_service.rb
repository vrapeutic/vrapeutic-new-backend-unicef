class Authorization::Center::CanInviteDoctorService

    def initialize(current_doctor:, center_id:)
        @current_doctor = current_doctor
        @center_id = center_id
    end

    def call 
        can_invite_doctor
    end

    private

    def can_invite_doctor
        Authorization::Center::CanUpdateService.new(current_doctor: @current_doctor, center_id: @center_id).call
    end
end