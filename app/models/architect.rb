class Architect < ApplicationRecord
    belongs_to :user
    belongs_to :city
    has_many :architect_specializations
    has_many :specializations, through: :architect_specializations
    has_many :portfolios
    has_many :projects
end