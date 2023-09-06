class HeadsetSerializer
  include JSONAPI::Serializer
  attributes :version, :name, :brand, :model, :key, :center
end
