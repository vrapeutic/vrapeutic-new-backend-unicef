class SoftwareModule::CreateService

    def initialize(create_params:, targeted_skill_ids:)
        @create_params = create_params
        @targeted_skill_ids = targeted_skill_ids
    end

    def call 
        SoftwareModule.transaction do 
            check_targeted_skills_existed
            create_software_moudle
            create_software_moudle_skills
            @new_software_module
        end
        rescue => e 
            raise e
    end

    private

    def create_software_moudle
        @new_software_module = SoftwareModule.create!(@create_params)
    end

    def check_targeted_skills_existed
        @targeted_skill_records = TargetedSkill::CheckIsExistedService.new(targeted_skill_ids: @targeted_skill_ids).call
    end

    def create_software_moudle_skills
        @new_software_module.targeted_skills << @targeted_skill_records
    end
end