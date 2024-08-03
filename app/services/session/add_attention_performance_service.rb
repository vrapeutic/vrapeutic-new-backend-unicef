class Session::AddAttentionPerformanceService
  def initialize(session:, software_module_id:, targets:, interruptions:, distractors:, level:)
    @session = session
    @software_module_id = software_module_id
    @targets = targets
    @interruptions = interruptions
    @distractors = distractors
    @level = level
  end

  def call
    Session.transaction do
      check_session_is_ended?
      create_attention_performance_record
      create_attention_targets
      create_attention_distractors
      create_attention_interruption
      create_session_performance
    end
  end

  private

  def check_session_is_ended?
    return if @session.ended_at?

    raise 'session is already running and not ended yet'
  end

  def create_attention_performance_record
    @attention_performance_record = AttentionPerformance.create!
  end

  def create_attention_targets
    @attention_performance_record.attention_targets.create!(JSON.parse(@targets.to_json))
  end

  def create_attention_distractors
    @attention_performance_record.attention_distractors.create!(JSON.parse(@distractors.to_json))
  end

  def create_attention_interruption
    @attention_performance_record.attention_interruptions.create!(JSON.parse(@interruptions.to_json))
  end

  def create_session_performance
    session_module_record = SessionModule.find_by(session_id: @session.id, software_module_id: @software_module_id)
    Performance.create!(session_module: session_module_record, level: @level, performanceable: @attention_performance_record)
  end
end
