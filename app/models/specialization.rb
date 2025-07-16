class Specialization < ApplicationRecord
    has_many :architect_specializations
    has_many :architects, through: :architect_specializations

    def multimedias 
        # Récupérer les médias des portfolios dont le nom contient cette spécialisation
        # OU utiliser la jointure pour être plus précis
        Multimedia.joins(portfolio: { architect: :specializations })
                  .where(specializations: { id: self.id })
                  .joins(:portfolio)
                  .where("portfolios.project_title LIKE ?", "%#{self.name}%")
    end
end