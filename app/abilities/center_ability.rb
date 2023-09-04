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

      else
        false
      end
    end
  
  end