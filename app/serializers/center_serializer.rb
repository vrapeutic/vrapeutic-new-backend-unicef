class CenterSerializer < BaseSerializer
  attributes :name, :website, :longitude, :latitude, :registration_number, :tax_id, :email, :phone_number

  attribute :logo_url do |center|
    center.logo_url
  end
  attribute :certificate_url do |center|
    center.certificate_url
  end

  has_many :headsets, if: proc { |_record, params| BaseSerializer.params_include?(params, 'headsets') }
  has_many :specialties, if: proc { |_record, params| BaseSerializer.params_include?(params, 'specialties') }
  has_many :software_modules, if: proc { |_record, params| BaseSerializer.params_include?(params, 'software_modules') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
  has_many :headsets, if: proc { |_record, params| BaseSerializer.params_include?(params, 'headsets') }
end
