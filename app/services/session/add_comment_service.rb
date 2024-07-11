class Session::AddCommentService
  def initialize(session:, comment_name:)
    @session = session
    @comment_name = comment_name
  end

  def call
    Session.transaction do
      check_session_is_ended?
      add_session_comment
    end
  end

  private

  def check_session_is_ended?
    return unless @session.ended_at.nil?

    raise 'session is already running and not ended yet'
  end

  def add_session_comment
    SessionComment.create!(session: @session, name: @comment_name)
  end
end
