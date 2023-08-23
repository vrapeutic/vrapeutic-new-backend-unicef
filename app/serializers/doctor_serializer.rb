class DoctorSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :degree, :university, :is_email_verified

  attribute :photo_url do |doctor|
    doctor.photo_url
  end
  attribute :certificate_url do |doctor|
    doctor.certificate_url
  end
end
