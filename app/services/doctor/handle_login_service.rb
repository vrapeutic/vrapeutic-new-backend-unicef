class Doctor::HandleLoginService
    def initialize(email:, password:)
        @email = email
        @password = password
    end

    def call 
        handle_login
    end

    private

    def handle_login
        unless @email.present? || @password.present?
            raise "Invalid credentials"
        end


        if @email.downcase == ENV['ADMIN_EMAIL']
            return {is_admin: true}
        end

        doctor = Doctor.find_by(email: @email.downcase)

        unless doctor.present?
            raise "Invalid credentials"
        end
    
        unless doctor.authenticate(@password).present?
            raise "Invalid credentials"
        end

        # generate token 
        # Doctor::GenerateJwtTokenService.new(doctor_id: doctor.id).call
        {doctor: doctor, is_admin: false}

    end
    
end