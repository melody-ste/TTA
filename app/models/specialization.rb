class Specialization < ApplicationRecord
    has_many :architect_specializations
    has_many :architects, through: :architect_specializations
# <!-- new update carousel-->
    def multimedias 
        Multimedia.joins(portfolio: {architect: :specializations}).where(specializations: {id: id})
    end
end