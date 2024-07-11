class SeedAdmin < ActiveRecord::Migration[7.0]
  def up 
    Admin.create!
  end

  def down 
    Admin.destroy_all
  end
end
