class Doctor::GetCenterChildModulesService

    def initialize(center_id:, child_id:)
        @center_id = center_id
        @child_id = child_id
    end

    def call 
        child_modules_in_center
    end

    private

    def child_modules_in_center
        Child::GetAssignedModulesInCenterService.new(child_id: @child_id, center_id: @center_id).call
    end
end