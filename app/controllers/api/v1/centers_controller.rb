class Api::V1::CentersController < Api::BaseApi
  before_action :set_center,
                only: %i[update invite_doctor assign_doctor make_doctor_admin
                         add_child add_modules assign_doctor_child unassign_doctor_child]
  before_action :authorized

  authorize_resource

  def current_ability
    @current_ability ||= CenterAbility.new(current_doctor, params)
  end

  def create
    new_center = Center::CreateService.new(
      name: params[:name],
      longitude: params[:longitude],
      latitude: params[:latitude],
      website: params[:website],
      logo: params[:logo],
      certificate: params[:certificate],
      registration_number: params[:registration_number],
      tax_id: params[:tax_id],
      current_doctor: current_doctor,
      specialty_ids: params[:specialty_ids],
      social_links: params[:social_links],
      email: params[:email],
      phone_number: params[:phone_number]
    ).call
    render json: CenterSerializer.new(new_center, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    updated_center = Center::EditService.new(
      current_center: @center,
      edit_params: edit_center_params.except(:social_links, :specialty_ids),
      specialty_ids: params[:specialty_ids],
      social_links: params[:social_links]
    ).call
    render json: CenterSerializer.new(updated_center, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def invite_doctor
    @invitaion_token_data = Center::GenerateInvitationTokenService.new(email: params[:email], center_id: @center.id).call
    InviteDoctorMailer.send_invitation_link(params[:email], @center, @invitaion_token_data).deliver_later
    render json: 'invitation is sent'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def assign_doctor
    Center::AssignDoctorService.new(doctor_id: params[:doctor_id], center_id: @center.id).call
    render json: 'assigned successfully'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def edit_doctor
    new_doctor = Doctor::UpdateService.new(
      doctor_id: params[:doctor_id],
      degree: params[:degree],
      certificate: params[:certificate],
      specialty_ids: params[:specialty_ids],
      photo: params[:photo],
      university: params[:university]
    ).call
    render json: DoctorSerializer.new(new_doctor, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def make_doctor_admin
    Center::MakeDoctorAdminService.new(doctor_id: params[:doctor_id], center_id: @center.id).call
    render json: 'assigned successfully'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def add_child
    new_child = Center::AddChildService.new(
      name: params[:name],
      email: params[:email],
      age: params[:age],
      photo: params[:photo],
      center_id: @center.id,
      diagnosis_ids: params[:diagnosis_ids].is_a?(String) ? params[:diagnosis_ids]&.split(',') : params[:diagnosis_ids]
    ).call
    render json: ChildSerializer.new(new_child, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def edit_child
    child = Center::EditChildService.new(
      child_id: params[:child_id],
      edit_params: edit_child_params.except(:diagnosis_ids),
      diagnosis_ids: params[:child][:diagnosis_ids]
    ).call
    render json: ChildSerializer.new(child, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def add_headset
    new_headset = Center::AddHeadsetService.new(
      headset_params: headset_params,
      center_id: params[:id]
    ).call

    render json: HeadsetSerializer.new(new_headset).serializable_hash
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def edit_headset
    headset = Center::EditHeadsetService.new(
      headset_params: headset_params,
      headset_id: params[:headset_id]
    ).call

    render json: HeadsetSerializer.new(headset).serializable_hash
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_center
    @center = Center.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def center_params
    params.require(:center).permit(:name, :longitude, :latitude, :website, :logo, :certificate, :registration_number, :tax_id, :specialty_ids,
                                   :social_links, :email, :phone_number)
  end

  def edit_center_params
    params.permit(:id, :name, :longitude, :latitude, :website, :logo, :certificate, :registration_number, :tax_id, :email, :phone_number,
                  :social_links, specialty_ids: [])
  end

  def edit_child_params
    params.require(:child).permit(:name, :age, :photo, :diagnosis_ids)
  end

  def headset_params
    params.require(:headset).permit(:model, :key)
  end
end
