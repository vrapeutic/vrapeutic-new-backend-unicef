class DropCenterSoftwareModulesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :center_software_modules do |t|
      t.references :software_module, null: false, foreign_key: true
      t.references :center, null: false, foreign_key: true

      t.timestamps
    end
  end
end
