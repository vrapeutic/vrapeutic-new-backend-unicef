class DoctorCenterSerializer < BaseSerializer
  attributes :doctor_id, :center_id, :role, :created_at, :updated_at

  attribute :sessions_number do |doctor_center|
    doctor_center&.doctor&.sessions&.any? ? doctor_center.doctor.sessions.where(center_id: doctor_center.center_id).count : 0
  end

  has_one :center, if: proc { |_record, params| BaseSerializer.params_include?(params, 'center') }
  has_one :doctor, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctor') }
end
