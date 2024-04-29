class Center::EditChildService
  def initialize(child_id:, edit_params:, diagnosis_ids:)
    @child_id = child_id
    @edit_params = edit_params
    @diagnosis_ids = diagnosis_ids
    @diagnoses_records = nil
  end

  def call
    Child.transaction do
      check_diagnoses_existed
      find_child
      update_child
      update_child_diagnoses
      @child
    end
  rescue StandardError => e
    raise e
  end

  private

  def find_child
    @child = Child.find(@child_id)
  end

  def update_child
    @child.update!(@edit_params)
  end

  def check_diagnoses_existed
    return unless @diagnosis_ids.present?

    @diagnoses_records = Diagnosis::CheckIsExistedService.new(diagnosis_ids: @diagnosis_ids).call
  end

  def update_child_diagnoses
    return if @diagnoses_records.nil?

    # remove old records
    @child.diagnoses.destroy_all

    # create new diagnoses
    @child.diagnoses << @diagnoses_records
  end
end
