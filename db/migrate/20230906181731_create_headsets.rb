class CreateHeadsets < ActiveRecord::Migration[7.0]
  def change
    create_table :headsets do |t|
      t.string :name
      t.string :brand
      t.string :model
      t.string :version
      t.string :key
      t.references :center, null: false, foreign_key: true

      t.timestamps
    end
    add_index :headsets, :key, unique: true
    add_index :headsets, [:name, :center_id], unique: true
  end
end
