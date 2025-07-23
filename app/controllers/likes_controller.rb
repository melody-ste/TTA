class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_for_clients, only: [ :create, :destroy ]

  def create
    @architect = Architect.find(params[:id])
    @like = current_user.likes.build(architect: @architect)

    if @like.save
      respond_to do |format|
        format.html { redirect_to @architect }
        format.js   # va appeler create.js.erb
      end
    else
      respond_to do |format|
        format.html { redirect_to @architect, alert: "Erreur lors de l'ajout aux favoris" }
        format.js { render json: { error: "Erreur" }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @architect = Architect.find(params[:id])
    @like = current_user.likes.find_by(architect: @architect)

    if @like&.destroy
      respond_to do |format|
        format.html { redirect_to @architect }
        format.js   # va appeler destroy.js.erb
      end
    else
      respond_to do |format|
        format.html { redirect_to @architect, alert: "Erreur lors de la suppression des favoris" }
        format.js { render json: { error: "Erreur" }, status: :unprocessable_entity }
      end
    end
  end

  private

  def only_for_clients
    unless current_user.client?
      redirect_to root_path, alert: "Vous ne pouvez pas aimer les architectes"
    end
  end
end
