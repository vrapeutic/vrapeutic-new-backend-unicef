class Api::V1::Centers::DoctorsController < Api::BaseApi
  # before_action :authorized_doctor?
  before_action :set_center
  before_action :set_center_doctors, only: :index
  before_action :set_center_doctor, only: %i[show assign_doctor_child unassign_doctor_child edit_doctor]

  # def current_ability
  #   @current_ability ||= DoctorAbility.new(current_doctor, params)
  # end
  # authorize_resource

  def index
    q = @doctors.ransack_query(sort: params[:sort], query: params[:q])
    render json: DoctorSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: DoctorSerializer.new(@doctor, param_options).serializable_hash
  end

  def assign_doctor_child
    Center::AssignDoctorToChildService.new(
      assignee_doctor_id: @doctor.id,
      child_id: params[:child_id],
      center_id: @center.id
    ).call

    render json: 'doctor is assigned to child'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def unassign_doctor_child
    Center::UnassignDoctorFromChildService.new(
      assignee_doctor_id: @doctor.id,
      child_id: params[:child_id],
      center_id: @center.id
    ).call

    render json: 'doctor is unassigned from child'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def invite_doctor
    doctor = Doctor.find_by(email: params[:email]&.downcase)
    if doctor.present?
      Center::AssignDoctorService.new(doctor_id: doctor.id, center_id: @center.id, current_doctor: current_doctor).call
      render json: 'we have sent notification invitation to the existed doctor'
    else
      InviteDoctorMailer.send_invitation_link(
        params[:email],
        @center,
        Center::GenerateInvitationTokenService.new(email: params[:email]).call
      ).deliver_later
      render json: 'we have sent email invitation to the new doctor'
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # def assign_doctor
  #   Center::AssignDoctorService.new(doctor_id: params[:id] || params[:doctor_id], center_id: @center.id).call
  #   render json: 'assigned successfully'
  # rescue StandardError => e
  #   render json: { error: e.message }, status: :unprocessable_entity
  # end

  def edit_doctor
    new_doctor = Doctor::UpdateService.new(
      name: params[:name],
      doctor_id: @doctor.id,
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
    Center::MakeDoctorAdminService.new(doctor_id: params[:id] || params[:doctor_id], center_id: @center.id).call
    render json: 'marked as admin successfully'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_center_doctors
    @doctors = @center.doctors
  end

  def set_center_doctor
    set_center_doctors
    @doctor = @doctors.find(params[:id] || params[:doctor_id])
  end
end
