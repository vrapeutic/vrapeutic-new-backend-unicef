class Api::V1::SessionsController < Api::BaseApi
  before_action :set_session, only: %i[ show update destroy resend_otp validate_otp end_session ]

  before_action :authorized

  def current_ability
    @current_ability ||= SessionAbility.new(current_doctor, params)
  end
  authorize_resource

  # GET /sessions
  def index
    @sessions = Session.all

    render json: @sessions
  end

  # GET /sessions/1
  def show
    render json: @session
  end

  # POST /sessions
  def create
    begin
      session = Session::CreateService.new(
        doctor: current_doctor, 
        center_id: params[:center_id], 
        child_id: params[:child_id], 
        headset_id: params[:headset_id]
      ).call
      # generate otp 
      otp_code = Otp::GenerateService.new(doctor: current_doctor, code_type: Otp::SESSION_VERIFICATION).call
      # send email
      SessionOtpMailer.send_otp(current_doctor.email, otp_code).deliver_later
      render json: SessionSerializer.new(session).serializable_hash
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def resend_otp 
    if @session.is_verified
      return render json: {error: "session is already vdrified"}, status: :unprocessable_entity
    end
    # generate otp 
    otp_code = Otp::GenerateService.new(doctor: current_doctor, code_type: Otp::SESSION_VERIFICATION).call
    # send email
    SessionOtpMailer.send_otp(current_doctor.email, otp_code).deliver_later
    render json: 'otp is sent again'
  end

  def validate_otp 
    if @session.is_verified
      return render json: {error: "session is already vdrified"}, status: :unprocessable_entity
    end
    result = Otp::ValidateService.new(doctor: @doctor, entered_otp: params[:otp], code_type: Otp::SESSION_VERIFICATION).call
    if result
      @session.update(is_verified: true)
      return  render json: SessionSerializer.new(@session).serializable_hash
    end
    render json: {error: "otp is not valid or expired"}, status: :unprocessable_entity
  end

  def add_module
    begin
      Session::AddSoftwareModuleService.new(session_id: params[:id], software_module_id: params[:software_module_id]).call
      render json: "module is added to session successfully"
    rescue => e
      puts e.type
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def add_doctor
    begin
      Session::AddDoctorService.new(session_id: params[:id], doctor_id: params[:added_doctor_id]).call
      render json: "doctor is added successfully  to session"
    rescue => e
      puts e.type
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def end_session 
    begin
      updated_session = Session::EndService.new(session: @session).call
      render json: SessionSerializer.new(updated_session).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
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
