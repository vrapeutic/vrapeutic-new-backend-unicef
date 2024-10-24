class HomeDoctorSerializer < BaseSerializer
  attributes :name, :join_date, :number_of_sessions, :specialties, :photo_url, :degree

  attribute :is_center_admin, if: proc { |_doctor, params|
    params && params[:center_id]
  } do |doctor, params|
    doctor.doctor_centers.find_by(center_id: params[:center_id]).admin?
  end

  has_many :specialties, if: proc { |_record, params| BaseSerializer.params_include?(params, 'specialties') }
  has_many :centers, if: proc { |_record, params| BaseSerializer.params_include?(params, 'centers') }
  has_many :children, if: proc { |_record, params| BaseSerializer.params_include?(params, 'children') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
end
