class Center::GoodSessionsPercentageService

    def initialize(doctor:, center:, doctor_sessions: nil)
        @doctor = doctor
        @center = center
        @doctor_sessions = doctor_sessions
    end

    def call 
        doctor_sessions
        center_good_sessions_percentage
    end

    private


    def doctor_sessions
        if @doctor_sessions.nil?
            @sessions = Doctor::CenterSessionsService.new(doctor: @doctor, center:  @center).call
        else
            @sessions = @doctor_sessions
        end
    end

    def center_good_sessions_percentage
         # Count sessions with an evaluation of "good" or higher
        good_sessions_count = @sessions.where('evaluation >= ?', Session.evaluations['good']).count

        # Count total sessions
        total_sessions_count = @sessions.count

        # Calculate the percentage
        if total_sessions_count > 0
            return (good_sessions_count.to_f / total_sessions_count) * 100
        end
        0
    end
end