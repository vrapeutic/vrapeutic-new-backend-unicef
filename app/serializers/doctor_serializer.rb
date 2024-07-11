class DoctorSerializer < BaseSerializer
  attributes :name, :email, :degree, :university, :is_email_verified, :created_at, :updated_at

  attribute :photo_url do |doctor|
    doctor.photo_url
  end
  attribute :certificate_url do |doctor|
    doctor.certificate_url
  end

  has_many :specialties, if: proc { |_record, params| BaseSerializer.params_include?(params, 'specialties') }
  has_many :centers, if: proc { |_record, params| BaseSerializer.params_include?(params, 'centers') }
  has_many :children, if: proc { |_record, params| BaseSerializer.params_include?(params, 'children') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
end
