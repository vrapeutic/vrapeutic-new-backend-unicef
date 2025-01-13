class Center::AddHeadsetService
  def initialize(headset_params:, center_id:)
    @headset_params = headset_params
    @center_id = center_id
  end

  def call
    create_headset
    @headset
  end

  private

  def create_headset
    @headset = Headset.discarded.find_by(key: @headset_params[:key], center_id: @center_id) || Headset.new(@headset_params)

    if @headset.persisted?
      @headset.undiscard
    else
      @headset[:center_id] = @center_id
      @headset.save!
    end
  end
end
