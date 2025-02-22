class Admin::EditChildService
  def initialize(child_id:, center_ids:, edit_params:, diagnosis_ids:)
    @child_id = child_id
    @center_ids = center_ids
    @edit_params = edit_params
    @diagnosis_ids = diagnosis_ids
  end

  def call
    edit_child_with_diagnoses
  end

  private

  def edit_child_with_diagnoses
    Center::EditChildService.new(
      child_id: @child_id,
      center_id: @center_ids,
      edit_params: @edit_params,
      diagnosis_ids: @diagnosis_ids
    ).call
  end
end
