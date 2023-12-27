class SoftwareModule::CreateService

    def initialize(name:, version:, technology:, min_age:, max_age:, image:, targeted_skill_ids:)
        @name = name
        @version = version
        @technology= technology
        @min_age = min_age.to_i
        @max_age= max_age.to_i
        @image = image
        @targeted_skill_ids = targeted_skill_ids
    end

    def call 
        SoftwareModule.transaction do 
            check_age_range_valid?
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

    def check_age_range_valid?
        raise "min age and max age should be existed and valid numbers" if @min_age == 0 || @max_age == 0 
        raise "max age must be greater than min age" if @min_age >= @max_age
    end

    def check_targeted_skills_existed
        @targeted_skill_records = TargetedSkill::CheckIsExistedService.new(targeted_skill_ids: @targeted_skill_ids).call
    end

    def create_software_moudle_skills
        @new_software_module.targeted_skills << @targeted_skill_records
    end
end