class Portfolio < ApplicationRecord
  belongs_to :architect
  has_many :multimedias
end