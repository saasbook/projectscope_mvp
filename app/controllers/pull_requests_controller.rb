class PullRequestsController < ApplicationController
  before_action :set_pull_request, only: [:show, :edit, :update, :destroy]

  # GET /projects/:project_id/pull_requests(.:format)
  def index
    @pull_requests = PullRequest.find_by params[:project_id]
  end

  # GET /projects/:project_id/pull_requests/:id(.:format)
  def show
  end

  # GET /projects/:project_id/pull_requests/new(.:format)
  def new
    @pull_request = PullRequest.new
  end

  # GET /projects/:project_id/pull_requests/:id/edit(.:format)
  def edit
  end

  # POST /projects/:project_id/pull_requests(.:format)
  def create
    @pull_request = PullRequest.new(pull_request_params)

    respond_to do |format|
      if @pull_request.save
        format.html { redirect_to @pull_request, notice: 'Pull request was successfully created.' }
        format.json { render :show, status: :created, location: @pull_request }
      else
        format.html { render :new }
        format.json { render json: @pull_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/:project_id/pull_requests/:id(.:format)
  def update
    respond_to do |format|
      if @pull_request.update(pull_request_params)
        format.html { redirect_to @pull_request, notice: 'Pull request was successfully updated.' }
        format.json { render :show, status: :ok, location: @pull_request }
      else
        format.html { render :edit }
        format.json { render json: @pull_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/:project_id/pull_requests/:id(.:format)
  def destroy
    @pull_request.destroy
    respond_to do |format|
      format.html { redirect_to pull_requests_url, notice: 'Pull request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pull_request
      @pull_request = PullRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pull_request_params
      params.require(:pull_request).permit(:red, :yellow, :green, :project_id)
    end
end
