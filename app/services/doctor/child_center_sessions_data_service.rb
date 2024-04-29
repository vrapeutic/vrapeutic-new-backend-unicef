class Doctor::ChildCenterSessionsDataService
  def initialize(doctor:, center_id:, child_id:, start_date:, end_date:)
    @doctor = doctor
    @center_id = center_id
    @child_id = child_id
    @start_date = start_date
    @end_date = end_date
  end

  def call
    child_sessions
    apply_date_filter
    map_date
  end

  private

  def child_sessions
    @child = Child.find(@child_id)
    @sessions = @child.sessions.where(center_id: @center_id)
  end

  def apply_date_filter
    if @start_date && @end_date
      start_date = Date.parse(@start_date)
      end_date = Date.parse(@end_date)
      @sessions = @sessions.where(created_at: start_date..end_date)
    elsif @start_date
      start_date = Date.parse(@start_date)
      @sessions = @sessions.where("created_at >= ?": start_date)
    end

    @sessions = @sessions.includes(session_modules: { performances: { performanceable: %i[attention_targets attention_distractors
                                                                                          attention_interruptions] } })
  end

  def map_date
    @sessions.map do |session|
      {
        session_id: session.id,
        session_evaluation: session.evaluation,
        session_duration: session.duration,
        session_vr_duration: session.vr_duration,
        session_modules: session.session_modules.map do |session_module|
                           {
                             module_id: session_module.software_module_id,
                             performances: session_module.performances.map do |performance|
                                             attention_performance = performance.performanceable
                                             # to do handle multiple types of perfomance
                                             {
                                               level: performance.level,
                                               attention: {
                                                 interruptions: attention_performance.attention_interruptions,
                                                 distractors: attention_performance.attention_distractors,
                                                 targets: attention_performance.attention_targets
                                               }
                                             }
                                           end
                           }
                         end
      }
    end
  end
end
