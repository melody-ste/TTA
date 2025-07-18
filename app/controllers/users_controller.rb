class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    # Rediriger vers le profil de l'utilisateur connecté si l'ID ne correspond pas
    redirect_to user_path(current_user) if params[:id].to_i != current_user.id
  end

  def edit
  end

  def update
    # Gérer les spécialisations et diplômes pour les architectes
    handle_architect_data if architect_params_present?
    
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Votre profil a été mis à jour avec succès."
    else
      # Ajouter les erreurs dans flash pour le débogage
      flash.now[:alert] = "Erreur lors de la mise à jour : #{@user.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to root_path, notice: "Votre compte a été supprimé"
  end

  private

  def set_user
    @user = current_user
  end

  def architect_params_present?
    @user.role == "architect" && params[:user][:architect_attributes]
  end

  def handle_architect_data
    return unless @user.architect || @user.build_architect
    
    architect_attrs = params[:user][:architect_attributes]
    
    # Gérer les spécialisations
    if architect_attrs[:specialization_names]
      @user.architect.specialization_names = architect_attrs[:specialization_names]
    end
    
    # Gérer les diplômes
    if architect_attrs[:selected_degrees]
      @user.architect.selected_degrees = architect_attrs[:selected_degrees]
    end
    
    # Sauvegarder explicitement l'architecte
    @user.architect.save if @user.architect.changed?
  end

  def user_params
    params.require(:user).permit(
      :first_name, 
      :last_name,
      city_attributes: [:id, :name, :zip_code, :department],
      architect_attributes: [:id, :description, :degree_name, :degree_acronym, :years_study, specialization_names: [], selected_degrees: []]
    )
  end
end


