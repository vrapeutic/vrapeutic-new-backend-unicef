class Api::V1::AuthController < Api::BaseApi
  before_action :set_doctor, only: %i[forget_password validate_reset_password_otp]
  before_action :set_otp_code_type, only: :validate_reset_password_otp
  before_action :set_doctor_by_id, only: %i[validate_email_otp resend_email_otp]

  def sign_in
    result = Doctor::HandleLoginService.new(email: params[:email], password: params[:password]).call
    if result[:is_admin]
      otp = Admin::GenerateOtpService(email: params[:email]).new.call
      AdminOtpMailer.send_otp(params[:email]&.downcase, otp).deliver_later
      render json: result
    else
      @doctor = result[:doctor]
      @doctor.update_column(:is_email_verified, false)
      otp_code = Otp::GenerateService.new(doctor: @doctor).call
      OtpMailer.send_otp(@doctor, otp_code).deliver_later
      doctor_data = DoctorSerializer.new(@doctor, param_options).serializable_hash
      render json: { is_admin: result[:is_admin], doctor: doctor_data[:data] }
    end
  rescue StandardError => e
    render json: e.message, status: :unauthorized
  end

  def forget_password
    otp_code = Otp::GenerateService.new(doctor: @doctor, code_type: Otp::FORGET_PASSWORD, expires_at: 1.hours.from_now).call

    DoctorMailer.forget_password(doctor: @doctor, otp_code: otp_code).deliver_later

    render json: DoctorSerializer.new(@doctor, param_options).serializable_hash, status: :ok
  end

  def validate_reset_password_otp
    if Otp::ValidateService.new(doctor: @doctor, entered_otp: user_otp_param, code_type: Otp::OTP_CODE_TYPES[@otp_code_type]).call
      render json: { token: JsonWebToken.encode({ id: @doctor.id }, Time.zone.now + 5.minutes) }
    else
      render json: 'otp is not valid or expired', status: :unauthorized
    end
  end

  def reset_password
    decoded_data = JsonWebToken.decode(user_token_param)

    if decoded_data.present?
      doctor = Doctor.find_by_id(decoded_data['id'])

      if doctor.update(reset_password_params)
        render json: DoctorSerializer.new(doctor, param_options).serializable_hash, status: :ok
      else
        render json: doctor.errors, status: :unprocessable_entity
      end
    else
      render json: 'token is not valid or expired', status: :unauthorized
    end
  end

  def validate_email_otp
    if @doctor.is_email_verified
      render json: { error: 'doctor is already verified' }, status: :unprocessable_entity
    else
      result = Otp::ValidateService.new(doctor: @doctor, entered_otp: params[:otp]).call
      if result
        @doctor.update_column(:is_email_verified, true)
        render json: Doctor::GenerateJwtTokenService.new(doctor_id: @doctor.id).call, status: :ok
      else
        render json: { error: 'otp is not valid or expired' }, status: :unprocessable_entity
      end
    end
  end

  def resend_email_otp
    if @doctor.is_email_verified
      render json: { error: 'doctor is already verified' }, status: :unprocessable_entity
    else
      otp_code = Otp::GenerateService.new(doctor: @doctor).call
      # send email
      OtpMailer.send_otp(@doctor, otp_code).deliver_later
      render json: 'otp is sent again'
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find_by_email!(user_email_param)
  end

  def set_doctor_by_id
    @doctor = Doctor.find(params[:id])
  end

  def set_otp_code_type
    raise ActionController::BadRequest.new, 'Invalid otp code type' unless %w[email_verification
                                                                              session_verification
                                                                              forget_password].include?(params[:otp_code_type])

    @otp_code_type = params[:otp_code_type]&.to_sym
  end

  def user_email_param
    params.require(:email)
  end

  def user_otp_param
    params.require(:otp)
  end

  def user_token_param
    params.require(:token)
  end

  def reset_password_params
    params.require(:data).permit(:password, :password_confirmation)
  end
end
