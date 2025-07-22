# Comment activer mailer avec devise
## mise à jour Migration devise
1. Rollback la migration devise:
```bash
rails db:migrate:down VERSION=20250716100801
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

## mise à jour model User
remplacer:
```ruby
# AVANT
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# APRES
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
```

## mise à jour config/environments/development.rb

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

## Mise à jour de config/initializers/devise.rb
Remplacer:
```ruby
# AVANT
config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

# APRÈS
config.mailer_sender = ENV['SENDMAIL_USERNAME']
```

Redemarrer server