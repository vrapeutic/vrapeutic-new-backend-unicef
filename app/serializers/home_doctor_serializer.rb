class HomeDoctorSerializer
  include JSONAPI::Serializer
  attributes :name, :join_date, :number_of_sessions, :specialties, :photo_url, :degree
end
