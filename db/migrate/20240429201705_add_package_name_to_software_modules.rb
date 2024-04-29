class AddPackageNameToSoftwareModules < ActiveRecord::Migration[7.0]
  def change
    add_column :software_modules, :package_name, :string
  end
end
