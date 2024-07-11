class CreateChildCenters < ActiveRecord::Migration[7.0]
  def change
    create_table :child_centers do |t|
      t.references :child, null: false, foreign_key: true
      t.references :center, null: false, foreign_key: true

      t.timestamps
    end

    add_index :child_centers, [:child_id, :center_id], unique: true
  end
end
