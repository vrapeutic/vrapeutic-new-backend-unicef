class Api::V1::SpecialtiesController < Api::BaseApi
  before_action :set_specialty, only: %i[ show update destroy ]

  # GET /specialties
  def index
    @specialties = Specialty.all

    render json: @specialties
  end

  # GET /specialties/1
  def show
    render json: @specialty
  end

  # POST /specialties
  def create
    @specialty = Specialty.new(specialty_params)

    if @specialty.save
      render json: @specialty, status: :created, location: @specialty
    else
      render json: @specialty.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /specialties/1
  def update
    if @specialty.update(specialty_params)
      render json: @specialty
    else
      render json: @specialty.errors, status: :unprocessable_entity
    end
  end

  # DELETE /specialties/1
  def destroy
    @specialty.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_specialty
      @specialty = Specialty.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def specialty_params
      params.require(:specialty).permit(:name)
    end
end
