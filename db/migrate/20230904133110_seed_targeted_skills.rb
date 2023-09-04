class SeedTargetedSkills < ActiveRecord::Migration[7.0]
  def up
    TargetedSkill.create(
      [
        {name: TargetedSkill::ACADEMIC_SKILLS},
        {name: TargetedSkill::ATTENTION_SKILLS},
        {name: TargetedSkill::COGNITIVE_SKILLS},
        {name: TargetedSkill::MEMORY_SKILLS},
        {name: TargetedSkill::MOTOR_SKILLS},
        {name: TargetedSkill::SOCIAL_SKILLS},
      ]
    )
  end

  def down 
    names = [ TargetedSkill::ACADEMIC_SKILLS, TargetedSkill::ATTENTION_SKILLS, TargetedSkill::COGNITIVE_SKILLS, TargetedSkill::MEMORY_SKILLS, TargetedSkill::MOTOR_SKILLS, TargetedSkill::SOCIAL_SKILLS ]
    TargetedSkill.where(name: names).destroy_all
  end
end
