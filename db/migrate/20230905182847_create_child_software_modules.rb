class CreateChildSoftwareModules < ActiveRecord::Migration[7.0]
  def change
    create_table :child_software_modules do |t|
      t.references :software_module, null: false, foreign_key: true
      t.references :child, null: false, foreign_key: true

      t.timestamps
    end

    add_index :child_software_modules, [:child_id, :software_module_id], unique: true
  end
end
