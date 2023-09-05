class Api::V1::AdminsController < Api::BaseApi
  before_action :set_admin, only: %i[ show update destroy ]
  before_action :validate_admin_otp, only: %i[ edit_child ]

  def send_otp 
    otp = Admin::GenerateOtpService.new.call
    AdminOtpMailer.send_otp(ENV['ADMIN_EMAIL'], otp).deliver_later
    render json: "otp is sent successfully"
  end

  def edit_child 
    begin
      child = Admin::EditChildService.new(
        child_id: params[:child_id], 
        edit_params: edit_child_params.except(:diagnosis_ids), 
        diagnosis_ids: params[:child][:diagnosis_ids]
      ).call
      render json: ChildSerializer.new(child).serializable_hash
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
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

    def edit_child_params
      params.require(:child).permit(:name, :age, :diagnosis_ids)
    end
end
