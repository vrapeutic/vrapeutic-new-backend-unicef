class Specialty::CheckIsExistedService
  def initialize(specialty_ids:)
    @specialty_ids = specialty_ids
  end

  def call
    check_if_existed
  end

  private

  def check_if_existed
    error_message = 'specialties not found, please provide at least one'
    raise error_message if @specialty_ids.nil?

    specialty_records = Specialty.where(id: @specialty_ids)
    raise error_message if specialty_records.count.zero?

    specialty_records
  end
end
