class SoftwareModule::CheckIsExistedService
  def initialize(software_module_ids:)
    @software_module_ids = software_module_ids
  end

  def call
    check_if_existed
  end

  private

  def check_if_existed
    error_message = 'software modules not found, please provide at least one'
    raise error_message if @software_module_ids.nil?

    software_module_records = SoftwareModule.where(id: @software_module_ids)
    raise error_message if software_module_records.count.zero?

    software_module_records
  end
end
