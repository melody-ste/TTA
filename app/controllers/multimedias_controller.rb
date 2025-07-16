class MultimediasController < ApplicationController
  def index 
    @Multimedias = Multimedia.all
  end
end
