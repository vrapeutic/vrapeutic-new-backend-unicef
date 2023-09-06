class Center::AddModulesService

    def initialize(software_module_ids: , center_id:)
        @software_module_ids = software_module_ids
        @center_id = center_id
    end

    def call 
        Center.transaction do 
            check_software_modules_existed
            find_center
            add_modules_to_center
        end
        rescue => e 
            raise e
    
    end

    private

    def find_center
        @center = Center.find_by(id: @center_id)
    end

    def check_software_modules_existed
        @software_module_records = SoftwareModule::CheckIsExistedService.new(software_module_ids: @software_module_ids).call
    end

    def add_modules_to_center
        @center.software_modules << @software_module_records
    end
end