module Api
  class Api::BaseApi < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotUnique, with: :record_is_existed_before
    rescue_from CanCan::AccessDenied do |exception|
      Sentry.capture_message("CanCan::AccessDenie::#{exception} - #{exception.message}", level: :info)
      render json: exception.message, status: :forbidden
    end

    def current_admin
      admin_auth_header = request.headers['otp']

      Admin.find_by(otp: admin_auth_header) if admin_auth_header
    end

    def current_doctor
      Doctor.find(17)
      # doctor_decoded_token && Doctor.find_by(id: doctor_decoded_token['id'], is_email_verified: true) || nil
    end

    def current_center
      @center.nil? && request_center_params.present? ? Center.find_by(id: request_center_params) : @center
    end

    def request_center_params
      params[:center_id] || params[:q] && (params[:q][:centers_id_eq] || params[:q][:center_id_eq])
    end

    def param_options
      include_param = params[:include]&.split(',') || []
      hash_params = { include: include_param }
      hash_params[:center_id] = current_center&.id if current_center.present?

      { params: hash_params, include: include_param }
    end

    private

    def doctor_decoded_token
      doctor_auth_header = request.headers['Authorization']

      JsonWebToken.decode(doctor_auth_header.split(' ')[1]) if doctor_auth_header
    end

    def record_not_found
      render json: { error: 'data not found' }, status: :not_found
    end

    def record_is_existed_before
      render json: { error: 'data is aleady existed' }, status: :conflict
    end

    def authorized_doctor?
      if !!current_doctor
        Sentry.capture_message('Doctor Request', level: :info)
      else
        render json: 'unauthenticated doctor', status: :unauthorized
      end
    end

    def authorized_admin?
      if !current_admin
        render json: 'unauthenticated admin', status: :unauthorized
      elsif !Admin::ValidateOtpService.new(entered_otp: current_admin&.otp).call
        render json: 'otp is not valid or expired', status: :unauthorized
      else
        Sentry.capture_message('Admin Request', level: :info)
      end
    end
  end
end
