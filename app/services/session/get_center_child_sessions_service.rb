class Session::GetCenterChildSessionsService
  def initialize(child_id:, center_id:)
    @center_id = center_id
    @child_id = child_id
  end

  def call
    center_child_sessions
  end

  private

  def center_child_sessions
    Child::GetAssignedSessionsInCenterService.new(child_id: @child_id, center_id: @center_id).call
  end
end
