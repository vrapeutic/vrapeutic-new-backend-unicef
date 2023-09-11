class MiniCenterSerializer
  include JSONAPI::Serializer
  attributes :name, :longitude, :latitude, :phone_number, :website, :logo
end
