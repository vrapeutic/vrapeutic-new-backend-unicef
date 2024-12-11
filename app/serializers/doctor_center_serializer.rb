class DoctorCenterSerializer < BaseSerializer
  attributes :doctor_id, :center_id, :status, :role, :center, :created_at, :updated_at

  attribute :sessions_number do |doctor_center|
    doctor_center.approved? && doctor_center.doctor.sessions&.any? ? doctor_center.doctor.sessions.where(center_id: doctor_center.center_id).count : 0
  end

  attribute :invited_by_email do |doctor_center|
    doctor_center&.invited_by&.email
  end

  has_one :center, if: proc { |_record, params| BaseSerializer.params_include?(params, 'center') }
  has_one :doctor, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctor') }
  has_one :invited_by, if: proc { |_record, params| BaseSerializer.params_include?(params, 'invited_by') }
end
