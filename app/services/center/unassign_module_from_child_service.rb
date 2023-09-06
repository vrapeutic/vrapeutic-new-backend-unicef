class Center::UnassignModuleFromChildService

    def initialize(child_id:, software_module_id:, center_id:)
        @child_id = child_id
        @software_module_id = software_module_id
        @center_id = center_id
    end

    def call 
        remove_module_from_child
    end

    private

    def remove_module_from_child
        ChildSoftwareModule.find_by(child_id: @child_id, software_module_id: @software_module_id, center_id: @center_id).destroy
    end
end