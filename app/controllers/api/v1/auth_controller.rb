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
    forget_password_token = JsonWebToken.encode({ id: doctor.id, email: user_email_param }, 1.hours.from_now)

    DoctorMailer.forget_password(doctor: doctor, token: forget_password_token).deliver_later

    render json: DoctorSerializer.new(doctor, param_options).serializable_hash, status: :ok
  end

  def reset_password
    decoded_data = JsonWebToken.decode(user_token_param)
    doctor = Doctor.find_by_email!(decoded_data['email'])

    if doctor.update(reset_password_params)
      render json: DoctorSerializer.new(doctor, param_options).serializable_hash, status: :ok
    else
      render json: doctor.errors, status: :unprocessable_entity
    end
  end

  private

  def user_email_param
    params.require(:email)
  end

  def user_token_param
    params.require(:token)
  end

  def reset_password_params
    params.require(:data).permit(:password, :password_confirmation)
  end
end
