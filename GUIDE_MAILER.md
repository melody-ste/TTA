# Mise en place action mailer avec devise et mailjet
## Comment activer mailer avec devise
[tutorial](https://www.bogotobogo.com/RubyOnRails/RubyOnRails_Devise_Authentication_Sending_Confirmation_Email.php)
### mise à jour Migration devise
1. Rollback la migration devise:
```bash
rails db:migrate:down VERSION=200....
```
2. Décommenter les lignes suivantes:
```ruby
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
```
3. Faire migration:
```bash
rails db:migrate
```
4. Vérifier les modifications sont apportées à schema.rb.
On doit voir les lignes en plus:
```ruby
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
```
si les lignes sont manquantes, faire db:drop, db:create, db:migrate

### mise à jour model User
remplacer:
```ruby
# AVANT
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# APRES
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
```

### mise à jour config/environments/development.rb

1. Ajouter les lignes suivantes:
```ruby
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: ENV['MAIL_HOST'] }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name:      ENV['SENDMAIL_USERNAME'],
    password:       ENV['SENDMAIL_PASSWORD'],
    domain:         ENV['MAIL_HOST'],
    address:       'smtp.gmail.com',
    port:          '587',
    authentication: :plain,
    enable_starttls_auto: true
  }
```

2. Mettre à jour le fichier .env

    * Créer mot de passe pour application avec gmail:  security.google.com/settings/security/apppasswords
    * Récupérer mot de passe bvuw vwlu lbkw mlvn
    * Mettre à jour .env
```ruby
SENDMAIL_PASSWORD=aaaa aaaa aaaa aaaa
SENDMAIL_USERNAME=myemail@gmail.com
MAIL_HOST=localhost:3000
```

### Mise à jour de config/initializers/devise.rb
Remplacer:
```ruby
# AVANT
config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

# APRÈS
config.mailer_sender = ENV['SENDMAIL_USERNAME']
```
Décommenter ou ajoute:
```ruby
# ==> Configuration for :recoverable
config.reset_password_keys = [:email]
config.reset_password_within = 6.hours
config.sign_in_after_reset_password = true

# ==> Configuration for :lockable  
config.lock_strategy = :failed_attempts
config.unlock_keys = [:email]
config.unlock_strategy = :email
config.maximum_attempts = 20
config.unlock_in = 1.hour
```

Redemarrer server et tester

## Mailjet
[tutorial](https://github.com/mailjet/mailjet-gem)

### Mettre à jour gemfile
1. Ajouter sur gemfile
```gemfile
gem 'mailjet'
```
2. installer wrapper
```bash
gem install mailjet
```
3. Install
```bash
bundle install
```
## Mettre à jour .env
1. Récupérer les clés api sur [mailjet](https://app.mailjet.com/account/apikeys)
```env
MJ_APIKEY_PUBLIC= xxxxxx
MJ_APIKEY_PRIVATE=xxxxxx
```
2. Mettre à jour config/environments/production.rb en ajoutant
```ruby
    config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'in-v3.mailjet.com',
    port: 587,
    user_name: ENV['MAILJET_API_KEY'],
    password: ENV['MAILJET_SECRET_KEY'],
    authentication: :plain,
    enable_starttls_auto: true
  }
```
3. Mettre à jour config/environments/development.rb en remplacant
```ruby
# AVANT
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name:      ENV['SENDMAIL_USERNAME'],
    password:       ENV['SENDMAIL_PASSWORD'],
    domain:         ENV['MAIL_HOST'],
    address:       'smtp.gmail.com',
    port:          '587',
    authentication: :plain,
    enable_starttls_auto: true
  }
# APRES
    config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'in-v3.mailjet.com',
    port: 587,
    user_name: ENV['MAILJET_API_KEY'],
    password: ENV['MAILJET_SECRET_KEY'],
    authentication: :plain,
    enable_starttls_auto: true
  }
```
```gemfile
gem 'mailjet'
```
```gemfile
gem 'mailjet'
```
```gemfile
gem 'mailjet'
```