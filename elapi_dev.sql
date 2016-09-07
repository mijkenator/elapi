-- MySQL dump 10.13  Distrib 5.6.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: elapi_dev
-- ------------------------------------------------------
-- Server version	5.6.28-0ubuntu0.15.04.1

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
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` bigint(20) NOT NULL DEFAULT '0',
  `inserted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES (20160702101250,'2016-07-02 10:16:37'),(20160702103007,'2016-07-02 10:32:05'),(20160702110027,'2016-07-02 11:02:19'),(20160705192308,'2016-07-05 20:23:17'),(20160705204349,'2016-07-05 20:45:19'),(20160713195936,'2016-07-13 20:02:47');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `data` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_token_index` (`token`),
  CONSTRAINT `sessions_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (87,'2nYrdxcXPOhjeOZbRW1Wbg',1,'2016-07-29 20:39:19','2016-07-29 20:39:19','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(88,'KiJ2jR1Q-CJQS47Xk9ZwUA',1,'2016-07-29 21:46:02','2016-07-29 21:46:02','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(89,'BDguPZPBh1I1QQCVF8tHGA',1,'2016-07-29 21:56:19','2016-07-29 21:56:19','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(90,'C3sNfPP6TwPMUE7_8sQXbA',1,'2016-07-29 21:59:29','2016-07-29 21:59:29','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(91,'hMzsFaD4934S0Pm4C611Cg',1,'2016-07-29 22:05:54','2016-07-29 22:05:54','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(92,'4VYtxKWO5ro8tG9sut0-SQ',1,'2016-07-29 22:09:04','2016-07-29 22:09:04','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(93,'aFiNFpnvbABCc4w77ZLk-A',1,'2016-07-29 22:11:55','2016-07-29 22:11:55','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(94,'XqvmhlKt6XP_-u8xA-FkwQ',1,'2016-07-29 22:13:21','2016-07-29 22:13:21','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(95,'oQg3AH9B_LRhklqKl3Cniw',1,'2016-07-29 22:13:55','2016-07-29 22:13:55','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(96,'DYhQiJFHbzLxfe7L2-b1hA',1,'2016-07-31 13:16:45','2016-07-31 13:16:45','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(97,'uw9O7gyo7ni9gmTNeCTuoA',1,'2016-08-02 16:27:12','2016-08-02 16:27:12','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(98,'0dYR4r3NTdf29rOG00-P_Q',1,'2016-08-02 16:28:21','2016-08-02 16:28:21','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(99,'XKx3HuTftuN92qFnk-Jb2A',1,'2016-08-02 16:42:03','2016-08-02 16:42:03','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(100,'EliqNGFVkuZ5iEuB-Id-fA',1,'2016-08-02 16:43:27','2016-08-02 16:43:27','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(101,'Q4BbUKDIS_HKACoNv9y5zg',1,'2016-08-02 16:44:44','2016-08-02 16:44:44','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(102,'hTcg4phSZeG7ZhiRVvOtMw',1,'2016-08-05 15:28:04','2016-08-05 15:28:04','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(103,'RrAWZ8MFsbqdcbmqthfoRQ',1,'2016-08-16 19:30:50','2016-08-16 19:30:50','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(104,'Aha9Zk68XfrQtn5FeC_mJw',1,'2016-08-16 19:31:13','2016-08-16 19:31:13','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(105,'4F2zRztLdH2_YBnJDHeIfg',1,'2016-08-16 19:32:29','2016-08-16 19:32:29','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(106,'fzL91kdWJJJ1_QRBMxrzLQ',1,'2016-08-16 19:51:55','2016-08-16 19:51:55','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(107,'zp3fg53ocZRRvC-trZn58g',1,'2016-08-16 19:53:46','2016-08-16 19:53:46','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(108,'JwwUdqb00Hz6q7u-fX4Z2g',1,'2016-08-16 20:10:01','2016-08-16 20:10:01','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(109,'WGt8njUtZyu0IwcoX3mXJw',1,'2016-08-16 20:15:05','2016-08-16 20:15:05','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(110,'Yh2gChu1yJ_4RDXLFVoC_A',1,'2016-08-16 20:20:32','2016-08-16 20:20:32','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(111,'FIbFl0ndFOtPMY2WJSUgHA',1,'2016-08-17 17:11:50','2016-08-17 17:11:50','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(112,'niVF3cOSQxdvPM6q0rirHQ',1,'2016-08-17 18:55:57','2016-08-17 18:55:57','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(113,'uAAuJXh1oenYz6EMwbE7VQ',1,'2016-08-19 19:36:35','2016-08-19 19:36:35','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(114,'GQ_F6QykXOEt9Pp_kzcwMw',1,'2016-08-24 19:43:28','2016-08-24 19:43:28','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(115,'GMVv0UhHoCpdz7F2Jg-K8w',1,'2016-08-24 19:50:26','2016-08-24 19:50:26','{\"test\":\"lalalal\",\"ip\":\"127.0.0.1\"}'),(116,'kSnRJ_jNtO_LydTf2q3TIA',1,'2016-08-26 20:06:31','2016-08-26 20:06:31','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(117,'VK2bY0tH0jYxqWwU_Ds1og',1,'2016-08-26 20:08:53','2016-08-26 20:08:53','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(118,'W2dmkAokTx3XUt2nodeqHg',1,'2016-08-29 18:47:05','2016-08-29 18:47:05','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(119,'3S84Ne0eDsrJgC2Un9YesA',1,'2016-08-29 18:59:13','2016-08-29 18:59:13','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(120,'0W_v7lyVPAiueTXjJHw4wg',1,'2016-08-29 20:03:49','2016-08-29 20:03:49','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(121,'Fd_nDfdISDjUfBkCDGjxSw',1,'2016-08-29 20:07:38','2016-08-29 20:07:38','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(122,'fnLv_r5-ZrTQGxmDZ-nIXQ',1,'2016-08-29 20:13:14','2016-08-29 20:13:14','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(123,'Xw9yPaJLFOkDgBHpUdtXPw',1,'2016-08-29 20:23:24','2016-08-29 20:23:24','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(124,'bR8gdSZCiK8UT8FiG8cFGQ',1,'2016-08-29 20:27:59','2016-08-29 20:27:59','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(125,'PDAbb4y7Mfq-iOE3uMDDew',1,'2016-08-29 20:29:02','2016-08-29 20:29:02','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(126,'X5GOzd8GGhuFwb2Q2KoOrg',1,'2016-08-29 20:31:35','2016-08-29 20:31:35','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(127,'uNF6swhQ1EHEx5rkG2BkbA',1,'2016-08-29 20:32:53','2016-08-29 20:32:53','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(128,'hUbckmlSk9qxGN5sU5exNg',1,'2016-08-29 20:44:07','2016-08-29 20:44:07','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(129,'G740hmj_3MTprjMo3rDNjw',1,'2016-08-30 18:04:45','2016-08-30 18:04:45','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(130,'feNlxYe78f02mFEodxmo6A',1,'2016-08-30 18:05:26','2016-08-30 18:05:26','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(131,'fImYfaysBJXfW3fcORv01g',1,'2016-08-30 18:07:33','2016-08-30 18:07:33','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(132,'zndnYp3dHxnFLf3PFu8CAw',1,'2016-08-30 18:37:10','2016-08-30 18:37:10','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(133,'wyoLs0MRJoCvqmSf5NZuPA',22,'2016-08-30 18:44:32','2016-08-30 18:44:32','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(134,'jEHI-dr4AQsRNiF9EhqGuw',1,'2016-08-30 19:10:39','2016-08-30 19:10:39','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(135,'Y0TKuAfB1GeRzidskGN4gQ',1,'2016-09-01 18:24:07','2016-09-01 18:24:07','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(136,'EKruSvJ4-S9LdX95yfzeIA',1,'2016-09-01 18:38:40','2016-09-01 18:38:40','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(137,'D8iagkI-xvhbHDd0Ct6J7g',23,'2016-09-01 18:46:48','2016-09-01 18:46:48','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(138,'XE7DjtIROkSEROShA-iaUA',23,'2016-09-01 18:47:01','2016-09-01 18:47:01','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(139,'L2WI5v5baNaQosj14x7veA',1,'2016-09-01 18:47:13','2016-09-01 18:47:13','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(140,'3I_R-JT85qKzxtcY97nIGw',1,'2016-09-01 18:50:26','2016-09-01 18:50:26','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(141,'Mc81h-xeeEcG3nITC26_hg',1,'2016-09-01 18:57:20','2016-09-01 18:57:20','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(142,'9XDy7dV5kwOR3QNsO-2EWQ',1,'2016-09-01 18:57:46','2016-09-01 18:57:46','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(143,'bQbJ6kb358VBnos_0Y_WzQ',23,'2016-09-01 18:58:23','2016-09-01 18:58:23','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(144,'QFStEXxEO2wCogjFXCldIw',1,'2016-09-01 19:36:47','2016-09-01 19:36:47','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(145,'ORv6gCgR9EV2VddWjIVpJQ',1,'2016-09-01 19:38:24','2016-09-01 19:38:24','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(146,'x-Cc2UNQzCiZAmqRU8UnQw',1,'2016-09-01 19:53:27','2016-09-01 19:53:27','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(147,'uOvKoxySz5IsUUkyCetGwA',1,'2016-09-01 19:54:55','2016-09-01 19:54:55','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(148,'QC5wf7h6FV7DXYa65safFg',1,'2016-09-01 20:00:18','2016-09-01 20:00:18','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(149,'He8NIAHkY7iIN8EJ3WYd4w',1,'2016-09-01 20:08:53','2016-09-01 20:08:53','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(150,'kbTBXylgi2-74bFs2crX_w',1,'2016-09-01 20:09:11','2016-09-01 20:09:11','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(151,'DHRLcZigH4o-GMAieRw8cw',1,'2016-09-01 21:07:49','2016-09-01 21:07:49','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(152,'0WBVfizc49jxqGQFr8R9pw',1,'2016-09-01 21:08:55','2016-09-01 21:08:55','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(153,'WZYs47V73vwn5skyjm3O1Q',1,'2016-09-01 21:09:16','2016-09-01 21:09:16','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(154,'Ae8IsIt5UyAQMKJFnKY69Q',1,'2016-09-01 21:11:11','2016-09-01 21:11:11','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(155,'ieEjCgsuzSmclFIRpWkU5A',1,'2016-09-01 21:12:08','2016-09-01 21:12:08','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(156,'_SfGcBtI3idodCsqwQliFw',1,'2016-09-01 21:12:18','2016-09-01 21:12:18','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(157,'7l0-UloGksseivYakvIgNw',1,'2016-09-01 21:14:44','2016-09-01 21:14:44','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(158,'QiL6_WI92XSPbLrBv1IohQ',22,'2016-09-01 21:14:55','2016-09-01 21:14:55','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(159,'vMvRFYd2qkgym9yoXu76bw',23,'2016-09-01 21:15:06','2016-09-01 21:15:06','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(160,'v_6qa_TRBQFrp5exoHmcJQ',1,'2016-09-01 21:15:14','2016-09-01 21:15:14','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(161,'k6RjrblIq2j8Jb4m2aHcLQ',1,'2016-09-02 17:26:15','2016-09-02 17:26:15','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}'),(162,'XCwNK1MswvnFf4jDKAfeHA',1,'2016-09-02 19:58:47','2016-09-02 19:58:47','{\"test\":\"lalalal\",\"ip\":\"192.168.99.1\"}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todos`
--

DROP TABLE IF EXISTS `todos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `owner_id` bigint(20) unsigned DEFAULT NULL,
  `complete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `todos_owner_id_fkey` (`owner_id`),
  CONSTRAINT `todos_owner_id_fkey` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todos`
--

LOCK TABLES `todos` WRITE;
/*!40000 ALTER TABLE `todos` DISABLE KEYS */;
INSERT INTO `todos` VALUES (4,'lalalalala22','2016-07-07 19:31:30','2016-07-07 19:31:30',1,0),(5,'lalalalala22','2016-07-11 22:08:22','2016-07-11 22:08:22',1,0),(6,'lalalalala22','2016-07-12 23:59:57','2016-07-12 23:59:57',1,0);
/*!40000 ALTER TABLE `todos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_properties`
--

DROP TABLE IF EXISTS `user_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_properties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `data` text,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_properties_user_id_fkey` (`user_id`),
  CONSTRAINT `user_properties_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_properties`
--

LOCK TABLES `user_properties` WRITE;
/*!40000 ALTER TABLE `user_properties` DISABLE KEYS */;
INSERT INTO `user_properties` VALUES (1,1,'{\"permissions\":{\"admin\":[\"dashboard\"]}}','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `user_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `users_email_index` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'mkh@mail.ru','$2b$12$qYWZbFvZn30Lr10u2taMves18BVNEKaYUzlmYrnVOf8b8GyscCeT.','2016-07-06 18:29:28','2016-07-06 18:29:28'),(22,'mkh1@mail.ru','$2b$12$qYWZbFvZn30Lr10u2taMves18BVNEKaYUzlmYrnVOf8b8GyscCeT.','0000-00-00 00:00:00','0000-00-00 00:00:00'),(23,'mkh2@mail.ru','$2b$12$iuaygAkdhyV7Lee1WiphM.OoTiSn2PcHEIIygBatBQwEk0FMy6U3m','2016-09-01 18:32:22','2016-09-01 18:32:22'),(24,'mkh4@mail.ru','$2b$12$9jVRxmFAt8XKshDiHgChIuDy5eDPayFY2rcG.vdtNp.M.u3wc0wdS','2016-09-02 19:58:16','2016-09-02 19:58:16');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'elapi_dev'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-07 19:06:54
