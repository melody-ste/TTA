class Project < ApplicationRecord
  belongs_to :user
  belongs_to :architect
  has_many :multimedias, dependent: :destroy
  enum :status, { en_validation: "en_validation", accepte: "accepte", refuse: "refuse", en_cours: "en_cours", termine: "termine", annule: "annule" }


  # Méthode temporaire pour récupérer une image aléatoire depuis les médias
  # En attendant l'implémentation d'Active Storage
  def random_project_image
    architect_medias = architect.projects.includes(:multimedias).map(&:multimedias).flatten
    if architect_medias.any?
      architect_medias.sample.type_media
    else
      Multimedia.all.sample&.type_media || "https://via.placeholder.com/150x100?text=Projet"
    end
  end
end
