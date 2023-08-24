class Center::CreateService
    def initialize(name:, longitude:, latitude:, website:, logo:, certificate:, registration_number:, tax_id:, current_doctor:)
        @name = name
        @longitude = longitude
        @latitude = latitude
        @website = website
        @logo = logo
        @certificate = certificate
        @registration_number = registration_number
        @tax_id = tax_id
        @current_doctor = current_doctor
    end


    def call 
        @current_doctor.trasnaction do
            new_center = create_center
            if new_center.save 
                DoctorCenter.create(center: new_center, doctor: @current_doctor, role: 'admin')
                return new_center
            end
            puts new_center.errors.as_json
            raise "can't create center right now"
        end
    end


    private 

    def create_center
        Center.new(
            name: @name,
            longitude: @longitude,
            latitude: @latitude,
            website: @website.present? ? @website.downcase : nil ,
            logo: @logo,
            certificate: @certificate,
            registration_number: @registration_number,
            tax_id: @tax_id
        )
    end
end