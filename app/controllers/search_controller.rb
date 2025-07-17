class SearchController < ApplicationController

  def index 
    @query = params[:query].to_s.strip
    
    if @query.present?
      # Normalisation de la requête pour enlever les accents
      normalized_query = I18n.transliterate(@query).downcase
      
      # Recherche des architectes
      @architects = Architect.joins(:user)
                             .left_joins(user: :city)
                             .left_joins(:specializations)
                             .where("LOWER(users.first_name) LIKE ? OR 
                                     LOWER(users.last_name) LIKE ? OR 
                                     LOWER(architects.description) LIKE ? OR 
                                     LOWER(cities.name) LIKE ? OR 
                                     LOWER(specializations.name) LIKE ?", 
                                    "%#{normalized_query}%", "%#{normalized_query}%", "%#{normalized_query}%", "%#{normalized_query}%", "%#{normalized_query}%")
                             .distinct
      
      # Recherche des spécialisations
      @specializations = Specialization.where("LOWER(name) LIKE ?", "%#{normalized_query}%")
      
      # Recherche des villes
      @cities = City.joins(:user)
                    .where("LOWER(cities.name) LIKE ?", "%#{normalized_query}%")
                    .distinct
    else
      @architects = []
      @specializations = []
      @cities = []
    end
  end
end
