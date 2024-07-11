class Admin::AssignCenterModuleService
  def initialize(center_id:, software_module_id:, end_date:)
    @center_id = center_id
    @software_module_id = software_module_id
    @end_date = end_date
  end

  def call
    validate_end_date
    assign_module_to_center
  end

  private

  def assign_module_to_center
    assigned_center = AssignedCenterModule.find_by(center_id: @center_id, software_module_id: @software_module_id)

    if assigned_center&.id?
      assigned_center.update(end_date: @end_date)
    else
      AssignedCenterModule.create!(center_id: @center_id, software_module_id: @software_module_id, end_date: @end_date)
    end
  end

  def validate_end_date
    raise 'end date is not existed , please provide it' unless @end_date.present?
    raise 'end date must be in the future' unless Time.parse(@end_date) >= (AssignedCenterModule::END_DATE + 24.hours)
  end
end
