class Api::V1::HeadsetsController < Api::BaseApi
  before_action :set_headset, only: :free_headset

  def free_headset
    @headset.sessions.update_all(ended_at: 1.day.ago, duration: 2, vr_duration: 1) unless Rails.env.production?
    head :no_content
  end

  private

  def set_headset
    @headset = Headset.find(params[:id])
  end
end
