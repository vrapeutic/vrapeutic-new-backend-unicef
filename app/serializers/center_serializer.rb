class CenterSerializer
  include JSONAPI::Serializer
  attributes :name, :website, :longitude, :latitude, :registration_number, :tax_id, :email, :phone_number

  attribute :logo_url do |center|
    center.logo_url
  end
  attribute :certificate_url do |center|
    center.certificate_url
  end
end
