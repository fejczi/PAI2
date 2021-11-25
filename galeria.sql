-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 24 Lis 2021, 21:37
-- Wersja serwera: 10.4.14-MariaDB
-- Wersja PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `galeria`
--

-- --------------------------------------------------------


CREATE TABLE `user` (
  `ID_user` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf16_polish_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `password` text COLLATE utf16_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_polish_ci;


CREATE TABLE `album` (
  `ID_album` int(11) NOT NULL AUTO_INCREMENT,
  `album_name` varchar(50) COLLATE utf16_polish_ci NOT NULL,
  `creator_id` int(11) NOT NULL,
  `description` text COLLATE utf16_polish_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_edited` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_album`),
  UNIQUE KEY (`ID_album`),
  FOREIGN KEY (`creator_id`) REFERENCES user(`ID_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `comment`
--

CREATE TABLE `comment` (
  `ID_comment` int(11) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) NOT NULL,
  `contents` text COLLATE utf16_polish_ci NOT NULL,
  `date_posted` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_comment`),
  UNIQUE KEY (`ID_comment`),
  FOREIGN KEY (`creator_id`) REFERENCES user(`ID_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `image`
--

CREATE TABLE `image` (
  `ID_image` int(11) NOT NULL AUTO_INCREMENT,
  `image_name` varchar(50) COLLATE utf16_polish_ci NOT NULL,
  `uploader_id` int(11) NOT NULL,
  `description` text COLLATE utf16_polish_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_edited` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID_image``),
  UNIQUE KEY (`ID_image`),
  FOREIGN KEY (`uploader_id`) REFERENCES user(`ID_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tag`
--

CREATE TABLE `tag` (
  `ID_tag` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf16_polish_ci NOT NULL,
  PRIMARY KEY (`ID_tag`),
  UNIQUE KEY (`ID_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tag_photo`
--

CREATE TABLE `tag_photo` (
  `ID_tag_photo` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL,
  PRIMARY KEY (`ID_tag_photo`),
  UNIQUE KEY (`ID_tag_photo`),
  FOREIGN KEY (`tag_id`) REFERENCES tag(`ID_tag`),
  FOREIGN KEY (`photo_id`) REFERENCES image(`ID_image`),
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_polish_ci;

-- --------------------------------------------------------

--
-- Ograniczenia dla tabeli `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`ID_user`);

--
-- Ograniczenia dla tabeli `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `image_ibfk_1` FOREIGN KEY (`uploader_id`) REFERENCES `user` (`ID_user`);

--
-- Ograniczenia dla tabeli `tag_photo`
--
ALTER TABLE `tag_photo`
  ADD CONSTRAINT `tag_photo_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`ID_tag`),
  ADD CONSTRAINT `tag_photo_ibfk_2` FOREIGN KEY (`photo_id`) REFERENCES `image` (`ID_image`);

--
-- Ograniczenia dla tabeli `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`ID_user`) REFERENCES `album` (`creator_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
