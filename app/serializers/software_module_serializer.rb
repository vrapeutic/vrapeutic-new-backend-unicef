class SoftwareModuleSerializer
  include JSONAPI::Serializer
  attributes :name, :version, :technology, :min_age, :max_age, :image, :targeted_skills
end
