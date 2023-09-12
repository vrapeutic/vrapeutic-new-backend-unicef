class MiniSoftwareModuleSerializer
  include JSONAPI::Serializer
  attributes :name, :version, :technology
end
