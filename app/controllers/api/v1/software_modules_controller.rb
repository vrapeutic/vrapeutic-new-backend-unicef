class Api::V1::SoftwareModulesController < Api::BaseApi
  before_action :set_software_module, only: %i[ show destroy ]

  before_action :validate_admin_otp, only: %i[create update]

  # GET /software_modules
  def index
    @software_modules = SoftwareModule.all

    render json: SoftwareModuleSerializer.new(@software_modules).serializable_hash
  end

  # GET /software_modules/1
  def show
    render json: @software_module
  end

  # POST /software_modules
  def create
    begin
      @new_software_module = SoftwareModule::CreateService.new(create_params: software_module_params.except(:targeted_skill_ids), targeted_skill_ids: params[:targeted_skill_ids]).call 
      render json: SoftwareModuleSerializer.new(@new_software_module).serializable_hash
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /software_modules/1
  def update
    begin
      software_module = SoftwareModule::UpdateService.new(
        edit_params: software_module_params.except(:targeted_skill_ids), 
        targeted_skill_ids: params[:targeted_skill_ids],
        software_module_id: params[:id]
      ).call
      render json: SoftwareModuleSerializer.new(software_module).serializable_hash
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  # DELETE /software_modules/1
  def destroy
    @software_module.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_module
      @software_module = SoftwareModule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def software_module_params
      params.require(:software_module).permit(:name, :version, :technology, :targeted_skill_ids)
    end
end
