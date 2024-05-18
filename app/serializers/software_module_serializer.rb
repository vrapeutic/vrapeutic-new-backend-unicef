class SoftwareModuleSerializer
  include JSONAPI::Serializer
  attributes :name, :version, :technology, :package_name, :min_age, :max_age,
             :image, :targeted_skills, :created_at, :updated_at

  attribute :image_url do |software_module|
    software_module.image_url
  end

  has_many :targeted_skills, if: proc { |_record, params| BaseSerializer.params_include?(params, 'targeted_skills') }
  has_many :centers, if: proc { |_record, params| BaseSerializer.params_include?(params, 'centers') }
  has_many :children, if: proc { |_record, params| BaseSerializer.params_include?(params, 'children') }
  has_many :sessions, if: proc { |_record, params| BaseSerializer.params_include?(params, 'sessions') }
end
