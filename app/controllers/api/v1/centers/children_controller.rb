class Api::V1::Centers::ChildrenController < Api::BaseApi
  before_action :set_center
  before_action :set_children, only: %i[index show]
  before_action :set_child, only: :show
  before_action :authorized

  def current_ability
    @current_ability ||= ChildAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    render json: ChildSerializer.new(@children, param_options).serializable_hash
  end

  def show
    render json: ChildSerializer.new(@child, param_options).serializable_hash
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_children
    @children = @center.children
  end

  def set_child
    @child = @children.find(params[:id])
  end
end
