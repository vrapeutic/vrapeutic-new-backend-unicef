class CreateAttentionPerformances < ActiveRecord::Migration[7.0]
  def change
    create_table :attention_performances do |t|

      t.timestamps
    end
  end
end
