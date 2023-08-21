class Otp::ValidateService
    def initialize(doctor:, entered_otp:)
        @doctor = doctor
        @entered_otp = entered_otp
    end

    def call
        validate_otp
    end

    private

    def validate_otp
        return false unless @doctor.otp.present?

        return false if @doctor.otp.expires_at < Time.now

        @doctor.otp.code == @entered_otp
    end
end