class ChildAbility
  include CanCan::Ability

  def initialize(doctor, params)
    case params[:action]
    when 'index'
      can :index, Child if Authorization::Center::CanGetKidsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'show'
      can :show, Child if Authorization::Center::CanGetKidsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'add_child'
      can :add_child, Child if Authorization::Center::CanAddChildService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'edit_child'
      can :edit_child, Child if Authorization::Center::CanEditChildService.new(current_doctor: doctor, center_id: params[:center_id],
                                                                               child_id: params[:id] || params[:child_id]).call
    else
      false
    end
  end
end
