class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :city, dependent: :destroy
  has_one :architect, dependent: :destroy
  has_many :projects
  has_one_attached :avatar
  
  enum :role, {
    admin: 0,
    client: 1,
    architect: 2
  }

  validates :role, presence: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def fullname
    "#{first_name} #{last_name}".strip
  end
end