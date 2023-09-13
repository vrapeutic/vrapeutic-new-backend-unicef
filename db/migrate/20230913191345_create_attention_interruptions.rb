class CreateAttentionInterruptions < ActiveRecord::Migration[7.0]
  def change
    create_table :attention_interruptions do |t|
      t.float :duration_seconds
      t.references :attention_performance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
