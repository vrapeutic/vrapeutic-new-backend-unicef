class AddFieldsToCenter < ActiveRecord::Migration[7.0]
  def change
    add_column :centers, :email, :string
    add_index :centers, :email, unique: true
    add_column :centers, :phone_number, :string
    add_index :centers, :phone_number, unique: true
  end
end
