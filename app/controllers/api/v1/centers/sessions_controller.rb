class Api::V1::Centers::SessionsController < Api::BaseApi
  before_action :set_center
  before_action :set_sessions, only: :index
  before_action :set_session, only: :show
  before_action :authorized_doctor?

  def current_ability
    @current_ability ||= SessionAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    q = @sessions.ransack_query(sort: params[:sort], query: params[:q])
    render json: SessionSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: SessionSerializer.new(@session, param_options).serializable_hash
  end

  def evaluations
    render json: @center.evaluation_stats
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_sessions
    @sessions = @center.sessions
  end

  def set_session
    set_sessions
    @session = @sessions.find(params[:id])
  end
end
