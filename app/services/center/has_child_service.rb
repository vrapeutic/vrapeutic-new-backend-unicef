class Center::HasChildService
  def initialize(child_id:, center_id:)
    @child_id = child_id
    @center_id = center_id
  end

  def call
    is_child_in_this_center
  end

  private

  def is_child_in_this_center
    ChildCenter.find_by(child_id: @child_id, center_id: @center_id).present? ? true : false
  end
end
