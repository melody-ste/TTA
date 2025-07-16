class Architect < ApplicationRecord
    belongs_to :user
    has_many :architect_specializations
    has_many :specializations, through: :architect_specializations
    has_many :portfolios
    has_many :projects
end