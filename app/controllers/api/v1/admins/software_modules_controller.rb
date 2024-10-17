class Api::V1::Admins::SoftwareModulesController < Api::BaseApi
  before_action :authorized_admin?
  before_action :set_software_module, only: %i[show update destroy]

  def index
    q = SoftwareModule.ransack_query(sort: params[:sort], query: params[:q])
    render json: SoftwareModuleSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: SoftwareModuleSerializer.new(@software_module, param_options).serializable_hash
  end

  def create
    @new_software_module = SoftwareModule::CreateService.new(
      name: params[:name],
      version: params[:version],
      technology: params[:technology],
      package_name: params[:package_name],
      min_age: params[:min_age],
      max_age: params[:max_age],
      image: params[:image],
      targeted_skill_ids: params[:targeted_skill_ids]
    ).call
    render json: SoftwareModuleSerializer.new(@new_software_module).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    software_module = SoftwareModule::UpdateService.new(
      edit_params: software_module_params.except(:targeted_skill_ids),
      targeted_skill_ids: params[:targeted_skill_ids] || params[:software_module][:targeted_skill_ids],
      software_module_id: @software_module.id
    ).call
    render json: SoftwareModuleSerializer.new(software_module).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    @software_module.destroy
  end

  private

  def set_software_module
    @software_module = SoftwareModule.find(params[:id])
  end

  def software_module_params
    params.require(:software_module).permit(:name, :version, :technology, :package_name, :min_age, :max_age, :image, :targeted_skill_ids)
  end
end
