class AddInvitedByIdToDoctorCenters < ActiveRecord::Migration[7.0]
  def change
    add_reference :doctor_centers, :invited_by, polymorphic: true
  end
end
