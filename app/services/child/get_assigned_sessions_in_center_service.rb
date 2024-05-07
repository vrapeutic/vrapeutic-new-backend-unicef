class Child::GetAssignedSessionsInCenterService
  def initialize(child_id:, center_id:)
    @center_id = center_id
    @child_id = child_id
  end

  def call
    set_assigned_sessions_in_center
  end

  private

  def set_assigned_sessions_in_center
    child = Child.find(@child_id)
    child.sessions.where(sessions: { center_id: @center_id })
  end
end
