class Api::V1::DoctorsController < Api::BaseApi
  before_action :set_doctor, only: %i[ show update destroy validate_otp resend_otp ]

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
        specialty_ids: params[:specialty_ids],
        photo: params[:photo]
      ).call
      render json: DoctorSerializer.new(@doctor).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
  end

  def validate_otp
    result = Otp::ValidateService.new(doctor: @doctor, entered_otp: params[:otp]).call
    if result
      @doctor.update_column(:is_email_verified, true)
      return render json: DoctorSerializer.new(@doctor).serializable_hash
    end
    render json: {error: "otp is not valid or expired"}, status: :unprocessable_entity
  end

  def resend_otp
    if @doctor.is_email_verified
      return render json: {error: "doctor is already vdrified"}, status: :unprocessable_entity 
    end
    Otp::GenerateService.new(doctor: @doctor).call
    # send email 
    OtpMailer.send_otp(@doctor, @doctor.otp.code).deliver_now
    render json: "otp is sent again"
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
      params.require(:doctor).permit(:name, :email, :password, :degree, :university, :photo, :specialty_ids, :otp)
    end
end
