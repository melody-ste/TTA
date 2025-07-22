class AvatarsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])

    # Vérification : l'utilisateur ne peut modifier que son propre avatar
    unless @user == current_user
      redirect_to user_path(@user), alert: "Action non autorisée"
      return
    end

    if params[:avatar].present?
      @user.avatar.attach(params[:avatar])

      if @user.avatar.attached?
        flash[:notice] = "Avatar mis à jour avec succès"
      else
        flash[:alert] = "Erreur lors de l’envoi de l’avatar"
      end
    else
      flash[:alert] = "Aucun fichier sélectionné"
    end

    redirect_to user_path(@user)
  end
end
