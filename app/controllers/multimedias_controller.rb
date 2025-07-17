class MultimediasController < ApplicationController
  # <!-- new update carousel-->
  def index
    @medias = Multimedia.all
  end

  def show
    @media = Multimedia.find(params[:id])
  end
end
