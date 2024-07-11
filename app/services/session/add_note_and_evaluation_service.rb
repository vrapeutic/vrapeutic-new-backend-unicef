class Session::AddNoteAndEvaluationService
  def initialize(session:, note:, evaluation:)
    @session = session
    @note = note
    @evaluation = evaluation
  end

  def call
    Session.transaction do
      check_session_is_ended?

      check_evlaution_existed?

      add_note_and_evaluation
    end
  end

  private

  def check_session_is_ended?
    return unless @session.ended_at?

    raise 'session is already running and not ended yet'
  end

  def check_evlaution_existed?
    return if @session.evaluation? || @evaluation.present?

    raise 'evaluation not found , please submit it'
  end

  def add_note_and_evaluation
    @session.update!(evaluation: @evaluation, note: @note)
  end
end
