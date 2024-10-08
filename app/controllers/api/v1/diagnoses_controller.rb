class Api::V1::DiagnosesController < Api::BaseApi
  # before_action :authorized_doctor?
  before_action :set_diagnosis, only: :show

  # GET /diagnoses
  def index
    @diagnoses = Diagnosis.all

    render json: @diagnoses
  end

  # GET /diagnoses/1
  def show
    render json: @diagnosis
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_diagnosis
    @diagnosis = Diagnosis.find(params[:id])
  end
end
