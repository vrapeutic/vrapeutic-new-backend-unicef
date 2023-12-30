class CreateAssignedCenterModules < ActiveRecord::Migration[7.0]
  def change
    create_table :assigned_center_modules do |t|
      t.references :center, null: false, foreign_key: true
      t.references :software_module, null: false, foreign_key: true
      t.datetime :end_date

      t.timestamps
    end

    add_index :assigned_center_modules, [:center_id, :software_module_id], unique: true, name: "assigned_center_modules_index"
  end
end
