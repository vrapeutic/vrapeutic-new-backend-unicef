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
        child = Child.find(@child_id)
        child.software_modules.where(child_software_modules: {center_id: @center_id})
    end
end