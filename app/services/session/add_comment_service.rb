class Session::AddCommentService

    def initialize(session_id:, comment_name:)
        @session_id = session_id
        @comment_name = comment_name
    end

    def call 
        add_session_comment
    end

    private

    def add_session_comment
        SessionComment.create!(session_id: @session_id, name: @comment_name)
    end
end