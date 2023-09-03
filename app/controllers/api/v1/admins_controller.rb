class Api::V1::AdminsController < Api::BaseApi
  before_action :set_admin, only: %i[ show update destroy ]
  before_action :validate_admin_otp, only: %i[ validate_otp]

  def send_otp 
    otp = Admin::GenerateOtpService.new.call
    AdminOtpMailer.send_otp(ENV['ADMIN_EMAIL'], otp).deliver_later
    render json: "otp is sent successfully"
  end

  def validate_otp 
    render json: "admin is now authorized to do actions"
  end

  # GET /admins
  def index
    @admins = Admin.all

    render json: @admins
  end

  # GET /admins/1
  def show
    render json: @admin
  end

  # POST /admins
  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      render json: @admin, status: :created, location: @admin
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admins/1
  def update
    if @admin.update(admin_params)
      render json: @admin
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  # DELETE /admins/1
  def destroy
    @admin.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:otp, :expires_at)
    end
end
