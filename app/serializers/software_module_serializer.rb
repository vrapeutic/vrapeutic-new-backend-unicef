class SoftwareModuleSerializer
  include JSONAPI::Serializer
  attributes :name, :version, :technology, :min_age, :max_age, :image, :targeted_skills, :created_at, :updated_at

  has_many :targeted_skills, if: proc { |_record, params| BaseSerializer.params_include?(params, 'targeted_skills') }
  has_many :centers, if: proc { |_record, params| BaseSerializer.params_include?(params, 'centers') }
  has_many :children, if: proc { |_record, params| BaseSerializer.params_include?(params, 'children') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
end
