class Api::V1::Admins::ChildrenController < Api::BaseApi
  before_action :authorized_admin?
  before_action :set_child, only: %i[show update]

  def index
    q = Child.ransack_query(sort: params[:sort], query: params[:q])
    render json: ChildSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: ChildSerializer.new(@child, param_options).serializable_hash
  end

  def update
    child = Admin::EditChildService.new(
      child_id: @child.id,
      edit_params: child_params.except(:diagnosis_ids),
      diagnosis_ids: params[:child][:diagnosis_ids]
    ).call

    render json: ChildSerializer.new(child, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_child
    @child = Child.find(params[:id] || params[:child_id])
  end

  def child_params
    params.require(:child).permit(:name, :age, :photo, :diagnosis_ids)
  end
end
