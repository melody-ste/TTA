class Architect < ApplicationRecord
    belongs_to :user
    has_many :architect_specializations, dependent: :destroy
    has_many :specializations, through: :architect_specializations
    has_one :portfolio
    has_many :projects

    # Validation pour s'assurer que l'utilisateur associé a une ville
    validate :user_must_have_city

    def fullname
        user.fullname
    end

    private

    def user_must_have_city
        if user && user.city.nil?
            errors.add(:user, "doit avoir une ville associée")
        end
    end
end
