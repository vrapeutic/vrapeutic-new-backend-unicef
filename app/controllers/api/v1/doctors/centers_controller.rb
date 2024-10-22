class Api::V1::Doctors::CentersController < Api::BaseApi
  before_action :authorized_doctor?
  before_action :set_doctor
  before_action :set_doctor_centers, only: %i[index home_centers]
  before_action :set_doctor_center,  only: %i[show center_statistics center_vr_minutes]

  def current_ability
    @current_ability ||= CenterAbility.new(current_doctor, params)
  end
  authorize_resource except: %i[index home_centers]

  def index
    q = @centers.ransack_query(sort: params[:sort], query: params[:q])
    render json: CenterSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: CenterSerializer.new(@center, param_options).serializable_hash
  end

  def home_centers
    current_doctor_centers = @centers.select("centers.*, COUNT(DISTINCT doctors.id)
                                           AS doctors_count, COUNT(DISTINCT children.id)
                                           AS children_count")
                                     .left_joins(:doctors, :children)
                                     .group('centers.id')
                                     .includes(:specialties, :center_social_links)
    render json: HomeCenterSerializer.new(current_doctor_centers, param_options).serializable_hash
  end

  def center_statistics
    result = Doctor::CenterStatisticsService.new(doctor: @doctor, center_id: @center.id).call
    render json: result
  end

  def center_vr_minutes
    result = Doctor::CenterVrMinutesService.new(doctor: @doctor, center_id: @center.id, year: params[:year]).call
    render json: result
  end

  private

  def set_doctor
    @doctor = current_doctor
  end

  def set_doctor_centers
    @centers = @doctor.centers
  end

  def set_doctor_center
    set_doctor_centers
    @center = @centers.find(params[:id] || params[:center_id])
  end
end
