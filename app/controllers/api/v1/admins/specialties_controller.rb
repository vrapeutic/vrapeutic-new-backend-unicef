class Api::V1::Admins::SpecialtiesController < Api::BaseApi
  before_action :authorized_admin?
  before_action :set_specialty, only: :show

  def index
    q = Specialty.ransack_query(sort: params[:sort], query: params[:q])
    render json: SpecialtySerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: SpecialtySerializer.new(@specialty, param_options).serializable_hash
  end

  private

  def set_specialty
    @specialty = Specialty.find(params[:id])
  end
end
