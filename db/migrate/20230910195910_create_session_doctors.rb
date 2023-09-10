class CreateSessionDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :session_doctors do |t|
      t.references :session, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end

    add_index :session_doctors, [:doctor_id, :session_id], unique: true
  end
end
