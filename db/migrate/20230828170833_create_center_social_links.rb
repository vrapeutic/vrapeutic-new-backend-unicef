class CreateCenterSocialLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :center_social_links do |t|
      t.references :center, null: false, foreign_key: true
      t.string :link
      t.integer :link_type

      t.timestamps
    end

    add_index :center_social_links, [:link], unique: true
  end
end
