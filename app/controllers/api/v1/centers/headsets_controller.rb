class Api::V1::Centers::HeadsetsController < Api::BaseApi
  before_action :set_center
  before_action :set_headsets, only: :index
  before_action :set_headset, only: %i[show edit_headset]
  before_action :authorized

  def current_ability
    @current_ability ||= HeadsetAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    render json: HeadsetSerializer.new(@headsets, param_options).serializable_hash
  end

  def show
    render json: HeadsetSerializer.new(@headset, param_options).serializable_hash
  end

  def add_headset
    new_headset = Center::AddHeadsetService.new(
      headset_params: headset_params,
      center_id: @center.id
    ).call

    render json: HeadsetSerializer.new(new_headset).serializable_hash
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def edit_headset
    headset = Center::EditHeadsetService.new(
      headset_params: headset_params,
      headset_id: @headset.id
    ).call

    render json: HeadsetSerializer.new(headset).serializable_hash
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_headsets
    @headsets = @center.headsets
  end

  def set_headset
    set_headsets
    @headset = @headsets.find(params[:id] || params[:headset_id])
  end

  def headset_params
    params.require(:headset).permit(:model, :key)
  end
end
