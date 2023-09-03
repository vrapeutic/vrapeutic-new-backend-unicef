module Api
    class Api::BaseApi < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordNotUnique, with: :record_is_existed_before

      rescue_from CanCan::AccessDenied do |exception|
        render json: exception.message, status: :forbidden
      end
  
      # implement token auth logic
      def auth_header
        request.headers['Authorization']
      end
  
      def token
        auth_header.split(' ')[1]
      end
  
      def decoded_token
        if auth_header
          JsonWebToken.decode(token)
        end
      end
      def current_doctor
        if decoded_token
          doctor_id = decoded_token['id']
          @doctor = Doctor.find_by(id: doctor_id, is_email_verified: true)
          @doctor.present? ? @doctor : false
        end
      end
  
      def logged_in?
        !!current_doctor
      end
  
      def authorized
        render json: "unauthenticated doctor", status: :unauthorized unless logged_in?
      end

      private

      def record_not_found
        render json: { error: "data not found" }, status: :not_found
      end
      
      def record_is_existed_before
        render json: {error: "data is aleady existed"}, status: :conflict
      end

      def validate_admin_otp 
        
      end
  
    end
  end