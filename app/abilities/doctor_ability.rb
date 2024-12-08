class DoctorAbility
  include CanCan::Ability

  def initialize(doctor, params)
    case params[:action]

    when 'index'
      can :index, Doctor if Authorization::Center::CanGetDoctorsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'show'
      can :show, Doctor if Authorization::Center::CanGetDoctorsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'update'
      can :update, Doctor if Authorization::Doctor::CanEditProfileService.new(current_doctor: doctor, updated_doctor_id: params[:id]).call
    when 'center_assigned_children'
      can :center_assigned_children, Doctor if Authorization::Doctor::CanGetAssignedCenterChildrenService.new(current_doctor: doctor,
                                                                                                              center_id: params[:center_id]).call
    when 'center_headsets'
      can :center_headsets, Doctor if Authorization::Doctor::CanGetCenterHeadsetsService.new(current_doctor: doctor,
                                                                                             center_id: params[:center_id]).call
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
    when 'center_child_sessions'
      can :center_child_modules, Doctor if Authorization::Doctor::CanGetCenterChildSessionsService.new(
        current_doctor: doctor,
        center_id: params[:center_id],
        child_id: params[:child_id]
      ).call
    when 'home_doctors'
      can :home_doctors, Doctor if Authorization::Doctor::CanGetHomeDoctorsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'home_kids'
      can :home_kids, Doctor if Authorization::Doctor::CanGetHomeKidsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'sessions_percentage'
      can :sessions_percentage, Doctor if Authorization::Doctor::CanGetCenterSessionsPercentageService.new(current_doctor: doctor,
                                                                                                           center_id: params[:center_id]).call
    when 'kids_percentage'
      can :kids_percentage, Doctor if Authorization::Doctor::CanGetCenterKidsPercentageService.new(current_doctor: doctor,
                                                                                                   center_id: params[:center_id]).call
    when 'assign_doctor_child'
      if Authorization::Center::CanAssignDoctorToChildService.new(
        current_doctor: doctor,
        center_id: params[:center_id],
        assignee_doctor_id: params[:id] || params[:doctor_id],
        child_id: params[:child_id]
      ).call
        can :assign_doctor_child,
            Doctor
      end
    when 'unassign_doctor_child'
      if Authorization::Center::CanUnassignDoctorFromChildService.new(
        current_doctor: doctor,
        center_id: params[:center_id],
        assignee_doctor_id: params[:id] || params[:doctor_id],
        child_id: params[:child_id]
      ).call
        can :unassign_doctor_child,
            Doctor
      end
    when 'invite_doctor'
      can :invite_doctor, Doctor if Authorization::Center::CanInviteDoctorService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'assign_doctor'
      can :assign_doctor, Doctor if Authorization::Center::CanAssignDoctorService.new(current_doctor: doctor, center_id: params[:center_id],
                                                                                      assignee_doctor_id: params[:id] || params[:doctor_id]).call
    when 'edit_doctor'
      can :edit_doctor, Doctor if Authorization::Center::CanEditDoctorService.new(current_doctor: doctor, center_id: params[:center_id],
                                                                                  doctor_id: params[:id] || params[:doctor_id]).call
    when 'make_doctor_admin'
      if Authorization::Center::CanMakeDoctorAdminService.new(current_doctor: doctor, center_id: params[:center_id],
                                                              worker_doctor_id: params[:id] || params[:doctor_id]).call
        can :make_doctor_admin,
            Doctor
      end
    else
      false
    end
  end
end
