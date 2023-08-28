class Center::CreateService
    def initialize(name:, longitude:, latitude:, website:, logo:, certificate:, registration_number:, tax_id:, current_doctor:, specialty_ids:, social_links:)
        @name = name
        @longitude = longitude
        @latitude = latitude
        @website = website
        @logo = logo
        @certificate = certificate
        @registration_number = registration_number
        @tax_id = tax_id
        @current_doctor = current_doctor
        @specialty_ids = specialty_ids
        @social_links = social_links
    end


    def call 
        check_social_links_existed
        ActiveRecord::Base.transaction do
            @new_center = create_center
            create_doctor_center
            create_center_specialties
            create_center_social_links
            @new_center
        end
        rescue => e
            puts e
            raise "can't create new center now"
    end


    private 

    def create_center
        Center.create!(
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

    def create_doctor_center
        DoctorCenter.create!(center: @new_center, doctor: @current_doctor, role: "admin")
    end

    def create_center_specialties
        @new_center.specialties << Specialty.where(id: @specialty_ids)
    end

    def check_social_links_existed
        error_message ="social links are not existed , please provide at least one "
        if @social_links.nil?
            raise error_message
        end
        @parsed_social_links = JSON.parse(@social_links)
        unless @parsed_social_links.length
            raise error_message
        end

    end

    def create_center_social_links
        @new_center.center_social_links.create!(@parsed_social_links)
    end
end