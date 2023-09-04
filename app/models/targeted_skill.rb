class TargetedSkill < ApplicationRecord

    validates :name, presence: true, uniqueness: true

    # names 
    MOTOR_SKILLS = "Motor Skills".freeze
    SOCIAL_SKILLS = "Social Skills".freeze
    ATTENTION_SKILLS = "Attention Skills".freeze
    MEMORY_SKILLS = "Memory Skills".freeze
    COGNITIVE_SKILLS = "Cognitive Skills".freeze
    ACADEMIC_SKILLS = "Academic Skills".freeze
end
