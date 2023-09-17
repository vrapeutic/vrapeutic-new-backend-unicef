class DoctorAbility
    include CanCan::Ability
    def initialize(doctor, params)
      case params[:action]

      when 'update'
        can :update, Doctor if Authorization::Doctor::CanEditProfileService.new(current_doctor: doctor, updated_doctor_id: params[:id]).call
      when 'center_assigned_children'
        can :center_assigned_children, Doctor if Authorization::Doctor::CanGetAssignedCenterChildrenService.new(current_doctor: doctor, center_id: params[:center_id]).call
      when 'center_headsets'
        can :center_headsets, Doctor if Authorization::Doctor::CanGetCenterHeadsetsService.new(current_doctor: doctor, center_id: params[:center_id]).call
      when 'center_child_modules'
        can :center_child_modules, Doctor if Authorization::Doctor::CanGetCenterChildModulesService.new(
          current_doctor: doctor, 
          center_id: params[:center_id], 
          child_id: params[:child_id]
        ).call
      when 'center_child_doctors'
        can :center_child_doctors, Doctor if Authorization::Doctor::CanGetCenterChildDoctorsService.new(
          current_doctor: doctor, 
          center_id: params[:center_id], 
          child_id: params[:child_id]
        ).call
      when 'home_doctors'
        can :home_doctors, Doctor if Authorization::Doctor::CanGetHomeDoctorsService.new(current_doctor: doctor, center_id: params[:center_id]).call

      else
        false
      end
    end
  
  end