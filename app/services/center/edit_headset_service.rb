class Center::EditHeadsetService
  def initialize(headset_params:, headset_id:)
    @headset_id = headset_id
    @headset_params = headset_params
  end

  def call
    Headset.transaction do
      find_headset
      update_headset
      @headset
    end
  end

  private

  def find_headset
    @headset = Headset.find(@headset_id)
  end

  def update_headset
    @headset.update!(@headset_params)
  end
end
