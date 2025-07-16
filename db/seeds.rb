require 'faker'

puts "🧹 Nettoyage de la base..."
Multimedia.destroy_all
Portfolio.destroy_all
Project.destroy_all
ArchitectSpecialization.destroy_all
Architect.destroy_all
User.destroy_all
Specialization.destroy_all
City.destroy_all

# === CITIES ===
puts "🏙️ Création des villes..."
cities_data = [
  { name: "Paris", zip_code: "75001", department: "Paris" },
  { name: "Lyon", zip_code: "69001", department: "Rhône" },
  { name: "Marseille", zip_code: "13001", department: "Bouches-du-Rhône" },
  { name: "Toulouse", zip_code: "31000", department: "Haute-Garonne" },
  { name: "Nice", zip_code: "06000", department: "Alpes-Maritimes" }
]

# === TEMP USER POUR VILLES ===
temp_user = User.create!(
  first_name: "Ville",
  last_name: "Temporaire",
  email: "temp@yopmail.com",
  password: "password",
  role: 1 # client
)

cities = cities_data.map { |data| City.create!(data.merge(user_id: temp_user.id)) }


# === SPECIALIZATIONS ===
puts "🧱 Création des spécialités..."
specializations = [
  "Architecture résidentielle",
  "Architecture d'intérieur",
  "Architecture paysagère"
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

# === CLIENTS ===
puts "👤 Création des clients..."
clients = 10.times.map do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "client#{i}@yopmail.com",
    password: "password",
    role: 1 # enum :client
  )
end

# === ARCHITECTS + PORTFOLIOS + PROJECTS ===
puts "🏗️ Création des architectes, portfolios et projets..."

degrees = [
  { name: "Diplôme d'État d'Architecte", acronym: "DEA", years: 5 },
  { name: "Diplôme d'Architecte de l'École Spéciale", acronym: "DESA", years: 6 },
  { name: "Master en Architecture", acronym: "MA", years: 5 }
]

10.times do |i|
  # Architect User
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "architect#{i}@yopmail.com",
    password: "password",
    role: 2 # enum :architect
  )

  # Architect Profile
  degree = degrees.sample
  architect = Architect.create!(
    user: user,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    degree_name: degree[:name],
    degree_acronym: degree[:acronym],
    years_study: degree[:years]
  )

  # Lier l'utilisateur à la ville
  cities.sample.update(user_id: user.id)

  # Spécialisations (1 à 2 par architecte)
  specializations.sample(rand(1..2)).each do |spec|
    ArchitectSpecialization.create!(architect: architect, specialization: spec)
  end

  # Portfolio
  portfolio = Portfolio.create!(
    architect: architect,
    project_title: Faker::Construction.material + " " + Faker::Construction.heavy_equipment,
    project_description: Faker::Lorem.paragraph(sentence_count: 5)
  )

  # Multimédia pour le portfolio
  3.times do
    Multimedia.create!(
      portfolio: portfolio,
      type_media: ["Image", "Video"].sample,
      description: Faker::Lorem.sentence
    )
  end

  # Projets (1 à 3 projets entre architecte et clients)
  rand(1..3).times do
    Project.create!(
      user: clients.sample,
      architect: architect,
      start_date: Faker::Date.backward(days: 1000),
      description: Faker::Lorem.paragraph,
      status: %w[en_cours terminé annulé].sample
    )
  end
end

puts "✅ Seed terminé avec succès !"
