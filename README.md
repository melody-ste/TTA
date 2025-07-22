# README

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