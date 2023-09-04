class SoftwareModuleSerializer
  include JSONAPI::Serializer
  attributes :name, :version, :technology, :targeted_skills
end
