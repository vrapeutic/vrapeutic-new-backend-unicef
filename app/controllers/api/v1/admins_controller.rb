class Api::V1::AdminsController < Api::BaseApi
  before_action :set_admin, only: %i[ show update destroy ]
  before_action :validate_admin_otp, only: %i[ edit_child edit_doctor doctors kids assign_center_module ]

  def current_ability
    @current_ability ||= AdminAbility.new(params)
  end
  authorize_resource only: %i[ edit_doctor ]

  def send_otp 
    otp = Admin::GenerateOtpService.new.call
    AdminOtpMailer.send_otp(ENV['ADMIN_EMAIL'], otp).deliver_later
    render json: "otp is sent successfully"
  end

  def edit_child 
    begin
      child = Admin::EditChildService.new(
        child_id: params[:child_id], 
        edit_params: edit_child_params.except(:diagnosis_ids), 
        diagnosis_ids: params[:child][:diagnosis_ids]
      ).call
      render json: ChildSerializer.new(child).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def edit_doctor 
    begin
      doctor = Admin::EditDoctorService.new(
        doctor_id: params[:doctor_id], 
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

  def assign_center_module 
    begin
      Admin::AssignCenterModuleService.new(center_id: params[:center_id], software_module_id: params[:software_module_id], end_date: params[:end_date]).call
      render json: "assigned successfully"
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def doctors 
    all_doctors = Doctor.all 
    render json: DoctorSerializer.new(all_doctors).serializable_hash
  end

  def kids 
    all_kids = Child.all 
    render json: ChildSerializer.new(all_kids).serializable_hash
  end

  # GET /admins
  def index
    @admins = Admin.all

    render json: @admins
  end

  # GET /admins/1
  def show
    render json: @admin
  end

  # POST /admins
  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      render json: @admin, status: :created, location: @admin
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admins/1
  def update
    if @admin.update(admin_params)
      render json: @admin
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  # DELETE /admins/1
  def destroy
    @admin.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:otp, :expires_at)
    end

    def edit_child_params
      params.require(:child).permit(:name, :age, :diagnosis_ids)
    end
end
