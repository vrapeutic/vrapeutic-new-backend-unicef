class Api::V1::Doctors::SpecialtiesController < Api::BaseApi
  before_action :authorized_doctor?
  before_action :set_doctor
  before_action :set_doctor_specialties, only: %i[index]

  before_action :set_doctor_specialty, only: %i[show]

  def index
    q = @specialties.ransack_query(sort: params[:sort], query: params[:q])
    render json: SpecialtySerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: SpecialtySerializer.new(@specialty, param_options).serializable_hash
  end

  private

  def set_doctor
    @doctor = current_doctor
  end

  def set_doctor_specialties
    @specialties = @doctor.specialties
  end

  def set_doctor_specialty
    set_doctor_specialties
    @specialty = @specialties.find(params[:id] || params[:specialty_id])
  end
end
