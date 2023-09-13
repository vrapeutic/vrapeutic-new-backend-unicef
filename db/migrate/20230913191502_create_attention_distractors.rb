class CreateAttentionDistractors < ActiveRecord::Migration[7.0]
  def change
    create_table :attention_distractors do |t|
      t.string :name
      t.float :time_following_it_seconds
      t.references :attention_performance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
