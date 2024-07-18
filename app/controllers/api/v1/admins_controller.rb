class Api::V1::AdminsController < Api::BaseApi
  before_action :validate_admin_otp, only: %i[edit_child edit_doctor edit_headset delete_headset doctors kids headsets assign_center_module assign_center_headset centers]

  def send_otp
    otp = Admin::GenerateOtpService.new.call
    AdminOtpMailer.send_otp(ENV['ADMIN_EMAIL'], otp).deliver_later
    render json: 'otp is sent successfully'
  end

  def edit_child
    child = Admin::EditChildService.new(
      child_id: params[:child_id],
      edit_params: child_params.except(:diagnosis_ids),
      diagnosis_ids: params[:child][:diagnosis_ids]
    ).call
    render json: ChildSerializer.new(child, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def edit_doctor
    doctor = Admin::EditDoctorService.new(
      doctor_id: params[:doctor_id],
      degree: params[:degree],
      certificate: params[:certificate],
      specialty_ids: params[:specialty_ids],
      photo: params[:photo],
      university: params[:university],
      name: params[:name]
    ).call
    render json: DoctorSerializer.new(doctor).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def assign_center_module
    Admin::AssignCenterModuleService.new(center_id: params[:center_id], software_module_id: params[:software_module_id],
                                         end_date: params[:end_date]).call
    render json: 'assigned successfully'
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def assign_center_headset
    new_headset = Center::AddHeadsetService.new(headset_params: headset_params, center_id: params[:center_id]).call
    render json: HeadsetSerializer.new(new_headset, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def edit_headset
    headset = Center::EditHeadsetService.new(headset_params: headset_params, headset_id: params[:headset_id]).call
    render json: HeadsetSerializer.new(headset).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def delete_headset
    headset = Headset.find(params[:headset_id])
    headset.discard
    head :no_content
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def doctors
    q = Doctor.ransack_query(sort: params[:sort], query: params[:q])
    render json: DoctorSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def centers
    q = Center.ransack_query(sort: params[:sort], query: params[:q])
    render json: CenterSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def kids
    q = Child.ransack_query(sort: params[:sort], query: params[:q])
    render json: ChildSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def headsets
    q = Headset.ransack_query(sort: params[:sort], query: params[:q])
    render json: HeadsetSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  private

  # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:otp, :expires_at)
  end

  def child_params
    params.require(:child).permit(:name, :age, :photo, :diagnosis_ids)
  end

  def headset_params
    params.require(:headset).permit(:name, :version, :model, :key, :brand)
  end
end
