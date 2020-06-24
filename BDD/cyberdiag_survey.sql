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
-- Table structure for table `survey`
--

DROP TABLE IF EXISTS `survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `survey` (
  `id` int NOT NULL AUTO_INCREMENT,
  `survey_title` varchar(250) DEFAULT NULL,
  `client_name` varchar(50) DEFAULT NULL,
  `survey_creation_date` date DEFAULT NULL,
  `companyCompanyId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `has_a_survey` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_a3e7ffc7c5dc4ca238f4f068856` (`companyCompanyId`),
  KEY `FK_5963e1aea20c3c7c2108849c08a` (`userId`),
  CONSTRAINT `FK_5963e1aea20c3c7c2108849c08a` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_a3e7ffc7c5dc4ca238f4f068856` FOREIGN KEY (`companyCompanyId`) REFERENCES `company` (`companyId`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey`
--

LOCK TABLES `survey` WRITE;
/*!40000 ALTER TABLE `survey` DISABLE KEYS */;
INSERT INTO `survey` VALUES (37,'questionnaire 6','client','2020-05-12',1,NULL,0),(52,'test','1','2020-05-19',1,NULL,0),(53,'test','2','2020-05-19',2,NULL,0),(54,'jean','9','2020-05-19',1,NULL,0),(55,'bernard','8','2020-05-19',1,NULL,0),(56,'questionnaire','chrome','2020-05-22',1,NULL,0),(60,'pierre','4','2020-06-01',1,NULL,0),(61,'Questionnaire Bernard','Bernard','2020-06-02',1,NULL,0),(110,'aaa','aaa','2020-06-05',1,NULL,0),(112,'questionnaire 3','Ron','2020-06-08',1,17,1),(133,NULL,NULL,NULL,NULL,17,0),(134,NULL,NULL,NULL,NULL,NULL,0),(136,'questionnaire 1','Albus','2020-06-09',1,18,1),(137,'mmm','mmm','2020-06-09',1,17,1),(138,'hhh','hhh','2020-06-10',1,17,1),(144,'questionnaire George','George2','2020-06-11',1,20,1),(146,'ggg','ggg','2020-06-11',1,17,1),(147,'fff','fff','2020-06-12',1,17,1),(148,'lalala','lalala','2020-06-15',1,17,1),(154,'Survey 1','User','2020-06-16',1,27,1),(155,'Survey 2','','2020-06-16',1,27,1),(165,'ESSAI','','2020-06-18',1,27,1),(184,'test','','2020-06-23',2,27,1),(188,'mmm','','2020-06-30',1,27,0);
/*!40000 ALTER TABLE `survey` ENABLE KEYS */;
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
