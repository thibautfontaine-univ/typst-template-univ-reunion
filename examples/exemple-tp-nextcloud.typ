// TP - Déploiement de Nextcloud avec Docker Compose

#import "../template/template-univ-reunion.typ": *

// =============================================================================
// PAGE DE COUVERTURE
// =============================================================================

#page-couverture(
  logo-univ: "../img/UR_LOGO_2025_BLEU.jpg",
  logo-composante: "../img/logo-IUT-departements_RT.png",
  titre: "Déploiement de Nextcloud avec Docker Compose",
  sous-titre: "Mise en place d'un cloud privé conteneurisé",
  type-document: "TP - Administration Système",
  auteurs: (
    "Thibaut Fontaine",
  ),
  encadrants: (
    "Thalia Fontaine",
  ),
  formation: "BUT 3 Réseaux & Télécoms",
  annee-universitaire: "2025-2026",
  date: "Décembre 2025",
  style: "minimaliste",
)

// =============================================================================
// CONFIGURATION DU DOCUMENT
// =============================================================================

#show: univ-report.with(
  titre: "TP - Déploiement Nextcloud Docker",
  auteurs: ("John Doe",),
  date: datetime.today(),
  lang: "fr",
  toc: true,
)

// =============================================================================
// INTRODUCTION
// =============================================================================

= Introduction

== Objectifs du TP

Ce TP a pour objectif de déployer une instance Nextcloud fonctionnelle en utilisant Docker Compose. Nextcloud est une solution de cloud privé open source permettant le stockage et le partage de fichiers.

À l'issue de ce TP, vous serez capable de :
- Comprendre l'architecture d'une application multi-conteneurs
- Rédiger un fichier `docker-compose.yml`
- Configurer les volumes persistants
- Mettre en place un reverse proxy avec Traefik
- Sécuriser l'accès avec HTTPS

== Prérequis

- Docker et Docker Compose installés
- Connaissances de base en Linux
- Un nom de domaine (ou utilisation de `localhost`)

== Architecture cible

```
┌─────────────────────────────────────────────────────────┐
│                      Internet                            │
└────────────────────────┬────────────────────────────────┘
                         │ :443 (HTTPS)
                         ▼
┌─────────────────────────────────────────────────────────┐
│                 Traefik (Reverse Proxy)                  │
│                    Port 80/443                           │
└────────────────────────┬────────────────────────────────┘
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
     ┌─────────┐   ┌──────────┐   ┌──────────┐
     │Nextcloud│   │ MariaDB  │   │  Redis   │
     │  :80    │   │  :3306   │   │  :6379   │
     └─────────┘   └──────────┘   └──────────┘
```

// =============================================================================
// PRÉPARATION
// =============================================================================

= Préparation de l'environnement

== Création de l'arborescence

Créez la structure de répertoires pour le projet :

```bash
mkdir -p ~/nextcloud-docker/{data,db,redis}
cd ~/nextcloud-docker
```

== Vérification de Docker

Vérifiez que Docker est correctement installé :

```bash
docker --version
# Docker version 24.0.7, build afdd53b

docker compose version
# Docker Compose version v2.23.0
```

== Création du réseau Docker

Créez un réseau dédié pour l'application :

```bash
docker network create nextcloud-network
```

// =============================================================================
// CONFIGURATION
// =============================================================================

= Configuration Docker Compose

== Fichier docker-compose.yml

Créez le fichier `docker-compose.yml` :

```yaml
version: '3.8'

services:
  # Base de données MariaDB
  db:
    image: mariadb:10.11
    container_name: nextcloud-db
    restart: unless-stopped
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    volumes:
      - ./db:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_PASSWORD=${DB_PASSWORD}
    networks:
      - nextcloud-network

  # Cache Redis
  redis:
    image: redis:7-alpine
    container_name: nextcloud-redis
    restart: unless-stopped
    command: redis-server --requirepass ${REDIS_PASSWORD}
    volumes:
      - ./redis:/data
    networks:
      - nextcloud-network

  # Application Nextcloud
  app:
    image: nextcloud:28-apache
    container_name: nextcloud-app
    restart: unless-stopped
    depends_on:
      - db
      - redis
    volumes:
      - ./data:/var/www/html
    environment:
      - MYSQL_HOST=db
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
      - MYSQL_PASSWORD=${DB_PASSWORD}
      - REDIS_HOST=redis
      - REDIS_HOST_PASSWORD=${REDIS_PASSWORD}
      - NEXTCLOUD_ADMIN_USER=${ADMIN_USER}
      - NEXTCLOUD_ADMIN_PASSWORD=${ADMIN_PASSWORD}
      - NEXTCLOUD_TRUSTED_DOMAINS=${DOMAIN}
      - OVERWRITEPROTOCOL=https
    networks:
      - nextcloud-network
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.nextcloud.rule=Host(`${DOMAIN}`)"
      - "traefik.http.routers.nextcloud.entrypoints=websecure"
      - "traefik.http.routers.nextcloud.tls.certresolver=letsencrypt"
      - "traefik.http.services.nextcloud.loadbalancer.server.port=80"

  # Reverse Proxy Traefik
  traefik:
    image: traefik:v2.10
    container_name: nextcloud-traefik
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./traefik/acme.json:/acme.json
      - ./traefik/traefik.yml:/traefik.yml:ro
    networks:
      - nextcloud-network

networks:
  nextcloud-network:
    external: true
```

== Fichier d'environnement

Créez le fichier `.env` pour les variables sensibles :

```bash
# .env
DB_ROOT_PASSWORD=ChangeMe974!
DB_PASSWORD=ChangeMe974Nextcloud!
REDIS_PASSWORD=ChangeMe974
ADMIN_USER=admin
ADMIN_PASSWORD=ChangeMe974
DOMAIN=nextcloud.example.com
```

#info-box(title: "Sécurité", type: "warning")[
  Ne jamais commiter le fichier `.env` dans un dépôt Git. Ajoutez-le au `.gitignore`.
]

== Configuration Traefik

Créez le répertoire et le fichier de configuration Traefik :

```bash
mkdir -p traefik
touch traefik/acme.json
chmod 600 traefik/acme.json
```

Créez `traefik/traefik.yml` :

```yaml
api:
  dashboard: true

entryPoints:
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https

  websecure:
    address: ":443"

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
    network: nextcloud-network

certificatesResolvers:
  letsencrypt:
    acme:
      email: admin@example.com
      storage: /acme.json
      httpChallenge:
        entryPoint: web
```

// =============================================================================
// DÉPLOIEMENT
// =============================================================================

= Déploiement

== Lancement des conteneurs

Démarrez l'ensemble des services :

```bash
docker compose up -d
```

Vérifiez que tous les conteneurs sont en cours d'exécution :

```bash
docker compose ps
```

Résultat attendu :

```
NAME                STATUS              PORTS
nextcloud-app       Up                  80/tcp
nextcloud-db        Up                  3306/tcp
nextcloud-redis     Up                  6379/tcp
nextcloud-traefik   Up                  0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp
```

== Vérification des logs

Surveillez les logs pour détecter d'éventuelles erreurs :

```bash
# Logs de tous les services
docker compose logs -f

# Logs d'un service spécifique
docker compose logs -f app
```

== Accès à l'interface

Accédez à Nextcloud via votre navigateur :
- URL : `https://nextcloud.example.com`
- Utilisateur : `admin`
- Mot de passe : celui défini dans `.env`

// =============================================================================
// CONFIGURATION AVANCÉE
// =============================================================================

= Configuration avancée

== Optimisation des performances

=== Configuration PHP

Créez un fichier de configuration PHP personnalisé :

```bash
mkdir -p config
```

Créez `config/php.ini` :

```ini
; config/php.ini
memory_limit = 512M
upload_max_filesize = 10G
post_max_size = 10G
max_execution_time = 3600
max_input_time = 3600
```

Ajoutez le volume dans `docker-compose.yml` :

```yaml
app:
  volumes:
    - ./data:/var/www/html
    - ./config/php.ini:/usr/local/etc/php/conf.d/custom.ini:ro
```

=== Configuration du cache

Éditez la configuration Nextcloud pour optimiser le cache :

```bash
docker exec -u www-data nextcloud-app php occ config:system:set \
  memcache.local --value="\OC\Memcache\APCu"

docker exec -u www-data nextcloud-app php occ config:system:set \
  memcache.distributed --value="\OC\Memcache\Redis"

docker exec -u www-data nextcloud-app php occ config:system:set \
  memcache.locking --value="\OC\Memcache\Redis"
```

== Tâches planifiées (Cron)

Configurez les tâches de fond via cron :

```bash
docker exec -u www-data nextcloud-app php occ background:cron
```

Ajoutez un service cron dans `docker-compose.yml` :

```yaml
cron:
  image: nextcloud:28-apache
  container_name: nextcloud-cron
  restart: unless-stopped
  depends_on:
    - app
  volumes:
    - ./data:/var/www/html
  entrypoint: /cron.sh
  networks:
    - nextcloud-network
```

== Sauvegarde

=== Script de sauvegarde

Créez un script `backup.sh` :

```bash
#!/bin/bash
# backup.sh

BACKUP_DIR="/backup/nextcloud"
DATE=$(date +%Y%m%d_%H%M%S)

# Création du répertoire de backup
mkdir -p $BACKUP_DIR

# Mise en maintenance
docker exec -u www-data nextcloud-app php occ maintenance:mode --on

# Sauvegarde de la base de données
docker exec nextcloud-db mysqldump -u root -p$DB_ROOT_PASSWORD \
  nextcloud > $BACKUP_DIR/db_$DATE.sql

# Sauvegarde des données
tar -czf $BACKUP_DIR/data_$DATE.tar.gz ./data

# Fin de maintenance
docker exec -u www-data nextcloud-app php occ maintenance:mode --off

echo "Sauvegarde terminée : $DATE"
```

Rendez le script exécutable :

```bash
chmod +x backup.sh
```

// =============================================================================
// VÉRIFICATION
// =============================================================================

= Vérification et tests

== Tests fonctionnels

#figure(
  table(
    columns: 3,
    [*Test*], [*Commande/Action*], [*Résultat attendu*],
    [Accès HTTPS], [Navigateur], [Page de connexion],
    [Connexion admin], [Login], [Dashboard Nextcloud],
    [Upload fichier], [Glisser-déposer], [Fichier visible],
    [Partage], [Bouton partager], [Lien généré],
    [Sync client], [Client desktop], [Synchronisation OK],
  ),
  caption: [Checklist des tests fonctionnels],
)

== Vérification de la santé

```bash
# État des conteneurs
docker compose ps

# Utilisation des ressources
docker stats --no-stream

# Espace disque des volumes
du -sh data/ db/ redis/
```

== Scan de sécurité Nextcloud

Utilisez le scan intégré de Nextcloud :

```bash
docker exec -u www-data nextcloud-app php occ security:scan
```

Vérifiez également via l'interface d'administration :
- Paramètres > Administration > Vue d'ensemble
- Section "Avertissements de sécurité et configuration"

// =============================================================================
// DÉPANNAGE
// =============================================================================

= Dépannage

== Problèmes courants

=== Erreur de permissions

```bash
# Corriger les permissions des données
docker exec nextcloud-app chown -R www-data:www-data /var/www/html
```

=== Base de données inaccessible

```bash
# Vérifier la connectivité
docker exec nextcloud-app ping -c 3 db

# Vérifier les logs MariaDB
docker compose logs db
```

=== Certificat SSL invalide

```bash
# Vérifier le fichier acme.json
cat traefik/acme.json | jq .

# Régénérer le certificat
rm traefik/acme.json
touch traefik/acme.json
chmod 600 traefik/acme.json
docker compose restart traefik
```

== Commandes utiles

#figure(
  table(
    columns: 2,
    [*Action*], [*Commande*],
    [Redémarrer], [`docker compose restart`],
    [Arrêter], [`docker compose down`],
    [Supprimer tout], [`docker compose down -v`],
    [Shell Nextcloud], [`docker exec -it nextcloud-app bash`],
    [Console OCC], [`docker exec -u www-data nextcloud-app php occ`],
    [Logs temps réel], [`docker compose logs -f`],
  ),
  caption: [Commandes Docker Compose utiles],
)

// =============================================================================
// CONCLUSION
// =============================================================================

= Conclusion

Ce TP nous a permis de déployer une instance Nextcloud complète et sécurisée avec :

- *Base de données MariaDB* pour le stockage des métadonnées
- *Cache Redis* pour l'amélioration des performances
- *Reverse proxy Traefik* avec certificat SSL automatique
- *Volumes persistants* pour la sauvegarde des données

== Points clés à retenir

+ Docker Compose simplifie le déploiement d'applications multi-conteneurs
+ Les variables d'environnement permettent de sécuriser les secrets
+ Traefik gère automatiquement les certificats Let's Encrypt
+ Les sauvegardes régulières sont essentielles en production

== Pour aller plus loin

- Mettre en place la haute disponibilité avec un cluster
- Configurer la réplication de la base de données
- Intégrer un système de monitoring (Prometheus/Grafana)
- Automatiser les sauvegardes avec un cron job

// =============================================================================
// PAGE DE GARDE FINALE
// =============================================================================

#page-garde-finale(
  logo-gauche: "../img/UR_LOGO_2025_BLEU.jpg",
  logo-centre: "../img/logo-IUT-departements_RT.png",
  logo-droite: "../img/MESRE_RVB.png",
  nom: "John Doe",
  email: "john.doe@etudiant.univ-reunion.fr",
  telephone: "+262 6 92 XX XX XX",
  adresse: "IUT de La Réunion - 40 avenue de Soweto, 97410 Saint-Pierre",
)
