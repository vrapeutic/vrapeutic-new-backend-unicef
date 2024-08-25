module Api
  class Api::BaseApi < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotUnique, with: :record_is_existed_before
    rescue_from CanCan::AccessDenied do |exception|
      Sentry.capture_message("CanCan::AccessDenie::#{exception} - #{exception.message}", level: :info)
      render json: exception.message, status: :forbidden
    end

    def current_doctor
      return unless decoded_token

      Doctor.find_by(id: decoded_token['id'], is_email_verified: true) || false
    end

    def authorized
      render json: 'unauthenticated doctor', status: :unauthorized unless logged_in?
    end

    def param_options
      include_param = params[:include]&.split(',') || []
      { params: { include: include_param }, include: include_param }
    end

    private

    def auth_header
      request.headers['Authorization']
    end

    def token
      auth_header.split(' ')[1]
    end

    def decoded_token
      return unless auth_header

      JsonWebToken.decode(token)
    end

    def logged_in?
      !!current_doctor
    end

    def record_not_found
      render json: { error: 'data not found' }, status: :not_found
    end

    def record_is_existed_before
      render json: { error: 'data is aleady existed' }, status: :conflict
    end

    # implement admin authentication

    def admin_auth_header
      request.headers['otp']
    end

    def validate_admin_otp
      return render json: 'unauthenticated admin', status: :unauthorized unless admin_auth_header

      render json: 'otp is not valid or expired', status: :unauthorized unless Admin::ValidateOtpService.new(entered_otp: admin_auth_header).call
    end
  end
end
