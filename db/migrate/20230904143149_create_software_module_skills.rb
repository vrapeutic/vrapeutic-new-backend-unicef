class CreateSoftwareModuleSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :software_module_skills do |t|
      t.references :software_module, null: false, foreign_key: true
      t.references :targeted_skill, null: false, foreign_key: true

      t.timestamps
    end

    add_index :software_module_skills, [:software_module_id, :targeted_skill_id], unique: true, name: "software_module_skills_index"
  end
end
