class Doctor::CreateService
    def initialize(name:, email:, password:, degree:, university:, specialty_ids:)
        @name = name
        @email = email
        @password = password
        @degree = degree
        @university = university
        @specialty_ids = specialty_ids
    end

    def call 
        new_doctor = create_doctor
        if new_doctor.save
            create_doctor_specialties(new_doctor)
            Otp::GenerateService.new(doctor: new_doctor).call
            OtpMailer.send_otp(new_doctor, new_doctor.otp.code).deliver_now
            return new_doctor
        end
        raise "can't create new doctor now"
    end

    private

    def create_doctor
        Doctor.new(
            name: @name,
            email: @email.downcase,
            password: @password,
            degree: @degree,
            university: @university
        )
    end

    def create_doctor_specialties(doctor)
        doctor.specialties << Specialty.where(id: @specialty_ids)
    end
end