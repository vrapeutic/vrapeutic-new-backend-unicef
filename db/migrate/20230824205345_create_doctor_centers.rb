class CreateDoctorCenters < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_centers do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :center, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
    add_index :doctor_centers, [:doctor_id, :center_id], unique: true
  end
end
