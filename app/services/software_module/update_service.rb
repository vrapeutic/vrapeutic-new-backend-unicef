class SoftwareModule::UpdateService
  def initialize(edit_params:, targeted_skill_ids:, software_module_id:)
    @edit_params = edit_params
    @targeted_skill_ids = targeted_skill_ids
    @software_module_id = software_module_id
    @targeted_skill_records = nil
  end

  def call
    SoftwareModule.transaction do
      check_targeted_skills_existed
      find_software_module
      update_software_moudle
      update_software_moudle_skills
      @software_module
    end
  rescue StandardError => e
    raise e
  end

  private

  def find_software_module
    @software_module = SoftwareModule.find(@software_module_id)
  end

  def update_software_moudle
    @software_module.update!(@edit_params)
  end

  def check_targeted_skills_existed
    return unless @targeted_skill_ids.present?

    @targeted_skill_records = TargetedSkill::CheckIsExistedService.new(targeted_skill_ids: @targeted_skill_ids).call
  end

  def update_software_moudle_skills
    return if @targeted_skill_records.nil?

    # destroy old records
    @software_module.targeted_skills.destroy_all
    # create new skills
    @software_module.targeted_skills << @targeted_skill_records
  end
end
