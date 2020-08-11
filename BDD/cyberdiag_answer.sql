CREATE DATABASE  IF NOT EXISTS `cyberdiag` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cyberdiag`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: cyberdiag
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `answerId` int NOT NULL AUTO_INCREMENT,
  `answer_title` varchar(50) DEFAULT NULL,
  `answer_quote` int DEFAULT NULL,
  PRIMARY KEY (`answerId`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,'Inconnu',0),(2,'Non',1),(3,'Une fois',2),(4,'Récemment',3),(5,'Régulièrement',5),(6,'Occasionnellement',3),(8,'Matériel portable',2),(9,'Matériel fixe et portable',3),(10,'Tous types de matériels',4),(11,'Peu',2),(12,'En fonction du poste occupé',3),(13,'Partiellement',3),(14,'Systématiquement',4),(15,'Entre 1 et 4 caractères',2),(16,'Entre 4 et 7 caractères',3),(17,'Plus de 8 caractères',4),(18,'Oui mais il n\'est pas mis à jour',2),(19,'Oui mis à jour régulièrement',3),(20,'En partie',2),(21,'Oui',3),(22,'Oui tous les mois',2),(23,'Oui toutes les semaines',3),(24,'Oui mais seulement une partie du réseau',2),(25,'Oui mais pas mis à jour',3),(26,'Oui tout le réseau est mis à jour régulièrement',4),(27,'Tous les ans',2),(28,'Tous les 6 mois',3),(29,'Rappels réguliers',4),(30,'Non / Prestataire externe à temps partiel',1),(31,'Prestataire externe à temps plein',2),(32,'Oui à temps partiel',3),(33,'Oui mais non mis à jour',2),(34,'Oui et mis à jour occasionnellement',3),(35,'Oui et mis à jour régulièrement',4),(36,'>24h',1),(37,'<24h',2),(38,'<12h',3),(39,'<3h',4),(40,'Oui à temps plein',4);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-24 10:39:05
