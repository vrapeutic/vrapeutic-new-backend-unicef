class HomeCenterSerializer
  include JSONAPI::Serializer
  attributes :name, :longitude, :latitude, :logo, :website, :email, :phone_number, :doctors_count,
             :children_count, :specialties, :registration_number, :tax_id, :center_social_links, :certificate

  has_many :headsets, if: proc { |_record, params| BaseSerializer.params_include?(params, 'headsets') }
  has_many :specialties, if: proc { |_record, params| BaseSerializer.params_include?(params, 'specialties') }
  has_many :software_modules, if: proc { |_record, params| BaseSerializer.params_include?(params, 'software_modules') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
  has_many :center_social_links, if: proc { |_record, params| BaseSerializer.params_include?(params, 'center_social_links') }
  has_many :children, if: proc { |_record, params| BaseSerializer.params_include?(params, 'children') }
end
