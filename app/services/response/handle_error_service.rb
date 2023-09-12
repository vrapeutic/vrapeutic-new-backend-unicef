class Response::HandleErrorService
    # use it to handle error in unique check for records in database level

    def initialize(error:)
        @error = error
    end

    def call 
        handle_error_message
    end

    private

    def handle_error_message
        error_message = ''
        if @error.message.include? "PG::UniqueViolation"
            error_message = "data is already existed and duplicated"
            status = :conflict
        else
            error_message = @error.message
            status = :unprocessable_entity
        end
        {data: {error: error_message}, status: status}
    end
end