class Otp::ValidateService
  def initialize(doctor:, entered_otp:, code_type: Otp::EMAIL_VERIFICATION)
    @doctor = doctor
    @entered_otp = entered_otp
    @code_type = code_type
  end

  def call
    find_otp_record
    validate_otp
  end

  private

  def find_otp_record
    @otp_record = Otp::FindByTypeService.new(doctor: @doctor, code_type: @code_type).call
  end

  def validate_otp
    return false if @otp_record.nil? || @otp_record.expires_at? && @otp_record.expires_at < Time.now

    @otp_record.code == @entered_otp && @otp_record.update!(expires_at: 30.seconds)
  end
end
