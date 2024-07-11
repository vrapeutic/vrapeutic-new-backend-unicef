class AddCenterToChildSoftwareModule < ActiveRecord::Migration[7.0]
  def change
    # add center reference
    add_reference :child_software_modules, :center, null: false, foreign_key: true

    # remove old index 
    remove_index :child_software_modules, [:child_id , :software_module_id]

    # create new index 
    add_index :child_software_modules, [:child_id, :software_module_id, :center_id], unique: true, name: "child_modules_index"
    
  end
end
