class Child::HasModuleInCenterService
  def initialize(child_id:, software_module_id:, center_id:)
    @child_id = child_id
    @software_module_id = software_module_id
    @center_id = center_id
  end

  def call
    child_has_module?
  end

  private

  def child_has_module?
    ChildSoftwareModule.find_by(child_id: @child_id, software_module_id: @software_module_id, center_id: @center_id).present? ? true : false
  end
end
