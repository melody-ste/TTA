class Architect < ApplicationRecord
    belongs_to :user
    has_many :architect_specializations, dependent: :destroy
    has_many :specializations, through: :architect_specializations
    has_many :projects
    has_many :likes, dependent: :destroy
    has_many :clients_who_liked, through: :likes, source: :client

    # Validation pour s'assurer que l'utilisateur associé a une ville
    validate :user_must_have_city


    # Attribut virtuel pour gérer les spécialisations dans le formulaire
    attr_accessor :specialization_names

    # Attributs virtuels pour gérer plusieurs diplômes
    attr_accessor :selected_degrees

    def fullname
        user.fullname
    end

    # Méthodes pour gérer les diplômes multiples
    def degree_acronyms_array
        return [] if degree_acronym.blank?
        degree_acronym.split(" | ")
    end

    def degree_names_array
        return [] if degree_name.blank?
        degree_name.split(" | ")
    end

    def selected_degrees=(degree_acronyms)
        return if degree_acronyms.blank?

        # Filtrer les valeurs vides
        valid_acronyms = degree_acronyms.reject(&:blank?)

        if valid_acronyms.any?
            # Trouver les noms correspondants
            degree_data = degree_mapping
            selected_names = valid_acronyms.map { |acronym| degree_data[acronym] }.compact

            # Assembler les chaînes
            self.degree_acronym = valid_acronyms.join(" | ")
            self.degree_name = selected_names.join(" | ")
        else
            self.degree_acronym = nil
            self.degree_name = nil
        end
    end

    # Callback pour gérer les spécialisations après la sauvegarde
    after_save :update_specializations, if: :specialization_names

    private

    def degree_mapping
        {
            "DEA" => "Diplôme d'État d'Architecte",
            "DESA" => "Diplôme d'Architecte de l'École Spéciale",
            "MA" => "Master en Architecture",
            "MAH" => "Master Architecture et Habitat",
            "MAR" => "Master Architecture Résidentielle",
            "DSAA-AI" => "Diplôme Supérieur d'Arts Appliqués Architecture d'Intérieur",
            "MDEAI" => "Master Design d'Espace et Architecture d'Intérieur",
            "BTS-DE" => "BTS Design d'Espace",
            "DNAT-AI" => "Diplôme National d'Arts et Techniques Architecture d'Intérieur",
            "MAP" => "Master Architecture du Paysage",
            "DIP" => "Diplôme d'Ingénieur Paysagiste",
            "MUAP" => "Master Urbanisme et Aménagement Paysager",
            "LP-AP" => "Licence Professionnelle Aménagement Paysager"
        }
    end

    def liked_by_client?(client)
        likes.exists?(client: client)
    end

    def likes_count
        likes.count
    end

    private

    def user_must_have_city
        if user && user.city.nil?
            errors.add(:user, "doit avoir une ville associée")
        end
    end

    def update_specializations
        # Supprimer les anciennes associations
        self.architect_specializations.destroy_all

        # Créer les nouvelles associations seulement s'il y a des spécialisations
        if specialization_names.present?
            specialization_names.reject(&:blank?).each do |spec_name|
                specialization = Specialization.find_or_create_by(name: spec_name)
                self.architect_specializations.create(specialization: specialization)
            end
        end
    end
end
