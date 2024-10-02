class Api::V1::HeadsetsController < Api::BaseApi
  before_action :authorized_doctor?
  before_action :set_headset, only: %i[show free_headset]

  # GET /headsets
  def index
    @headsets = Headset.all

    render json: @headsets
  end

  # GET /headsets/1
  def show
    render json: @headset
  end

  def free_headset
    @headset.sessions.update_all(ended_at: 1.day.ago, duration: 2, vr_duration: 1) unless Rails.env.production?
    head :no_content
  end

  private

  def set_headset
    @headset = Headset.find_by(key: params[:id]) || Headset.find(params[:id])
  end
end
