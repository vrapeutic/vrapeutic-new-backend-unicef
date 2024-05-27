class Api::V1::SessionsController < Api::BaseApi
  before_action :set_session,
                only: %i[show update destroy resend_otp validate_otp end_session add_comment add_evaluation
                         add_note_and_evaluation
                         add_attention_performance
                         add_attention_performance_modules]

  before_action :authorized

  def current_ability
    @current_ability ||= SessionAbility.new(current_doctor, params)
  end
  authorize_resource

  # GET /sessions
  def index
    @sessions = Session.all

    render json: SessionSerializer.new(@sessions, param_options).serializable_hash
  end

  # GET /sessions/1
  def show
    render json: SessionSerializer.new(@session, param_options).serializable_hash
  end

  # POST /sessions
  def create
    raise 'headset is not available for session' unless Headset::IsAvailableForSessionService.new(headset_id: params[:headset_id],
                                                                                                  center_id: params[:center_id]).call

    session = Session::CreateService.new(
      doctor: current_doctor,
      center_id: params[:center_id],
      child_id: params[:child_id],
      headset_id: params[:headset_id]
    ).call
    # # generate otp
    # otp_code = Otp::GenerateService.new(doctor: current_doctor, code_type: Otp::SESSION_VERIFICATION).call
    # # send email
    # SessionOtpMailer.send_otp(current_doctor.email, otp_code).deliver_later
    render json: SessionSerializer.new(session, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def resend_otp
    return render json: { error: 'session is already verified' }, status: :unprocessable_entity if @session.is_verified

    # generate otp
    otp_code = Otp::GenerateService.new(doctor: current_doctor, code_type: Otp::SESSION_VERIFICATION).call
    # send email
    SessionOtpMailer.send_otp(current_doctor.email, otp_code).deliver_later
    render json: 'otp is sent again'
  end

  def validate_otp
    return render json: { error: 'session is already verified' }, status: :unprocessable_entity if @session.is_verified

    result = Otp::ValidateService.new(doctor: @doctor, entered_otp: params[:otp], code_type: Otp::SESSION_VERIFICATION).call
    if result
      @session.update(is_verified: true)
      return render json: SessionSerializer.new(@session, param_options).serializable_hash
    end
    render json: { error: 'otp is not valid or expired' }, status: :unprocessable_entity
  end

  def add_module
    Session::AddSoftwareModuleService.new(session_id: params[:id], software_module_id: params[:software_module_id]).call
    render json: 'module is added to session successfully'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def add_doctor
    Session::AddDoctorService.new(session_id: params[:id], doctor_id: params[:added_doctor_id]).call
    render json: 'doctor is added successfully  to session'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def end_session
    updated_session = Session::EndService.new(session: @session, vr_duration: params[:vr_duration]).call
    render json: SessionSerializer.new(updated_session, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def add_comment
    Session::AddCommentService.new(session: @session, comment_name: params[:name]).call
    render json: 'comment is added to session'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def add_evaluation
    Session::AddEvaluationService.new(session: @session, evaluation: params[:evaluation]).call
    render json: 'session is evaluated successfully'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def add_note_and_evaluation
    Session::AddNoteAndEvaluationService.new(session: @session, note: params[:note], evaluation: params[:evaluation]).call
    render json: SessionSerializer.new(@session, param_options).serializable_hash
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def add_attention_performance
    Session::AddAttentionPerformanceService.new(
      session: @session,
      software_module_id: params[:software_module_id],
      targets: params[:targets],
      interruptions: params[:interruptions],
      distractors: params[:distractors],
      level: params[:level]
    ).call
    render json: 'performance data is added to session'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def add_attention_performance_modules
    Session::AddAttentionPerformanceModulesService.new(session: @session, modules_data: params[:data], duration: params[:duration],
                                                       vr_duration: params[:vr_duration]).call
    render json: 'all attention performance data is saved'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /sessions/1
  def update
    if @session.update(session_params)
      render json: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sessions/1
  def destroy
    @session.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def session_params
    params.require(:session).permit(:center_id, :headset_id, :child_id)
  end
end
