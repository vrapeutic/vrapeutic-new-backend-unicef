class AddCertificateToDoctor < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :certificate, :string, null: false
  end
end
