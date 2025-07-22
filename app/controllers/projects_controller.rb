class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :update]


  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.architect_id = params[:architect_id]
    @project.user = current_user
    @project.status = "en_validation"
end


  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.status ||= "en_validation"
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    if current_user.architect?
      if @project.update(status_params)
        redirect_to @project, notice: (@project.status == "en_cours" ? "Projet accepté !" : "Projet refusé !")
      else
        render :edit, status: :unprocessable_entity
      end
    else
      if @project.update(project_params)
        redirect_to @project, notice: "Projet mis à jour."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_path, status: :see_other, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params.fetch(:id))
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:architect_id, :start_date, :description, :status)

    end

     def status_params
      params.require(:project).permit(:status)
    end

    def authorize_user!
      unless current_user == @project.user
        redirect_to project_path(@project), alert: "Vous n'êtes pas autorisé à effectuer cette action."
      end
    end
end
