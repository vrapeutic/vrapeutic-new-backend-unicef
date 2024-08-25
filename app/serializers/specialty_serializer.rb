class SpecialtySerializer < BaseSerializer
  attributes :name, :created_at, :updated_at

  has_many :centers, if: proc { |_record, params| BaseSerializer.params_include?(params, 'centers') }
  has_many :doctors, if: proc { |_record, params| BaseSerializer.params_include?(params, 'doctors') }
end
