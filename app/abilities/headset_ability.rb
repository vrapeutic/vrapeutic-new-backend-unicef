class HeadsetAbility
  include CanCan::Ability

  def initialize(doctor, params)
    case params[:action]
    when 'index'
      can :index, Headset if Authorization::Center::CanGetHeadsetsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'show'
      can :show, Headset if Authorization::Center::CanGetHeadsetsService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'add_headset'
      can :add_headset, Headset if Authorization::Center::CanAddHeadsetService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'edit_headset'
      can :edit_headset, Headset if Authorization::Center::CanEditHeadsetService.new(current_doctor: doctor, center_id: params[:center_id],
                                                                                     headset_id: params[:id] || params[:headset_id]).call
    else
      false
    end
  end
end
