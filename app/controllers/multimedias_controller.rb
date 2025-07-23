class MultimediasController < ApplicationController
  # <!-- new update carousel-->
  def index
    @medias = Multimedia.all
  end

  def show
    @media = Multimedia.find(params[:id])
  end

  def create
    @media = Multimedia.new(media_params)
    if @media.save
      redirect_back fallback_location: root_path, notice: "Multimédia ajouté avec succès."
    else
      render :new
    end
  end

  private

  def media_params
    params.require(:multimedia).permit(:description, :file, :project_id)
  end
end
