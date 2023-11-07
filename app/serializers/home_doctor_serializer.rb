class HomeDoctorSerializer
  include JSONAPI::Serializer
  attributes :name, :join_date, :number_of_sessions, :specialties, :image_url
end
