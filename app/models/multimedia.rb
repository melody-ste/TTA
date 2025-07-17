class Multimedia < ApplicationRecord
  self.table_name = "multimedias" 
  belongs_to :portfolio
  has_one_attached :file
end
