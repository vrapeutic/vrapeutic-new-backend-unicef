class CenterAbility
    include CanCan::Ability
    def initialize(doctor ,params)
      case params[:action]

      when 'update'
        can :update, Center if Authorization::Center::CanUpdateService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'create'
        can :create, Center
      when 'invite_doctor'
        can :invite_doctor, Center if Authorization::Center::CanInviteDoctorService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'assign_doctor'
        can :assign_doctor, Center if Authorization::Center::CanAssignDoctorService.new(current_doctor: doctor, center_id: params[:id], assignee_doctor_id: params[:doctor_id]).call
      when 'edit_doctor'
        can :edit_doctor, Center if Authorization::Center::CanEditDoctorService.new(current_doctor: doctor, center_id: params[:id], doctor_id: params[:doctor_id]).call
      when 'make_doctor_admin'
        can :make_doctor_admin, Center if Authorization::Center::CanMakeDoctorAdminService.new(current_doctor: doctor, center_id: params[:id], worker_doctor_id: params[:doctor_id]).call
      when 'add_child'
        can :add_child, Center if Authorization::Center::CanAddChildService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'edit_child'
        can :edit_child, Center if Authorization::Center::CanEditChildService.new(current_doctor: doctor, center_id: params[:id], child_id: params[:child_id]).call
      when 'add_modules'
        can :add_modules, Center if Authorization::Center::CanAddModulesService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'assign_module_child'
        can :assign_module_child, Center if Authorization::Center::CanAssignModuleToChildService.new(
          current_doctor: doctor, 
          center_id: params[:id], 
          software_module_id: params[:software_module_id], 
          child_id: params[:child_id]
        ).call
      when 'unassign_module_child'
        can :unassign_module_child, Center if Authorization::Center::CanUnassignModuleFromChildService.new(
          current_doctor: doctor, 
          center_id: params[:id], 
          software_module_id: params[:software_module_id], 
          child_id: params[:child_id]
        ).call
      when 'assign_doctor_child'
        can :assign_doctor_child, Center if Authorization::Center::CanAssignDoctorToChildService.new(
          current_doctor: doctor, 
          center_id: params[:id], 
          assignee_doctor_id: params[:doctor_id], 
          child_id: params[:child_id]
        ).call

      when 'unassign_doctor_child'
        can :unassign_doctor_child, Center if Authorization::Center::CanUnassignDoctorFromChildService.new(
          current_doctor: doctor, 
          center_id: params[:id], 
          assignee_doctor_id: params[:doctor_id], 
          child_id: params[:child_id]
        ).call

      when 'add_headset'
        can :add_headset, Center if Authorization::Center::CanAddHeadsetService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'edit_headset'
        can :edit_headset, Center if Authorization::Center::CanEditHeadsetService.new(current_doctor: doctor, center_id: params[:id], headset_id: params[:headset_id]).call
      when 'all_doctors'
        can :all_doctors, Center if Authorization::Center::CanGetAllDoctorsService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'assigned_modules'
        can :assigned_modules, Center if Authorization::Center::CanGetAssignedModulesService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'kids'
        can :kids, Center if Authorization::Center::CanGetKidsService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'doctors'
        can :doctors, Center if Authorization::Center::CanGetDoctorsService.new(current_doctor: doctor, center_id: params[:id]).call
      # when 'modules'
      #   can :modules, Center if Authorization::Center::CanGetModulesService.new(current_doctor: doctor, center_id: params[:id]).call
      else
        false
      end
    end
  
  end