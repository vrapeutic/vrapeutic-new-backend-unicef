class Doctor::HandleLoginService
  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    handle_login
  end

  private

  def handle_login
    raise 'Invalid credentials' unless @email.present? || @password.present?

    superadmins = (ENV['ADMIN_EMAILS'].present? ? ENV['ADMIN_EMAILS'].split(',') : []) + [ENV['ADMIN_EMAIL']]

    return { is_admin: true } if superadmins.include?(@email.downcase)

    doctor = Doctor.find_by(email: @email.downcase)

    raise 'Invalid credentials' unless doctor.present?

    raise 'Invalid credentials' unless doctor.authenticate(@password).present?

    # generate token
    # Doctor::GenerateJwtTokenService.new(doctor_id: doctor.id).call
    { doctor: doctor, is_admin: false }
  end
end
