class HomeCenterSerializer
  include JSONAPI::Serializer
  attributes :name, :longitude, :latitude, :logo, :website, :email, :phone_number, :doctors_count, :children_count, :specialties

  

  

  # attribute :doctors_number do |center|
  #   center.doctors.count
  # end

  # attribute :children_number do |center|
  #   center.children.count
  # end
end
