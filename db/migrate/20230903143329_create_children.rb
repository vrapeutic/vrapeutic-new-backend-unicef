class CreateChildren < ActiveRecord::Migration[7.0]
  def change
    create_table :children do |t|
      t.string :name
      t.string :email
      t.integer :age

      t.timestamps
    end
    add_index :children, :email, unique: true
  end
end
