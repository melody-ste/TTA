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
    # Gérer les spécialisations pour les architectes
    handle_architect_specializations if architect_with_specializations?
    
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Votre profil a été mis à jour avec succès."
    else
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

  def architect_with_specializations?
    @user.role == "architect" && 
    params[:user][:architect_attributes] && 
    params[:user][:architect_attributes][:specialization_names]
  end

  def handle_architect_specializations
    @user.architect ||= @user.build_architect
    @user.architect.specialization_names = params[:user][:architect_attributes][:specialization_names]
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


