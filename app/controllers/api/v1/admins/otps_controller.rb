class Api::V1::Admins::OtpsController < Api::BaseApi
  before_action :set_admin_email, only: :send_otp

  def send_otp
    otp = Admin::GenerateOtpService.new(email: @email).call
    AdminOtpMailer.send_otp(@email, otp).deliver_later
    render json: 'otp is sent successfully'
  end

  private

  def set_admin_email
    @email = (Admin::PERMITTED_EMAILS.select { |email| email == params[:email]&.downcase }).first

    raise ActiveRecord::RecordNotFound if @email.nil?
  end
end
