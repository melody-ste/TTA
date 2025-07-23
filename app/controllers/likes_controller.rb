class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_for_clients, only: [:create, :destroy]

  def create 
    @architect = Architect.find(params[:architect_id])
    @like = current_user.likes.build(architect: @architect)

    if @like.save
      redirect_to @architect
    end
  end

  def destroy 
    @architect = Architect.find(params[:architect_id])
    @like = current_user.likes.find_by(architect: @architect)

    if @like.destroy
      redirect_to @architect
    end
  end

  private 

  def only_for_clients
    unless current_user.client?
      redirect_to root_path, alert: "Vous ne pouvez pas aimer les architectes"
    end
  end
end
