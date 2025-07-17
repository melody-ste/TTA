class Project < ApplicationRecord
  belongs_to :user
  belongs_to :architect
  
  # enum :status, { en_validation: "en_validation", accepte: "accepte", refuse: "refuse", en_cours: "en_cours", termine: "termine", annule: "annule"}
end
