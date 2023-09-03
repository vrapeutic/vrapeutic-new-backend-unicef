class CreateDiagnoses < ActiveRecord::Migration[7.0]
  def change
    create_table :diagnoses do |t|
      t.string :name

      t.timestamps
    end
    add_index :diagnoses, :name, unique: true
  end
end
