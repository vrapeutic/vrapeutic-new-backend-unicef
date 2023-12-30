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
        AssignedCenterModule.create!(center_id: @center_id, software_module_id: @software_module_id, end_date: @end_date)
    end

    def validate_end_date
        raise "end date is not existed , please provide it" unless @end_date.present?
        raise "end date must be in the future" unless Time.parse(@end_date) >= Time.now
    end
end