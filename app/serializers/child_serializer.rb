class ChildSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :age
end
