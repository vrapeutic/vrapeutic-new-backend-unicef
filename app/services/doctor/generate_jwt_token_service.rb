class Doctor::GenerateJwtTokenService
  def initialize(doctor_id:)
    @doctor_id = doctor_id
  end

  def call
    generate_token
  end

  private

  def generate_token
    expires_at = Time.zone.now + 4.days
    token = JsonWebToken.encode({ id: @doctor_id }, expires_at)
    { token: token, expires_at: expires_at }
  end
end
