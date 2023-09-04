class CreateCenterSoftwareModules < ActiveRecord::Migration[7.0]
  def change
    create_table :center_software_modules do |t|
      t.references :software_module, null: false, foreign_key: true
      t.references :center, null: false, foreign_key: true

      t.timestamps
    end

    add_index :center_software_modules, [:center_id, :software_module_id], unique: true, name: "center_modules_index"
  end
end
