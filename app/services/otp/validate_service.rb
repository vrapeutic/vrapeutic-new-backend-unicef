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
    return false unless @otp_record.present?

    return false if @otp_record.expires_at < Time.now

    @otp_record.code == @entered_otp
  end
end
