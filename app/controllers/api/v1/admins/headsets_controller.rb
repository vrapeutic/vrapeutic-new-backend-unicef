class Api::V1::Admins::HeadsetsController < Api::BaseApi
  before_action :validate_admin_otp
  before_action :set_headset, only: :show

  def index
    q = Headset.kept.ransack_query(sort: params[:sort], query: params[:q])
    render json: HeadsetSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: HeadsetSerializer.new(@headset, param_options).serializable_hash
  end

  private

  def set_headset
    @headset = Headset.find(params[:id])
  end
end
