class Doctor::UpdateService

    def initialize(doctor_id:, degree:, certificate:, specialty_ids:, photo:, university:)
        @doctor_id = doctor_id
        @degree = degree
        @certificate = certificate
        @photo = photo
        @university = university
        @specialty_ids = specialty_ids
    end

    def call 
        Doctor.transaction do 
            update_doctor
            update_doctor_specialties
            @doctor
        end
    end

    private

    def update_doctor
        @doctor = Doctor.find_by(id: @doctor_id)
        @doctor.degree = @degree if @degree.present?
        @doctor.photo = @photo if @photo.present?
        @doctor.certificate = @certificate if @certificate.present?
        @doctor.university = @university if @university.present?
        @doctor.save!
    end

    def update_doctor_specialties
        if @specialty_ids.present? && @specialty_ids.length 
            specialties = Specialty::CheckIsExistedService.new(specialty_ids: @specialty_ids).call
            # destroy old specialties 
            @doctor.specialties.destroy_all
            # create new specialties 
            @doctor.specialties << specialties
        end
    end
end