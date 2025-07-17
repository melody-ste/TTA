class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :city, dependent: :destroy
  has_one :architect, dependent: :destroy

  enum :role, {
    admin: 0,
    client: 1,
    architect: 2
  }

  validates :role, presence: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  # Validation conditionnelle : les architectes doivent avoir une ville
  # Sauf lors des seeds (attribut temporaire skip_city_validation)
  validates :city, presence: true, if: :should_validate_city?

  attr_accessor :skip_city_validation

  def fullname
    "#{first_name} #{last_name}".strip
  end

  private

  def should_validate_city?
    architect? && !skip_city_validation
  end
end
