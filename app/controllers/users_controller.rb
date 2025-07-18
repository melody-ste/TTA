class UsersController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :configure_permitted_parameters

    
    def show
    # Rediriger vers le profil de l'utilisateur connecté si l'ID ne correspond pas
    if params[:id].to_i != current_user.id
      redirect_to user_path(current_user)
    else
      @user = current_user
    end
  end

  def edit
@user = current_user

  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_path(@user), notice: "Votre profil a été mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "Votre compte a été supprimé" }
      format.json { head :no_content }
    end
  end

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :description,
      specializations: [],
      degrees: [:name, :acronym, :years_study],
      city_id: [:name, :zip_code, :department],
    ])
  end

  private
    def set_user
      @user = User.find(params.expect(:id))
    end

      def user_params
    params.require(:user).permit(
      :first_name, :last_name,:description,
      specializations: [],
      degrees: [:name, :acronym, :duration_years],
      city_id: [:name, :zip_code, :department],
    )
  end

end
