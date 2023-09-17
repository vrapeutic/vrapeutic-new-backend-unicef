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
        center.doctors.select(
                           'doctors.id AS id',
                           'doctors.name AS name',
                           'doctor_centers.created_at AS join_date',
                           'COUNT(DISTINCT(sessions.id)) AS number_of_sessions'
                         )
                         .left_joins(:doctor_centers, :sessions)
                         .group('doctors.id, doctor_centers.created_at')
                         .includes(:specialties)
    end
end