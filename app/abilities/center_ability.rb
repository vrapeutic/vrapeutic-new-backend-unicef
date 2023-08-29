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

      else
        false
      end
    end
  
  end