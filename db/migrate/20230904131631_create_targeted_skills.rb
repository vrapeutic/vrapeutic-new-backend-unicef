class CreateTargetedSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :targeted_skills do |t|
      t.string :name

      t.timestamps
    end
    add_index :targeted_skills, :name, unique: true
  end
end
