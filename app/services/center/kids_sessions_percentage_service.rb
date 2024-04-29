class Center::KidsSessionsPercentageService
  def initialize(doctor:, center:, kids: nil)
    @doctor = doctor
    @center = center
    @kids = kids
  end

  def call
    doctor_kids
    kids_using_vr_percentage
  end

  private

  def doctor_kids
    return unless @kids.nil?

    @kids = Doctor::CenterKidsService.new(doctor: @doctor, center: @center).call
  end

  def kids_using_vr_percentage
    # Count the total number of kids associated with the center
    total_kids_count = @kids.count

    # Count the number of kids who have sessions in the specific center
    kids_with_sessions_count = @kids.joins(:sessions)
                                    .where('sessions.center_id = ?', @center.id)
                                    .distinct
                                    .count

    # Calculate the percentage
    return (kids_with_sessions_count.to_f / total_kids_count) * 100 if total_kids_count.positive?

    0
  end
end
