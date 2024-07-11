class Session::AddSoftwareModuleService
  def initialize(session_id:, software_module_id:)
    @session_id = session_id
    @software_module_id = software_module_id
  end

  def call
    add_module_to_session
  end

  private

  def add_module_to_session
    SessionModule.create!(session_id: @session_id, software_module_id: @software_module_id)
  end
end
