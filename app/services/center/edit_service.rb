class Center::EditService

    def initialize(current_center:, edit_params:, specialty_ids:, social_links:)
        @current_center = current_center
        @edit_params = edit_params
        @specialty_ids = specialty_ids
        @social_links = social_links
    end

    def call 
        @current_center.transaction do 
            edit_center
            edit_center_speialties
            edit_center_social_links
            @current_center
        end
        rescue => e 
            puts e
            raise "can't update this center"
    end


    private

    def edit_center
        @current_center.update!(@edit_params)
    end

    def edit_center_speialties
        if @specialty_ids.present? && @specialty_ids.length 
            # destroy old specialties 
            @current_center.specialties.destroy_all
            # create new specialties 
            @current_center.specialties << Specialty.where(id: @specialty_ids)
        end
    end

    def edit_center_social_links
        unless @social_links.nil?
            parsed_social_links = JSON.parse(@social_links)
            unless parsed_social_links.length
                raise "your center should have at least one social media link"
            end
            # delete old social links 
            @current_center.center_social_links.destroy_all
            # create new social links
            @current_center.center_social_links.create!(parsed_social_links)
        end
    end
end