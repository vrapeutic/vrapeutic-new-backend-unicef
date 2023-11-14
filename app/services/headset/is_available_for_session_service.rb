class Headset::IsAvailableForSessionService
    # check if headset is not used in any sessions at this time 

    def initialize(headset_id:, center_id:)
        @headset_id = headset_id
        @center_id = center_id
        
    end

    def call 
        check_headset_is_available
    end

    private

    def check_headset_is_available
        Session.where(headset_id: @headset_id, center_id: @center_id, ended_at: nil).present? ? false : true
    end

    
end