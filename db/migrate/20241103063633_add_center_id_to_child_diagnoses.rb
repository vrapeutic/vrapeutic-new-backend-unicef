class AddCenterIdToChildDiagnoses < ActiveRecord::Migration[7.0]
  def change
    add_reference :child_diagnoses, :center, null: true, foreign_key: true
  end
end
