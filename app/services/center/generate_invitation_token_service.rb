class Center::GenerateInvitationTokenService
  def initialize(email:)
    @email = email
  end

  def call
    generate_invitation_token
  end

  private

  def generate_invitation_token
    raise 'email is not found , please provide it' if @email.nil?
    raise 'email is already existed , please provide another one' if Doctor.find_by(email: @email.downcase).present?

    expires_at = Time.zone.now + 30.minutes
    token = JsonWebToken.encode({ email: @email }, expires_at)
    { token: token, expires_at: expires_at }
  end
end
