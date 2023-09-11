class Session::EndService

    def initialize(session:)
        @session = session
    end

    def call 
        Session.transaction do 
            check_session_is_ended?
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

    def end_session
        ended_at = Time.now 
        duration = (( ended_at - @session.created_at ) / 60.0).round(1)
        @session.update!(ended_at: ended_at, duration: duration)
    end
    
end