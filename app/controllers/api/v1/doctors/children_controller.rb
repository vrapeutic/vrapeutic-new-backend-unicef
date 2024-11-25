class Api::V1::Doctors::ChildrenController < Api::BaseApi
  before_action :authorized_doctor?
  before_action :set_doctor
  before_action :set_doctor_children, only: %i[index]

  before_action :set_doctor_child, only: %i[show]

  def index
    q = @children.ransack_query(sort: params[:sort], query: params[:q])
    render json: ChildSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: ChildSerializer.new(@child, param_options).serializable_hash
  end

  private

  def set_doctor
    @doctor = current_doctor
  end

  def set_doctor_children
    @children = @doctor.children
  end

  def set_doctor_child
    set_doctor_children
    @child = @children.find(params[:id] || params[:child_id])
  end
end
