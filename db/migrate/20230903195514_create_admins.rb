class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :otp
      t.datetime :expires_at

      t.timestamps
    end
  end
end
