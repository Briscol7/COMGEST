-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le :  mer. 12 fév. 2020 à 11:17
-- Version du serveur :  5.7.23
-- Version de PHP :  7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `COMGEST`
--

-- --------------------------------------------------------

--
-- Structure de la table `BENEFICIAIRE`
--

CREATE TABLE `BENEFICIAIRE` (
  `CODBEN` varchar(50) NOT NULL,
  `NOMBENEF` varchar(100) NOT NULL,
  `ADRESSE_VILLE` varchar(50) NOT NULL,
  `ADRESSE_CONTACT` varchar(30) NOT NULL,
  `ADRESSE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `CIRCFIN`
--

CREATE TABLE `CIRCFIN` (
  `CODECF` int(4) NOT NULL,
  `NOMCF` varchar(50) NOT NULL,
  `NBREPC` int(4) NOT NULL,
  `PCENTRA` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `COMPTE`
--

CREATE TABLE `COMPTE` (
  `NUMCPTE` int(50) NOT NULL,
  `LIBELCPTE` varchar(100) NOT NULL,
  `CODEXE` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `EXERCICE`
--

CREATE TABLE `EXERCICE` (
  `CODEXE` year(4) NOT NULL,
  `NUMEXE` int(4) NOT NULL,
  `Datedebut` date NOT NULL,
  `Datefin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `PERIODCOMPTA`
--

CREATE TABLE `PERIODCOMPTA` (
  `CODEPERD` int(4) NOT NULL,
  `Datedeb` date NOT NULL,
  `Datefin` date NOT NULL,
  `CODEXE` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `PSTCPTE`
--

CREATE TABLE `PSTCPTE` (
  `CODEPC` varchar(5) NOT NULL,
  `NOMPC` varchar(50) NOT NULL,
  `CODECF` int(4) NOT NULL,
  `DEPARTPC` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `TITRES`
--

CREATE TABLE `TITRES` (
  `ORDRE` int(100) DEFAULT NULL,
  `CODEXE` year(4) NOT NULL,
  `CODEPC` varchar(4) NOT NULL,
  `CODEPERD` int(4) NOT NULL,
  `NUMBON` varchar(10) NOT NULL,
  `CODBEN` varchar(100) NOT NULL,
  `MONTPAYE` int(25) NOT NULL,
  `CPTEBUD` int(50) NOT NULL,
  `NUMAUT` varchar(10) DEFAULT NULL,
  `IMPUTBUD` varchar(100) DEFAULT NULL,
  `DATEPAIE` date NOT NULL,
  `DATEVAL` date DEFAULT NULL,
  `INDVAL` varchar(2) DEFAULT NULL,
  `TYPBON` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `BENEFICIAIRE`
--
ALTER TABLE `BENEFICIAIRE`
  ADD PRIMARY KEY (`CODBEN`);

--
-- Index pour la table `CIRCFIN`
--
ALTER TABLE `CIRCFIN`
  ADD PRIMARY KEY (`CODECF`),
  ADD KEY `fk_pstecpte_cirfin` (`PCENTRA`);

--
-- Index pour la table `COMPTE`
--
ALTER TABLE `COMPTE`
  ADD PRIMARY KEY (`NUMCPTE`),
  ADD KEY `fk_cpte_exo` (`CODEXE`);

--
-- Index pour la table `EXERCICE`
--
ALTER TABLE `EXERCICE`
  ADD PRIMARY KEY (`CODEXE`);

--
-- Index pour la table `PERIODCOMPTA`
--
ALTER TABLE `PERIODCOMPTA`
  ADD PRIMARY KEY (`CODEPERD`),
  ADD KEY `fk_periodc_exo` (`CODEXE`);

--
-- Index pour la table `PSTCPTE`
--
ALTER TABLE `PSTCPTE`
  ADD PRIMARY KEY (`CODEPC`),
  ADD KEY `fk_cirfin_pstecpte` (`CODECF`);

--
-- Index pour la table `TITRES`
--
ALTER TABLE `TITRES`
  ADD PRIMARY KEY (`NUMBON`,`CODBEN`,`CODEPC`,`MONTPAYE`,`CPTEBUD`),
  ADD KEY `FK_EXO_TITRES` (`CODEXE`),
  ADD KEY `FK_CPTE_TITRES` (`CPTEBUD`),
  ADD KEY `FK_PSTCPTE_TITRES` (`CODEPC`),
  ADD KEY `FK_PERDCPTE_TITRES` (`CODEPERD`),
  ADD KEY `FK_BENEF_TITRES` (`CODBEN`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `CIRCFIN`
--
ALTER TABLE `CIRCFIN`
  ADD CONSTRAINT `fk_pstecpte_cirfin` FOREIGN KEY (`PCENTRA`) REFERENCES `pstcpte` (`CODEPC`);

--
-- Contraintes pour la table `COMPTE`
--
ALTER TABLE `COMPTE`
  ADD CONSTRAINT `fk_cpte_exo` FOREIGN KEY (`CODEXE`) REFERENCES `EXERCICE` (`CODEXE`);

--
-- Contraintes pour la table `PERIODCOMPTA`
--
ALTER TABLE `PERIODCOMPTA`
  ADD CONSTRAINT `fk_periodc_exo` FOREIGN KEY (`CODEXE`) REFERENCES `EXERCICE` (`CODEXE`);

--
-- Contraintes pour la table `PSTCPTE`
--
ALTER TABLE `PSTCPTE`
  ADD CONSTRAINT `fk_cirfin_pstecpte` FOREIGN KEY (`CODECF`) REFERENCES `CIRCFIN` (`CODECF`);

--
-- Contraintes pour la table `TITRES`
--
ALTER TABLE `TITRES`
  ADD CONSTRAINT `FK_BENEF_TITRES` FOREIGN KEY (`CODBEN`) REFERENCES `BENEFICIAIRE` (`CODBEN`),
  ADD CONSTRAINT `FK_CPTE_TITRES` FOREIGN KEY (`CPTEBUD`) REFERENCES `COMPTE` (`NUMCPTE`),
  ADD CONSTRAINT `FK_EXO_TITRES` FOREIGN KEY (`CODEXE`) REFERENCES `EXERCICE` (`CODEXE`),
  ADD CONSTRAINT `FK_PERDCPTE_TITRES` FOREIGN KEY (`CODEPERD`) REFERENCES `PERIODCOMPTA` (`CODEPERD`),
  ADD CONSTRAINT `FK_PSTCPTE_TITRES` FOREIGN KEY (`CODEPC`) REFERENCES `PSTCPTE` (`CODEPC`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
