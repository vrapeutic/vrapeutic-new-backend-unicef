class Session::HasModuleService
  def initialize(session_id:, software_module_id:)
    @session_id = session_id
    @software_module_id = software_module_id
  end

  def call
    session_has_module?
  end

  private

  def session_has_module?
    SessionModule.find_by(session_id: @session_id, software_module_id: @software_module_id).present? ? true : false
  end
end
