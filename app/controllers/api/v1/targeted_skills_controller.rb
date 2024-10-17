class Api::V1::TargetedSkillsController < Api::BaseApi
  # before_action :authorized_doctor?
  before_action :set_targeted_skill, only: :show

  # GET /targeted_skills
  def index
    @targeted_skills = TargetedSkill.all

    render json: @targeted_skills
  end

  # GET /targeted_skills/1
  def show
    render json: @targeted_skill
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_targeted_skill
    @targeted_skill = TargetedSkill.find(params[:id])
  end
end
