class Specialization < ApplicationRecord
    has_many :architect_specializations
    has_many :architects, through: :architect_specializations
end