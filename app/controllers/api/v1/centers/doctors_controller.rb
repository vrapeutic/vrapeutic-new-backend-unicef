class Api::V1::Centers::DoctorsController < Api::BaseApi
  before_action :set_center
  before_action :set_center_doctors, only: %i[index show assign_doctor_child unassign_doctor_child]
  before_action :set_center_doctor, only: %i[show assign_doctor_child unassign_doctor_child]
  before_action :authorized

  def current_ability
    @current_ability ||= DoctorAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    render json: DoctorSerializer.new(@doctors, param_options).serializable_hash
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

    render json: 'doctor is assigned to  child'
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

    render json: 'doctor is un assigned from child'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_center_doctors
    @doctors = @center.doctors
  end

  def set_center_doctor
    @doctor = @doctors.find(params[:id])
  end
end
