class Center::EditService
  def initialize(current_center:, edit_params:, specialty_ids:, social_links:)
    @current_center = current_center
    @edit_params = edit_params
    @specialty_ids = specialty_ids
    @social_links = social_links
  end

  def call
    @current_center.transaction do
      edit_center
      edit_center_speialties
      edit_center_social_links
      @current_center
    end
  rescue StandardError => e
    puts e
    raise e
  end

  private

  def edit_center
    @current_center.update!(@edit_params)
  end

  def edit_center_speialties
    return unless @specialty_ids.present? && @specialty_ids.length

    @specialties = Specialty::CheckIsExistedService.new(specialty_ids: @specialty_ids).call
    # destroy old specialties
    @current_center.specialties.destroy_all
    # create new specialties
    @current_center.specialties << @specialties
  end

  def edit_center_social_links
    return if @social_links.nil?

    parsed_social_links = JSON.parse(@social_links)
    raise 'your center should have at least one social media link' unless parsed_social_links.length

    # delete old social links
    @current_center.center_social_links.destroy_all
    # create new social links
    @current_center.center_social_links.create!(parsed_social_links)
  end
end
