class Child::HasModuleService

    def initialize(child_id:, software_module_id:)
        @child_id = child_id
        @software_module_id = software_module_id
    end

    def call 
        child_has_module?
    end

    private

    def child_has_module?
        ChildSoftwareModule.find_by(child_id: @child_id, software_module_id: @software_module_id).present? ? true : false
    end
end