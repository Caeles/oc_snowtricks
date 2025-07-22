-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 22 juil. 2025 à 14:10
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `snowtricks`
--
CREATE DATABASE IF NOT EXISTS `snowtricks` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `snowtricks`;

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONS POUR LA TABLE `category`:
--

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `name`, `slug`, `createdAt`, `updatedAt`) VALUES
(1, 'Grabs', 'grabs', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(2, 'Rotations', 'rotations', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(3, 'Flips', 'flips', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(4, 'Slides', 'slides', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(5, 'Butters', 'butters', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(6, 'Old School', 'old-school', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(7, 'Jumps', 'jumps', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(8, 'Rails', 'rails', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(9, 'Half-pipe', 'half-pipe', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(10, 'Big Air', 'big-air', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(11, 'Jibbing', 'jibbing', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(12, 'Flatland', 'flatland', '2025-06-04 09:20:48', '2025-06-04 09:20:48');

-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `trick_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONS POUR LA TABLE `comment`:
--

--
-- Déchargement des données de la table `comment`
--

INSERT INTO `comment` (`id`, `trick_id`, `author_id`, `content`, `createdAt`) VALUES
(1, 2, 12, 'This trick is awesome! I\'ve been practicing it for weeks.', '2025-06-04 09:20:48'),
(2, 9, 8, 'Great explanation, helped me understand the technique.', '2025-06-04 09:20:48'),
(3, 4, 4, 'I find this one particularly difficult. Any tips?', '2025-06-04 09:20:48'),
(4, 3, 4, 'Landed this for the first time yesterday! So stoked!', '2025-06-04 09:20:48'),
(5, 6, 9, 'One of my favorite tricks to perform on fresh powder.', '2025-06-04 09:20:48'),
(6, 10, 7, 'The video really helped me understand how to position my body.', '2025-06-04 09:20:48'),
(7, 6, 9, 'I\'m still learning this one, but making progress!', '2025-06-04 09:20:48'),
(8, 6, 5, 'This trick looks so cool when done properly.', '2025-06-04 09:20:48'),
(9, 7, 11, 'How long did it take you to master this?', '2025-06-04 09:20:48'),
(10, 11, 3, 'I prefer the variation where you...', '2025-06-04 09:20:48'),
(11, 6, 12, 'Can\'t wait to try this on my next mountain trip.', '2025-06-04 09:20:48'),
(12, 10, 7, 'This is essential for any serious snowboarder.', '2025-06-04 09:20:48');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- RELATIONS POUR LA TABLE `doctrine_migration_versions`:
--

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `trick_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL COMMENT 'Name of the image file',
  `alt_text` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONS POUR LA TABLE `image`:
--   `trick_id`
--       `trick` -> `id`
--

--
-- Déchargement des données de la table `image`
--

INSERT INTO `image` (`id`, `trick_id`, `filename`, `alt_text`, `createdAt`) VALUES
(1, 1, 'trick_1_1.jpg', 'Trick 1 Image 1', '2025-06-04 09:20:48'),
(2, 1, 'trick_1_2.jpg', 'Trick 1 Image 2', '2025-06-04 09:20:48'),
(3, 3, 'trick_3_1.jpg', 'Trick 3 Image 1', '2025-06-04 09:20:48'),
(4, 3, 'trick_3_2.jpg', 'Trick 3 Image 2', '2025-06-04 09:20:48'),
(5, 2, 'trick_2_1.jpg', 'Trick 2 Image 1', '2025-06-04 09:20:48'),
(6, 2, 'trick_2_2.jpg', 'Trick 2 Image 2', '2025-06-04 09:20:48'),
(7, 4, 'trick_4_1.jpg', 'Trick 4 Image 1', '2025-06-04 09:20:48'),
(8, 4, 'trick_4_2.jpg', 'Trick 4 Image 2', '2025-06-04 09:20:48'),
(9, 5, 'trick_5_1.jpg', 'Trick 5 Image 1', '2025-06-04 09:20:48'),
(10, 5, 'trick_5_2.jpg', 'Trick 5 Image 2', '2025-06-04 09:20:48'),
(11, 6, 'trick_6_1.jpg', 'Trick 6 Image 1', '2025-06-04 09:20:48'),
(12, 6, 'trick_6_2.jpg', 'Trick 6 Image 2', '2025-06-04 09:20:48'),
(13, 7, 'trick_7_1.jpg', 'Trick 7 Image 1', '2025-06-04 09:20:48'),
(14, 7, 'trick_7_2.jpg', 'Trick 7 Image 2', '2025-06-04 09:20:48'),
(15, 8, 'trick_8_1.jpg', 'Trick 8 Image 1', '2025-06-04 09:20:48'),
(16, 8, 'trick_8_2.jpg', 'Trick 8 Image 2', '2025-06-04 09:20:48'),
(17, 9, 'trick_9_1.jpg', 'Trick 9 Image 1', '2025-06-04 09:20:48'),
(18, 9, 'trick_9_2.jpg', 'Trick 9 Image 2', '2025-06-04 09:20:48'),
(19, 10, 'trick_10_1.jpg', 'Trick 10 Image 1', '2025-06-04 09:20:48'),
(20, 10, 'trick_10_2.jpg', 'Trick 10 Image 2', '2025-06-04 09:20:48'),
(21, 11, 'trick_11_1.jpg', 'Trick 11 Image 1', '2025-06-04 09:20:48'),
(22, 11, 'trick_11_2.jpg', 'Trick 11 Image 2', '2025-06-04 09:20:48');

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONS POUR LA TABLE `messenger_messages`:
--

-- --------------------------------------------------------

--
-- Structure de la table `reset_password`
--

CREATE TABLE `reset_password` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expired_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONS POUR LA TABLE `reset_password`:
--   `user_id`
--       `user` -> `id`
--

-- --------------------------------------------------------

--
-- Structure de la table `trick`
--

CREATE TABLE `trick` (
  `id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONS POUR LA TABLE `trick`:
--

--
-- Déchargement des données de la table `trick`
--

INSERT INTO `trick` (`id`, `author_id`, `category_id`, `title`, `slug`, `description`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 'Indy Grab', 'indy-grab', 'Un grab Indy consiste pour le rider à attraper la carre avant de la planche entre les fixations avec la main arrière.', '2025-06-04 09:20:48', '2025-07-20 01:36:00'),
(2, 2, 1, 'Mute Grab', 'mute-grab', 'Un grab Indy consiste pour le rider à attraper la carre avant de la planche entre les fixations avec la main arrière.', '2025-06-04 09:20:48', '2025-07-20 01:56:27'),
(3, 1, 2, '360', '360-rotation', 'Un 360 est une rotation complète où le rider effectue un tour de 360 degrés en l’air.\r\n', '2025-06-04 09:20:48', '2025-07-20 01:57:07'),
(4, 3, 2, '540', '540-rotation', 'Un 540 correspond à une rotation d’un tour et demi, où le rider effectue 540 degrés de rotation en l’air.', '2025-06-04 09:20:48', '2025-07-20 01:57:24'),
(5, 4, 3, 'Backflip', 'backflip', 'Un backflip est une figure où le rider effectue un salto arrière en l’air.\r\n', '2025-06-04 09:20:48', '2025-07-20 01:57:54'),
(6, 5, 3, 'Frontflip', 'frontflip', 'Un frontflip est une figure où le rider effectue un salto avant en l’air.\r\n', '2025-06-04 09:20:48', '2025-07-20 01:58:10'),
(7, 6, 4, 'Boardslide', 'boardslide', 'Un boardslide est une figure où le rider glisse le long d’un rail ou d’un module avec la planche perpendiculaire à l’obstacle.\r\n', '2025-06-04 09:20:48', '2025-07-20 01:58:29'),
(8, 7, 5, 'Nose Butter', 'nose-butter', 'Un nose butter est une figure où le rider appuie sur l’avant de la planche (le nose) et effectue une rotation tout en restant en contact avec la neige.\r\n', '2025-06-04 09:20:48', '2025-07-20 01:58:46'),
(9, 8, 6, 'Method Air', 'method-air', 'Le Method Air est une figure classique de snowboard où le rider attrape la carre arrière de la planche derrière le pied arrière tout en s’étendant et en fléchissant les genoux.\r\n', '2025-06-04 09:20:48', '2025-07-20 01:59:02'),
(10, 9, 7, 'Ollie', 'ollie', 'Un ollie est un saut de base où le rider décolle en prenant appui sur l’arrière de la planche (le tail), sans utiliser de tremplin.\r\n', '2025-06-04 09:20:48', '2025-07-20 01:59:20'),
(11, 10, 8, '50-50', '50-50', 'Un 50-50 est une figure où le rider glisse le long d’un rail ou d’un module avec la planche parallèle à l’obstacle.\r\n', '2025-06-04 09:20:48', '2025-07-20 01:59:36');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(180) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`roles`)),
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONS POUR LA TABLE `user`:
--

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `avatar`, `roles`, `createdAt`, `updatedAt`) VALUES
(1, 'admin', 'admin@snowtricks.com', '$2y$13$0uGmDSrFizlLime4JADzDeU2U1mK5CYWh2VDx3TsjxxVoYeu/S0Ie', 'avatar.jpeg', '[\"ROLE_ADMIN\",\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(2, 'johndoe', 'john@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(3, 'janedoe', 'jane@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(4, 'mikebrown', 'mike@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(5, 'sarahwilson', 'sarah@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(6, 'alexjohnson', 'alex@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(7, 'emmathomas', 'emma@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(8, 'jacksonlee', 'jackson@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(9, 'oliviakim', 'olivia@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(10, 'liamharris', 'liam@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(11, 'sophiachen', 'sophia@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(12, 'noahgarcia', 'noah@example.com', '$2y$12$1famfEXPMoGqYonylolZYOIU.1aZ0I/QrCETWLzvkBawMOWgCBTdi', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-04 09:20:48', '2025-06-04 09:20:48'),
(17, 'test', 'test@example.com', '$2y$13$BAexozhCclSLZCLeZwt1BeJhycemaLfW6cO7EJHd4ou1kFgVx5ICu', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-06-24 11:31:36', '2025-06-24 11:31:36'),
(25, 'user', 'user@snowtricks.com', '$2y$13$OfKgGOZPuacTMZrTnn90AOegEcZJR0BRIWRvQuI8pWGIT1N2IJoVa', 'avatar.jpeg', '[\"ROLE_USER\"]', '2025-07-21 22:36:03', '2025-07-21 22:36:03');

-- --------------------------------------------------------

--
-- Structure de la table `video`
--

CREATE TABLE `video` (
  `id` int(11) NOT NULL,
  `trick_id` int(11) NOT NULL,
  `url` varchar(500) NOT NULL COMMENT 'URL to the video (e.g., YouTube, Vimeo)',
  `platform` varchar(50) DEFAULT NULL COMMENT 'e.g., youtube, vimeo',
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONS POUR LA TABLE `video`:
--   `trick_id`
--       `trick` -> `id`
--

--
-- Déchargement des données de la table `video`
--

INSERT INTO `video` (`id`, `trick_id`, `url`, `platform`, `createdAt`) VALUES
(1, 1, 'https://www.youtube.com/embed/dQw4w9WgXcQ', 'youtube', '2025-06-04 09:20:48'),
(2, 2, 'https://www.youtube.com/embed/jofNR_WkoCE', 'youtube', '2025-06-04 09:20:48'),
(3, 3, 'https://www.youtube.com/embed/gzlBF-aSbBg', 'youtube', '2025-06-04 09:20:48'),
(4, 4, 'https://www.youtube.com/embed/6Fb3OYYN_bo', 'youtube', '2025-06-04 09:20:48'),
(5, 5, 'https://www.youtube.com/embed/M-aGPniFvS0', 'youtube', '2025-06-04 09:20:48'),
(6, 6, 'https://www.youtube.com/embed/QlmJCKxpjfM', 'youtube', '2025-06-04 09:20:48'),
(7, 7, 'https://www.youtube.com/embed/rT-7TwWPDFw', 'youtube', '2025-06-04 09:20:48'),
(8, 8, 'https://www.youtube.com/embed/uQZzqwJIRdI', 'youtube', '2025-06-04 09:20:48'),
(9, 9, 'https://www.youtube.com/embed/6yA3XqjTh_w', 'youtube', '2025-06-04 09:20:48'),
(10, 10, 'https://www.youtube.com/embed/JU7C8OumNF4', 'youtube', '2025-06-04 09:20:48'),
(11, 11, 'https://www.youtube.com/embed/1TJ08caetkw', 'youtube', '2025-06-04 09:20:48');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_comment_trick` (`trick_id`),
  ADD KEY `idx_comment_author` (`author_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_image_trick` (`trick_id`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Index pour la table `reset_password`
--
ALTER TABLE `reset_password`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_B9983CE5A76ED395` (`user_id`);

--
-- Index pour la table `trick`
--
ALTER TABLE `trick`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_trick_author` (`author_id`),
  ADD KEY `idx_trick_category` (`category_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649F85E0677` (`username`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- Index pour la table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_video_trick` (`trick_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `image`
--
ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reset_password`
--
ALTER TABLE `reset_password`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `trick`
--
ALTER TABLE `trick`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `video`
--
ALTER TABLE `video`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `fk_image_trick` FOREIGN KEY (`trick_id`) REFERENCES `trick` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reset_password`
--
ALTER TABLE `reset_password`
  ADD CONSTRAINT `FK_B9983CE5A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `fk_video_trick` FOREIGN KEY (`trick_id`) REFERENCES `trick` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
