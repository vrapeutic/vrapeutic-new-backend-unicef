class Session::AddAttentionPerformanceModulesService

    def initialize(session:, modules_data:, duration:, vr_duration:)
        @session = session
        @modules_data = modules_data
        @duration = duration
        @vr_duration = vr_duration
    end

    def call 
        Session.transaction do 
            check_duration_existed
            update_session
            add_attention_performance_module_date
        end
    end

    private

    def check_duration_existed
        raise "session duration is not existed, please provide it" if @duration.nil?
        raise "vr duration is not existed, please provide it" if @vr_duration.nil?
        raise "session duration can't be less than vr duration" if @vr_duration > @duration
    end

    def update_session
        @session.update!(duration: @duration, vr_duration: @vr_duration, ended_at: @session.created_at + @duration.to_f.minutes)
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