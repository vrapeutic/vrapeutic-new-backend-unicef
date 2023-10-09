class Api::V1::CentersController < Api::BaseApi
  before_action :set_center, only: %i[ show update destroy invite_doctor assign_doctor assigned_modules kids ]
  before_action :authorized

  def current_ability
    @current_ability ||= CenterAbility.new(current_doctor ,params)
  end
  authorize_resource

  # GET /centers
  def index
    @centers = Center.all

    render json: @centers
  end

  # GET /centers/1
  def show
    render json: @center
  end

  # POST /centers
  def create
    begin
      new_center = Center::CreateService.new(
        name: params[:name], 
        longitude: params[:longitude], 
        latitude:params[:latitude], 
        website:params[:website], 
        logo:params[:logo], 
        certificate:params[:certificate], 
        registration_number:params[:registration_number], 
        tax_id: params[:tax_id],
        current_doctor: current_doctor,
        specialty_ids: params[:specialty_ids],
        social_links: params[:social_links],
        email: params[:email],
        phone_number: params[:phone_number]
      ).call
      render json: CenterSerializer.new(new_center).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /centers/1
  def update
    begin
      updated_center = Center::EditService.new(
        current_center: @center, 
        edit_params: edit_center_params.except(:social_links, :specialty_ids), 
        specialty_ids: params[:specialty_ids], 
        social_links: params[:social_links]
      ).call
      render json: CenterSerializer.new(updated_center).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def invite_doctor
    begin
      @invitaion_token_data = Center::GenerateInvitationTokenService.new(email: params[:email], center_id: @center.id).call
      InviteDoctorMailer.send_invitation_link(params[:email], @center, @invitaion_token_data).deliver_later
      render json: 'invitation is sent'
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def assign_doctor
    begin
      Center::AssignDoctorService.new(doctor_id: params[:doctor_id], center_id: @center.id).call 
      render json: "assigned successfully"
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def edit_doctor
    begin
      new_doctor = Doctor::UpdateService.new(
        doctor_id: params[:doctor_id], 
        degree: params[:degree], 
        certificate: params[:certificate], 
        specialty_ids: params[:specialty_ids], 
        photo: params[:photo], 
        university: params[:university]
      ).call 
      render json: DoctorSerializer.new(new_doctor).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def make_doctor_admin
    begin
      Center::MakeDoctorAdminService.new(doctor_id: params[:doctor_id], center_id: params[:id]).call 
      render json: "assigned successfully"
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def add_child
    begin
      new_child = Center::AddChildService.new(
        name: params[:name], 
        email: params[:email], 
        age: params[:age], 
        center_id: params[:id], 
        diagnosis_ids: params[:diagnosis_ids]
      ).call 
      render json: ChildSerializer.new(new_child).serializable_hash
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def edit_child
    begin
      child = Center::EditChildService.new(
        child_id: params[:child_id], 
        edit_params: edit_child_params.except(:diagnosis_ids), 
        diagnosis_ids: params[:child][:diagnosis_ids]
      ).call
      render json: ChildSerializer.new(child).serializable_hash
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def add_modules
    begin
      Center::AddModulesService.new(software_module_ids: params[:software_module_ids], center_id: params[:id]).call 
      render json: "modules added successfully"
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def assign_module_child
    begin
      Center::AssignModuleToChildService.new(child_id: params[:child_id], software_module_id: params[:software_module_id], center_id: params[:id]).call 
      render json: "module is assigned to child"
    rescue => e
      result = Response::HandleErrorService.new(error: e).call
      render json: result[:data], status: result[:status]
    end
  end

  def unassign_module_child
    begin
      Center::UnassignModuleFromChildService.new(child_id: params[:child_id], software_module_id: params[:software_module_id], center_id: params[:id]).call 
      render json: "module is un assigned to child"
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def assign_doctor_child
    begin
      Center::AssignDoctorToChildService.new(assignee_doctor_id: params[:doctor_id], child_id: params[:child_id], center_id: params[:id]).call
      render json: "doctor is assigned to  child"
    rescue => e
      result = Response::HandleErrorService.new(error: e).call
      render json: result[:data], status: result[:status]
    end
  end

  def  unassign_doctor_child
    begin
      Center::UnassignDoctorFromChildService.new(assignee_doctor_id: params[:doctor_id], child_id: params[:child_id], center_id: params[:id]).call
      render json: "doctor is un assigned from child"
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def add_headset
    begin
      new_headset = Center::AddHeadsetService.new(headset_params: headset_params, center_id: params[:id]).call 
      render json: HeadsetSerializer.new(new_headset).serializable_hash
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def edit_headset
    begin
      headset = Center::EditHeadsetService.new(headset_params: headset_params, headset_id: params[:headset_id]).call 
      render json: HeadsetSerializer.new(headset).serializable_hash
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def all_doctors
    doctors = Doctor.where.not(id: current_doctor.id)
    render json: MiniDoctorSerializer.new(doctors).serializable_hash
  end

  def assigned_modules
    modules = Center::AssignedModulesService.new(center: @center).call
    render json: SoftwareModuleSerializer.new(modules).serializable_hash
  end

  def kids 
    kids = @center.children
    render json: ChildSerializer.new(kids).serializable_hash
  end

  # DELETE /centers/1
  def destroy
    @center.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_center
      @center = Center.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def center_params
      params.require(:center).permit(:name, :longitude, :latitude, :website, :logo, :certificate, :registration_number, :tax_id, :specialty_ids, :social_links, :email, :phone_number)
    end

    def edit_center_params
      params.permit(:id, :name, :longitude, :latitude, :website, :logo, :certificate, :registration_number, :tax_id, :email, :phone_number, :social_links, :specialty_ids => [])
    end

    def edit_child_params
      params.require(:child).permit(:name, :age, :diagnosis_ids)
    end

    def headset_params
      params.require(:headset).permit(:name, :version, :model, :key, :brand)
    end
end
