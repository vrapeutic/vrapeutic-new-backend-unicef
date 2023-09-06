class Child::HasDoctorInCenterService
    # check if this child assigned ti this doctor in this center
    def initialize(doctor_id:, child_id:, center_id:)
        @doctor_id = doctor_id
        @child_id = child_id
        @center_id = center_id
    end

    def call 
        is_child_assigned_to_doctor_in_center
    end

    private

    def is_child_assigned_to_doctor_in_center
        ChildDoctor.find_by(child_id: @child_id, doctor_id: @doctor_id, center_id: @center_id).present? ? true : false
    end
end