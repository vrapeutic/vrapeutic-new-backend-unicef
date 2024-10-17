class DropTableIfExists < ActiveRecord::Migration[7.0]
  def up
    drop_table(:delayed_jobs, if_exists: true)
  end
end
