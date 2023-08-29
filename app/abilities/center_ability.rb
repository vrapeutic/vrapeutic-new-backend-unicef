class CenterAbility
    include CanCan::Ability
    def initialize(doctor ,params)
      case params[:action]

      when 'update'
        can :update, Center if Authorization::Center::CanUpdateService.new(current_doctor: doctor, center_id: params[:id]).call
      when 'create'
        can :create, Center 

      else
        false
      end
    end
  
  end