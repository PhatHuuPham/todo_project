-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: todo_app
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `task_categories`
--

DROP TABLE IF EXISTS `task_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name_per_user` (`name`,`user_id`),
  KEY `fk_task_categories_users` (`user_id`),
  CONSTRAINT `fk_task_categories_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_categories`
--

LOCK TABLES `task_categories` WRITE;
/*!40000 ALTER TABLE `task_categories` DISABLE KEYS */;
INSERT INTO `task_categories` VALUES (1,'Làm viêc','Làm viêc','2025-02-28 08:25:50',NULL),(2,'học','Học flutter','2025-02-28 08:25:50',NULL),(4,'chơ','ss','2025-02-28 16:48:45',NULL),(5,'giỡn','hehehe','2025-03-02 18:18:44',NULL),(6,'category nè','','2025-03-02 18:20:34',NULL),(7,'qqqq','qqqq','2025-03-02 18:22:12',NULL),(8,'pppp','pppp','2025-03-02 18:23:58',NULL),(9,'ewwewewe','ưưewe','2025-03-02 18:25:10',NULL),(10,'wqwqwq','qwqwqwqw','2025-03-02 18:41:01',NULL),(11,'aqaqaqqqa','aqaqqaqqaqa','2025-03-02 18:47:12',NULL),(12,'g','g','2025-03-02 19:22:17',NULL),(13,'1','1','2025-03-06 17:45:24',NULL),(29,'làm việc 2','cate làm việc','2025-03-13 16:52:27',3),(30,'hưewewew','ưeweww','2025-03-13 17:00:18',3),(31,'cxzcz','zxczx','2025-03-13 17:01:43',3),(32,'qa','aq','2025-03-13 17:44:29',3),(33,'xzsdxs','xz','2025-03-13 17:52:56',1),(34,'bn','bn','2025-03-13 17:54:34',1),(35,'bh','bh','2025-03-13 17:58:09',1),(36,'làm việc 3','dsad','2025-03-13 18:15:43',3),(37,'làm việc 4','adasd','2025-03-13 18:15:57',3),(38,'today','','2025-03-14 06:37:05',1),(39,'jmjm','mjmj','2025-03-14 06:39:43',1),(40,'hjh','hjh','2025-03-14 06:41:27',1),(41,'jjuuj','juju','2025-03-14 06:42:07',1),(42,'vbvbvb','bvvbv','2025-03-14 06:42:45',1),(43,'thấy chưa','hello','2025-03-14 13:29:24',1),(44,'sửa rồi nè','dfdfdf','2025-03-14 13:33:46',1),(45,'ccxc','xcxcx','2025-03-16 07:38:36',1),(51,'sdsdssds','sdsdsdsd','2025-03-18 02:07:51',1),(54,'dcd','cd','2025-03-18 02:12:25',1),(56,'làm việc 5','sdshsdh','2025-03-18 02:16:21',1),(57,'làm việc','sdsd','2025-03-18 03:03:48',1),(58,'ddssdssdsdsd','dsds','2025-03-18 03:04:05',1),(60,'làm việc 2','sdsdsd','2025-03-18 03:07:48',1);
/*!40000 ALTER TABLE `task_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_images`
--

DROP TABLE IF EXISTS `task_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `image_url` text NOT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `task_images_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_images`
--

LOCK TABLES `task_images` WRITE;
/*!40000 ALTER TABLE `task_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_locations`
--

DROP TABLE IF EXISTS `task_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `task_locations_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_locations`
--

LOCK TABLES `task_locations` WRITE;
/*!40000 ALTER TABLE `task_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_sharing`
--

DROP TABLE IF EXISTS `task_sharing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_sharing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `shared_with_user_id` int NOT NULL,
  `permission` enum('read','edit','owner') DEFAULT 'read',
  `shared_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  KEY `shared_with_user_id` (`shared_with_user_id`),
  CONSTRAINT `task_sharing_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_sharing_ibfk_2` FOREIGN KEY (`shared_with_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_sharing`
--

LOCK TABLES `task_sharing` WRITE;
/*!40000 ALTER TABLE `task_sharing` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_sharing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `due_date` datetime DEFAULT NULL,
  `status` enum('pending','in_progress','completed') DEFAULT 'pending',
  `priority` enum('low','medium','high') DEFAULT 'medium',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_id` int DEFAULT NULL,
  `isSynced` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `task_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,1,'Hello World','Xin chào thế giới','2025-02-25 00:00:00','completed','medium','2025-02-23 16:45:56','2025-03-12 12:49:58',NULL,0),(2,1,'Phát Hữu','Phạm Hữu Phát','2025-02-25 17:00:00','completed','high','2025-02-23 17:42:14','2025-03-09 02:25:34',NULL,0),(3,1,'Phi','Lý Nguyễn Hoàng Phi',NULL,'completed','medium','2025-02-24 15:31:12','2025-03-09 02:25:34',NULL,0),(20,NULL,'titleController.text','descriptionController.text','2025-02-25 15:05:08','in_progress','low','2025-02-25 15:05:08','2025-02-28 08:20:40',NULL,0),(21,1,'titleController.text','descriptionController.text','2025-02-25 15:09:47','in_progress','low','2025-02-25 15:09:47','2025-03-09 02:25:34',NULL,0),(22,NULL,'hahaa','được rồi','2025-02-25 15:14:06','pending','low','2025-02-25 15:14:06','2025-02-25 15:14:06',NULL,0),(23,1,'hello shiba','shiba là ai','2025-02-25 16:17:53','pending','low','2025-02-25 16:17:53','2025-03-09 02:25:34',NULL,0),(24,1,'vfvv','vcvcvcv','2025-02-25 16:18:07','pending','low','2025-02-25 16:18:07','2025-03-09 02:25:34',NULL,0),(25,1,'qqqq','qqqq','2025-02-25 16:19:40','pending','low','2025-02-25 16:19:40','2025-03-09 02:25:34',NULL,0),(26,NULL,'rrr','rrr','2025-02-25 16:20:19','pending','low','2025-02-25 16:20:19','2025-02-25 16:20:19',NULL,0),(28,NULL,'cập nhật','giao diện tạo task mới',NULL,'in_progress','low','2025-02-27 07:25:43','2025-02-27 15:32:50',NULL,0),(31,NULL,'222','222',NULL,'pending','high','2025-02-27 07:26:58','2025-02-27 07:26:58',NULL,0),(32,NULL,'thêm ngày','đasadasdasd','2025-02-26 17:00:00','in_progress','high','2025-02-27 07:34:24','2025-02-27 15:33:44',NULL,0),(33,NULL,'1','1',NULL,'in_progress','medium','2025-02-27 14:14:33','2025-02-27 15:33:41',NULL,0),(34,NULL,'21','21',NULL,'in_progress','high','2025-02-27 14:14:41','2025-02-27 14:56:50',NULL,0),(35,NULL,'vfvf','fvfv','2025-02-10 17:00:00','in_progress','medium','2025-02-27 14:14:53','2025-02-27 14:56:52',NULL,0),(36,NULL,'qqqqqqqq','qqqqq','2025-02-26 17:00:00','pending','high','2025-02-27 14:15:19','2025-02-27 14:15:19',NULL,0),(37,NULL,'ffvbgv','vvgvfg',NULL,'in_progress','medium','2025-02-27 14:24:15','2025-02-27 16:16:25',NULL,0),(38,NULL,'hôm nay','sdss','2025-02-26 17:00:00','in_progress','medium','2025-02-27 16:15:40','2025-02-27 16:15:40',NULL,0),(39,NULL,'11','11','2025-02-27 17:00:00','in_progress','medium','2025-02-28 03:39:16','2025-02-28 16:42:59',NULL,0),(40,NULL,'hjhj','hhj','2025-02-27 17:00:00','in_progress','medium','2025-02-28 03:40:10','2025-02-28 16:42:59',NULL,0),(41,NULL,'','','2025-02-26 17:00:00','pending','medium','2025-02-28 03:40:51','2025-02-28 03:40:51',NULL,0),(42,NULL,'gfgfg','fgfgf','2025-02-28 17:00:00','completed','medium','2025-02-28 03:41:00','2025-03-01 07:03:12',NULL,0),(43,NULL,'433','rêr','2025-03-01 17:00:00','completed','medium','2025-02-28 03:45:40','2025-03-02 09:49:34',NULL,0),(44,NULL,'ưewew','ưewe','2025-02-27 17:00:00','in_progress','medium','2025-02-28 03:51:12','2025-02-28 16:43:00',NULL,0),(45,NULL,'ewwew','ewewe','2025-02-26 17:00:00','pending','medium','2025-02-28 03:51:22','2025-02-28 03:51:22',NULL,0),(46,NULL,'f','f','2025-02-27 17:00:00','in_progress','medium','2025-02-28 13:47:14','2025-02-28 16:43:00',NULL,0),(47,NULL,'','',NULL,'pending','medium','2025-02-28 16:14:09','2025-02-28 16:14:09',NULL,0),(48,NULL,'thêm cate','đ','2025-02-27 17:00:00','in_progress','medium','2025-02-28 16:37:17','2025-03-02 18:19:14',2,0),(49,NULL,'âsas','âsa','2025-02-27 17:00:00','in_progress','high','2025-02-28 16:38:20','2025-03-02 18:25:21',1,0),(50,NULL,'111','111','2025-03-01 17:00:00','in_progress','medium','2025-03-02 09:22:51','2025-03-02 18:19:17',4,0),(51,NULL,'111','111','2025-03-01 17:00:00','in_progress','high','2025-03-02 09:23:17','2025-03-02 18:19:17',4,0),(52,NULL,'q','q','2025-03-01 17:00:00','in_progress','medium','2025-03-02 09:42:00','2025-03-02 11:05:13',1,0),(53,NULL,'s','s','2025-03-01 17:00:00','in_progress','medium','2025-03-02 09:42:48','2025-03-02 11:05:12',4,0),(54,NULL,'5','5','2025-03-01 17:00:00','in_progress','medium','2025-03-02 09:49:05','2025-03-02 10:20:53',4,0),(55,NULL,'7','7','2025-03-01 17:00:00','in_progress','medium','2025-03-02 09:51:36','2025-03-02 09:53:11',2,0),(56,NULL,'9','9','2025-03-01 17:00:00','in_progress','medium','2025-03-02 09:52:34','2025-03-02 09:54:37',1,0),(57,NULL,'8','8','2025-03-01 17:00:00','pending','medium','2025-03-02 09:53:40','2025-03-02 09:53:40',1,0),(58,NULL,'q11','q11','2025-03-01 17:00:00','in_progress','medium','2025-03-02 10:20:45','2025-03-02 18:47:00',4,0),(59,NULL,'111111111','1111111111','2025-03-01 17:00:00','in_progress','medium','2025-03-02 10:25:03','2025-03-02 18:18:49',2,0),(60,NULL,'```','```','2025-03-01 17:00:00','in_progress','medium','2025-03-02 10:37:57','2025-03-02 10:39:19',4,0),(61,NULL,'===','===','2025-03-01 17:00:00','in_progress','medium','2025-03-02 10:39:13','2025-03-02 11:05:11',4,0),(64,NULL,'aqqq','aqaqaq','2025-03-02 17:00:00','in_progress','medium','2025-03-02 18:47:23','2025-03-03 12:49:37',9,0),(65,NULL,'ưewwe','ưewewew','2025-03-02 17:00:00','in_progress','medium','2025-03-02 18:53:26','2025-03-03 12:49:38',5,0),(66,NULL,'ưewwwhyh','ưewewhyhyhyh','2025-03-02 17:00:00','in_progress','medium','2025-03-02 18:54:02','2025-03-03 12:49:38',4,0),(67,NULL,'sxsxssxs','xsssxsxs','2025-03-02 17:00:00','in_progress','medium','2025-03-02 18:54:19','2025-03-03 12:49:34',2,0),(68,NULL,'gtgtg','tgtgtg','2025-03-02 17:00:00','in_progress','medium','2025-03-02 19:08:14','2025-03-03 12:49:34',1,0),(69,NULL,'g','g','2025-03-02 17:00:00','in_progress','medium','2025-03-02 19:17:18','2025-03-02 19:24:59',1,0),(70,NULL,'z','z','2025-03-02 17:00:00','in_progress','medium','2025-03-02 19:19:32','2025-03-02 19:22:04',1,0),(71,NULL,'m','m','2025-03-02 17:00:00','in_progress','medium','2025-03-02 19:21:55','2025-03-02 19:29:51',4,0),(72,NULL,'v','v','2025-03-02 17:00:00','in_progress','medium','2025-03-02 19:29:48','2025-03-03 12:48:33',5,0),(73,NULL,'12','','2025-03-02 17:00:00','in_progress','medium','2025-03-02 19:33:24','2025-03-03 12:41:53',1,0),(74,NULL,'t5','','2025-03-02 17:00:00','in_progress','medium','2025-03-02 19:33:41','2025-03-03 12:49:31',5,0),(75,NULL,'qq1q1q1','1q1q1q11q','2025-03-03 12:41:00','in_progress','medium','2025-03-03 12:41:26','2025-03-03 12:49:31',1,0),(76,NULL,'jujujujuju','jujujujjjjjjj','2025-03-02 17:00:00','in_progress','medium','2025-03-03 12:41:49','2025-03-03 12:49:32',6,0),(77,NULL,'nhnhnhnhn','hnhnhnhn',NULL,'pending','medium','2025-03-03 12:42:04','2025-03-03 12:42:04',7,0),(78,NULL,'12121111','121212121',NULL,'pending','medium','2025-03-03 12:48:23','2025-03-03 12:48:23',NULL,0),(79,NULL,'232322','2223232','2025-03-02 17:00:00','in_progress','medium','2025-03-03 12:48:31','2025-03-03 12:49:32',NULL,0),(80,NULL,'.ll.l.','.l.l.l','2025-03-03 17:00:00','pending','medium','2025-03-03 18:13:20','2025-03-03 18:13:20',5,0),(81,NULL,'///p','/p/p/p','2025-03-03 11:13:00','in_progress','medium','2025-03-03 18:13:45','2025-03-04 15:17:12',1,0),(82,NULL,'ưqwqwq','qưqwqwq','2025-03-04 11:35:00','in_progress','medium','2025-03-03 18:35:38','2025-03-04 15:09:10',NULL,0),(83,NULL,'hello w','8s8wie','2025-03-04 15:08:00','pending','medium','2025-03-04 15:09:00','2025-03-04 15:09:00',1,0),(84,NULL,'hello world','jdjjd','2025-03-06 17:45:00','in_progress','medium','2025-03-06 17:45:15','2025-03-06 17:45:31',1,0),(85,NULL,'','','2025-03-06 17:50:00','pending','medium','2025-03-06 17:50:05','2025-03-06 17:50:05',NULL,0),(86,NULL,'2','2','2025-03-11 17:13:00','pending','medium','2025-03-11 17:13:42','2025-03-11 17:13:42',NULL,0),(87,1,'id','thêm id','2025-03-12 06:08:00','in_progress','medium','2025-03-12 06:08:25','2025-03-12 12:49:13',NULL,0),(88,1,'ôppop','popop','2025-03-12 12:38:00','in_progress','medium','2025-03-12 12:38:49','2025-03-12 12:49:12',NULL,0),(89,1,'11','11','2025-03-12 17:17:00','pending','medium','2025-03-12 17:17:46','2025-03-12 17:17:46',NULL,0),(90,1,'cxcxcx','xccxcxcx','2025-03-12 17:22:00','pending','medium','2025-03-12 17:22:13','2025-03-12 17:22:13',NULL,0),(91,1,'xss','ssxsxsxs','2025-03-12 17:23:00','pending','medium','2025-03-12 17:23:40','2025-03-12 17:23:40',NULL,0),(92,1,'ds','dsdsd','2025-03-13 17:25:00','completed','medium','2025-03-12 17:25:20','2025-03-14 13:43:39',NULL,0),(93,1,'task','','2025-03-13 06:17:00','completed','medium','2025-03-13 06:17:25','2025-03-14 13:43:40',NULL,0),(94,2,'hello world','xin chào thế giới','2025-03-13 09:52:00','in_progress','medium','2025-03-13 09:52:18','2025-03-13 12:25:03',NULL,0),(95,NULL,'wsw','wswsw','2025-03-13 12:23:00','pending','medium','2025-03-13 12:23:56','2025-03-13 12:23:56',NULL,0),(96,2,'ưddwdw','ưdwdwdwd','2025-03-13 12:24:00','in_progress','medium','2025-03-13 12:24:56','2025-03-13 12:25:02',NULL,0),(97,3,'aa','aa','2025-03-13 12:36:00','completed','medium','2025-03-13 12:36:56','2025-03-14 02:35:28',NULL,0),(98,2,'qưqwqwq','qưqwqwqw','2025-03-13 12:40:00','pending','medium','2025-03-13 12:40:28','2025-03-13 12:40:28',NULL,0),(99,3,'212121','21212121','2025-03-13 12:41:00','completed','medium','2025-03-13 12:41:05','2025-03-14 02:35:29',NULL,0),(100,NULL,'dsdsdssdsdssd','','2025-03-13 12:42:00','pending','medium','2025-03-13 12:42:09','2025-03-13 12:42:09',NULL,0),(101,3,'ffdfđfdcđfđ','đfdfdfdfdd','2025-03-13 12:43:00','pending','medium','2025-03-13 12:43:29','2025-03-13 12:43:29',NULL,0),(102,3,'bbgbgbgb','gbgbgbgbgbgb','2025-03-13 12:43:00','pending','medium','2025-03-13 12:43:50','2025-03-13 12:43:50',NULL,0),(103,3,'pôppo','pôppopo','2025-03-13 12:45:00','pending','medium','2025-03-13 12:45:02','2025-03-13 12:45:02',NULL,0),(104,3,'bvbvbvb','vbvbvbvbvb','2025-03-13 12:45:00','in_progress','medium','2025-03-13 12:45:28','2025-03-13 16:52:36',NULL,0),(105,1,'gbgbggbg','bgbgbgbg','2025-03-13 12:46:00','pending','medium','2025-03-13 12:46:30','2025-03-13 12:46:30',NULL,0),(106,2,'xzxzxz','xzxzxx','2025-03-13 12:52:00','pending','medium','2025-03-13 12:52:30','2025-03-13 12:52:30',NULL,0),(107,2,'cxcxcxcx','ccxcxcxcxc','2025-03-12 17:00:00','pending','medium','2025-03-13 12:52:37','2025-03-13 12:52:37',NULL,0),(108,2,'mnnmnmnm','nmnmnmnmn','2025-03-13 12:52:00','pending','medium','2025-03-13 12:52:54','2025-03-13 12:52:54',NULL,0),(109,3,'bvbvbv','bvbvbvbv','2025-03-13 12:53:00','pending','medium','2025-03-13 12:53:32','2025-03-13 12:53:32',NULL,0),(110,3,'rere','êreree','2025-03-13 12:58:00','in_progress','medium','2025-03-13 12:58:19','2025-03-13 16:54:37',NULL,0),(111,1,'vb','vbvb','2025-03-13 12:58:00','completed','medium','2025-03-13 12:58:59','2025-03-14 13:43:43',NULL,0),(112,1,'nbn','bn','2025-03-13 13:01:00','completed','medium','2025-03-13 13:01:48','2025-03-14 13:43:43',NULL,0),(113,1,'mn','mn','2025-03-13 13:01:00','completed','medium','2025-03-13 13:01:59','2025-03-14 13:43:44',NULL,0),(114,2,'dsdsd','dsdsds','2025-03-13 13:03:00','pending','medium','2025-03-13 13:03:16','2025-03-13 13:03:16',NULL,0),(115,2,'cx','xcx','2025-03-13 13:03:00','in_progress','medium','2025-03-13 13:03:29','2025-03-13 16:29:48',NULL,0),(116,2,'xvxvxxv','xvxvvx','2025-03-13 13:50:00','in_progress','medium','2025-03-13 13:50:22','2025-03-13 16:29:48',NULL,0),(117,3,'fvfvfvfvfvf','fvfvfvfvfvf','2025-03-13 13:50:00','pending','medium','2025-03-13 13:50:59','2025-03-13 13:50:59',NULL,0),(118,NULL,'gdfds','dsfdsfsdf','2025-03-13 17:16:00','pending','medium','2025-03-13 17:16:25','2025-03-13 17:16:25',NULL,0),(119,3,'\'\'\'','\'\'\'\'','2025-03-13 17:18:00','pending','medium','2025-03-13 17:18:07','2025-03-13 17:18:07',NULL,0),(120,3,'hyhyhy','yhyhy','2025-03-14 10:18:00','completed','medium','2025-03-13 17:18:20','2025-03-14 02:35:24',29,0),(121,1,'đwd','ưdwdwdw','2025-03-13 17:50:00','pending','medium','2025-03-13 17:50:45','2025-03-13 17:50:45',NULL,0),(122,1,'fg','fgfg','2025-03-14 17:51:00','completed','medium','2025-03-13 17:51:32','2025-03-14 13:30:20',NULL,0),(123,1,'vvc','cvvvcv','2025-03-14 17:54:00','completed','medium','2025-03-13 17:54:03','2025-03-14 13:30:19',NULL,0),(124,1,'frfrrr','frfrfr',NULL,'pending','medium','2025-03-14 13:29:04','2025-03-14 13:29:04',42,0),(125,1,'hgtgh','hghgh','2025-03-16 07:35:00','in_progress','medium','2025-03-16 07:35:41','2025-03-16 07:38:26',NULL,NULL),(126,1,'vccvcv','vcvcvcv','2025-03-15 17:00:00','pending','medium','2025-03-16 07:37:42','2025-03-16 07:37:42',NULL,NULL),(127,1,'xvcvxv','xvcxvxvxv','2025-03-17 07:37:00','in_progress','medium','2025-03-16 07:37:54','2025-03-17 14:11:13',NULL,NULL),(128,1,'cbcv','cvcb','2025-03-16 07:38:00','in_progress','medium','2025-03-16 07:38:56','2025-03-16 07:39:12',34,NULL),(129,1,'olol','olol','2025-03-15 17:00:00','pending','medium','2025-03-16 07:39:10','2025-03-16 07:39:10',NULL,NULL),(130,1,'oloo','ololo','2025-03-16 07:39:00','pending','medium','2025-03-16 07:39:19','2025-03-16 07:39:19',NULL,NULL),(131,1,'ilioi,ik','hgjkhg','2025-03-16 07:39:00','pending','medium','2025-03-16 07:39:39','2025-03-16 07:39:39',NULL,NULL),(132,1,'zaaz','zaa','2025-03-16 08:13:00','pending','medium','2025-03-16 08:13:44','2025-03-16 08:13:44',33,NULL),(133,2,'hello world','xin chào thế giới','2025-03-18 13:05:00','pending','medium','2025-03-18 13:05:55','2025-03-18 13:05:55',NULL,NULL),(134,1,'hêwew','ưewewe','2025-03-18 15:16:00','completed','medium','2025-03-18 15:16:22','2025-03-18 16:14:02',NULL,NULL),(135,2,'ư','wdwdwwd','2025-03-18 15:17:00','pending','medium','2025-03-18 15:17:04','2025-03-18 15:17:04',NULL,NULL),(136,NULL,'jasdasdasdsad','adasdas','2025-03-18 15:20:00','pending','medium','2025-03-18 15:20:34','2025-03-18 15:20:34',NULL,NULL),(137,NULL,'được chưa 2','hello world','2025-03-18 14:51:00','pending','medium','2025-03-18 15:21:13','2025-03-18 15:21:13',NULL,NULL),(138,3,'xin chào','ádsads','2025-03-18 15:21:00','pending','medium','2025-03-18 15:21:28','2025-03-18 15:21:28',NULL,NULL),(139,NULL,'dữ liệu','',NULL,'pending','medium','2025-03-18 15:21:46','2025-03-18 15:21:46',NULL,NULL),(140,NULL,'đá','sadas','2025-03-18 15:22:00','pending','medium','2025-03-18 15:23:10','2025-03-18 15:23:10',NULL,NULL),(141,1,'ưe','ưe','2025-03-18 15:23:00','completed','medium','2025-03-18 15:23:24','2025-03-18 16:14:02',NULL,NULL),(142,NULL,'data','123',NULL,'pending','medium','2025-03-18 15:42:36','2025-03-18 15:42:36',NULL,NULL),(143,NULL,'123','123','2025-03-18 15:57:00','pending','medium','2025-03-18 15:57:26','2025-03-18 15:57:26',NULL,NULL),(144,2,'d','d','2025-03-18 16:10:00','pending','medium','2025-03-18 16:10:51','2025-03-18 16:10:51',NULL,NULL),(145,3,'fsd','dsf','2025-03-18 16:11:00','pending','medium','2025-03-18 16:11:31','2025-03-18 16:11:31',NULL,NULL),(146,NULL,'chưa lưu nữa','adas','2025-03-18 16:11:00','pending','medium','2025-03-18 16:11:51','2025-03-18 16:11:51',NULL,NULL),(147,NULL,'task nội bộ','adsasdas','2025-03-18 16:16:00','pending','medium','2025-03-18 16:16:28','2025-03-18 16:16:28',NULL,NULL),(148,NULL,'task lưu ','sđsds','2025-03-18 16:22:00','pending','medium','2025-03-18 16:23:11','2025-03-18 16:23:11',NULL,NULL),(149,1,'d','d','2025-03-18 16:23:00','in_progress','medium','2025-03-18 16:23:21','2025-03-18 16:28:13',NULL,NULL),(150,NULL,'a','a','2025-03-18 16:27:00','pending','medium','2025-03-18 16:27:58','2025-03-18 16:27:58',NULL,NULL),(151,1,'dư','dư','2025-03-17 17:00:00','pending','medium','2025-03-18 16:28:20','2025-03-18 16:28:20',NULL,NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar_url` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'phathuucm852','phamhuuphat852@gmail.com','$2b$10$mE2LZLx216Tfy/B9SPthve9Y6ArH8si9xlTF81FDktA/J2cE33Yza','C:\\Users\\phamh\\Downloads\\8046267-STAY-FOCUSED-Wallpaper.jpg','2025-03-08 11:38:27'),(2,'lekima','phatph.work@gmail.com','$2b$10$EiGZ.rwdSaORNLYznycMp.QJtqfNbLZxeePEXzztUvQ6uiPjRYTtW',NULL,'2025-03-13 09:27:36'),(3,'lyphi','phi@gmail.com','$2b$10$GVl61PpaKbyEPwyzbiSNZeZBQXHFA6Ua/hL4kukB/HwbzCdR8r8rG',NULL,'2025-03-13 09:51:27');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-19  0:42:09
