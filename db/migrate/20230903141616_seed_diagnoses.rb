class SeedDiagnoses < ActiveRecord::Migration[7.0]
  def up
    Diagnosis.create(
      [
        {name: Diagnosis::ADD},
        {name: Diagnosis::ADHD},
        {name: Diagnosis::ASPERGER},
        {name: Diagnosis::AUTISM},
        {name: Diagnosis::DOWN_SYNDROME},
        {name: Diagnosis::SPEECH_AND_COMMUNICATIONS_DISORDER},
      ]
    )
  end

  def down 
    names = [ Diagnosis::ADD, Diagnosis::ADHD, Diagnosis::ASPERGER, Diagnosis::AUTISM, Diagnosis::DOWN_SYNDROME, Diagnosis::SPEECH_AND_COMMUNICATIONS_DISORDER ]
    Diagnosis.where(name: names).destroy_all
  end
end
