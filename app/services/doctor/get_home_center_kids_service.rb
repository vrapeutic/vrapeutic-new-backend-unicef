class Doctor::GetHomeCenterKidsService

    def initialize(current_doctor:, center_id:)
        @center_id = center_id
        @current_doctor = current_doctor
    end

    def call 
        find_center
        define_kids
        home_kids
    end

    private

    

    def find_center
        @center = Center.find(@center_id)
    end

    def define_kids 
        is_current_doctor_admin = Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
        if is_current_doctor_admin
            @kids = @center.children
        else
            @kids = @current_doctor.children
        end
    end

    def home_kids 
        # be aware of child has many sessions but not to the same doctor if doctor is normal admin
        @kids.select(
            'children.id AS id',
            'children.name AS name',
            'children.age AS age',
            'child_centers.created_at AS join_date',
            'COUNT(sessions.id) AS number_of_sessions',
            'AVG(sessions.evaluation) AS average_evaluation'
          )
          .left_joins(:child_centers, :sessions)
          .where('sessions.doctor_id' => @current_doctor_id)
          .group('children.id, child_centers.created_at')
          .includes(:diagnoses)
    end
end