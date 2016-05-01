class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    sort = params[:sort]
    @projects = Project.all
    @projects.each do |project|
      # FIXME
      # Need to implement logic for fetching updates periodically
      if project.pull_request and project.pull_request.red == nil
        project.pull_request.get_data
      end
      if project.slack_metric and project.slack_data_points.length == 0
        project.slack_metric.get_data
      end
      if project.code_climate_metric and project.code_climate_metric.score == nil
        project.code_climate_metric.get_data
      end
      if project.pivotal_tracker and project.pivotal_tracker.done == nil
        project.pivotal_tracker.get_data
      end
      if project.slack_trend != nil && project.slack_trend.weekone == nil
        project.slack_trend.get_data
      end
    end
    if sort == 'gpa'
      @projects = Project.includes(:code_climate_metric).order("code_climate_metrics.gpa asc")
    end
    if sort == 'coverage'
      @projects = Project.includes(:code_climate_metric).order("code_climate_metrics.coverage asc")
    end
    if sort == 'prs'
      @projects = Project.includes(:pull_request).order("pull_requests.score asc")
    end
    if sort == 'pts'
      @projects = Project.includes(:pivotal_tracker).order("pivotal_trackers.score asc")
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end
end
