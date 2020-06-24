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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `legal_terms` tinyint NOT NULL DEFAULT '0',
  `lastname` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `user_creation_date` date DEFAULT NULL,
  `cie_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `is_admin` int NOT NULL DEFAULT '0',
  `role` enum('ghost','user','admin') NOT NULL DEFAULT 'ghost',
  `activated` tinyint NOT NULL DEFAULT '0',
  `connected` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('ron@mail.com','$argon2i$v=19$m=4096,t=3,p=1$8glu1lJnM5xnRtZGDgW+9Q$YO705I+m9bc8wzp9W6n3BHuUZMDyMejksPLQQKiLS2E',1,'Wensley','Ron','2020-06-05','Poudlard','0000000000','add comments',17,0,'user',1,0),('albus@mail.com','$argon2i$v=19$m=4096,t=3,p=1$Ehzr+aDvbon9GdnyrNuWVw$eipWxRgbFjdbfggvg8uQwmGEoAFGOKQ19BPed3n4pSY',1,'Albus','Dumbledore','2020-06-09','Poudlard','0000000000',NULL,18,0,'user',1,0),('george@mail.com','$argon2i$v=19$m=4096,t=3,p=1$XsFhHQUbE54D4jjOcnXjqg$EYSDhfO57djY4A5hsJuUxX5qFHzm+4IIM+BiX0eNf1U',1,'Wensley','George','2020-06-11','POUDLARD','0000000000',NULL,20,0,'user',1,0),('bernard.roussely@cyberens.fr','$argon2i$v=19$m=4096,t=3,p=1$quHs9CKlNzbZY9/X2dXbpg$E8M9IaEfbBeM391XVnvZJoCYSqaxRngu3rycQFkBtn8',1,'Roussely','Bernard','2020-06-15','CYBERENS','0601741354','comments',23,1,'admin',1,0),('admin@mail.com','$argon2i$v=19$m=4096,t=3,p=1$We2pP8YkYQoFHMXJ3ByEsw$lzGO3uUEXwrRgxc3O5ii01/ut6QmjpjuKmCnqKl4bWQ',1,'admin','Admin','2020-06-15','NONE','0987654567',NULL,25,1,'admin',1,0),('user@mail.com','$argon2i$v=19$m=4096,t=3,p=1$N+TJlBksptKUaTbp3j4xXQ$sDB3MalflNQjmr9W/4HQv8TzqfA0ZeVR+n350a5z5bw',1,'User','User','2020-06-16','Cyberens','0600000003',NULL,27,0,'user',1,1),('demo@mail.com','$argon2i$v=19$m=4096,t=3,p=1$tGwyYZ73bux0HAv6JaCfwg$88fdm5RD83swUxKjZZ1s5RXzdbBvB39HgvdBCm/Uowg',1,'Lalala','Demo','2020-06-17','','067777777777',NULL,29,0,'user',1,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
