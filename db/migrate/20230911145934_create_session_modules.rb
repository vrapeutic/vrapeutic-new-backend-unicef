class CreateSessionModules < ActiveRecord::Migration[7.0]
  def change
    create_table :session_modules do |t|
      t.references :session, null: false, foreign_key: true
      t.references :software_module, null: false, foreign_key: true

      t.timestamps
    end

    add_index :session_modules, [:session_id, :software_module_id], unique: true
  end
end
