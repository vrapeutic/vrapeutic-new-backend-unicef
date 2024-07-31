class Api::V1::Admins::OtpsController < Api::BaseApi
  before_action :set_admin_email, only: :send_otp

  def send_otp
    otp = Admin::GenerateOtpService.new.call
    AdminOtpMailer.send_otp(@email, otp).deliver_later
    render json: 'otp is sent successfully'
  end

  private

  def set_admin_email
    emails = (ENV['ADMIN_EMAILS'].present? ? ENV['ADMIN_EMAILS'].split(',') : []) + [ENV['ADMIN_EMAIL']]

    @email = (emails.select { |email| email == params[:email]&.downcase }).first || ENV['ADMIN_EMAIL']

    raise ActiveRecord::RecordNotFound if @email.nil?
  end
end
