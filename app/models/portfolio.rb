class Portfolio < ApplicationRecord
  belongs_to :architect
  has_many :multimedias, dependent: :destroy
end
