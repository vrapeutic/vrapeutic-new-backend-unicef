class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.references :center, null: false, foreign_key: true
      t.references :headset, null: false, foreign_key: true
      t.references :child, null: false, foreign_key: true
      t.integer :evaluation
      t.float :duration
      t.boolean :is_verified, default: false

      t.timestamps
    end
  end
end
