class DoctorAbility
    include CanCan::Ability
    def initialize(doctor, params)
      case params[:action]

      when 'update'
        can :update, Doctor if Authorization::Doctor::CanEditProfileService.new(current_doctor: doctor, updated_doctor_id: params[:id]).call
      when 'center_assigned_children'
        can :center_assigned_children, Doctor if Authorization::Doctor::CanGetAssignedCenterChildrenService.new(current_doctor: doctor, center_id: params[:center_id]).call

      else
        false
      end
    end
  
  end