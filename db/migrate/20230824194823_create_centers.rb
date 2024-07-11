class CreateCenters < ActiveRecord::Migration[7.0]
  def change
    create_table :centers do |t|
      t.string :name
      t.decimal :longitude, precision: 10, scale: 6
      t.decimal :latitude, precision: 10, scale: 6
      t.string :website
      t.string :logo
      t.string :certificate
      t.string :registration_number
      t.string :tax_id

      t.timestamps
    end
    add_index :centers, :website, unique: true
    add_index :centers, [:latitude, :longitude], unique: true
  end
end
