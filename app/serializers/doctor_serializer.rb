class DoctorSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :degree, :university, :is_email_verified
end
