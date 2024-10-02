class Api::V1::Admins::CentersController < Api::BaseApi
  before_action :authorized_admin?
  before_action :set_center, only: %i[show assign_center_headset assign_center_module session_evaluations]

  def index
    q = Center.ransack_query(sort: params[:sort], query: params[:q])
    render json: CenterSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: CenterSerializer.new(@center, param_options).serializable_hash
  end

  def assign_center_headset
    new_headset = Center::AddHeadsetService.new(headset_params: headset_params, center_id: @center.id).call
    render json: HeadsetSerializer.new(new_headset, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def assign_center_module
    Admin::AssignCenterModuleService.new(center_id: @center.id, software_module_id: params[:software_module_id],
                                         end_date: params[:end_date]).call
    render json: 'assigned successfully'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def session_evaluations
    render json: @center.evaluation_stats
  end

  private

  def set_center
    @center = Center.find(params[:id] || params[:center_id])
  end

  def headset_params
    params.require(:headset).permit(:model, :key)
  end
end
