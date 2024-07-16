class SeedAssignedCenterModule < ActiveRecord::Migration[7.0]
  def change
    if Object.const_defined?('CenterSoftwareModule')
      result = CenterSoftwareModule.all

      result.each do |record|
        AssignedCenterModule.create(
          center_id: record.center_id,
          software_module_id: record.software_module_id,
          end_date: Time.now + 1.years
        )
      end
    end
  end
end
