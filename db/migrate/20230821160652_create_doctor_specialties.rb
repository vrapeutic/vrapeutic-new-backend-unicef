class CreateDoctorSpecialties < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_specialties do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :specialty, null: false, foreign_key: true

      t.timestamps
    end
  end
end
