class Api::V1::SpecialtiesController < Api::BaseApi
  # before_action :authorized
  before_action :set_specialty, only: :show

  # GET /specialties
  def index
    @specialties = Specialty.all

    render json: @specialties
  end

  # GET /specialties/1
  def show
    render json: @specialty
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_specialty
    @specialty = Specialty.find(params[:id])
  end
end
