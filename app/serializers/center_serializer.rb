class CenterSerializer < BaseSerializer
  attributes :name, :longitude, :latitude, :logo, :website, :email, :phone_number,
             :tax_id, :certificate, :registration_number, :created_at, :updated_at

  attribute :logo_url do |center|
    center.logo_url
  end
  attribute :certificate_url do |center|
    center.certificate_url
  end
  attribute :specialties_number do |center|
    center.specialties.count
  end
  attribute :doctors_number do |center|
    center.doctors.count
  end
  attribute :children_number do |center|
    center.children.count
  end

  has_many :headsets, if: proc { |_record, params| BaseSerializer.params_include?(params, 'headsets') }
  has_many :specialties, if: proc { |_record, params| BaseSerializer.params_include?(params, 'specialties') }
  has_many :software_modules, if: proc { |_record, params| BaseSerializer.params_include?(params, 'software_modules') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
  has_many :center_social_links, if: proc { |_record, params| BaseSerializer.params_include?(params, 'center_social_links') }
  has_many :children, if: proc { |_record, params| BaseSerializer.params_include?(params, 'children') }
end
