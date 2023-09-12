class Session::AddEvaluationService

    def initialize(session:, evaluation:)
        @session = session
        @evaluation = evaluation
    end

    def call 
        Session.transaction do 
            check_session_is_ended?
            check_session_has_evaluation?
            check_evlaution_existed?
            add_evaluation
        end
    end

    private

    def check_session_is_ended? 
        if @session.ended_at.nil?
            raise "session is already running and not ended yet"
        end
    end

    def check_session_has_evaluation? 
        if @session.evaluation
            raise "session is already has evaluation"
        end
    end

    def check_evlaution_existed? 
        if @evaluation.nil?
            raise "evaluation not found , please submit it"
        end
    end

    def add_evaluation
        @session.update!(evaluation: @evaluation)
    end
end