class Session::CreateService

    def initialize(doctor:, center_id:, child_id:, headset_id:)
        @doctor = doctor
        @center_id = center_id
        @child_id = child_id
        @headset_id = headset_id
    end

    def call 
        Session.transaction do 
            create_session
            add_doctor_to_session
            @new_session
        end
    end

    private

    def create_session
        @new_session  = Session.create!(center_id: @center_id, headset_id: @headset_id, child_id: @child_id)
    end

    def add_doctor_to_session

    end
end