module ArchitectsHelper
 
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
