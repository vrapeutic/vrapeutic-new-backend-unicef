class ChildAbility
  include CanCan::Ability

  def initialize(doctor, params)
    case params[:action]
    when 'index'
      can :index, Child if Authorization::Center::CanGetKidsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'show'
      can :show, Child if Authorization::Center::CanGetKidsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    else
      false
    end
  end
end
