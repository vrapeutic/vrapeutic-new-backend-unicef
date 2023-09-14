class CustomSerializer::Home::CenterService

    def initialize(centers:)
        @centers = centers
    end

    def call 
        {
            data: serialize_centers
        }
    end

    private

    def serialize_centers
        @centers.map do |center|
            {
                id: center.id,
                type: "Center",
                attributes: {
                    name: center.name,
                    longitude: center.longitude,
                    latitude: center.latitude,
                    logo: center.logo,
                    website: center.website,
                    email: center.email,
                    phone_number: center.phone_number,
                    doctors_count: center.doctors.count,
                    children_count: center.children.count,
                    specialties: center.specialties
                }
            }
        end
    end
end