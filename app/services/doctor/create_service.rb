class Doctor::CreateService
    def initialize(name:, email:, password:, degree:, university:)
        @name = name
        @email = email
        @password = password
        @degree = degree
        @university = university
    end

    def call 
        new_doctor = create_doctor
        if new_doctor.save
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
end