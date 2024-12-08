class Api::V1::Doctors::DoctorCentersController < Api::BaseApi
  before_action :authorized_doctor?
  before_action :set_doctor
  before_action :set_doctor_doctor_centers, only: :index
  before_action :set_doctor_doctor_center, only: %i[show update destroy]

  def index
    q = @doctor_centers.ransack_query(sort: params[:sort], query: params[:q])
    render json: DoctorCenterSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: DoctorCenterSerializer.new(@doctor_center, param_options).serializable_hash
  end

  def update
    if @doctor_center.update(status: params[:status])
      render json: @doctor_center, status: :ok
    else
      render json: @doctor_center.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @doctor_center.invited?
      @doctor_center.destroy
      render json: { message: 'Doctor center has been deleted successfully.' }, status: :ok
    else
      render json: { message: 'Failed to delete doctor center.' }, status: :unprocessable_entity
    end
  end

  private

  def set_doctor
    @doctor = current_doctor
  end

  def set_doctor_doctor_centers
    @doctor_centers = DoctorCenter.where(doctor_id: @doctor.id)
  end

  def set_doctor_doctor_center
    set_doctor_doctor_centers
    @doctor_center = @doctor_centers.find(params[:id] || params[:doctor_id])
  end
end
