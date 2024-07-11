class AddNoteToSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :note, :text
  end
end
