class SessionAbility
    include CanCan::Ability
    def initialize(doctor, params)
      case params[:action]

      when 'create'
        can :create, Session if Authorization::Session::CanCreateService.new(
            current_doctor: doctor, 
            child_id: params[:child_id], 
            center_id: params[:center_id], 
            headset_id: params[:headset_id]
        ).call
      when 'resend_otp'
        can :resend_otp, Session if Authorization::Session::CanResendOtpService.new(current_doctor: doctor, session_id:  params[:id]).call
      when 'validate_otp'
        can :validate_otp, Session if Authorization::Session::CanValidateOtpService.new(current_doctor: doctor, session_id:  params[:id]).call
      when 'add_module'
        can :add_module, Session if Authorization::Session::CanAddSoftwareModuleService.new(
          current_doctor: doctor, 
          session_id: params[:id], 
          software_module_id: params[:software_module_id]
        ).call
      when 'add_doctor'
        can :add_doctor, Session if Authorization::Session::CanAddDoctorService.new(current_doctor:doctor, session_id: params[:id], added_doctor_id: params[:added_doctor_id]).call
      when 'end_session'
        can :end_session, Session if Authorization::Session::CanEndService.new(current_doctor: doctor, session_id: params[:id]).call
      when 'add_comment'
        can :add_comment, Session if Authorization::Session::CanAddCommentService.new(current_doctor: doctor, session_id: params[:id]).call

      else
        false
      end
    end
  
  end