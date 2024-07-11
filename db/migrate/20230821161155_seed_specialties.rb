class SeedSpecialties < ActiveRecord::Migration[7.0]
  def up
    Specialty.create(
      [
        {name: Specialty::COGNITIVE_BEHAVIORAL_THERAPY},
        {name: Specialty::OCCUPATIONAL_THERAPY},
        {name: Specialty::PHYSICAL_THERAPY},
        {name: Specialty::SENSORY_INTEGRATION},
        {name: Specialty::SPEECH_AND_LANGUAGE_THERAPY}
      ]
    )
  end

  def down 
    names = [Specialty::COGNITIVE_BEHAVIORAL_THERAPY, Specialty::OCCUPATIONAL_THERAPY, Specialty::PHYSICAL_THERAPY, Specialty::SENSORY_INTEGRATION, Specialty::SPEECH_AND_LANGUAGE_THERAPY]
    Specialty.where(name: names).destroy_all
  end
end
