class AddDiscardToHeadsets < ActiveRecord::Migration[7.0]
  def change
    add_column :headsets, :discarded_at, :datetime
    add_index :headsets, :discarded_at
  end
end
