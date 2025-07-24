# README
# Trouve Ton Architecte

**TTA** est une application Ruby on Rails permettant aux clients de trouver des architectes, de consulter leurs portfolios et de leur soumettre des projets en ligne.
cahier des charge : https://docs.google.com/document/d/15_coCOfKQWbx-plhF4neyv2I3l2zjxs_T10r_CZQBO8/edit?tab=t.0
site en production : https://trouve-ton-architecte.onrender.com/ 
---

## Fonctionnalités

- Recherche d'architectes par spécialisation
- Rôles user : 'client', 'architecte'
- Portfolio visuel pour chaque architecte
- Création de projets par les clients
- Acceptation / refus des projets par les architectes
- Statuts de projets : 'en_validation', 'en_cours', 'termine', 'refuse', 'annule'
- Ajout d'avatars et de médias (images/vidéos)
- Ajout aux favoris pour les client
- Dashboard client et architecte

---

## Technologies utilisées
Ruby on Rails 8

SQLite (dev) / PostgreSQL (prod)

Devise (authentification)

ActiveStorage (fichiers, images)

Bootstrap 5

Faker (génération de données seed)

Mailjet



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  ```bash
  Ruby 3.4.2
  ```

* System dependencies
  - SQLite3 (>= 2.1) - Database
* Configuration
 1. Clone the repository
 2. Install the gems: bundle install
 3. Configure environment variables in a .env file:
   - Email account variables (password: SENDMAIL_PASSWORD, email: SENDMAIL_USERNAME)
   - Mailjet variables (MAILJET_API_KEY, MAILJET_SECRET_KEY)
   - Localhost variable (MAIL_HOST)

* Database creation
  ```bash
  rails db:create
  ```
* Database initialization
  ```bash
  rails db:migrate
  rails db:seed
  ```

* To reset everything including indexes:
  ```bash
  rails db:reset
  ```

* Rollbacks
    1. To undo the last migration (one step at a time)
  ```bash
  rails db:rollback
  ```
    2. To undo a specific migration (replace version_number with the actual version)
  ```bash
  rails db:migrate:down VERSION=version_number
  ```

* How to run the test suite
# Unit and functional tests
```bash
rails test
```
# System tests (with Capybara and Selenium)
```bash
rails test:system
```
# All tests
```bash
rails test:all
```
# Specific tests
```bash
rails test test/models/
rails test test/controllers/
rails test test/system/
```

* Services (job queues, cache servers, search engines, etc.)

    * Solid Queue: Background job processing
    * Solid Cache: Database-backed caching system
    * Solid Cable: WebSockets for Action Cable
    * Mailjet: Email sending service
    * Devise: User authentication


* Deployment instructions
```bash
# Local development
rails server

# Using Docker
docker build -t tta .
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name tta tta

# Using Kamal (production deployment)
kamal setup    # First-time setup
kamal deploy   # Subsequent deployments
```
```bash
```
```bash
```
```bash
```
