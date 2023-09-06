class CreateChildDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :child_doctors do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :child, null: false, foreign_key: true
      t.references :center, null: false, foreign_key: true

      t.timestamps
    end

    add_index :child_doctors, [:child_id, :doctor_id, :center_id], unique: true
  end
end
