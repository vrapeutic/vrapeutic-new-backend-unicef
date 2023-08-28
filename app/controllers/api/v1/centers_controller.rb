class Api::V1::CentersController < Api::BaseApi
  before_action :set_center, only: %i[ show update destroy ]
  before_action :authorized

  # GET /centers
  def index
    @centers = Center.all

    render json: @centers
  end

  # GET /centers/1
  def show
    render json: @center
  end

  # POST /centers
  def create
    begin
      new_center = Center::CreateService.new(
        name: params[:name], 
        longitude: params[:longitude], 
        latitude:params[:latitude], 
        website:params[:website], 
        logo:params[:logo], 
        certificate:params[:certificate], 
        registration_number:params[:registration_number], 
        tax_id: params[:tax_id],
        current_doctor: current_doctor,
        specialty_ids: params[:specialty_ids],
        social_links: params[:social_links],
        email: params[:email],
        phone_number: params[:phone_number]
      ).call
      render json: CenterSerializer.new(new_center).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /centers/1
  def update
    if @center.update(center_params)
      render json: @center
    else
      render json: @center.errors, status: :unprocessable_entity
    end
  end

  # DELETE /centers/1
  def destroy
    @center.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_center
      @center = Center.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def center_params
      params.require(:center).permit(:name, :longitude, :latitude, :website, :logo, :certificate, :registration_number, :tax_id, :specialty_ids, :social_links, :email, :phone_number)
    end
end
