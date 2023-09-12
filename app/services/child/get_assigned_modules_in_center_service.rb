class Child::GetAssignedModulesInCenterService

    def initialize(child_id:, center_id:)
        @center_id = center_id
        @child_id = child_id
    end

    def call 
        get_assigned_modules_in_center
    end

    private

    def get_assigned_modules_in_center
        child = Child.find(@child_id)
        child.software_modules.where(child_software_modules: {center_id: @center_id})
    end
end