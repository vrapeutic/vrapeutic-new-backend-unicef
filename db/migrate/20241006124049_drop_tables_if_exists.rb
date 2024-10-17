class DropTablesIfExists < ActiveRecord::Migration[7.0]
  def change
    drop_table(:attention_targets, if_exists: true)
    drop_table(:attention_interruptions, if_exists: true)
    drop_table(:attention_distractors, if_exists: true)
    drop_table(:attention_performances, if_exists: true)
    drop_table(:performances, if_exists: true)
  end
end
