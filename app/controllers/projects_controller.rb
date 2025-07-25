class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :authorize_user!, only: [ :edit, :update ]



  def index
    @projects = Project.all
  end

  
  def show
  end

 
  def new
    @project = Project.new
    @project.architect_id = params[:architect_id]
    @project.user = current_user
  end


  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if current_user.role == "client"
      @project.status = "en_validation"
    else
      @project.status = "termine"
      @project.portfolio = true
    end

    respond_to do |format|
      if @project.save
        UserProjectMailMailer.new_project_client(@project).deliver_now
        UserProjectMailMailer.new_project_architect(@project).deliver_now
        format.html { redirect_to @project, notice: "Votre projet a été créé avec succès et est en attente de validation par l'architecte. Vous recevrez un email de confirmation pour la création du projet." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    if current_user.architect?
      attrs = status_params

      # Ajout au portfolio uniquement si le projet est terminé
      if attrs.key?(:portfolio)
        if @project.status == "termine" && @project.update(attrs)
          redirect_to @project, notice: "Projet ajouté au portfolio." and return
        else
          redirect_to @project, alert: "Le projet doit être terminé avant d'être ajouté au portfolio." and return
        end
      end

      # Changement de statut (accepter, refuser, terminer)
      if attrs.key?(:status) && @project.update(attrs)
        notice = case @project.status
        when "en_cours" 
          ValidatedMailMailer.project_validated_client(@project).deliver_now
          "Projet accepté, il est maintenant en cours."
        when "refuse" then "Projet refusé."
        when "termine" then "Projet terminé."
        else "Projet mis à jour."
        end
        redirect_to @project, notice: notice and return
      elsif attrs.key?(:status)
        render :show, status: :unprocessable_entity and return
      end

      render :show, status: :unprocessable_entity
    else
      if @project.update(project_params)
        redirect_to @project, notice: "Projet mis à jour." and return
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end


 
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to user_path(current_user), status: :see_other, notice: "Project was successfully destroyed." }
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
      params.require(:project).permit(
        :title,
        :description,
        :start_date,
        :architect_id,
        :status,
        :portfolio,
        :user_id
      )
    end

     def status_params
      params.require(:project).permit(:status, :portfolio)
    end

    def authorize_user!
      unless current_user == @project.user || current_user == @project.architect&.user
        redirect_to project_path(@project), alert: "Vous n'êtes pas autorisé à effectuer cette action."
      end
    end
end
