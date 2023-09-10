class Otp::FindByTypeService

    def initialize(doctor:, code_type: Otp::EMAIL_VERIFICATION)
        @doctor = doctor
        @code_type = code_type
    end

    def call 
        find_otp_record
    end

    private

    def find_otp_record
        @doctor.otps.find_by(code_type: @code_type)
    end
end