class AddEndedAtToSession < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :ended_at, :datetime
  end
end
