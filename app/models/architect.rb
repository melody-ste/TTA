class Architect < ApplicationRecord
    belongs_to :user
    has_many :architect_specializations
    has_many :specializations, through: :architect_specializations
    has_one :portfolio
    has_many :projects

    def fullname
        user.fullname
    end
end