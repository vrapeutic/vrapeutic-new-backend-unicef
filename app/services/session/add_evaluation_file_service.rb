class Session::AddEvaluationFileService
  def initialize(session:, evaluation_file:)
    @session = session
    @evaluation_file = evaluation_file
  end

  def call
    Session.transaction do
      check_session_is_ended?
      add_session_evaluation_file
    end
  end

  private

  def check_session_is_ended?
    return if @session.ended_at?

    raise 'session is already running and not ended yet'
  end

  def add_session_evaluation_file
    @session.update(
      evaluation_file: @evaluation_file
    )
  end
end
