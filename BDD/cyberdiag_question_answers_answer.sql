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
-- Table structure for table `question_answers_answer`
--

DROP TABLE IF EXISTS `question_answers_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_answers_answer` (
  `questionQuestionId` int NOT NULL,
  `answerAnswerId` int NOT NULL,
  PRIMARY KEY (`questionQuestionId`,`answerAnswerId`),
  KEY `IDX_ea6e496d57fcbf081f178ea095` (`questionQuestionId`),
  KEY `IDX_fdf1d1b2f64dd0b5368b0c9a7e` (`answerAnswerId`),
  CONSTRAINT `FK_ea6e496d57fcbf081f178ea0955` FOREIGN KEY (`questionQuestionId`) REFERENCES `question` (`questionId`) ON DELETE CASCADE,
  CONSTRAINT `FK_fdf1d1b2f64dd0b5368b0c9a7e2` FOREIGN KEY (`answerAnswerId`) REFERENCES `answer` (`answerId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_answers_answer`
--

LOCK TABLES `question_answers_answer` WRITE;
/*!40000 ALTER TABLE `question_answers_answer` DISABLE KEYS */;
INSERT INTO `question_answers_answer` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(2,1),(2,2),(2,5),(2,6),(2,11),(3,1),(3,2),(3,8),(3,9),(3,10),(4,1),(4,2),(4,5),(4,6),(4,11),(5,1),(5,2),(5,11),(5,12),(5,14),(6,1),(6,2),(6,11),(6,12),(6,14),(7,1),(7,2),(7,11),(7,13),(7,14),(8,1),(8,2),(8,5),(8,6),(8,14),(9,1),(9,2),(9,15),(9,16),(9,17),(10,1),(10,2),(10,18),(10,19),(11,1),(11,2),(11,20),(11,21),(12,1),(12,2),(12,22),(12,23),(13,1),(13,2),(13,24),(13,25),(13,26),(14,1),(14,2),(14,21),(15,1),(15,2),(15,27),(15,28),(15,29),(16,1),(16,30),(16,31),(16,32),(16,40),(17,1),(17,2),(17,27),(17,28),(17,29),(18,1),(18,2),(18,5),(18,6),(18,14),(19,1),(19,2),(19,33),(19,34),(19,35),(20,1),(20,36),(20,37),(20,38),(20,39),(21,1),(21,36),(21,37),(21,38),(21,39),(22,1),(22,2),(22,21),(23,1),(23,2),(23,3),(24,1),(24,2),(24,3),(25,1),(25,2),(25,3),(26,1),(26,2),(26,3),(27,1),(27,2),(27,3),(27,4),(28,1),(28,2),(28,3),(28,4);
/*!40000 ALTER TABLE `question_answers_answer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-24 10:39:04
