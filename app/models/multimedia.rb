class Multimedia < ApplicationRecord
  self.table_name = "multimedias"
  belongs_to :project, optional: true  # optional si certains multimedias n'ont pas de projet
  has_one_attached :file
end
