class Admin::EditDoctorService

    def initialize(doctor_id:, degree:, certificate:, specialty_ids:, photo:, university:, name:)
        @doctor_id = doctor_id
        @degree = degree
        @certificate = certificate
        @photo = photo
        @university = university
        @specialty_ids = specialty_ids
        @name = name
    end

    def call 
        update_doctor_with_specialties
    end

    private

    def update_doctor_with_specialties
        Doctor::UpdateService.new(
            doctor_id: @doctor_id, 
            degree: @degree, 
            certificate: @certificate, 
            specialty_ids: @specialty_ids, 
            photo: @photo, 
            university: @university,
            name: @name
        ).call
    end
end