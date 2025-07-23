require 'faker'
require 'open-uri'

puts "🧹 Nettoyage de la base..."
Multimedia.destroy_all
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
  first_name: "Admin",
  last_name: "Admin",
  email: "admin@yopmail.com",
  password: "password",
  role: 0, # enum :admin
  confirmed_at: Time.current
)
# admin.skip_confirmation!
# admin.save!

# Créer une ville pour l'admin
admin_city_data = cities_data.sample
admin.create_city!(admin_city_data)


# === CLIENTS ===
puts "👤 Création des clients..."
clients = 50.times.map do |i|
  client = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "client#{i}@yopmail.com",
    password: "password",
    role: 1, # enum :client
    confirmed_at: Time.current # Confirmer l'email automatiquement
  )

  # Créer une ville pour chaque client
  client_city_data = cities_data.sample
  client.create_city!(client_city_data)

  client
end

# === ARCHITECTS + PORTFOLIOS + PROJECTS ===
puts "🏗️ Création des multimédias et diplômes..."

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
    "https://img.freepik.com/photos-gratuite/maison-verte-moderne-entouree-paysage-luxuriant-chemin-pierre-mene-entree_191095-99768.jpg?t=st=1753302238~exp=1753305838~hmac=997aad83419c6552977d6f5129de8c63a4e12ff4c6604d6570db09a0424d1171&w=900",
    "https://img.freepik.com/vecteurs-libre/conception-fond-architecture_1168-209.jpg"
  ],

  "Intérieure" => [
    "https://img.freepik.com/photos-premium/dessin-salle-sejour-vue-ville_337384-123322.jpg",
    "https://img.freepik.com/photos-gratuite/petite-entree-style-moderne_23-2150713049.jpg",
    "https://img.freepik.com/photos-gratuite/interieur-design-cuisine-moderne_23-2150954758.jpg",
    "https://www.architecte-interieur-montpellier.com/static/33a25ff011f72777301a6550bca783cb/bfeed/di-01.jpg",
    "https://www.artmeta.fr/wp-content/uploads/2024/03/verriere-Atelier-4-acier-sur-mesure-C-1024x682.jpg",
    "https://cdn1.eminza.com/uploads/cache/blog_mea_mobile_retina/uploads/media/5cd143c44d0ce/astuce-decointerieure-blog-mea-1960x1228.jpg",
    "https://s3.eu-west-3.amazonaws.com/cdn.kipli/blog/deco-interieur/comment-choisir-accessoires-indispensables-decoration-interieur-1.jpg",
    "https://www.eyrc.com/hubfs/Imported_Blog_Media/EYRC%20Architects%20Irvine%20Cove%20Residence%20Interior%20Courtyards%202-3.jpg",
    "https://sdg-migration-id.s3.amazonaws.com/Interior-Design-Aidlin-Darling-Design-idx210101_boy_CountryHouse_Desert01-01.21.jpg",
    "https://mariakillam.com/wp-content/uploads/2020/09/step-one-design-1024x768.jpg",
    "https://img.freepik.com/photos-gratuite/piece-moderne-vide-meubles_23-2149178338.jpg?t=st=1753302024~exp=1753305624~hmac=0472f5e6116b008afb4c03c1dc6e247423b71e74c8f4bbece47b9b34d9c79164&w=996",
    "https://img.freepik.com/photos-gratuite/interieur-cuisine-scandinave-moderne-elegant-accessoires-cuisine-cuisine-blanche-lumineuse-articles-menagers_169016-4558.jpg",
    "https://img.freepik.com/photos-gratuite/piece-moderne-vide-meubles_23-2149178886.jpg?t=st=1753301533~exp=1753305133~hmac=d5a9f4b6b95a7ab85d7ff92c13b5009c624d26430c357bc5fac14454cb721b86&w=900",
    "https://img.freepik.com/photos-gratuite/design-interieur-baignoire-vintage_23-2148291600.jpg?t=st=1753301494~exp=1753305094~hmac=ecf1afeb51e924039abd91a9bf2201f2fe56748537e1654d845dd0d713d25106&w=360",
    "https://img.freepik.com/photos-gratuite/interieur-style-boheme-mur-briques_23-2149637986.jpg"
  ],

  "Paysagère" => [

    "https://img.freepik.com/photos-gratuite/fond-herbe_1127-3417.jpg",
    "https://img.freepik.com/photos-premium/details-jardin-luxe-moderne_1031776-159081.jpg",
    "https://www.outsideinfluencedesign.com/wp-content/uploads/2021/01/Residential_Landscape2.jpg",
    "https://images.adsttc.com/media/images/6099/9983/f91c/812c/b300/0007/newsletter/%28c%29_Frans_Parthesius__-_02_Villa_Fifty-Fifty_Design_Studioninedots_Photography_Frans_Parthesius.jpg?1620679031=",
    "https://images.adsttc.com/media/images/6099/9ead/f91c/812c/b300/000a/newsletter/%28c%29_Paul_Dyer_Tierwelthaus_%2815%29.jpg?1620680355=",
    "https://images.squarespace-cdn.com/content/v1/5987c76cf5e231e93c7abd43/6d1a378c-54c0-477a-85d4-dbcfcf2864aa/9.jpg",
    "https://img.freepik.com/photos-gratuite/belle-vue-nature-envoutante-dans-jardins-japonais-style-traditionnel-adelaide-himeji_181624-34903.jpg?t=st=1753301833~exp=1753305433~hmac=6a74e3144459a71e1caab8dfd5b7531459aa5bd9cc85d2ce9cd8109c1ad78af8&w=826",
    "https://img.freepik.com/photos-gratuite/piscine_74190-7325.jpg?t=st=1753302608~exp=1753306208~hmac=14b714ed7420b1fc37df4838185a0e0b01fdd6727ec6d68787d907bddb0d0797&w=900",
    "https://img.freepik.com/photos-gratuite/terrasse-exterieure-construction_1203-2586.jpg?t=st=1753302690~exp=1753306290~hmac=cd66285673b801e4d893e12ec4cc1c676704cebc636b25cfaf05db2908fed3ae&w=360"
  ]
}


degrees = [
  { name: "Diplôme d'État d'Architecte", acronym: "DEA"},
  { name: "Diplôme d'Architecte de l'École Spéciale", acronym: "DESA" },
  { name: "Master en Architecture", acronym: "MA" },
  { name: "Master Architecture et Habitat", acronym: "MAH"},
  { name: "Master Architecture Résidentielle", acronym: "MAR" },
  { name: "Diplôme Supérieur d'Arts Appliqués Architecture d'Intérieur", acronym: "DSAA-AI" },
  { name: "Master Design d'Espace et Architecture d'Intérieur", acronym: "MDEAI" },
  { name: "BTS Design d'Espace", acronym: "BTS-DE" },
  { name: "Diplôme National d'Arts et Techniques Architecture d'Intérieur", acronym: "DNAT-AI" },
  { name: "Master Architecture du Paysage", acronym: "MAP" },
  { name: "Diplôme d'Ingénieur Paysagiste", acronym: "DIP" },
  { name: "Master Urbanisme et Aménagement Paysager", acronym: "MUAP" },
  { name: "Licence Professionnelle Aménagement Paysager", acronym: "LP-AP" }
]
# === ARCHITECTES & PROJETS ===
puts "🏗️ Création des architectes et projets..."
50.times do |i|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "architect#{i}@yopmail.com",
    password: "password",
    role: 2,
    skip_city_validation: true,
    confirmed_at: Time.current
  )
  user.create_city!(cities_data.sample)

  selected_degrees = degrees.sample(rand(1..2))
  degree_names = selected_degrees.map { |d| d[:name] }.join(" | ")
  degree_acronyms = selected_degrees.map { |d| d[:acronym] }.join(" | ")

  architect = Architect.create!(
    user: user,
    description: Faker::Lorem.paragraph(sentence_count: 20),
    degree_name: degree_names,
    degree_acronym: degree_acronyms
  )

  specs = specializations.sample(rand(1..2))
  specs.each do |spec|
    ArchitectSpecialization.create!(architect: architect, specialization: spec)
  end

    # ✅ Projet "portfolio" garanti pour chaque architecte
  project = Project.create!(
    user: clients.sample,
    architect: architect,
    title: "#{Faker::Construction.material} #{Faker::Address.city} #{rand(100..999)}",
    start_date: Faker::Date.backward(days: 1000),
    description: Faker::Lorem.paragraph(sentence_count: 10),
    status: "termine",
    portfolio: true
  )

  specs.each do |spec|
    media_urls = medias_by_specialization[spec.name]
    next unless media_urls.present?

    media_urls.sample(rand(1..[media_urls.size, 3].min)).each_with_index do |url, idx|
      begin
        file = URI.open(url)
        media = Multimedia.new(
          project: project,
          type_media: "image",
          description: "#{spec.name} - Image #{idx + 1}"
        )
        media.file.attach(
          io: file,
          filename: "media_#{spec.name.parameterize}_#{idx + 1}.jpg",
          content_type: "image/jpeg"
        )
        media.save!
      rescue => e
        puts "    ⚠️ Erreur attachement #{spec.name} image #{idx + 1} : #{e.message}"
      end
    end
  end

  # ⚙️ Autres projets aléatoires (0 à 2) sans portfolio
  rand(0..2).times do
    prj = Project.create!(
      user: clients.sample,
      architect: architect,
      title: "#{Faker::Construction.material} #{Faker::Address.city} #{rand(100..999)}",
      start_date: Faker::Date.backward(days: 1000),
      description: Faker::Lorem.paragraph(sentence_count: 8),
      status: (Project.statuses.keys - ["termine"]).sample,
      portfolio: false
    )
    specs.each do |spec|
      media_urls = medias_by_specialization[spec.name]
      next unless media_urls.present?

      media_urls.sample(rand(1..[media_urls.size, 3].min)).each_with_index do |url, idx|
        begin
          file = URI.open(url)
          media = Multimedia.new(
            project: prj,
            type_media: "image",
            description: "#{spec.name} - Image #{idx + 1}"
          )
          media.file.attach(io: file,
                            filename: "media_#{spec.name.parameterize}_#{idx + 1}.jpg",
                            content_type: "image/jpeg")
          media.save!
        rescue => e
          puts "    ⚠️ Erreur attachement pour projet secondaire: #{e.message}"
        end
      end
    end
  end
end

puts "✅ Seed terminé avec succès !"