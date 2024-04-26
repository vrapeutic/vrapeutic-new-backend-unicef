class AddPhotoToChildren < ActiveRecord::Migration[7.0]
  def change
    add_column :children, :photo, :string
  end
end
