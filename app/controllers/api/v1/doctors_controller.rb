class Api::V1::DoctorsController < Api::BaseApi
  before_action :authorized_doctor?, only: %i[update center_assigned_children center_headsets
                                              center_child_modules center_child_doctors home_doctors
                                              home_kids sessions_percentage kids_percentage]
  before_action :set_doctor, only: :show

  authorize_resource only: %i[update center_assigned_children center_headsets center_child_modules
                              center_child_doctors home_doctors home_kids
                              sessions_percentage kids_percentage]

  def current_ability
    @current_ability ||= DoctorAbility.new(current_doctor, params)
  end

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

  def center_assigned_children
    children = Doctor::GetAssignedCenterChildrenService.new(doctor: current_doctor, center_id: params[:center_id]).call
    render json: ChildSerializer.new(children, param_options).serializable_hash
  end

  def center_headsets
    headsets = Doctor::GetCenterHeadsetsService.new(center_id: params[:center_id], scope: params[:scope]).call
    render json: HeadsetSerializer.new(headsets, param_options).serializable_hash
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

  def home_doctors
    doctors = Doctor::GetCenterDoctorsService.new(current_doctor: current_doctor, center_id: params[:center_id]).call
    render json: HomeDoctorSerializer.new(doctors, param_options).serializable_hash
  end

  def home_kids
    kids = Doctor::GetHomeCenterKidsService.new(current_doctor: current_doctor, center_id: params[:center_id]).call
    render json: HomeKidSerializer.new(kids, param_options).serializable_hash
  end

  def sessions_percentage
    result = Doctor::CenterSessionsPercentageService.new(doctor: current_doctor, center_id: params[:center_id]).call
    render json: result
  end

  def kids_percentage
    result = Doctor::CenterKidsPercentageService.new(doctor: current_doctor, center_id: params[:center_id]).call
    render json: result
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
