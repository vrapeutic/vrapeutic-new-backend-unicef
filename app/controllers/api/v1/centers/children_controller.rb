class Api::V1::Centers::ChildrenController < Api::BaseApi
  before_action :set_center
  before_action :set_children, only: :index
  before_action :set_child, only: %i[show edit_child]
  before_action :authorized_doctor?

  def current_ability
    @current_ability ||= ChildAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    q = @children.ransack_query(sort: params[:sort], query: params[:q])
    render json: ChildSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: ChildSerializer.new(@child, param_options).serializable_hash
  end

  def add_child
    new_child = Center::AddChildService.new(
      name: params[:name],
      email: params[:email],
      age: params[:age],
      photo: params[:photo],
      center_id: @center.id,
      diagnosis_ids: params[:diagnosis_ids].is_a?(String) ? params[:diagnosis_ids]&.split(',') : params[:diagnosis_ids]
    ).call
    render json: ChildSerializer.new(new_child, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def edit_child
    child = Center::EditChildService.new(
      child_id: @child.id,
      edit_params: edit_child_params.except(:diagnosis_ids),
      diagnosis_ids: params[:child][:diagnosis_ids]
    ).call
    render json: ChildSerializer.new(child, param_options).serializable_hash
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_children
    @children = @center.children
  end

  def set_child
    set_children
    @child = @children.find(params[:id])
  end

  def edit_child_params
    params.require(:child).permit(:name, :age, :photo, :diagnosis_ids)
  end
end
