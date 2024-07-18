class Doctor::GetCenterHeadsetsService
  def initialize(center_id:, scope: 'all')
    @center_id = center_id
    @scope = scope
  end

  def call
    center_headsets
  end

  private

  def center_headsets
    center = Center.find(@center_id)

    if @scope == 'active'
      center.headsets.active
    elsif @scope == 'inactive'
      center.headsets.inactive
    else
      center.headsets.kept
    end
  end
end
