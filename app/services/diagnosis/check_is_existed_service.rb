class Diagnosis::CheckIsExistedService
  def initialize(diagnosis_ids:)
    @diagnosis_ids = diagnosis_ids
  end

  def call
    check_if_existed
  end

  private

  def check_if_existed
    error_message = 'diagnoses not found, please provide at least one'
    raise error_message if @diagnosis_ids.nil?

    diagnosis_records = Diagnosis.where(id: @diagnosis_ids)
    raise error_message if diagnosis_records.count.zero?

    diagnosis_records
  end
end
