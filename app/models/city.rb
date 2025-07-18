class City < ApplicationRecord
    belongs_to :user

    validates :name, presence: true
    validates :zip_code, presence: true
    validates :department, presence: true
end
