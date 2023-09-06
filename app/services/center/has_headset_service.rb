class Center::HasHeadsetService

    # check if this center has this headset or not

    def initialize(center_id:, headset_id:)
        @center_id = center_id
        @headset_id = headset_id
    end

    def call 
        center_has_headset?
    end

    private

    def center_has_headset?
        Headset.find_by(id: @headset_id, center_id: @center_id).present? ? true : false
    end
end