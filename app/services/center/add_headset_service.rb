class Center::AddHeadsetService

    def initialize(headset_params:, center_id:)
        @headset_params = headset_params
        @center_id = center_id
    end

    def call 
        create_headset
        @headset
    end

    private

    def create_headset
        @headset = Headset.new(@headset_params)
        @headset[:center_id] = @center_id
        @headset.save!
    end
end