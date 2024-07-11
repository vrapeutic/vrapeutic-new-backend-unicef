class Doctor::CreateService
  def initialize(name:, email:, password:, degree:,
                 university:, specialty_ids:, photo:, certificate:, is_invited: false)
    @name = name
    @email = email
    @password = password
    @degree = degree
    @university = university
    @specialty_ids = specialty_ids
    @photo = photo
    @certificate = certificate
    @is_invited = is_invited
  end

  def call
    check_specialties_existed
    Doctor.transaction do
      create_doctor
      create_doctor_specialties
      @new_doctor
    end
  rescue StandardError => e
    puts e.as_json
    raise e
  end

  private

  def create_doctor
    @new_doctor = Doctor.create!(
      name: @name,
      email: @email.downcase,
      password: @password,
      degree: @degree,
      university: @university,
      photo: @photo,
      certificate: @certificate,
      is_email_verified: @is_invited ? true : false
    )
  end

  def check_specialties_existed
    @specialties = Specialty::CheckIsExistedService.new(specialty_ids: @specialty_ids).call
  end

  def create_doctor_specialties
    @new_doctor.specialties << @specialties
  end
end
