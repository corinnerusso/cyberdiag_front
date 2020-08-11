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
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `questionId` int NOT NULL AUTO_INCREMENT,
  `question_title` varchar(500) DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  `topicTopicId` int DEFAULT NULL,
  `questionNumber` int DEFAULT NULL,
  PRIMARY KEY (`questionId`),
  KEY `FK_35093d312e4e1b39eefd54d7c7f` (`topicTopicId`),
  CONSTRAINT `FK_35093d312e4e1b39eefd54d7c7f` FOREIGN KEY (`topicTopicId`) REFERENCES `topic` (`topicId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'Avez-vous, un jour, procédé à un audit de sécurité du système d\'information de votre entreprise par une entreprise externe ?','Des audits de sécurité permettent de détecter les éléments dangereux et les corrigés rapidement. L\'audit doit être fait par une entreprise externe pour être avoir un résultat le plus neutre possible.',1,1),(2,'Avez-vous procédé à un inventaire des OS & logiciels, installés sur le matériel fixe et portable de l\'entreprise ?','Connaître les programmes installés sur les ordinateurs et machines permet de limiter l\'installation de nouveaux programmes et l\'oublie de renouvellement de licences.',1,2),(3,'Votre matériel informatique fixe et portable est-il équipé de logiciels de sécurité (antivirus, firewall, etc.) ?','Les matériaux informatiques doivent être obligatoirement équipés de logiciels de sécurité sous peine d\'être contaminé très rapidement.',1,3),(4,'Les logiciels détenus par l\'entreprise sont-ils mis à jour ?','Les logiciels non mis à jour possèdent souvent des failles de sécurité.',1,4),(5,'Avez-vous mis en place une charte d\'utilisation du système d\'information et de communication, et/ou une clause de reconnaissance de responsabilité, pour l\'usage d\'internet et d\'intranet, des matériels informatiques et des logiciels de l\'entreprise, signée par chaque salarié ?',NULL,1,5),(6,'Avez-vous mis en place une politique d\'attribution et de gestion des droits d\'utilisation du Système d\'Information en fonction des besoins de chaque salarié ?',NULL,1,6),(7,'Avez-vous une réglementation pour l’installation de tout nouveau matériel ou logiciel sur les ordinateurs fixes et mobiles de l’entreprise ?',NULL,1,7),(8,'Avez-vous mis en œuvre une procédure d\'authentification (identification par login & mot de passe) du personnel pour accéder au système d\'information ?',NULL,1,8),(9,'Les mots de passe utilisés pour accéder au matériel informatique de l\'entreprise sont-ils une combinaison de chiffres ou bien de lettres et de caractères spéciaux ?',NULL,1,9),(10,'Présence d\'un pare-feu ?','Un pare-feu est un outil indispensable pour la sécurité de votre réseau. L\'essentiel des menaces peut être bloqué grâce à cet outil performant. Il doit néanmoins être bien configuré pour être efficace.',2,10),(11,'Les appareils importants sont-ils reliés à un onduleur ?','Les onduleurs permettent de gérer les coupures de courant et des orages. Ils assurent les fonctionnalités des appareils reliés.',2,11),(12,'La baie serveur est-elle nettoyée ?','La baie de brassage est un goulot d\'étranglement et peut paralyser pendant plusieurs heures votre réseau en cas de dysfonctionnement. La saleté essouffle les ventilateurs et risque de ralentir vos appareils.',2,12),(13,'Existe-t-il un plan réseau ?','Un mapping réseau est dangereux car il montre tous les équipements réseau avec leurs adresses ip. Néanmoins il est très utile pour gérer un réseau ou pour une reprise rapide en cas de défaillance.',2,13),(14,'Les serveurs et autres appareils sont-ils dans des locaux sécurisés ?','Les éléments importants de votre réseau doivent être protégés par des locaux sécurisés (Climatiseur, détection incendie, fermé à clé, etc.).',2,14),(15,'Les salariés ont-ils été sensibilisés et/ou formés sur la confidentialité qu\'ils doivent accorder à leurs login et mots de passe ?',NULL,3,15),(16,'Existe-t-il un Responsable de la Sécurité des Systèmes d\'Information (RSSI), désigné ou recruté ?',NULL,3,16),(17,'Le personnel est-il sensibilisé aux règles élémentaires en matière de sécurité informatique (fermeture de session, mails frauduleux, etc.) ?',NULL,3,17),(18,'Vos collaborateurs sont-ils sensibilisés aux conséquences de pertes / vols / destructions de données ?',NULL,3,18),(19,'Avez-vous élaboré un Plan de Continuité d’Activité (PCA) et un plan de reprise d’activité régulièrement testés ?','Le plan de reprise et le plan d\'action permettent lors d\'un bug ou d\'une attaque de reprendre une activité normale en un minimum de temps.',4,19),(20,'Délai estimé pour reprendre les activités après une attaque informatique ou autre perte/corruption de données',NULL,4,20),(21,'Temps durant lequel l’entreprise aura cessé son activité du fait d’un arrêt du système informatique entraînant des conséquences graves pour sa pérennité et son développement ?',NULL,4,21),(22,'Un plan de sauvegarde est-il formalisé et mis à jour régulièrement ?',NULL,4,22),(23,'Question 1 sujet 1',NULL,5,1),(24,'Question 2 sujet 1',NULL,5,2),(25,'Question 1 sujet 2',NULL,6,3),(26,'Question 2 sujet 2',NULL,6,4),(27,'Question 1 sujet 3','commentaires',7,5),(28,'Question 2 sujet 3','commentaires',7,6);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
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
