class Api::V1::Admins::CentersController < Api::BaseApi
  before_action :validate_admin_otp
  before_action :set_center, only: :show

  def index
    q = Center.ransack_query(sort: params[:sort], query: params[:q])
    render json: CenterSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: CenterSerializer.new(@center, param_options).serializable_hash
  end

  private

  def set_center
    @center = Center.find(params[:id])
  end
end
