class CenterAbility
  include CanCan::Ability

  def initialize(doctor, params)
    case params[:action]

    when 'show'
      can :show, Center if Authorization::Center::CanGetCentersService.new(current_doctor: doctor,
                                                                           center_id: params[:id] || params[:center_id] || params[:id]).call
    when 'update'
      can :update, Center if Authorization::Center::CanUpdateService.new(current_doctor: doctor, center_id: params[:id]).call
    when 'create'
      can :create, Center
    when 'invite_doctor'
      can :invite_doctor, Center if Authorization::Center::CanInviteDoctorService.new(current_doctor: doctor, center_id: params[:id]).call
    when 'assign_doctor'
      can :assign_doctor, Center if Authorization::Center::CanAssignDoctorService.new(current_doctor: doctor, center_id: params[:id],
                                                                                      assignee_doctor_id: params[:doctor_id]).call
    when 'edit_doctor'
      can :edit_doctor, Center if Authorization::Center::CanEditDoctorService.new(current_doctor: doctor, center_id: params[:id],
                                                                                  doctor_id: params[:doctor_id]).call
    when 'all_doctors'
      can :all_doctors, Center if Authorization::Center::CanGetAllDoctorsService
                                  .new(current_doctor: doctor,
                                       center_id: params[:id] || params[:center_id]).call
    when 'center_statistics'
      can :center_statistics, Center if Authorization::Doctor::CanGetCenterStatisticsService
                                        .new(current_doctor: doctor,
                                             center_id: params[:id] || params[:center_id]).call
    when 'center_vr_minutes'
      can :center_vr_minutes, Center if Authorization::Doctor::CanGetCenterVrMinutesService
                                        .new(current_doctor: doctor,
                                             center_id: params[:id] || params[:center_id]).call
    else
      false
    end
  end
end
