class Api::V1::DoctorsController < Api::BaseApi
  before_action :set_doctor, only: %i[show destroy validate_otp resend_otp]
  before_action :authorized,
                only: %i[update centers center_assigned_children center_headsets
                         center_child_modules center_child_doctors home_centers home_doctors
                         home_kids center_statistics center_vr_minutes center_child_sessions
                         child_session_performance_data sessions_percentage kids_percentage]

  def current_ability
    @current_ability ||= DoctorAbility.new(current_doctor, params)
  end
  authorize_resource only: %i[update center_assigned_children center_headsets center_child_modules center_child_doctors home_doctors home_kids
                              center_statistics center_vr_minutes child_session_performance_data sessions_percentage kids_percentage]

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
    Sentry.capture_message("Register Doctor with the following params #{params}", level: :info)

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
    render json: DoctorSerializer.new(@doctor, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def validate_otp
    if @doctor.is_email_verified
      render json: { error: 'doctor is already verified' }, status: :unprocessable_entity
    else
      result = Otp::ValidateService.new(doctor: @doctor, entered_otp: params[:otp]).call
      if result
        @doctor.update_column(:is_email_verified, true)
        render json: Doctor::GenerateJwtTokenService.new(doctor_id: @doctor.id).call, status: :ok
      else
        render json: { error: 'otp is not valid or expired' }, status: :unprocessable_entity
      end
    end
  end

  def resend_otp
    if @doctor.is_email_verified
      render json: { error: 'doctor is already verified' }, status: :unprocessable_entity
    else
      otp_code = Otp::GenerateService.new(doctor: @doctor).call
      # send email
      OtpMailer.send_otp(@doctor, otp_code).deliver_later
      render json: 'otp is sent again'
    end
  end

  def complete_profile
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
    render json: DoctorSerializer.new(new_doctor, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /doctors/1
  def update
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
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def centers
    render json: CenterSerializer.new(current_doctor.centers, param_options).serializable_hash
  end

  def center_assigned_children
    children = Doctor::GetAssignedCenterChildrenService.new(doctor: current_doctor, center_id: params[:center_id]).call
    render json: ChildSerializer.new(children, param_options).serializable_hash
  end

  def center_headsets
    headsets = Doctor::GetCenterHeadsetsService.new(center_id: params[:center_id], scope: params[:scope]).call
    render json: MiniHeadsetSerializer.new(headsets, param_options).serializable_hash
  end

  def center_child_modules
    modules = Doctor::GetCenterChildModulesService.new(center_id: params[:center_id], child_id: params[:child_id]).call

    render json: SoftwareModuleSerializer.new(modules, param_options).serializable_hash
  end

  def center_child_doctors
    doctors = Doctor::GetCenterChildDoctorsService.new(child_id: params[:child_id], center_id: params[:center_id],
                                                       current_doctor: current_doctor).call

    render json: DoctorSerializer.new(doctors, param_options).serializable_hash
  end

  def center_child_sessions
    sessions = Session::GetCenterChildSessionsService.new(child_id: params[:child_id], center_id: params[:center_id]).call

    render json: SessionSerializer.new(sessions, param_options).serializable_hash
  end

  def home_centers
    current_doctor_centers = current_doctor.centers
                                           .select("centers.*, COUNT(DISTINCT doctors.id)
                                           AS doctors_count, COUNT(DISTINCT children.id)
                                           AS children_count")
                                           .left_joins(:doctors, :children)
                                           .group('centers.id')
                                           .includes(:specialties, :center_social_links)
    render json: CenterSerializer.new(current_doctor_centers, param_options).serializable_hash
  end

  def home_doctors
    doctors = Doctor::GetCenterDoctorsService.new(current_doctor: current_doctor, center_id: params[:center_id]).call
    render json: HomeDoctorSerializer.new(doctors, param_options).serializable_hash
  end

  def home_kids
    kids = Doctor::GetHomeCenterKidsService.new(current_doctor: current_doctor, center_id: params[:center_id]).call
    render json: HomeKidSerializer.new(kids, param_options).serializable_hash
  end

  def center_statistics
    result = Doctor::CenterStatisticsService.new(doctor: current_doctor, center_id: params[:center_id]).call
    render json: result
  end

  def center_vr_minutes
    result = Doctor::CenterVrMinutesService.new(doctor: current_doctor, center_id: params[:center_id], year: params[:year]).call
    render json: result
  end

  def child_session_performance_data
    result = Doctor::ChildCenterSessionsDataService.new(
      doctor: current_doctor,
      center_id: params[:center_id],
      child_id: params[:child_id],
      start_date: params[:start_date],
      end_date: params[:end_date]
    ).call
    render json: result
  end

  def sessions_percentage
    result = Doctor::CenterSessionsPercentageService.new(doctor: current_doctor, center_id: params[:center_id]).call
    render json: result
  end

  def kids_percentage
    result = Doctor::CenterKidsPercentageService.new(doctor: current_doctor, center_id: params[:center_id]).call
    render json: result
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
