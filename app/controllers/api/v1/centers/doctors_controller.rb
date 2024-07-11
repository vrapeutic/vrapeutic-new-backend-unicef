class Api::V1::Centers::DoctorsController < Api::BaseApi
  before_action :set_center
  before_action :set_doctors, only: %i[index show]
  before_action :set_doctor, only: :show
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

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_doctors
    @doctors = @center.doctors
  end

  def set_doctor
    @doctor = @doctors.find(params[:id])
  end
end
