# Docker - Traefik - Let's Encrypt : sécuriser vos applications en production

Ce petit guide s’adresse à celles et ceux qui débutent dans l’univers des serveurs, du déploiement web, et de la sécurisation d'applications. Pas besoin d’avoir un niveau expert, on part de zéro.

L’objectif ? Apprendre à lancer une application web de manière **propre, sécurisée et automatisée** à l’aide de **Docker**, **Traefik**, **Let's Encrypt** et un **VPS (serveur dédié)**.

## 1. Introduction

### 1.1 🐳 Docker

Docker permet de **créer un conteneur isolé**, qui contient tout ce dont ton application a besoin pour fonctionner (Ruby, Rails, Node, etc). Ça évite de devoir tout installer à la main à chaque fois. C’est comme un environnement “clé en main”.

### 1.2 🚦 Traefik

Traefik est un **reverse proxy dynamique**. Il écoute automatiquement les services Docker que tu lances, et les rend accessibles sur Internet. Il gère aussi les redirections et les certificats HTTPS sans effort.

### 1.3 🔒 Let's Encrypt

C’est un organisme gratuit qui fournit des **certificats SSL**, nécessaires pour sécuriser un site en HTTPS. Traefik peut s’en occuper tout seul pour toi (pas besoin de t’inscrire ou de manipuler des clés).

### 1.4 ☁️ VPS ou Serveur dédié

Un VPS (Virtual Private Server) est un petit serveur distant sur lequel tu as un contrôle total (comme une machine personnelle accessible par Internet). C’est **moins cher** et **bien plus flexible** qu’une solution comme Heroku. Exemple :

* [LWS](https://www.lws.fr/serveur-virtuel.php) (avec le code **THP** : -50% la première année + nom de domaine gratuit)
* IONOS
* Hetzner
* OVH

### 1.5 🌐 Registrar (gestionnaire de domaine)

C’est là où tu achètes ton nom de domaine. Exemples : OVH, Gandi, LWS, IONOS, Infomaniak. C’est eux qui te permettent de rediriger ton nom de domaine vers l’adresse IP de ton serveur (via les DNS).

> 📝 **DISCLAIMER (important)** : dans cette formation, on reste simple et pédagogique. **On utilise SQLite** comme base de données pour tous les environnements, même en production. Pourquoi ? Parce que **Rails 8** gère très bien SQLite, que c’est rapide à mettre en place, et que cela reste stable tant que tu n’as pas de gros volume de trafic. C’est parfait pour apprendre, tester ou même lancer un vrai projet MVP sans douleur.

## 2. Ressource

### 2.1 Créer la structure du projet

À la racine de ton app, crée un dossier `ops/` avec trois sous-dossiers :
```
ops/
├── dev/
├── staging/
└── production/
```

Crée ensuite les fichiers suivants :
```yaml
# --- ops/dev/docker-compose.yml ---
# Usage: docker compose -f ops/dev/docker-compose.yml up

services:
  web:
    build: .
    container_name: nomapp-dev
    environment:
      RAILS_ENV: development
    env_file:
      - ../../.env
    volumes:
      - nomapp-dev-data:/rails/db
    ports:
      - "3000:3000"
    command: ["./bin/rails", "server", "-b", "0.0.0.0"]
    labels:
      - "traefik.enable=false"
      - "traefik.http.routers.nomapp-dev.rule=Host(`dev.tondomaine.com`)"
      - "traefik.http.routers.nomapp-dev.entrypoints=websecure"
      - "traefik.http.routers.nomapp-dev.tls=true"
      - "traefik.http.routers.nomapp-dev.tls.certresolver=letsencrypt"
    networks:
      - traefik

volumes:
  nomapp-dev-data:

networks:
  traefik:
    external: true
```

```yaml
# --- ops/staging/docker-compose.yml ---
# Usage: docker compose -f ops/staging/docker-compose.yml up -d

services:
  web:
    build: .
    container_name: nomapp-staging
    environment:
      RAILS_ENV: production
    env_file:
      - ../../.env
    volumes:
      - nomapp-staging-data:/rails/db
    ports:
      - "3001:3000"
    labels:
      - "traefik.enable=false"
      - "traefik.http.routers.nomapp-staging.rule=Host(`staging.tondomaine.com`)"
      - "traefik.http.routers.nomapp-staging.entrypoints=websecure"
      - "traefik.http.routers.nomapp-staging.tls=true"
      - "traefik.http.routers.nomapp-staging.tls.certresolver=letsencrypt"
    networks:
      - traefik

volumes:
  nomapp-staging-data:

networks:
  traefik:
    external: true
```

```yaml
# --- ops/production/docker-compose.yml ---
# Usage: docker compose -f ops/production/docker-compose.yml up -d

services:
  web:
    build: .
    container_name: nomapp-prod
    environment:
      RAILS_ENV: production
    env_file:
      - ../../.env
    volumes:
      - nomapp-prod-data:/rails/db
    ports:
      - "3002:3000"
    labels:
      - "traefik.enable=false"
      - "traefik.http.routers.nomapp-prod.rule=Host(`example.com`)"
      - "traefik.http.routers.nomapp-prod.entrypoints=websecure"
      - "traefik.http.routers.nomapp-prod.tls=true"
      - "traefik.http.routers.nomapp-prod.tls.certresolver=letsencrypt"
    networks:
      - traefik

volumes:
  tta-prod-data:

networks:
  traefik:
    external: true
```

### 2.2 Préparer ton serveur VPS

* Un minimum de 4go de RAM sera nécessaire pour faire tourner un seul contenair docker, un VPS à 8Go est le meilleur pour ce genre de projet.
* Lors de la commande de ton VPS, choisis **Ubuntu** comme système d’exploitation. Évite Debian, CentOS ou d’autres distributions qui peuvent créer des conflits avec Docker ou Rails.
* Choisis une installation **sans NGINX préinstallé** pour éviter les conflits avec Traefik (ils utilisent le même port 80).
* Ne prends **pas d’infogérance**, sinon tu n’auras pas les accès root nécessaires pour configurer librement ton environnement.

#### 2.2.1 Connexion SSH à ton serveur
Dans n'importe quel terminal en local (wsl / powershell / homebrew / etc)
```bash
ssh root@adresse_ip_du_vps
```

Puis entre le mot de passe fourni.

#### 2.2.2 Cloner ton projet depuis Git

```bash
git clone [url_ssh_git]
cd nom_du_projet
```

### À savoir après un `git clone`

> ⚠️ **Ne fais pas de `bundle install`, ni d’installfest.** Tout est déjà contenu dans le conteneur Docker. Tu n’as qu’à faire à chaque modification sur ton repo:
```bash
git pull origin dev
```

Pour mettre à jour l’application sur ton VPS avant un redéploiement Docker.

#### 2.2.3 Régénérer une master key (si besoin)

```bash
EDITOR="nano" bin/rails credentials:edit
```

#### 2.2.4 Copier la master key dans le fichier `.env`

```bash
cat config/master.key
nano .env
```

Et y mettre :
```
RAILS_MASTER_KEY=ta_clé_maitre
```

Ajoute également toutes les autres variables d’environnement requises par ton application.

### 2.3 Créer le réseau Docker partagé

```bash
docker network create traefik
```

Celui-ci permettra de lié traefik avec tes conteneurs dockers.

### 2.4 Fichier `traefik.yml`

À la racine de ton `user` (`root` par défaut), un simple `cd` permet d’y revenir à tout moment, peu importe le dossier dans lequel tu te trouves actuellement.
```bash
nano traefik.yml
```

Copie dedans : (avec un clic droit)
```yaml
entryPoints:
  web:
    address: ":80"
  websecure:
    address: ":443"

providers:
  docker:
    exposedByDefault: false

certificatesResolvers:
  letsencrypt:
    acme:
      email: ton.email@domaine.com
      storage: /acme.json
      httpChallenge:
        entryPoint: web
```

Enregistre avec Ctrl / Cmd + x puis Y puis Entrée

### 2.5 Créer le fichier de certificat

Toujours à la racine de ton user.
```bash
touch acme.json
chmod 600 acme.json
```

### 2.6 Lancer Traefik

Encore à la racine de ton user.
```bash
docker run -d \
  --name traefik \
  --network traefik \
  -p 80:80 -p 443:443 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/traefik.yml:/etc/traefik/traefik.yml \
  -v $PWD/acme.json:/acme.json \
  traefik:v2.11
```

### 2.7 Configurer ton nom de domaine

#### 2.7.1 Option 1 : DNS simple chez ton registrar

Ajoute 3 entrées de type A :

```
Type : A | Nom : @         | Cible : IP (production)
Type : A | Nom : staging  | Cible : IP (staging)
Type : A | Nom : dev      | Cible : IP (dev)
```

#### 2.7.2 Option 2 : Cloudflare

Cloudflare te permet de gérer tes DNS + sécurité. **Important** : le proxy (icône orange) doit être désactivé pour laisser passer le challenge HTTP de Let's Encrypt.


⚠️ Il est inutile de faire tourner `dev` et `staging` 24h/24. Tu peux les démarrer uniquement quand tu en as besoin, pour éviter de consommer inutilement les ressources de ton serveur (RAM, CPU).

Et voilà ! À partir de là, ton app est exposée en HTTPS avec certificat automatique 🎉


### 2.8 Faire tourner tes conteneurs : 🛠️ Commandes Docker essentielles

Pour faire tourner un conteneur, rien de plus simple voici une liste de commande utile, à faire depuis le dossier ops de chaque status de ton projet (dev / staging / production).
```bash
docker compose build     # Reconstruit l’image si le code source a changé
```

> 🎯 Pas nécessaire si tu modifies uniquement le `.env`. Le build ne supprime pas la base de données.

```bash
docker compose up        # Démarre les services avec logs
```

```bash
docker compose up -d     # Démarre les services en arrière-plan
```

```bash
docker compose down      # Arrête les conteneurs
```

⚠️ Ne laisse pas tourner `dev` ou `staging` 24h/24 inutilement : tu consommerais de la RAM pour rien 😉

📝 Si tu veux accéder à ton app sans utiliser Traefik pour tester, utilise l’IP de ton serveur et le port externe, par exemple :
```
http://adresseip:3000
```

Une fois que Traefik est actif `"traefik.enable=true"` et les redirections DNS faites, l’app sera accessible via :
```
https://dev.tondomaine.com
```

## 3. Pour aller plus loin

Une fois que tu maîtrises le déploiement manuel avec Docker et Traefik, tu peux aller encore plus loin grâce à **GitHub et au DevOps**.

### 3.1 🔁 Automatiser les déploiements avec GitHub

Il est possible de créer une logique avec **trois branches principales** :

* `dev` → met à jour automatiquement l'environnement de développement
* `staging` → met à jour l'environnement de préproduction
* `production` → déploie directement en production

Grâce à **GitHub Actions** ou d'autres outils CI/CD, tu peux faire en sorte que :

> à chaque fois qu'une pull request est acceptée sur une de ces branches, le serveur (VPS) exécute automatiquement les bonnes commandes `git pull`, `docker compose build`, `docker compose up -d`, **sans que tu n'aies jamais à te reconnecter à la machine**.

### 3.2 📚 Formation DevOps gratuite

Une formation complète, constamment mise à jour, est disponible gratuitement dans les spécialisations de The Hacking Project.

👉 Consulte la spécialisation DevOps dans la [bibliothèque THP](https://github.com/TheHackingProject/bibliotheque-THP/wiki/liste_sp%C3%A9cialisations)

Cela te permettra d'automatiser tout ton workflow, de gagner un temps précieux, et d'assurer des mises en production propres, traçables et réversibles.

Bon apprentissage, et bienvenue dans le monde du DevOps 👨‍💻✨