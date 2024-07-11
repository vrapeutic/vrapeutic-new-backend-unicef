class CreatePerformances < ActiveRecord::Migration[7.0]
  def change
    create_table :performances do |t|
      t.references :session_module, null: false, foreign_key: true
      t.integer :level
      t.references :performanceable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
