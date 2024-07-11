class Api::V1::Centers::SoftwareModulesController < Api::BaseApi
  before_action :set_center
  before_action :set_modules, only: %i[index show]
  before_action :set_module, only: :show
  before_action :authorized

  def current_ability
    @current_ability ||= SoftwareModuleAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    render json: SoftwareModuleSerializer.new(@modules, param_options).serializable_hash
  end

  def assigned_modules
    modules = Center::AssignedModulesService.new(center: @center).call
    render json: SoftwareModuleSerializer.new(modules).serializable_hash
  end

  def show
    render json: SoftwareModuleSerializer.new(@module, param_options).serializable_hash
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_modules
    @modules = Center::ModulesService.new(center: @center).call
  end

  def set_module
    @module = @modules.find(params[:id])
  end
end
