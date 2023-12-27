class SoftwareModule::CreateService

    def initialize(name:, version:, technology:, min_age:, max_age:, image:, targeted_skill_ids:)
        @name = name
        @version = version
        @technology= technology
        @min_age = min_age
        @max_age= max_age
        @image = image
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
        @new_software_module = SoftwareModule.create!(
            name: @name,
            version: @version,
            technology: @technology,
            min_age: @min_age,
            max_age: @max_age,
            image: @image
        )
    end

    def check_targeted_skills_existed
        @targeted_skill_records = TargetedSkill::CheckIsExistedService.new(targeted_skill_ids: @targeted_skill_ids).call
    end

    def create_software_moudle_skills
        @new_software_module.targeted_skills << @targeted_skill_records
    end
end