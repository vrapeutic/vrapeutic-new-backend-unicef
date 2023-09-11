class MiniChildSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :age
end
