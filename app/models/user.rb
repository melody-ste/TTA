class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :city, dependent: :destroy
  has_one :architect, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_one_attached :avatar
  
  enum :role, {
    admin: 0,
    client: 1,
    architect: 2
  }

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  # Nested attributes
  accepts_nested_attributes_for :city, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :architect, allow_destroy: true, reject_if: :all_blank

  # attribut virtuel(pas stocké sur db) pour le formulaire d'inscription
  attr_accessor :skip_city_validation

  def fullname
    if first_name.present? || last_name.present?
      "#{first_name} #{last_name}".strip
    else
      email # Fallback sur l'email si pas de nom
    end
  end
  
  private

    # Validation  les architectes doivent avoir une ville
  # Mais seulement après l'inscription, pas lors de la création du compte
  # validates :city, presence: true, if: :should_validate_city?
  def should_validate_city?
    architect? && !skip_city_validation
  end
end
