class SpecializationsController < ApplicationController
# <!-- new update carousel-->
  
  def index
    if params[:query].present?
      # Normalisation de la requête pour enlever les accents
      normalized_query = I18n.transliterate(params[:query]).downcase
      @specializations = Specialization.where("LOWER(name) LIKE ?", "%#{normalized_query}%")
    else
      @specializations = Specialization.all
    end
  end

  def show
    @specialization = Specialization.find(params[:id])
    @medias = @specialization.multimedias
  end
end
