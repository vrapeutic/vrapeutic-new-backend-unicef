class CreateSoftwareModules < ActiveRecord::Migration[7.0]
  def change
    create_table :software_modules do |t|
      t.string :name
      t.string :version
      t.integer :technology

      t.timestamps
    end
  end
end
