class Specialization < ApplicationRecord
    has_many :architect_specializations
    has_many :architects, through: :architect_specializations

    def multimedias 
        Multimedia.joins(portfolio: :architect).where(architects: {id: self.architects.pluck(:id)})
    end
end