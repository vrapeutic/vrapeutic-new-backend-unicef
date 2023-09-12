class MiniDoctorSerializer
  include JSONAPI::Serializer
  attributes :name, :degree, :university, :photo
end
