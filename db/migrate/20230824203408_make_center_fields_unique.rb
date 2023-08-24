class MakeCenterFieldsUnique < ActiveRecord::Migration[7.0]
  def change
    add_index :centers, :tax_id, unique: true
    add_index :centers, :registration_number, unique: true
  end
end
