class Architect < ApplicationRecord
    belongs_to :ville
    has_many :architect_specializations
    has_many :specializations, through: :architect_specializations
end