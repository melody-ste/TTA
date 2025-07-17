class Architect < ApplicationRecord
    belongs_to :user
    has_many :architect_specializations, dependent: :destroy
    has_many :specializations, through: :architect_specializations
    has_many :portfolios, dependent: :destroy
    has_many :projects, dependent: :destroy
end