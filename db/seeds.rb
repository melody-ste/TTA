require 'faker'

puts "🧹 Nettoyage de la base..."
Multimedia.destroy_all
Portfolio.destroy_all
Project.destroy_all
ArchitectSpecialization.destroy_all
Architect.destroy_all
City.destroy_all
User.destroy_all
Specialization.destroy_all


# === CITIES DATA ===
cities_data = [
  { name: "Paris", zip_code: "75001", department: "Paris" },
  { name: "Lyon", zip_code: "69001", department: "Rhône" },
  { name: "Marseille", zip_code: "13001", department: "Bouches-du-Rhône" },
  { name: "Toulouse", zip_code: "31000", department: "Haute-Garonne" },
  { name: "Nice", zip_code: "06000", department: "Alpes-Maritimes" },
  { name: "Nantes", zip_code: "44000", department: "Loire-Atlantique" },
  { name: "Strasbourg", zip_code: "67000", department: "Bas-Rhin" },
  { name: "Montpellier", zip_code: "34000", department: "Hérault" },
  { name: "Bordeaux", zip_code: "33000", department: "Gironde" },
  { name: "Lille", zip_code: "59000", department: "Nord" },
  { name: "Rennes", zip_code: "35000", department: "Ille-et-Vilaine" },
  { name: "Le Havre", zip_code: "76600", department: "Seine-Maritime" },
  { name: "Reims", zip_code: "51100", department: "Marne" },
  { name: "Saint-Étienne", zip_code: "42000", department: "Loire" },
  { name: "Toulon", zip_code: "83000", department: "Var" },
  { name: "Angers", zip_code: "49000", department: "Maine-et-Loire" },
  { name: "Grenoble", zip_code: "38000", department: "Isère" },
  { name: "Dijon", zip_code: "21000", department: "Côte-d'Or" },
  { name: "Nîmes", zip_code: "30000", department: "Gard" },
  { name: "Aix-en-Provence", zip_code: "13100", department: "Bouches-du-Rhône" },
  { name: "Clermont-Ferrand", zip_code: "63000", department: "Puy-de-Dôme" },
  { name: "Tours", zip_code: "37000", department: "Indre-et-Loire" }
]

# === SPECIALIZATIONS ===
puts "🧱 Création des spécialités..."
specializations = [
  "Résidentielle",
  "Intérieur",
  "Paysagère"
].map { |name| Specialization.create!(name: name) }

# === ADMIN ===
puts "🛡️ Création de l'admin..."
admin = User.create!(
  first_name: "Super",
  last_name: "Admin",
  email: "admin@yopmail.com",
  password: "password",
  role: 0 # enum :admin
)

# Créer une ville pour l'admin
admin_city_data = cities_data.sample
admin.create_city!(admin_city_data)


# === CLIENTS ===
puts "👤 Création des clients..."
clients = 10.times.map do |i|
  client = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "client#{i}@yopmail.com",
    password: "password",
    role: 1 # enum :client
  )

  # Créer une ville pour chaque client
  client_city_data = cities_data.sample
  client.create_city!(client_city_data)

  client
end

# === ARCHITECTS + PORTFOLIOS + PROJECTS ===
puts "🏗️ Création des architectes, portfolios et projets..."

medias_by_specialization = {
  "Architecture Résidentielle" => [
    "https://img.freepik.com/photos-gratuite/quartier-residentiel-moderne-toit-vert-balcon-genere-par-ia_188544-10276.jpg",
    "https://edwardgeorgelondon.com/wp-content/uploads/2024/10/Striking-modern-house-exterior-blending-white-stucco-glass-metal-and-wood-with-clean-lines-and-contrasting-textures.webp",
    "https://cdn.home-designing.com/wp-content/uploads/2017/05/wood-white-and-charcoal-modern-exterior-paint-themes.jpg",
    "https://c8.alamy.com/comp/2D6GMXX/building-project-blueprint-plans-and-house-model-real-estate-construction-concept-architecture-design-3d-illustration-2D6GMXX.jpg",
    "https://images.ctfassets.net/s4ybdu2ld1ox/7KoNH8PR71vjj6zKJ2klLO/0ef16a934b9095f429392dfe0e9f16e3/home-blueprints.jpeg?bg=transparent&fl=progressive&fm=jpg&h=683&q=70&w=1000",
    "https://archmodeler.com/wp-content/uploads/2023/02/Interior-model-7.jpg",
    "https://cdn.bluent.com/images/architectural-construction-drawing-portfolio-5-2.jpg",
    "https://img.freepik.com/photos-premium/maison-minimaliste-moderne-paysage-naturel_62754-4317.jpg",
    "https://img.freepik.com/vecteurs-libre/conception-fond-architecture_1168-209.jpg"
  ],

  "Architecture Intérieure" => [
    "https://img.freepik.com/photos-premium/dessin-salle-sejour-vue-ville_337384-123322.jpg",
    "https://img.freepik.com/photos-gratuite/petite-entree-style-moderne_23-2150713049.jpg",
    "https://img.freepik.com/photos-gratuite/interieur-design-cuisine-moderne_23-2150954758.jpg",
    "https://www.architecte-interieur-montpellier.com/static/33a25ff011f72777301a6550bca783cb/bfeed/di-01.jpg",
    "https://www.artmeta.fr/wp-content/uploads/2024/03/verriere-Atelier-4-acier-sur-mesure-C-1024x682.jpg",
    "https://cdn1.eminza.com/uploads/cache/blog_mea_mobile_retina/uploads/media/5cd143c44d0ce/astuce-decointerieure-blog-mea-1960x1228.jpg",
    "https://s3.eu-west-3.amazonaws.com/cdn.kipli/blog/deco-interieur/comment-choisir-accessoires-indispensables-decoration-interieur-1.jpg",
    "https://www.eyrc.com/hubfs/Imported_Blog_Media/EYRC%20Architects%20Irvine%20Cove%20Residence%20Interior%20Courtyards%202-3.jpg",
    "https://sdg-migration-id.s3.amazonaws.com/Interior-Design-Aidlin-Darling-Design-idx210101_boy_CountryHouse_Desert01-01.21.jpg",
    "https://mariakillam.com/wp-content/uploads/2020/09/step-one-design-1024x768.jpg"
  ],

  "Architecture Paysagère" => [

    "https://img.freepik.com/photos-gratuite/fond-herbe_1127-3417.jpg",
    "https://img.freepik.com/photos-premium/details-jardin-luxe-moderne_1031776-159081.jpg",
    "https://www.outsideinfluencedesign.com/wp-content/uploads/2021/01/Residential_Landscape2.jpg",
    "https://images.adsttc.com/media/images/6099/9983/f91c/812c/b300/0007/newsletter/%28c%29_Frans_Parthesius__-_02_Villa_Fifty-Fifty_Design_Studioninedots_Photography_Frans_Parthesius.jpg?1620679031=",
    "https://images.adsttc.com/media/images/6099/9ead/f91c/812c/b300/000a/newsletter/%28c%29_Paul_Dyer_Tierwelthaus_%2815%29.jpg?1620680355=",
    "https://images.squarespace-cdn.com/content/v1/5987c76cf5e231e93c7abd43/6d1a378c-54c0-477a-85d4-dbcfcf2864aa/9.jpg"
  ]
}


degrees = [
  { name: "Diplôme d'État d'Architecte", acronym: "DEA", years: 5 },
  { name: "Diplôme d'Architecte de l'École Spéciale", acronym: "DESA", years: 6 },
  { name: "Master en Architecture", acronym: "MA", years: 5 },
  { name: "Master Architecture et Habitat", acronym: "MAH", years: 5 },
  { name: "Master Architecture Résidentielle", acronym: "MAR", years: 5 },
  { name: "Diplôme Supérieur d'Arts Appliqués Architecture d'Intérieur", acronym: "DSAA-AI", years: 5 },
  { name: "Master Design d'Espace et Architecture d'Intérieur", acronym: "MDEAI", years: 5 },
  { name: "BTS Design d'Espace", acronym: "BTS-DE", years: 2 },
  { name: "Diplôme National d'Arts et Techniques Architecture d'Intérieur", acronym: "DNAT-AI", years: 3 },
  { name: "Master Architecture du Paysage", acronym: "MAP", years: 5 },
  { name: "Diplôme d'Ingénieur Paysagiste", acronym: "DIP", years: 5 },
  { name: "Master Urbanisme et Aménagement Paysager", acronym: "MUAP", years: 5 },
  { name: "Licence Professionnelle Aménagement Paysager", acronym: "LP-AP", years: 3 }
]

medias_by_specialization = {
  "Résidentielle" => [
    "https://img.freepik.com/photos-gratuite/quartier-residentiel-moderne-toit-vert-balcon-genere-par-ia_188544-10276.jpg",
    "https://edwardgeorgelondon.com/wp-content/uploads/2024/10/Striking-modern-house-exterior-blending-white-stucco-glass-metal-and-wood-with-clean-lines-and-contrasting-textures.webp",
    "https://cdn.home-designing.com/wp-content/uploads/2017/05/wood-white-and-charcoal-modern-exterior-paint-themes.jpg",
    "https://c8.alamy.com/comp/2D6GMXX/building-project-blueprint-plans-and-house-model-real-estate-construction-concept-architecture-design-3d-illustration-2D6GMXX.jpg",
    "https://images.ctfassets.net/s4ybdu2ld1ox/7KoNH8PR71vjj6zKJ2klLO/0ef16a934b9095f429392dfe0e9f16e3/home-blueprints.jpeg?bg=transparent&fl=progressive&fm=jpg&h=683&q=70&w=1000",
    "https://archmodeler.com/wp-content/uploads/2023/02/Interior-model-7.jpg",
    "https://cdn.bluent.com/images/architectural-construction-drawing-portfolio-5-2.jpg",
    "https://img.freepik.com/photos-premium/maison-minimaliste-moderne-paysage-naturel_62754-4317.jpg",
    "https://img.freepik.com/vecteurs-libre/conception-fond-architecture_1168-209.jpg"
  ],

  "Intérieur" => [
    "https://img.freepik.com/photos-premium/dessin-salle-sejour-vue-ville_337384-123322.jpg",
    "https://img.freepik.com/photos-gratuite/petite-entree-style-moderne_23-2150713049.jpg",
    "https://img.freepik.com/photos-gratuite/interieur-design-cuisine-moderne_23-2150954758.jpg",
    "https://www.architecte-interieur-montpellier.com/static/33a25ff011f72777301a6550bca783cb/bfeed/di-01.jpg",
    "https://www.artmeta.fr/wp-content/uploads/2024/03/verriere-Atelier-4-acier-sur-mesure-C-1024x682.jpg",
    "https://cdn1.eminza.com/uploads/cache/blog_mea_mobile_retina/uploads/media/5cd143c44d0ce/astuce-decointerieure-blog-mea-1960x1228.jpg",
    "https://s3.eu-west-3.amazonaws.com/cdn.kipli/blog/deco-interieur/comment-choisir-accessoires-indispensables-decoration-interieur-1.jpg",
    "https://www.eyrc.com/hubfs/Imported_Blog_Media/EYRC%20Architects%20Irvine%20Cove%20Residence%20Interior%20Courtyards%202-3.jpg",
    "https://sdg-migration-id.s3.amazonaws.com/Interior-Design-Aidlin-Darling-Design-idx210101_boy_CountryHouse_Desert01-01.21.jpg",
    "https://mariakillam.com/wp-content/uploads/2020/09/step-one-design-1024x768.jpg"
  ],

  "Paysagère" => [
    "https://img.freepik.com/photos-gratuite/fond-herbe_1127-3417.jpg",
    "https://img.freepik.com/photos-premium/details-jardin-luxe-moderne_1031776-159081.jpg",
    "https://www.outsideinfluencedesign.com/wp-content/uploads/2021/01/Residential_Landscape2.jpg",
    "https://images.adsttc.com/media/images/6099/9983/f91c/812c/b300/0007/newsletter/%28c%29_Frans_Parthesius__-_02_Villa_Fifty-Fifty_Design_Studioninedots_Photography_Frans_Parthesius.jpg?1620679031=",
    "https://images.adsttc.com/media/images/6099/9ead/f91c/812c/b300/000a/newsletter/%28c%29_Paul_Dyer_Tierwelthaus_%2815%29.jpg?1620680355=",
    "https://images.squarespace-cdn.com/content/v1/5987c76cf5e231e93c7abd43/6d1a378c-54c0-477a-85d4-dbcfcf2864aa/9.jpg"
  ]
}

10.times do |i|
  # Architect User et sa ville
  architect_city_data = cities_data.sample

  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "architect#{i}@yopmail.com",
    password: "password",
    role: 2, # enum :architect
    skip_city_validation: true
  )
  user.save!

  # Créer la ville pour l'architecte immédiatement après la création de l'utilisateur
  user.create_city!(architect_city_data)


  # Architect Profile - 1 à 2 diplômes aléatoires
  selected_degrees = degrees.sample(rand(1..2))

  # Concaténer les informations de diplômes s'il y en a plusieurs
  degree_names = selected_degrees.map { |d| d[:name] }.join(" | ")
  degree_acronyms = selected_degrees.map { |d| d[:acronym] }.join(" | ")


  architect = Architect.create!(
    user: user,
    description: Faker::Lorem.paragraph(sentence_count: 20),
    degree_name: degree_names,
    degree_acronym: degree_acronyms,
    years_study: 0  # Sera calculé dynamiquement par le helper
  )

  # Spécialisations (1 à 2 par architecte)
  architect_specializations = specializations.sample(rand(1..2))
  architect_specializations.each do |spec|
    ArchitectSpecialization.create!(architect: architect, specialization: spec)
  end

  # Créer un portfolio par spécialisation avec les médias correspondants
  architect_specializations.each do |specialization|
    # Portfolio spécifique à cette spécialisation
    portfolio = Portfolio.create!(
      architect: architect,
      project_title: "#{specialization.name} - #{Faker::Construction.material}",
      project_description: "Portfolio spécialisé en #{specialization.name}. #{Faker::Lorem.paragraph(sentence_count: 20)}"
    )

    # Médias correspondant à cette spécialisation uniquement
    media_urls = medias_by_specialization[specialization.name]
    next unless media_urls

    # Créer 3-5 médias pour cette spécialisation en s'assurant qu'on utilise des URLs uniques
    max_media_count = [ media_urls.length, 5 ].min # Ne pas dépasser le nombre d'URLs disponibles
    media_count = rand(3..max_media_count)
    selected_urls = media_urls.sample(media_count) # Sample sans répétition


    selected_urls.each_with_index do |url, index|
      Multimedia.create!(
        portfolio: portfolio,
        type_media: url,
        description: "#{specialization.name} - Image #{index + 1} - #{Faker::Lorem.sentence}"
      )
    end
  end

  # Projets (1 à 3 projets entre architecte et clients)
  rand(1..3).times do
    Project.create!(
      user: clients.sample,
      architect: architect,
      start_date: Faker::Date.backward(days: 1000),
      description: Faker::Lorem.paragraph,
      status: Project.statuses.keys.sample
      # status: %w[en_validation accepte refuse en_cours termine annule].sample
    )
  end
end

puts "✅ Seed terminé avec succès !"
