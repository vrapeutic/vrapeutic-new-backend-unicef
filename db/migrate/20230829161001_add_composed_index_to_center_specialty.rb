class AddComposedIndexToCenterSpecialty < ActiveRecord::Migration[7.0]
  def change
    add_index :center_specialties, [:center_id, :specialty_id], unique: true
  end
end
