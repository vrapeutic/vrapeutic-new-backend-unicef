class TargetedSkill::CheckIsExistedService 

    def initialize(targeted_skill_ids:)
        @targeted_skill_ids = targeted_skill_ids
    end

    def call 
        check_if_existed
    end

    private

    def check_if_existed
        error_message = 'targeted skills not found, please provide at least one'
        raise error_message if @targeted_skill_ids.nil? 
        targeted_skill_records = TargetedSkill.where(id: @targeted_skill_ids)
        raise error_message if targeted_skill_records.count == 0
        targeted_skill_records
    end
end