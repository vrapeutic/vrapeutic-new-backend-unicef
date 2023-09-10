class Doctor::UpdateService

    def initialize(doctor_id:, degree:, certificate:, specialty_ids:, photo:, university:, name:)
        @doctor_id = doctor_id
        @degree = degree
        @certificate = certificate
        @photo = photo
        @university = university
        @specialty_ids = specialty_ids
        @name = name
        @specialty_records = nil
    end

    def call 
        Doctor.transaction do 
            check_specialties_existed
            update_doctor
            update_doctor_specialties
            @doctor
        end
    end

    private

    def update_doctor
        @doctor = Doctor.find(@doctor_id)
        @doctor.name = @name if @name.present?
        @doctor.degree = @degree if @degree.present?
        @doctor.photo = @photo if @photo.present?
        @doctor.certificate = @certificate if @certificate.present?
        @doctor.university = @university if @university.present?
        @doctor.save!
    end

    def check_specialties_existed
        if @specialty_ids.present? 
            @specialty_records = Specialty::CheckIsExistedService.new(specialty_ids: @specialty_ids).call
        end
    end

    def update_doctor_specialties
        unless @specialty_records.nil? 
            # destroy old specialties 
            @doctor.specialties.destroy_all
            # create new specialties 
            @doctor.specialties << @specialty_records
        end
    end
end