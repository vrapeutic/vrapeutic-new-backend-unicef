class Doctor::CompleteProfileService

    def initialize( token:, name:, password:, degree:, university:, specialty_ids:, photo:, certificate: )
        @token = token
        @name = name
        @password = password
        @degree = degree
        @university = university
        @specialty_ids = specialty_ids
        @photo = photo
        @certificate = certificate
    end

    def call 
        Doctor.transaction do 
            decode_token
            create_doctor_with_specialties
            create_doctor_center_role
            @new_doctor
        end
        rescue => e 
            puts e.as_json
            raise e
    end

    private

    def decode_token
        raise "token is not found, please provide it" if @token.nil?
        decoded_data = JsonWebToken.decode(@token)
        raise "invitaion is expired" unless decoded_data
        @email = decoded_data['email']
        @center_id = decoded_data['center_id']
    end

    def create_doctor_with_specialties
        @new_doctor = Doctor::CreateService.new(
            name: @name,
            email: @email,
            password: @password,
            degree: @degree,
            university: @university,
            specialty_ids: @specialty_ids,
            photo: @photo,
            certificate: @certificate,
            is_invited: true
        ).call
    end

    def create_doctor_center_role
        DoctorCenter.create!(center_id: @center_id, doctor: @new_doctor)
    end
end