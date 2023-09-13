class CreateAttentionTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :attention_targets do |t|
      t.datetime :start_time
      t.datetime :hit_time
      t.references :attention_performance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
