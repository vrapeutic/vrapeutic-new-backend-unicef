class AddCodeTypeToOtp < ActiveRecord::Migration[7.0]
  def change
    add_column :otps, :code_type, :integer, default: Otp.code_types[Otp::EMAIL_VERIFICATION]
  end
end
