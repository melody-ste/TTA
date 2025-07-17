module ArchitectsHelper
  def calculate_average_study_years(architect)
    return 0 unless architect.degree_name.present?
    
    if architect.degree_name.include?("|")
      # Plusieurs diplômes - calculer la moyenne
      degree_names = architect.degree_name.split(" | ")
      
      # Mapping des diplômes avec leurs années d'études
      degree_years_mapping = {
        "Diplôme d'État d'Architecte" => 5,
        "Diplôme d'Architecte de l'École Spéciale" => 6,
        "Master en Architecture" => 5,
        "Master Architecture et Habitat" => 5,
        "Master Architecture Résidentielle" => 5,
        "Diplôme Supérieur d'Arts Appliqués Architecture d'Intérieur" => 5,
        "Master Design d'Espace et Architecture d'Intérieur" => 5,
        "BTS Design d'Espace" => 2,
        "Diplôme National d'Arts et Techniques Architecture d'Intérieur" => 3,
        "Master Architecture du Paysage" => 5,
        "Diplôme d'Ingénieur Paysagiste" => 5,
        "Master Urbanisme et Aménagement Paysager" => 5,
        "Licence Professionnelle Aménagement Paysager" => 3
      }
      
      total_years = degree_names.sum do |degree_name|
        degree_years_mapping[degree_name.strip] || 0
      end
      
      (total_years / degree_names.size.to_f).round
    else
      # Un seul diplôme - retourner la valeur stockée
      architect.years_study
    end
  end
  
  def format_degrees_display(architect)
    return "Aucun diplôme renseigné" unless architect.degree_name.present?
    
    if architect.degree_name.include?("|")
      degree_names = architect.degree_name.split(" | ")
      degree_acronyms = architect.degree_acronym.split(" | ")
      
      degrees_list = degree_names.each_with_index.map do |name, index|
        "#{name} (#{degree_acronyms[index]})"
      end
      
      degrees_list.join(" • ")
    else
      "#{architect.degree_name} (#{architect.degree_acronym})"
    end
  end
end
