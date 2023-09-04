class Api::V1::SoftwareModulesController < Api::BaseApi
  before_action :set_software_module, only: %i[ show update destroy ]

  before_action :validate_admin_otp, only: %i[create]

  # GET /software_modules
  def index
    @software_modules = SoftwareModule.all

    render json: @software_modules
  end

  # GET /software_modules/1
  def show
    render json: @software_module
  end

  # POST /software_modules
  def create
    begin
      @new_software_module = SoftwareModule::CreateService.new(create_params: software_module_params.except(:targeted_skill_ids), targeted_skill_ids: params[:targeted_skill_ids]).call 
      render json: @new_software_module
    rescue => e 
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /software_modules/1
  def update
    if @software_module.update(software_module_params)
      render json: @software_module
    else
      render json: @software_module.errors, status: :unprocessable_entity
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
