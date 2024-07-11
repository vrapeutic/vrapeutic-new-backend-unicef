class Api::V1::Centers::SessionsController < Api::BaseApi
  before_action :set_center
  before_action :set_sessions, only: %i[index show]
  before_action :set_session, only: :show
  before_action :authorized

  def current_ability
    @current_ability ||= SessionAbility.new(current_doctor, params)
  end
  authorize_resource

  def index
    render json: SessionSerializer.new(@sessions, param_options).serializable_hash
  end

  def show
    render json: SessionSerializer.new(@session, param_options).serializable_hash
  end

  private

  def set_center
    @center = Center.find(params[:center_id])
  end

  def set_sessions
    @sessions = @center.sessions
  end

  def set_session
    @session = @sessions.find(params[:id])
  end
end
