class Doctor::CenterKidsPercentageService < Doctor::CenterKidsService
  def initialize(doctor:, center_id:)
    super(doctor: doctor, center: Center.find(center_id))
    @is_doctor_admin = is_doctor_admin?
    @kids = doctor_kids
  end

  def call
    calculate_percentage
  end

  private

  def calculate_percentage
    # if doctor is admin we will make logic on children table but if not we will make logic on child_doctors table (to check assigned or not)
    @created_at_field = @is_doctor_admin ? 'children.created_at' : 'child_doctors.created_at'

    today_kids = @kids.where("DATE(#{@created_at_field}) = ?", Date.today).count
    yesterday_kids = @kids.where("DATE(#{@created_at_field}) = ?", Date.yesterday).count

    percentage = if yesterday_kids.positive?
                   ((today_kids.to_f - yesterday_kids) / yesterday_kids) * 100
                 else
                   today_kids * 100
                 end
    {
      today_kids: today_kids,
      yesterday_kids: yesterday_kids,
      percentage: percentage
    }
  end
end
