class Otp::GenerateService
  def initialize(doctor:, expires_at: Time.now + 15.minutes, code_type: Otp::EMAIL_VERIFICATION)
    @doctor = doctor
    @expires_at = expires_at
    @code_type = code_type
  end

  def call
    find_otp_record
    generate_otp
  end

  private

  def find_otp_record
    @otp_record = Otp::FindByTypeService.new(doctor: @doctor, code_type: @code_type).call
  end

  def generate_otp
    code = SecureRandom.hex(3)
    options = { code: code, expires_at: @expires_at, code_type: @code_type }
    if @otp_record.present?
      @otp_record.update(options)
    else
      @doctor.otps.create(options)
    end
    code
  end
end
