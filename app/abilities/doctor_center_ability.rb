class DoctorCenterAbility
  include CanCan::Ability

  def initialize(doctor, params)
    case params[:action]

    when 'index'
      can :index, DoctorCenter if Authorization::Center::CanGetDoctorsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'show'
      can :show, DoctorCenter if Authorization::Center::CanGetDoctorsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    else
      false
    end
  end
end
