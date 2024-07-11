class CreateCenterSpecialties < ActiveRecord::Migration[7.0]
  def change
    create_table :center_specialties do |t|
      t.references :center, null: false, foreign_key: true
      t.references :specialty, null: false, foreign_key: true

      t.timestamps
    end
  end
end
