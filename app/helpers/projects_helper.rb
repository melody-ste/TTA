module ProjectsHelper
  def format_french_date(date)
    return "" if date.nil?

    # Si c'est déjà une Date/DateTime, on la formate directement
    if date.is_a?(Date) || date.is_a?(DateTime)
      date.strftime("%d/%m/%Y")
    # Si c'est une string, on la parse d'abord
    elsif date.is_a?(String)
      begin
        Date.parse(date).strftime("%d/%m/%Y")
      rescue ArgumentError
        date # Retourne la date originale si le parsing échoue
      end
    else
      date.to_s
    end
  end

  def random_img
    images = [
     "https://img.freepik.com/photos-premium/processus-conception-maison_190619-4525.jpg",
     "https://img.freepik.com/photos-premium/dessin-main-villa-conception-realisation-du-batiment_190619-1591.jpg",
     "https://img.freepik.com/vecteurs-premium/composition-dessin-maison-moderne-realiste-illustration-vectorielle-symboles-dessin-main_1284-74414.jpg",
     "https://img.freepik.com/vecteurs-premium/maison-croquis-vecteur-vecteur-eps-fond-blanc-cree_89681-432.jpg"
    ]
    images.sample(2)
  end
end
