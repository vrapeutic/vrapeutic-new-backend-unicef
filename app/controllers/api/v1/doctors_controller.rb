class Api::V1::DoctorsController < Api::BaseApi
  before_action :set_doctor, only: %i[ show update destroy ]

  # GET /doctors
  def index
    @doctors = Doctor.all

    render json: @doctors
  end

  # GET /doctors/1
  def show
    render json: @doctor
  end

  # POST /doctors
  def create
    begin
      @doctor = Doctor::CreateService.new(
        name: params[:name],
        email: params[:email],
        password: params[:password],
        degree: params[:degree],
        university: params[:university],
        specialty_ids: params[:specialty_ids]
      ).call
      render json: DoctorSerializer.new(@doctor).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doctors/1
  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def doctor_params
      params.require(:doctor).permit(:name, :email, :password, :degree, :university, :specialty_ids)
    end
end
