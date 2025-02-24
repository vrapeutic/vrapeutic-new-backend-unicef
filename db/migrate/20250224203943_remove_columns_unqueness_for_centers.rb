class RemoveColumnsUnquenessForCenters < ActiveRecord::Migration[7.0]
  def change
    remove_index :centers, name: 'index_centers_on_email'
    remove_index :centers, name: 'index_centers_on_phone_number'
  end
end
