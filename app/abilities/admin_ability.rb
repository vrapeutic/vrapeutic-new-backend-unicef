class AdminAbility
    include CanCan::Ability
    def initialize(params)
      case params[:action]

      when 'edit_doctor'
        can :edit_doctor, Admin if Authorization::Admin::CanEditDoctorService.new(doctor_id: params[:doctor_id]).call

      else
        false
      end
    end
  
  end