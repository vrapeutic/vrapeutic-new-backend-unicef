class DoctorAbility
    include CanCan::Ability
    def initialize(doctor, params)
      case params[:action]

      when 'update'
        can :update, Doctor if Authorization::Doctor::CanEditProfileService.new(current_doctor: doctor, updated_doctor_id: params[:id]).call

      else
        false
      end
    end
  
  end