class CreateChildDiagnoses < ActiveRecord::Migration[7.0]
  def change
    create_table :child_diagnoses do |t|
      t.references :child, null: false, foreign_key: true
      t.references :diagnosis, null: false, foreign_key: true

      t.timestamps
    end

    add_index :child_diagnoses, [:child_id, :diagnosis_id], unique: true
  end
end
