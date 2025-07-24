module UsersHelper
  def user_is_architect_with_data?
    current_user.role == "architect" && current_user.architect.present?
  end

  def user_avatar_or_default
    if current_user.avatar.attached?
      image_tag current_user.avatar, alt: "avatar", class: "avatar"
    else
      image_tag "https://img.freepik.com/photos-gratuite/avatar-androgyne-personne-queer-non-binaire_23-2151100226.jpg",
                alt: "avatar par défaut",
                class: "avatar"
    end
  end

  def projects_by_status(status)
    current_user.projects.where(status: status)
  end

  def project_status_sections
    [
      { title: "Nouvelles demandes", status: "en_validation" },
      { title: "Projets en cours", status: "en_cours" },
      { title: "Historique des projets", status: "termine" }
    ]
  end

  def degree_options
    [
      [ "DEA - Diplôme d'État d'Architecte", "DEA" ],
      [ "DESA - Diplôme d'Architecte de l'École Spéciale", "DESA" ],
      [ "MA - Master en Architecture", "MA" ],
      [ "MAH - Master Architecture et Habitat", "MAH" ],
      [ "MAR - Master Architecture Résidentielle", "MAR" ],
      [ "DSAA-AI - Diplôme Supérieur d'Arts Appliqués Architecture d'Intérieur", "DSAA-AI" ],
      [ "MDEAI - Master Design d'Espace et Architecture d'Intérieur", "MDEAI" ],
      [ "BTS-DE - BTS Design d'Espace", "BTS-DE" ],
      [ "DNAT-AI - Diplôme National d'Arts et Techniques Architecture d'Intérieur", "DNAT-AI" ],
      [ "MAP - Master Architecture du Paysage", "MAP" ],
      [ "DIP - Diplôme d'Ingénieur Paysagiste", "DIP" ],
      [ "MUAP - Master Urbanisme et Aménagement Paysager", "MUAP" ],
      [ "LP-AP - Licence Professionnelle Aménagement Paysager", "LP-AP" ]
    ]
  end

  def specialization_options
    [ "Résidentielle", "Paysagère", "Intérieure" ]
  end
end
