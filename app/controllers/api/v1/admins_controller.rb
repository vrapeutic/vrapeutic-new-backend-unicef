class Api::V1::AdminsController < Api::BaseApi
  before_action :validate_admin_otp,
                only: %i[assign_center_headset assign_center_module]

  def send_otp
    otp = Admin::GenerateOtpService.new.call
    AdminOtpMailer.send_otp(ENV['ADMIN_EMAIL'], otp).deliver_later
    render json: 'otp is sent successfully'
  end

  # headsets actions
  def assign_center_headset
    new_headset = Center::AddHeadsetService.new(headset_params: headset_params, center_id: params[:center_id]).call
    render json: HeadsetSerializer.new(new_headset, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # software_modules actions
  def assign_center_module
    Admin::AssignCenterModuleService.new(center_id: params[:center_id], software_module_id: params[:software_module_id],
                                         end_date: params[:end_date]).call
    render json: 'assigned successfully'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:otp, :expires_at)
  end

  def headset_params
    params.require(:headset).permit(:model, :key)
  end
end
