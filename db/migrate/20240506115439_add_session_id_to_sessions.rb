class AddSessionIdToSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :session_id, :string
  end
end
