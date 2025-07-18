class Project < ApplicationRecord
  belongs_to :user
  belongs_to :architect
  has_many :multimedias, dependent: :destroy

  # Méthode temporaire pour récupérer une image aléatoire depuis les médias
  # En attendant l'implémentation d'Active Storage
  def random_project_image
    # Récupérer une image aléatoire depuis le portfolio de l'architecte
    architect_medias = architect.portfolio&.multimedias
    if architect_medias&.any?
      architect_medias.sample.type_media
    else
      # Fallback vers n'importe quel média si l'architecte n'a pas de portfolio
      Multimedia.all.sample&.type_media || 'https://via.placeholder.com/150x100?text=Projet'
    end
  end
end
