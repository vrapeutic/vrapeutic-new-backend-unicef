class Doctor::GetCenterDoctorsService

    def initialize(current_doctor:, center_id:)
        @center_id = center_id
        @current_doctor = current_doctor
    end

    def call 
        home_doctors
    end

    private

    def home_doctors 
        center = Center.find(@center_id)
        doctors = center.doctors.select(
                           'doctors.id AS id',
                           'doctors.name AS name',
                           'doctors.photo AS photo',
                           'doctor_centers.created_at AS join_date',
                           'COUNT(DISTINCT(sessions.id)) AS number_of_sessions'
                         )
                         .left_joins(:doctor_centers, :sessions)
                         .group('doctors.id, doctor_centers.created_at')
                         .includes(:specialties)

        doctors.map do |doctor|
            doctor.image_url = doctor.photo.url # Assuming doctor.photo is the CarrierWave field for photos
            doctor
        end
    end
end