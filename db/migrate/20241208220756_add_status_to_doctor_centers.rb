class AddStatusToDoctorCenters < ActiveRecord::Migration[7.0]
  def change
    add_column :doctor_centers, :status, :integer, default: 0

    DoctorCenter.update_all(status: 1)
  end
end
