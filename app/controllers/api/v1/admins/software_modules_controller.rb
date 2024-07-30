class Api::V1::Admins::SoftwareModulesController < Api::BaseApi
  before_action :validate_admin_otp
  before_action :set_software_module, only: :show

  def index
    q = SoftwareModule.ransack_query(sort: params[:sort], query: params[:q])
    render json: SoftwareModuleSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: SoftwareModuleSerializer.new(@software_module, param_options).serializable_hash
  end

  private

  def set_software_module
    @software_module = SoftwareModule.find(params[:id])
  end
end
