class AddVrDurationToSession < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :vr_duration, :float
  end
end
