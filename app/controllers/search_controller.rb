class SearchController < ApplicationController

  def index 
    query = params[:query].to_s.strip.downcase

    # recherche par architecte
    @architect = Architect.find_by("LOWER(name) LIKE ?", "%#{query}%")
    if @architect
      redirect_to architect_path(@architect) and return
    end

    # recherche par spécialisation
    @specialization = Specialization.find_by("LOWER(name) LIKE ?", "%#{query}%")
    if @specialization
      redirect_to specialization_path(@specialization) and return
    end

    # recherche par architecte par ville
    
  end
end
