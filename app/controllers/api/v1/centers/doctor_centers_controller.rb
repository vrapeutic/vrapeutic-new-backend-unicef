class Api::V1::Centers::DoctorCentersController < Api::BaseApi
  before_action :authorized_doctor?
  before_action :set_center
  before_action :set_center_doctor_centers, only: :index
  before_action :set_center_doctor_center, only: :show

  def current_ability
    @current_ability ||= DoctorCenterAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    q = @doctor_centers.ransack_query(sort: params[:sort], query: params[:q])
    render json: DoctorCenterSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: DoctorCenterSerializer.new(@doctor_center, param_options).serializable_hash
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_center_doctor_centers
    @doctor_centers = @center.doctor_centers
  end

  def set_center_doctor_center
    set_center_doctor_centers
    @doctor_center = @doctor_centers.find(params[:id] || params[:doctor_id])
  end
end
