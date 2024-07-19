class Api::V1::AuthController < Api::BaseApi
  def sign_in
    result = Doctor::HandleLoginService.new(email: params[:email], password: params[:password]).call
    if result[:is_admin]
      otp = Admin::GenerateOtpService.new.call
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
    doctor = Doctor.find_by_email!(user_email_param)
    otp_code = Otp::GenerateService.new(doctor: doctor, code_type: Otp::FORGET_PASSWORD, expires_at: 1.hours.from_now).call

    DoctorMailer.forget_password(doctor: doctor, otp_code: otp_code).deliver_later

    render json: DoctorSerializer.new(doctor, param_options).serializable_hash, status: :ok
  end

  def reset_password
    doctor = Doctor.find_by_email!(user_email_param)

    if Otp::ValidateService.new(doctor: doctor, entered_otp: user_otp_param, code_type: Otp::FORGET_PASSWORD).call
      if doctor.update(reset_password_params)
        render json: DoctorSerializer.new(doctor, param_options).serializable_hash, status: :ok
      else
        render json: doctor.errors, status: :unprocessable_entity
      end
    else
      render json: 'otp is not valid or expired', status: :unauthorized
    end
  end

  private

  def user_email_param
    params.require(:email)
  end

  def user_otp_param
    params.require(:otp)
  end

  def reset_password_params
    params.require(:data).permit(:password, :password_confirmation)
  end
end
