class SlackDataPointsController < ApplicationController
  before_action :set_slack_data_point, only: [:show, :edit, :update, :destroy]

  # GET /slack_data_points
  # GET /slack_data_points.json
  def index
    @slack_data_points = SlackDataPoint.all
  end

  # GET /slack_data_points/1
  # GET /slack_data_points/1.json
  def show
  end

  # GET /slack_data_points/new
  def new
    @slack_data_point = SlackDataPoint.new
  end

  # GET /slack_data_points/1/edit
  def edit
  end

  # POST /slack_data_points
  # POST /slack_data_points.json
  def create
    @slack_data_point = SlackDataPoint.new(slack_data_point_params)

    respond_to do |format|
      if @slack_data_point.save
        format.html { redirect_to @slack_data_point, notice: 'Slack data point was successfully created.' }
        format.json { render :show, status: :created, location: @slack_data_point }
      else
        format.html { render :new }
        format.json { render json: @slack_data_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_data_points/1
  # PATCH/PUT /slack_data_points/1.json
  def update
    respond_to do |format|
      if @slack_data_point.update(slack_data_point_params)
        format.html { redirect_to @slack_data_point, notice: 'Slack data point was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_data_point }
      else
        format.html { render :edit }
        format.json { render json: @slack_data_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_data_points/1
  # DELETE /slack_data_points/1.json
  def destroy
    @slack_data_point.destroy
    respond_to do |format|
      format.html { redirect_to slack_data_points_url, notice: 'Slack data point was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack_data_point
      @slack_data_point = SlackDataPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_data_point_params
      params.require(:slack_data_point).permit(:user, :messages, :slack_metric_id)
    end
end
