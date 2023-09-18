class Session::EndService

    def initialize(session:, vr_duration:)
        @session = session
        @vr_duration = vr_duration
    end

    def call 
        Session.transaction do 
            check_session_is_ended?
            check_vr_duration_existed
            end_session
            @session
        end
    end

    private

    def check_session_is_ended? 
        unless @session.ended_at.nil?
            raise "session is already ended"
        end
    end

    def check_vr_duration_existed
        raise "vr duration is not existed" if @vr_duration.nil?
    end
    

    def end_session
        ended_at = Time.now 
        duration = (( ended_at - @session.created_at ) / 60.0).round(1)
        raise "vr duration cannot be greater than session duration" if @vr_duration.to_f > duration
        @session.update!(ended_at: ended_at, duration: duration, vr_duration: @vr_duration.to_f)
    end
    
end