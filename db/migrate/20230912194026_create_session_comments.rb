class CreateSessionComments < ActiveRecord::Migration[7.0]
  def change
    create_table :session_comments do |t|
      t.references :session, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end

    add_index :session_comments, [:session_id, :name], unique: true
  end
end
