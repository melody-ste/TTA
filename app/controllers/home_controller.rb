class HomeController < ApplicationController
  def home
    # Récupérer toutes les spécialisations pour l'affichage des carousels
    @specializations = Specialization.includes(architect_specializations: { architect: { projects: :multimedias } })
  end
end
