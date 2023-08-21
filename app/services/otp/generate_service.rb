class Otp::GenerateService
    def initialize(doctor:, expires_at: Time.now + 5.minutes)
        @doctor = doctor
        @expires_at = expires_at
    end

    def call
        generate_otp
    end

    private

    def generate_otp
        code = SecureRandom.hex(3)
        options = {code: code, expires_at: @expires_at}
        if @doctor.otp.present?
            @doctor.otp.update(options)
        else
            @doctor.create_otp(options)
        end
    end
end