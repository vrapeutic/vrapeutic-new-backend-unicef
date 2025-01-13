class Api::V1::Admins::HeadsetsController < Api::BaseApi
  before_action :authorized_admin?
  before_action :set_headset, only: %i[show update destroy]

  def index
    q = Headset.ransack_query(sort: params[:sort], query: params[:q])
    render json: HeadsetSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: HeadsetSerializer.new(@headset, param_options).serializable_hash
  end

  def update
    headset = Center::EditHeadsetService.new(headset_params: headset_params, headset_id: @headset.id).call
    render json: HeadsetSerializer.new(headset).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    @headset.discard
    head :no_content
  end

  private

  def set_headset
    @headset = Headset.find(params[:id] || params[:headset_id])
  end

  def headset_params
    params.require(:headset).permit(:model, :key)
  end
end
