class SlackTrendsController < ApplicationController
  before_action :set_slack_trend, only: [:show, :edit, :update, :destroy]

  # GET /slack_trends
  # GET /slack_trends.json
  def index
    @slack_trends = SlackTrend.find_by params[:project_id]
  end

  # GET /slack_trends/1
  # GET /slack_trends/1.json
  def show
  end

  # GET /slack_trends/new
  def new
    @slack_trend = SlackTrend.new
  end

  # GET /slack_trends/1/edit
  def edit
  end

  # POST /slack_trends
  # POST /slack_trends.json
  def create
    @slack_trend = SlackTrend.new(slack_trend_params)

    respond_to do |format|
      if @slack_trend.save
        format.html { redirect_to @slack_trend, notice: 'Slack trend was successfully created.' }
        format.json { render :show, status: :created, location: @slack_trend }
      else
        format.html { render :new }
        format.json { render json: @slack_trend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_trends/1
  # PATCH/PUT /slack_trends/1.json
  def update
    respond_to do |format|
      if @slack_trend.update(slack_trend_params)
        format.html { redirect_to @slack_trend, notice: 'Slack trend was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_trend }
      else
        format.html { render :edit }
        format.json { render json: @slack_trend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_trends/1
  # DELETE /slack_trends/1.json
  def destroy
    @slack_trend.destroy
    respond_to do |format|
      format.html { redirect_to slack_trends_url, notice: 'Slack trend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack_trend
      @slack_trend = SlackTrend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_trend_params
      params.require(:slack_trend).permit(:weekone, :weektwo, :weekthree, :project_id)
    end
end
