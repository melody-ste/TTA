class Specialization < ApplicationRecord
    has_many :architect_specializations
    has_many :architects, through: :architect_specializations

    def multimedias 
        # jointure des tables Multimedias, Portfolios , Architects
        # grace à jointure, cela donne les médias dont le portfolio appartient à un architecte qui a cette spécialisation
        # on utilise pluck pour récupérer les ids des architectes
        # et on les utilise pour filtrer les medias
        Multimedia.joins(portfolio: :architect).where(architects: {id: self.architects.pluck(:id)})
    end
end