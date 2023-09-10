class SessionAbility
    include CanCan::Ability
    def initialize(doctor, params)
      case params[:action]

      when 'create'
        can :create, Session if Authorization::Session::CanDoctorCreateService.new(
            current_doctor: doctor, 
            child_id: params[:child_id], 
            center_id: params[:center_id], 
            headset_id: params[:headset_id]
        ).call
      when 'resend_otp'
        can :resend_otp, Session if Authorization::Session::CanDoctorResendOtpService.new(current_doctor: doctor, session_id:  params[:id]).call

      else
        false
      end
    end
  
  end