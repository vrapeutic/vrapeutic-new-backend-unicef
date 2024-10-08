class Api::V1::CentersController < Api::BaseApi
  before_action :authorized_doctor?
  before_action :set_center, only: %i[show update]

  authorize_resource except: %i[index show]

  def current_ability
    @current_ability ||= CenterAbility.new(current_doctor, params)
  end

  # GET /centers
  def index
    @centers = Center.all

    render json: @centers
  end

  # GET /centers/1
  def show
    render json: @center
  end

  def create
    new_center = Center::CreateService.new(
      name: params[:name],
      longitude: params[:longitude],
      latitude: params[:latitude],
      website: params[:website],
      logo: params[:logo],
      certificate: params[:certificate],
      registration_number: params[:registration_number],
      tax_id: params[:tax_id],
      current_doctor: current_doctor,
      specialty_ids: params[:specialty_ids],
      social_links: params[:social_links],
      email: params[:email],
      phone_number: params[:phone_number]
    ).call
    render json: CenterSerializer.new(new_center, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    updated_center = Center::EditService.new(
      current_center: @center,
      edit_params: edit_center_params.except(:social_links, :specialty_ids),
      specialty_ids: params[:specialty_ids],
      social_links: params[:social_links]
    ).call
    render json: CenterSerializer.new(updated_center, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_center
    @center = Center.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def center_params
    params.require(:center).permit(:name, :longitude, :latitude, :website, :logo, :certificate, :registration_number, :tax_id, :specialty_ids,
                                   :social_links, :email, :phone_number)
  end

  def edit_center_params
    params.permit(:name, :longitude, :latitude, :website, :logo, :certificate,
                  :registration_number, :tax_id, :email, :phone_number,
                  :social_links, specialty_ids: [])
  end
end
