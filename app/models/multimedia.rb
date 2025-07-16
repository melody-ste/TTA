class Multimedia < ApplicationRecord
  self.table_name = "multimedias" 
  belongs_to :portfolio
end
