class Session::AddAttentionPerformanceModulesService

    def initialize(session:, modules_data:)
        @session = session
        @modules_data = modules_data
    end

    def call 
        Session.transaction do 
            check_session_is_ended?
            add_attention_performance_module_date
        end
    end

    private

    def check_session_is_ended? 
        if @session.ended_at.nil?
            raise "session is already running and not ended yet"
        end
    end

    def add_attention_performance_module_date
        @modules_data.each do |module_data| 
            Session::AddAttentionPerformanceService.new(
                session: @session,
                software_module_id: module_data[:software_module_id],
                level: module_data[:level],
                targets: module_data[:targets],
                distractors: module_data[:distractors],
                interruptions: module_data[:interruptions]
            ).call
        end
    end
end