class Architect < ApplicationRecord
    belongs_to :user
    has_many :architect_specializations, dependent: :destroy
    has_many :specializations, through: :architect_specializations
    has_one :portfolio
    has_many :projects

    # Validation pour s'assurer que l'utilisateur associé a une ville
    validate :user_must_have_city
    
    # Validation pour les années d'études
    validates :years_study, presence: true, numericality: { greater_than: 0, only_integer: true }, allow_blank: true

    # Attribut virtuel pour gérer les spécialisations dans le formulaire
    attr_accessor :specialization_names

    def fullname
        user.fullname
    end

    # Callback pour gérer les spécialisations après la sauvegarde
    after_save :update_specializations

    private

    def user_must_have_city
        if user && user.city.nil?
            errors.add(:user, "doit avoir une ville associée")
        end
    end

    def update_specializations
        return unless specialization_names.present?
        
        # Supprimer les anciennes associations
        self.architect_specializations.destroy_all
        
        # Créer les nouvelles associations
        specialization_names.reject(&:blank?).each do |spec_name|
            specialization = Specialization.find_or_create_by(name: spec_name)
            self.architect_specializations.create(specialization: specialization)
        end
    end
end
