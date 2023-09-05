class Center::HasModuleService

    def initialize(center_id:, software_module_id:)
        @center_id = center_id
        @software_module_id = software_module_id
    end


    def call 
        center_has_module?
    end

    private

    def center_has_module?
        CenterSoftwareModule.find_by(center_id: @center_id, software_module_id: @software_module_id).present? ? true : false
    end
end