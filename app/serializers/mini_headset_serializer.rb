class MiniHeadsetSerializer
  include JSONAPI::Serializer
  attributes :name, :brand, :model, :version, :key
end
