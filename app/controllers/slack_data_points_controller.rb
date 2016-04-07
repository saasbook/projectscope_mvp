class SlackDataPointsController < ApplicationController
  before_action :set_slack_data_point, only: [:show, :edit, :update, :destroy]

  # GET /projects/:project_id/slack_data_points(.:format)
  def index
    
    @slack_data_points = SlackMetric.find_by(params[:project_id]).slack_data_points
  end

  # GET /projects/:project_id/slack_data_points/:id(.:format)
  def show
  end

  # GET /projects/:project_id/slack_data_points/new(.:format)
  def new
    @slack_data_point = SlackDataPoint.new
  end

  # GET /projects/:project_id/slack_data_points/:id/edit(.:format)
  def edit
  end

  # POST /projects/:project_id/slack_data_points(.:format)
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

  # PATCH/PUT /projects/:project_id/slack_data_points/:id(.:format)
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

  # DELETE /projects/:project_id/slack_data_points/:id(.:format)
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
      params.require(:slack_data_point).permit(:user, :messages, :project_id)
    end
end
