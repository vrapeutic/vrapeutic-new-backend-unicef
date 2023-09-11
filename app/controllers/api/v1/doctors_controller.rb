class Api::V1::DoctorsController < Api::BaseApi
  before_action :set_doctor, only: %i[ show destroy validate_otp resend_otp ]
  before_action :authorized, only: %i[ update centers center_assigned_children center_headsets ]

  def current_ability
    @current_ability ||= DoctorAbility.new(current_doctor, params)
  end
  authorize_resource only: %i[ update center_assigned_children center_headsets ]

  # GET /doctors
  def index
    @doctors = Doctor.all

    render json: @doctors
  end

  # GET /doctors/1
  def show
    render json: @doctor
  end

  # POST /doctors
  def create
    begin
      @doctor = Doctor::CreateService.new(
        name: params[:name],
        email: params[:email],
        password: params[:password],
        degree: params[:degree],
        university: params[:university],
        specialty_ids: params[:specialty_ids],
        photo: params[:photo],
        certificate: params[:certificate]
      ).call
      otp_code = Otp::GenerateService.new(doctor: @doctor).call
      OtpMailer.send_otp(@doctor, otp_code).deliver_later
      render json: DoctorSerializer.new(@doctor).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def validate_otp
    result = Otp::ValidateService.new(doctor: @doctor, entered_otp: params[:otp]).call
    if result
      @doctor.update_column(:is_email_verified, true)
      token_data = Doctor::GenerateJwtTokenService.new(doctor_id: @doctor.id).call
      return render json: token_data
    end
    render json: {error: "otp is not valid or expired"}, status: :unprocessable_entity
  end

  def resend_otp
    if @doctor.is_email_verified
      return render json: {error: "doctor is already vdrified"}, status: :unprocessable_entity 
    end
    otp_code = Otp::GenerateService.new(doctor: @doctor).call
    # send email 
    OtpMailer.send_otp(@doctor, otp_code).deliver_later
    render json: "otp is sent again"
  end

  def sign_in
    begin
      login_data = Doctor::HandleLoginService.new(email: params[:email], password: params[:password]).call
      render json: login_data
    rescue => e
      render json: e.message, status: :unauthorized
    end
  end

  def complete_profile
    begin
      new_doctor = Doctor::CompleteProfileService.new(
        token: params[:token],
        name: params[:name],
        password: params[:password],
        degree: params[:degree],
        university: params[:university],
        specialty_ids: params[:specialty_ids],
        photo: params[:photo],
        certificate: params[:certificate]
      ).call 
      render json: DoctorSerializer.new(new_doctor).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doctors/1
  def update
    begin
      doctor = Doctor::UpdateService.new(
        doctor_id: params[:id], 
        degree: params[:degree], 
        certificate: params[:certificate], 
        specialty_ids: params[:specialty_ids], 
        photo: params[:photo], 
        university: params[:university],
        name: params[:name]
      ).call 
      render json: DoctorSerializer.new(doctor).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end 
  end

  def centers 
    render json: MiniCenterSerializer.new(current_doctor.centers).serializable_hash
  end

  def center_assigned_children
    children = Doctor::GetAssignedCenterChildrenService.new(doctor: current_doctor, center_id: params[:center_id]).call
    render json: MiniChildSerializer.new(children).serializable_hash
  end

  def center_headsets
    headsets = Doctor::GetCenterHeadsetsService.new(center_id: params[:center_id]).call
    render json: MiniHeadsetSerializer.new(headsets).serializable_hash
  end

  # DELETE /doctors/1
  def destroy
    @doctor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def doctor_params
      params.require(:doctor).permit(:name, :email, :password, :degree, :university, :photo, :certificate, :specialty_ids, :otp)
    end
end
