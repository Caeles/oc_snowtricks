# Snowtricks

## Description
Snowtricks est une plateforme communautaire de partage de figures de snowboard développée avec Symfony 7. Ce projet permet aux passionnés de snowboard de partager leurs figures préférées, d'échanger des conseils et d'interagir avec la communauté.

## Fonctionnalités
- Gestion des figures de snowboard (tricks) avec catégorisation
- Système de commentaires
- Espace utilisateur avec authentification


## Prérequis
- PHP 8.2 ou supérieur
- MySQL 8.0 ou supérieur
- Serveur web (Apache, Nginx)
- Composer
- Symfony CLI (recommandé)

## Installation

### 1. Cloner le dépôt
```bash
git clone https://github.com/Caeles/snowtricks.git
cd snowtricks
```

### 2. Installer les dépendances
```bash
composer install
```

### 3. Configurer l'environnement
Copiez le fichier `.env` en `.env.local` et configurez les variables d'environnement, notamment la connexion à la base de données :
```bash
DATABASE_URL=mysql://username:password@127.0.0.1:3306/snowtricks
```

### 4. Créer la base de données
```bash
php bin/console doctrine:database:create
php bin/console doctrine:migrations:migrate
```


### 6. Démarrer le serveur
```bash
symfony serve
```

## Accès utilisateur
Pour vous connecter avec un compte de test (si les fixtures sont chargées) :
- Nom Utilisateur: user
- Mot de passe: password

## Licence

MIT License

Copyright (c)