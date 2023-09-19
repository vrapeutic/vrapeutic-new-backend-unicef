class Doctor::CenterStatisticsService

    def initialize(doctor:, center_id:)
        @doctor = doctor
        @center_id = center_id
    end

    def call 
        get_center
        doctor_sessions
        {
            good_session_percentage: center_good_sessions_percentage ,
            vr_percentage: center_vr_percentage,
            kids_using_vr_percentage: center_kids_sessions_percentage
        }
    end

    private

    def get_center
        @center = Center.find(@center_id)
    end

    # if admin return all center sessions or return only doctor sessions if doctor is normal worker
    def doctor_sessions 
        @sessions = Doctor::CenterSessionsService.new(doctor: @doctor, center:  @center).call
    end

    def center_good_sessions_percentage
        Center::GoodSessionsPercentageService.new(doctor: @doctor, center: @center, doctor_sessions: @sessions).call
    end

    def center_vr_percentage
        Center::SessionsVrPercentageService.new(doctor: @doctor, center: @center, doctor_sessions: @sessions).call
    end

    def center_kids_sessions_percentage
        Center::KidsSessionsPercentageService.new(doctor: @doctor, center: @center).call
    end
end