class AddPhotoToDoctor < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :photo, :string, null:false
  end
end
