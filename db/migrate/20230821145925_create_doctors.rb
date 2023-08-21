class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :degree
      t.string :university
      t.boolean :is_email_verified, default: false

      t.timestamps
    end
    add_index :doctors, :email, unique: true
  end
end
