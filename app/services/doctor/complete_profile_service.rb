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
            create_doctor
            create_doctor_specialties
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

    def create_doctor
        @new_doctor = Doctor.create!(
            name: @name,
            email: @email.downcase,
            password: @password,
            degree: @degree,
            university: @university,
            photo: @photo,
            certificate: @certificate
        )
    end

    def create_doctor_specialties
        error_message = 'specialties not found, please provide at least one'
        raise error_message if @specialty_ids.nil? || @specialty_ids.length == 0
        @new_doctor.specialties << Specialty.where(id: @specialty_ids)
    end

    def create_doctor_center_role
        DoctorCenter.create!(center_id: @center_id, doctor: @new_doctor)
    end
end