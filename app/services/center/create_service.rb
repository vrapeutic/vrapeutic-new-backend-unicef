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
        ActiveRecord::Base.transaction do
            new_center = create_center
            DoctorCenter.create(center: new_center, doctor: @current_doctor, role: "admin")
            new_center
        end
        rescue => e
            raise "can't create new center now"
    end


    private 

    def create_center
        Center.create(
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