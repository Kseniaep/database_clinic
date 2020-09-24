-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	5.7.31-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) unsigned NOT NULL,
  `deposit_sum` decimal(11,2) DEFAULT NULL COMMENT 'Сумма на депозите',
  `credit_sum` decimal(11,2) DEFAULT NULL,
  `discount` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=cp1251 COMMENT='Счета';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,2,7471.25,NULL,10,'2020-09-10 13:37:03','2020-09-13 14:10:10'),(2,11,NULL,74528.75,15,'2020-09-10 13:37:03','2020-09-13 14:13:02');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment` (
  `registration_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `body` text,
  `metadata` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `registration_id` (`registration_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`registration_id`) REFERENCES `registration` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch',NULL,'2020-09-13 12:24:18'),(4,'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch',NULL,'2020-09-13 12:27:23'),(5,'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch',NULL,'2020-09-13 12:27:38'),(6,'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch',NULL,'2020-09-13 12:27:52'),(8,'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch',NULL,'2020-09-13 12:28:08'),(9,'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch',NULL,'2020-09-13 13:22:40'),(10,'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch',NULL,'2020-09-13 13:29:36'),(11,'hdhhljjljhhkj.fjghjghhg.jgjchfxgxgh.gjfjhgjkhkgfvchch',NULL,'2020-09-13 14:00:21');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `days`
--

DROP TABLE IF EXISTS `days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `days` (
  `adding` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `days`
--

LOCK TABLES `days` WRITE;
/*!40000 ALTER TABLE `days` DISABLE KEYS */;
INSERT INTO `days` VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
/*!40000 ALTER TABLE `days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_schedule`
--

DROP TABLE IF EXISTS `doc_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_schedule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doctor_id` int(10) unsigned NOT NULL,
  `date_id` bigint(20) unsigned NOT NULL,
  `IS_FREE` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `date_id` (`date_id`),
  CONSTRAINT `doc_schedule_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `doc_schedule_ibfk_2` FOREIGN KEY (`date_id`) REFERENCES `schedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_schedule`
--

LOCK TABLES `doc_schedule` WRITE;
/*!40000 ALTER TABLE `doc_schedule` DISABLE KEYS */;
INSERT INTO `doc_schedule` VALUES (1,1,1,_binary ''),(2,1,2,_binary ''),(3,1,3,_binary ''),(4,1,4,_binary '\0'),(5,1,5,_binary ''),(6,1,6,_binary ''),(7,1,7,_binary ''),(8,1,8,_binary ''),(9,1,9,_binary ''),(10,1,10,_binary ''),(11,1,11,_binary ''),(12,1,56,_binary ''),(13,1,57,_binary ''),(14,1,58,_binary '\0'),(15,1,59,_binary '\0'),(16,1,60,_binary ''),(17,1,61,_binary ''),(18,1,62,_binary ''),(19,1,63,_binary ''),(20,1,64,_binary ''),(21,1,65,_binary ''),(22,1,66,_binary ''),(23,2,12,_binary ''),(24,2,13,_binary ''),(25,2,14,_binary ''),(26,2,15,_binary ''),(27,2,16,_binary ''),(28,2,17,_binary ''),(29,2,18,_binary ''),(30,2,19,_binary ''),(31,2,20,_binary ''),(32,2,21,_binary ''),(33,2,22,_binary ''),(34,2,67,_binary ''),(35,2,68,_binary ''),(36,2,69,_binary ''),(37,2,70,_binary ''),(38,2,71,_binary '\0'),(39,2,72,_binary ''),(40,2,73,_binary ''),(41,2,74,_binary ''),(42,2,75,_binary ''),(43,2,76,_binary ''),(44,2,77,_binary ''),(45,3,23,_binary ''),(46,3,24,_binary ''),(47,3,25,_binary ''),(48,3,26,_binary ''),(49,3,27,_binary ''),(50,3,28,_binary ''),(51,3,29,_binary ''),(52,3,30,_binary ''),(53,3,31,_binary ''),(54,3,32,_binary ''),(55,3,33,_binary ''),(56,3,78,_binary ''),(57,3,79,_binary '\0'),(58,3,80,_binary ''),(59,3,81,_binary ''),(60,3,82,_binary ''),(61,3,83,_binary ''),(62,3,84,_binary ''),(63,3,85,_binary ''),(64,3,86,_binary ''),(65,3,87,_binary ''),(66,3,88,_binary ''),(67,4,34,_binary ''),(68,4,35,_binary ''),(69,4,36,_binary ''),(70,4,37,_binary '\0'),(71,4,38,_binary ''),(72,4,39,_binary ''),(73,4,40,_binary '\0'),(74,4,41,_binary '\0'),(75,4,42,_binary ''),(76,4,43,_binary ''),(77,4,44,_binary '\0'),(78,4,89,_binary ''),(79,4,90,_binary ''),(80,4,91,_binary ''),(81,4,92,_binary ''),(82,4,93,_binary ''),(83,4,94,_binary ''),(84,4,95,_binary ''),(85,4,96,_binary ''),(86,4,97,_binary ''),(87,4,98,_binary ''),(88,4,99,_binary ''),(89,5,45,_binary ''),(90,5,46,_binary ''),(91,5,47,_binary ''),(92,5,48,_binary ''),(93,5,49,_binary ''),(94,5,50,_binary ''),(95,5,51,_binary ''),(96,5,52,_binary ''),(97,5,53,_binary ''),(98,5,54,_binary ''),(99,5,55,_binary ''),(100,5,100,_binary ''),(101,5,101,_binary ''),(102,5,102,_binary ''),(103,5,103,_binary '\0'),(104,5,104,_binary ''),(105,5,105,_binary ''),(106,5,106,_binary ''),(107,5,107,_binary ''),(108,5,108,_binary ''),(109,5,109,_binary ''),(110,5,110,_binary '');
/*!40000 ALTER TABLE `doc_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `doctor_results`
--

DROP TABLE IF EXISTS `doctor_results`;
/*!50001 DROP VIEW IF EXISTS `doctor_results`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `doctor_results` AS SELECT 
 1 AS `doctor`,
 1 AS `result_sum`,
 1 AS `busy_hour`,
 1 AS `work_hour`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL COMMENT 'Фамилия',
  `speciality` varchar(50) DEFAULT NULL,
  `category` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=cp1251 COMMENT='врачи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Ирина','Архипова','терапевт',1),(2,'Михаил','Баранов','невролог',100),(3,'Ольга','Васина','хирург',1),(4,'Анастасия','Глебова','терапевт',100),(5,'Николай','Дядькин','эндокринолог',NULL);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors_services`
--

DROP TABLE IF EXISTS `doctors_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctors_services` (
  `doctor_id` int(10) unsigned NOT NULL,
  `service_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`doctor_id`,`service_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `doctors_services_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `doctors_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors_services`
--

LOCK TABLES `doctors_services` WRITE;
/*!40000 ALTER TABLE `doctors_services` DISABLE KEYS */;
INSERT INTO `doctors_services` VALUES (1,1),(2,2),(4,2),(1,3),(4,3),(2,4),(2,5),(3,6),(3,7),(3,8),(5,9);
/*!40000 ALTER TABLE `doctors_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `pacient_debt`
--

DROP TABLE IF EXISTS `pacient_debt`;
/*!50001 DROP VIEW IF EXISTS `pacient_debt`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `pacient_debt` AS SELECT 
 1 AS `pacient`,
 1 AS `phonenumber`,
 1 AS `debt_sum`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `registration_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned DEFAULT '0',
  `pay_method` enum('cash','credit','deposit') NOT NULL DEFAULT 'cash',
  `total` decimal(11,2) NOT NULL,
  `IS_PAY` bit(1) DEFAULT b'0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `account_id` (`account_id`),
  KEY `registration_id` (`registration_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`registration_id`) REFERENCES `registration` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COMMENT='Чек';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (2,1,2,'cash',1700.00,_binary '','2020-09-13 12:24:18','2020-09-13 14:02:52'),(3,4,NULL,'cash',500.00,_binary '\0','2020-09-13 12:27:23','2020-09-13 12:27:23'),(4,5,NULL,'cash',2125.00,_binary '','2020-09-13 12:27:38','2020-09-13 13:00:06'),(5,6,2,'credit',2528.75,_binary '','2020-09-13 12:27:52','2020-09-13 14:13:02'),(8,9,1,'deposit',2528.75,_binary '','2020-09-13 13:22:40','2020-09-13 14:10:10'),(10,10,2,'cash',3500.00,_binary '\0','2020-09-13 13:29:36','2020-09-13 13:46:33'),(18,11,2,'cash',3500.00,_binary '\0','2020-09-13 14:00:21','2020-09-13 14:04:37');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_method
BEFORE UPDATE
ON payments FOR EACH ROW
BEGIN 
	IF NEW.pay_method<>'cash' and NEW.account_id IS NULL THEN 
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled. Method is able to account only';
 END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `insurance_number` bigint(20) unsigned DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `IS_AGREE` bit(1) NOT NULL,
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `insurance_number` (`insurance_number`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'f','1990-08-02',1521242,'РОМАШКА ООО','2020-09-10 13:24:21',_binary ''),(2,'m','1979-08-02',1521243,'ОГОНЬ ОАО','2020-09-10 13:24:21',_binary ''),(3,'m','1984-10-02',1521244,'РОМАШКА ООО','2020-09-10 13:24:21',_binary ''),(4,'m','2008-06-12',1521245,NULL,'2020-09-10 13:24:21',_binary ''),(5,'m','1988-10-02',1521246,'РОМАШКА ООО','2020-09-10 13:24:21',_binary ''),(6,'f','1991-05-14',1521247,'АЛМАЗ ПАО','2020-09-10 13:24:21',_binary ''),(7,'m','1992-04-22',1521248,'РОМАШКА ООО','2020-09-10 13:24:21',_binary ''),(8,'m','1990-03-12',1521249,'РОМАШКА ООО','2020-09-10 13:24:21',_binary ''),(9,'f','1986-04-03',1521250,'БЕРЕГ ООО','2020-09-10 13:24:21',_binary ''),(10,'m','2005-01-11',1521251,NULL,'2020-09-10 13:24:21',_binary '');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `prev_id` bigint(20) unsigned DEFAULT NULL,
  `pacient_id` bigint(20) unsigned NOT NULL,
  `service_id` bigint(20) unsigned NOT NULL,
  `schedule_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `IS_CANCEL` bit(1) DEFAULT b'0',
  `IS_SUCEED` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `pacient_id` (`pacient_id`),
  KEY `reg_fk` (`prev_id`),
  KEY `reg_fk_1` (`schedule_id`),
  KEY `reg_fk_service` (`service_id`),
  CONSTRAINT `reg_fk` FOREIGN KEY (`prev_id`) REFERENCES `appointment` (`registration_id`),
  CONSTRAINT `reg_fk_1` FOREIGN KEY (`schedule_id`) REFERENCES `doc_schedule` (`id`),
  CONSTRAINT `reg_fk_service` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`),
  CONSTRAINT `registration_ibfk_1` FOREIGN KEY (`pacient_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (1,NULL,1,1,57,'2020-09-13 11:48:47',_binary '\0',_binary ''),(2,NULL,3,2,38,'2020-09-13 11:50:59',_binary '\0',_binary '\0'),(4,NULL,2,3,4,'2020-09-13 11:51:07',_binary '\0',_binary ''),(5,NULL,4,9,103,'2020-09-13 11:51:11',_binary '\0',_binary ''),(6,NULL,6,4,14,'2020-09-13 12:18:41',_binary '\0',_binary ''),(7,NULL,5,5,15,'2020-09-13 12:18:45',_binary '\0',_binary '\0'),(8,NULL,10,4,70,'2020-09-13 12:22:09',_binary '\0',_binary ''),(9,NULL,10,4,77,'2020-09-13 13:22:17',_binary '\0',_binary ''),(10,6,6,4,73,'2020-09-13 13:28:31',_binary '\0',_binary ''),(11,6,6,4,74,'2020-09-13 13:36:51',_binary '\0',_binary '');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER insert_registration
BEFORE INSERT
ON registration FOR EACH ROW
BEGIN
DECLARE check_free BIT;
SELECT IS_FREE INTO check_free FROM doc_schedule ds WHERE ds.id = NEW.schedule_id;
	IF check_free = FALSE THEN 
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled. Time is busy.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_registration
BEFORE UPDATE
ON registration FOR EACH ROW
BEGIN
DECLARE check_free BIT;
SELECT IS_FREE INTO check_free FROM doc_schedule ds WHERE ds.id = NEW.schedule_id;
	IF (check_free = FALSE) and (NEW.schedule_id <> OLD.schedule_id) THEN 
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update canceled. Time is busy.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_chande_free
AFTER UPDATE
ON registration FOR EACH ROW
BEGIN
	IF NEW.schedule_id <> OLD.schedule_id THEN 
  		UPDATE doc_schedule ds
  		SET IS_FREE = FALSE where ds.id = NEW.schedule_id;
  		UPDATE doc_schedule ds
  		SET IS_FREE = TRUE where ds.id = OLD.schedule_id;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_change_free
AFTER UPDATE
ON registration FOR EACH ROW
BEGIN
IF NEW.schedule_id <> OLD.schedule_id THEN 
  		UPDATE doc_schedule ds
  		SET IS_FREE = FALSE where ds.id = NEW.schedule_id;
  		UPDATE doc_schedule ds
  		SET IS_FREE = TRUE where ds.id = OLD.schedule_id;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER del_registration
AFTER DELETE
ON registration FOR EACH ROW
BEGIN
	UPDATE doc_schedule ds
  		SET IS_FREE = TRUE where ds.id = OLD.schedule_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_app` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (1,'2020-09-01 09:00:00'),(2,'2020-09-01 10:00:00'),(3,'2020-09-01 11:00:00'),(4,'2020-09-01 12:00:00'),(5,'2020-09-01 13:00:00'),(6,'2020-09-01 14:00:00'),(7,'2020-09-01 15:00:00'),(8,'2020-09-01 16:00:00'),(9,'2020-09-01 17:00:00'),(10,'2020-09-01 18:00:00'),(11,'2020-09-01 19:00:00'),(12,'2020-09-02 09:00:00'),(13,'2020-09-02 10:00:00'),(14,'2020-09-02 11:00:00'),(15,'2020-09-02 12:00:00'),(16,'2020-09-02 13:00:00'),(17,'2020-09-02 14:00:00'),(18,'2020-09-02 15:00:00'),(19,'2020-09-02 16:00:00'),(20,'2020-09-02 17:00:00'),(21,'2020-09-02 18:00:00'),(22,'2020-09-02 19:00:00'),(23,'2020-09-03 09:00:00'),(24,'2020-09-03 10:00:00'),(25,'2020-09-03 11:00:00'),(26,'2020-09-03 12:00:00'),(27,'2020-09-03 13:00:00'),(28,'2020-09-03 14:00:00'),(29,'2020-09-03 15:00:00'),(30,'2020-09-03 16:00:00'),(31,'2020-09-03 17:00:00'),(32,'2020-09-03 18:00:00'),(33,'2020-09-03 19:00:00'),(34,'2020-09-04 09:00:00'),(35,'2020-09-04 10:00:00'),(36,'2020-09-04 11:00:00'),(37,'2020-09-04 12:00:00'),(38,'2020-09-04 13:00:00'),(39,'2020-09-04 14:00:00'),(40,'2020-09-04 15:00:00'),(41,'2020-09-04 16:00:00'),(42,'2020-09-04 17:00:00'),(43,'2020-09-04 18:00:00'),(44,'2020-09-04 19:00:00'),(45,'2020-09-05 09:00:00'),(46,'2020-09-05 10:00:00'),(47,'2020-09-05 11:00:00'),(48,'2020-09-05 12:00:00'),(49,'2020-09-05 13:00:00'),(50,'2020-09-05 14:00:00'),(51,'2020-09-05 15:00:00'),(52,'2020-09-05 16:00:00'),(53,'2020-09-05 17:00:00'),(54,'2020-09-05 18:00:00'),(55,'2020-09-05 19:00:00'),(56,'2020-09-06 09:00:00'),(57,'2020-09-06 10:00:00'),(58,'2020-09-06 11:00:00'),(59,'2020-09-06 12:00:00'),(60,'2020-09-06 13:00:00'),(61,'2020-09-06 14:00:00'),(62,'2020-09-06 15:00:00'),(63,'2020-09-06 16:00:00'),(64,'2020-09-06 17:00:00'),(65,'2020-09-06 18:00:00'),(66,'2020-09-06 19:00:00'),(67,'2020-09-07 09:00:00'),(68,'2020-09-07 10:00:00'),(69,'2020-09-07 11:00:00'),(70,'2020-09-07 12:00:00'),(71,'2020-09-07 13:00:00'),(72,'2020-09-07 14:00:00'),(73,'2020-09-07 15:00:00'),(74,'2020-09-07 16:00:00'),(75,'2020-09-07 17:00:00'),(76,'2020-09-07 18:00:00'),(77,'2020-09-07 19:00:00'),(78,'2020-09-08 09:00:00'),(79,'2020-09-08 10:00:00'),(80,'2020-09-08 11:00:00'),(81,'2020-09-08 12:00:00'),(82,'2020-09-08 13:00:00'),(83,'2020-09-08 14:00:00'),(84,'2020-09-08 15:00:00'),(85,'2020-09-08 16:00:00'),(86,'2020-09-08 17:00:00'),(87,'2020-09-08 18:00:00'),(88,'2020-09-08 19:00:00'),(89,'2020-09-09 09:00:00'),(90,'2020-09-09 10:00:00'),(91,'2020-09-09 11:00:00'),(92,'2020-09-09 12:00:00'),(93,'2020-09-09 13:00:00'),(94,'2020-09-09 14:00:00'),(95,'2020-09-09 15:00:00'),(96,'2020-09-09 16:00:00'),(97,'2020-09-09 17:00:00'),(98,'2020-09-09 18:00:00'),(99,'2020-09-09 19:00:00'),(100,'2020-09-10 09:00:00'),(101,'2020-09-10 10:00:00'),(102,'2020-09-10 11:00:00'),(103,'2020-09-10 12:00:00'),(104,'2020-09-10 13:00:00'),(105,'2020-09-10 14:00:00'),(106,'2020-09-10 15:00:00'),(107,'2020-09-10 16:00:00'),(108,'2020-09-10 17:00:00'),(109,'2020-09-10 18:00:00'),(110,'2020-09-10 19:00:00');
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `price` decimal(11,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Прием терапевта первой категории',2000.00),(2,'Прием терапевта высшей категории',3000.00),(3,'Профилактическая ЭКГ',500.00),(4,'Прием невролога высшей категории',3500.00),(5,'Лекарственная блокада',2500.00),(6,'Прием хирурга первой категории',2500.00),(7,'Наложение хирургической повязки',2000.00),(8,'Снятие хирургической повязки',1000.00),(9,'Прием эндокринолога',2500.00);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `times`
--

DROP TABLE IF EXISTS `times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `times` (
  `workhours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `times`
--

LOCK TABLES `times` WRITE;
/*!40000 ALTER TABLE `times` DISABLE KEYS */;
INSERT INTO `times` VALUES (9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19);
/*!40000 ALTER TABLE `times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL COMMENT 'Фамилия',
  `email` varchar(120) DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `account_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`),
  KEY `users_fk` (`account_id`),
  CONSTRAINT `users_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=cp1251 COMMENT='пациенты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Елена','Зайцева','user596@example.org',9152548521,'2020-09-10 13:23:38','2020-09-10 13:39:01',2),(2,'Алексей','Волков','user597@example.org',9995241385,'2020-09-10 13:23:38',NULL,0),(3,'Иван','Петров','user598@example.org',8521245998,'2020-09-10 13:23:38','2020-09-10 13:39:01',2),(4,'Сергей','Смолин','user599@example.org',9265414457,'2020-09-10 13:23:38',NULL,0),(5,'Александр','Кротов','user600@example.org',9215428545,'2020-09-10 13:23:38','2020-09-10 13:39:01',2),(6,'Анна','Краснова','user601@example.org',9635544121,'2020-09-10 13:23:38','2020-09-10 13:39:05',2),(7,'Иван','Краснов','user602@example.org',9165214412,'2020-09-10 13:23:38','2020-09-10 13:39:01',2),(8,'Петр','Сухов','user603@example.org',9824127485,'2020-09-10 13:23:38','2020-09-10 13:39:01',2),(9,'Екатерина','Лебедева','user604@example.org',9865231220,'2020-09-10 13:23:38','2020-09-10 13:39:09',1),(10,'Геннадий','Лебедев','user605@example.org',9254178322,'2020-09-10 13:23:38','2020-09-10 13:39:09',1),(11,NULL,NULL,'romashka@romashka.org',4951120102,'2020-09-10 13:23:38',NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `doctor_results`
--

/*!50001 DROP VIEW IF EXISTS `doctor_results`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `doctor_results` AS (select `sch`.`doctor_id` AS `doctor`,sum(`p`.`total`) AS `result_sum`,count(`r`.`id`) AS `busy_hour`,count(`sch`.`id`) AS `work_hour` from (`doc_schedule` `sch` left join (`payments` `p` join `registration` `r` on((`r`.`id` = `p`.`registration_id`))) on((`sch`.`id` = `r`.`schedule_id`))) group by `doctor`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pacient_debt`
--

/*!50001 DROP VIEW IF EXISTS `pacient_debt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pacient_debt` AS (select concat(`u`.`firstname`,' ',`u`.`lastname`) AS `pacient`,`u`.`phone` AS `phonenumber`,sum(`p`.`total`) AS `debt_sum` from (((`users` `u` join `registration` `r` on((`r`.`pacient_id` = `u`.`id`))) join `appointment` `a` on((`a`.`registration_id` = `r`.`id`))) join `payments` `p` on(((`p`.`registration_id` = `r`.`id`) and (`p`.`IS_PAY` = FALSE)))) group by `u`.`id` order by `debt_sum` desc) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-13 16:31:14
