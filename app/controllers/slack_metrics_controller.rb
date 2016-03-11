class SlackMetricsController < ApplicationController
  before_action :set_slack_metric, only: [:show, :edit, :update, :destroy]

  # GET /slack_metrics
  # GET /slack_metrics.json
  def index
    @slack_metrics = SlackMetric.all
  end

  # GET /slack_metrics/1
  # GET /slack_metrics/1.json
  def show
  end

  # GET /slack_metrics/new
  def new
    @slack_metric = SlackMetric.new
  end

  # GET /slack_metrics/1/edit
  def edit
  end

  # POST /slack_metrics
  # POST /slack_metrics.json
  def create
    @slack_metric = SlackMetric.new(slack_metric_params)

    respond_to do |format|
      if @slack_metric.save
        format.html { redirect_to @slack_metric, notice: 'Slack metric was successfully created.' }
        format.json { render :show, status: :created, location: @slack_metric }
      else
        format.html { render :new }
        format.json { render json: @slack_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slack_metrics/1
  # PATCH/PUT /slack_metrics/1.json
  def update
    respond_to do |format|
      if @slack_metric.update(slack_metric_params)
        format.html { redirect_to @slack_metric, notice: 'Slack metric was successfully updated.' }
        format.json { render :show, status: :ok, location: @slack_metric }
      else
        format.html { render :edit }
        format.json { render json: @slack_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slack_metrics/1
  # DELETE /slack_metrics/1.json
  def destroy
    @slack_metric.destroy
    respond_to do |format|
      format.html { redirect_to slack_metrics_url, notice: 'Slack metric was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slack_metric
      @slack_metric = SlackMetric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slack_metric_params
      params.fetch(:slack_metric, {})
    end
end
