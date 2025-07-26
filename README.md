## Trouve Ton Architecte
---

**TTA** is a Ruby on Rails application that allows clients to find architects, browse their portfolios, and submit projects online.
- [View PDF](https://drive.google.com/file/d/1HfiI2k1e2NMPfCapolGFQAa1RxHKRXY2/view?usp=drive_link)
- [Live site fly.io ](https://ttaforkv2.fly.dev/architects)
---

### Features

- Search for architects by specialization  
- User roles: 'client', 'architect'  
- Visual portfolio for each architect  
- Project creation by clients  
- Project acceptance/refusal by architects  
- Project statuses: 'en_validation', 'en_cours', 'termine', 'refuse', 'annule' 
- Avatar and media (images/videos) upload  
- Favorites system for clients  
- Client and architect dashboards  
---

### Technologies Used

- Ruby on Rails 8
- SQLite (dev) / PostgreSQL (prod)
- Devise (authentification)
- ActiveStorage (fichiers, images)
- Bootstrap 5
- gem Faker
- Mailjet
- AWS
---

### Configuration

 1. Clone the repository
 2. Install the gems: bundle install
 3. Configure environment variables in a .env file:
   - Email account variables (password: SENDMAIL_PASSWORD, email: SENDMAIL_USERNAME)
   - Mailjet variables (MAILJET_API_KEY, MAILJET_SECRET_KEY)
   - Localhost variable (MAIL_HOST)

* Database initialization
  ```bash
  rails db:create
  rails db:migrate
  rails db:seed
  ```
  
* To see in dev
 ```bash
  rails s
  ```
Then go to : http://localhost:3000/

---
### Team

This project was developed by a team of three people. You can check out my collaborators' profiles here:

- [@RosaBen](https://github.com/RosaBen)
- [@brainycodings](https://github.com/brainycodings)
