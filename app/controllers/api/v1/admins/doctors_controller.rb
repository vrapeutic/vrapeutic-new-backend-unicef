class Api::V1::Admins::DoctorsController < Api::BaseApi
  before_action :authorized_admin?
  before_action :set_doctor, only: %i[show update]

  def index
    q = Doctor.ransack_query(sort: params[:sort], query: params[:q])
    render json: DoctorSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: DoctorSerializer.new(@doctor, param_options).serializable_hash
  end

  def update
    doctor = Admin::EditDoctorService.new(
      doctor_id: @doctor.id,
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

  private

  def set_doctor
    @doctor = Doctor.find(params[:id] || params[:doctor_id])
  end
end
