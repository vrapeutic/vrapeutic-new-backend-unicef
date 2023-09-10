class AddUniqueKeyToOtp < ActiveRecord::Migration[7.0]
  def change
    add_index :otps, [:doctor_id, :code_type], unique: true
  end
end
