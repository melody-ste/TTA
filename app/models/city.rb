class City < ApplicationRecord
    belongs_to :user
    has_many :architects
end