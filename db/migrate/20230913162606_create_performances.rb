class CreatePerformances < ActiveRecord::Migration[7.0]
  def change
    create_table :performances do |t|
      t.references :session_module, null: false, foreign_key: true
      t.references :targeted_skill, null: false, foreign_key: true
      t.references :performanceable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :performances, [:session_module_id, :targeted_skill_id], unique: true
  end
end
