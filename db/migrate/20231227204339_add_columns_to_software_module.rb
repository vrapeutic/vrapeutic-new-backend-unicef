class AddColumnsToSoftwareModule < ActiveRecord::Migration[7.0]
  def change
    add_column :software_modules, :min_age, :integer
    add_column :software_modules, :max_age, :integer
    add_column :software_modules, :image, :string
  end
end
