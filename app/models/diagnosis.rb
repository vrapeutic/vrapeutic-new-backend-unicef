class Diagnosis < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    # diagnoses names
    ADHD = "ADHD".freeze  
    ADD = "ADD".freeze
    SPEECH_AND_COMMUNICATIONS_DISORDER = "Speech and Communications Disorder".freeze
    DOWN_SYNDROME = "Down Syndrome".freeze 
    AUTISM = "Autism".freeze
    ASPERGER = "Asperger".freeze
end
