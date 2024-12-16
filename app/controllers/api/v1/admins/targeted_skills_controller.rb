class Api::V1::Admins::TargetedSkillsController < Api::BaseApi
  before_action :authorized_admin?
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

  # POST /targeted_skills
  def create
    @targeted_skill = TargetedSkill.new(targeted_skill_params)

    if @targeted_skill.save
      render json: @targeted_skill, status: :created, location: @targeted_skill
    else
      render json: @targeted_skill.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_targeted_skill
    @targeted_skill = TargetedSkill.find(params[:id])
  end

  def targeted_skill_params
    params.require(:targeted_skill).permit(:name)
  end
end
