class Api::V1::Doctors::SessionsController < Api::BaseApi
  before_action :authorized_doctor?
  before_action :set_doctor
  before_action :set_doctor_sessions, only: %i[index]

  before_action :set_doctor_session,  only: %i[show]

  def index
    q = @sessions.ransack_query(sort: params[:sort], query: params[:q])
    render json: SessionSerializer.new(q.result(distinct: true), param_options).serializable_hash
  end

  def show
    render json: SessionSerializer.new(@session, param_options).serializable_hash
  end

  private

  def set_doctor
    @doctor = current_doctor
  end

  def set_doctor_sessions
    @sessions = @doctor.sessions
  end

  def set_doctor_session
    set_doctor_sessions
    @session = @sessions.find(params[:id] || params[:session_id])
  end
end
