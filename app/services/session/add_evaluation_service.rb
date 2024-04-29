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
    return unless @session.ended_at.nil?

    raise 'session is already running and not ended yet'
  end

  def check_session_has_evaluation?
    return unless @session.evaluation

    raise 'session is already has evaluation'
  end

  def check_evlaution_existed?
    return unless @evaluation.nil?

    raise 'evaluation not found , please submit it'
  end

  def add_evaluation
    @session.update!(evaluation: @evaluation)
  end
end
