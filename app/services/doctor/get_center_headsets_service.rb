class Doctor::GetCenterHeadsetsService
  def initialize(center_id:)
    @center_id = center_id
  end

  def call
    center_headsets
  end

  private

  def center_headsets
    center = Center.find(@center_id)
    center.headsets
  end
end
