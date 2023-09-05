class Center::AssignModuleToChildService

    def initialize(child_id:, software_module_id:)
        @child_id = child_id
        @software_module_id = software_module_id
    end

    def  call 
        add_module_to_child
    end

    private

    def add_module_to_child
        ChildSoftwareModule.create!(child_id: @child_id, software_module_id: @software_module_id)
    end
end