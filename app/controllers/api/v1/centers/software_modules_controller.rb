class Api::V1::Centers::SoftwareModulesController < Api::BaseApi
  before_action :set_center
  before_action :set_center_software_modules, only: :index
  before_action :set_center_software_module, only: %i[show assign_module_child unassign_module_child]
  before_action :authorized_doctor?

  def current_ability
    @current_ability ||= SoftwareModuleAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    render json: SoftwareModuleSerializer.new(@software_modules, param_options).serializable_hash
  end

  def assigned_modules
    modules = Center::AssignedModulesService.new(center: @center).call
    render json: SoftwareModuleSerializer.new(modules).serializable_hash
  end

  def show
    render json: SoftwareModuleSerializer.new(@software_module, param_options).serializable_hash
  end

  def add_modules
    Center::AddModulesService.new(
      software_module_ids: params[:software_module_ids],
      center_id: @center.id
    ).call

    render json: 'modules added successfully'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def assign_module_child
    Center::AssignModuleToChildService.new(
      child_id: params[:child_id],
      software_module_id: @software_module.id,
      center_id: @center.id
    ).call

    render json: 'module is assigned to child'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  def unassign_module_child
    Center::UnassignModuleFromChildService.new(
      child_id: params[:child_id],
      software_module_id: @software_module.id,
      center_id: @center.id
    ).call

    render json: 'module is un assigned to child'
  rescue StandardError => e
    result = Response::HandleErrorService.new(error: e).call
    render json: result[:data], status: result[:status]
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_center_software_modules
    @software_modules = Center::ModulesService.new(center: @center).call
  end

  def set_center_software_module
    set_center_software_modules
    @software_module = @software_modules.find(params[:id] || params[:software_module_id])
  end
end
