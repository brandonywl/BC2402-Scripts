CREATE DATABASE  IF NOT EXISTS `sql_2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sql_2`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: sql_2
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branchno` varchar(4) NOT NULL,
  `street` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`branchno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('B003','163 Main St'),('B005','1 Nanyang Ave'),('B007','123 Raffles Street');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_t`
--

DROP TABLE IF EXISTS `customer_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_t` (
  `CUSTOMER_ID` decimal(11,0) NOT NULL,
  `CUSTOMER_NAME` varchar(25) NOT NULL,
  `CUSTOMER_ADDRESS` varchar(30) DEFAULT NULL,
  `CITY` varchar(20) DEFAULT NULL,
  `STATE` varchar(2) DEFAULT NULL,
  `POSTAL_CODE` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`CUSTOMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_t`
--

LOCK TABLES `customer_t` WRITE;
/*!40000 ALTER TABLE `customer_t` DISABLE KEYS */;
INSERT INTO `customer_t` VALUES (1,'Ben Choi','1 Nanyang Ave','Jurong','JR','321231'),(2,'Jayden Choi','23 Sengkang Street','Sengkang','SK','543125'),(3,'Cammy Soh','88 Wealthy Road','Richland','RR','233132'),(4,'Steve Job','1 Apple Tree Way','Appletown','CA','342323'),(5,'Bill Gates','0 Windows Drive','Billsville','CA','342321');
/*!40000 ALTER TABLE `customer_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_line_t`
--

DROP TABLE IF EXISTS `order_line_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_line_t` (
  `order_id` decimal(11,0) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ordered_quantity` decimal(11,0) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `ORDER_LINE_FK2_idx` (`product_id`),
  CONSTRAINT `ORDER_LINE_FK1` FOREIGN KEY (`order_id`) REFERENCES `order_t` (`order_id`),
  CONSTRAINT `ORDER_LINE_FK2` FOREIGN KEY (`product_id`) REFERENCES `product_t` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_line_t`
--

LOCK TABLES `order_line_t` WRITE;
/*!40000 ALTER TABLE `order_line_t` DISABLE KEYS */;
INSERT INTO `order_line_t` VALUES (5101,8880,2),(5101,8882,4),(5101,8887,2),(5102,8885,3),(5102,8889,1),(5103,8883,2),(5103,8888,1),(5103,8889,10),(5104,8883,1),(5105,8880,1),(5105,8881,3),(5105,8882,2),(5105,8886,5),(5106,8881,25),(5106,8884,30),(5106,8887,40),(5106,8889,90);
/*!40000 ALTER TABLE `order_line_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_t`
--

DROP TABLE IF EXISTS `order_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_t` (
  `order_id` decimal(11,0) NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` decimal(11,0) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `order_fk_idx` (`customer_id`),
  CONSTRAINT `order_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer_t` (`CUSTOMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_t`
--

LOCK TABLES `order_t` WRITE;
/*!40000 ALTER TABLE `order_t` DISABLE KEYS */;
INSERT INTO `order_t` VALUES (5101,'2018-10-18 09:18:03',1),(5102,'2018-10-18 09:18:03',1),(5103,'2018-10-18 09:18:30',2),(5104,'2018-10-18 09:18:30',1),(5105,'2018-10-18 09:18:30',4),(5106,'2018-10-18 09:18:47',4);
/*!40000 ALTER TABLE `order_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_t`
--

DROP TABLE IF EXISTS `product_t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_t` (
  `product_id` int(11) NOT NULL,
  `product_description` varchar(50) DEFAULT NULL,
  `product_finish` varchar(20) DEFAULT NULL,
  `standard_price` decimal(6,2) DEFAULT NULL,
  `product_line_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_t`
--

LOCK TABLES `product_t` WRITE;
/*!40000 ALTER TABLE `product_t` DISABLE KEYS */;
INSERT INTO `product_t` VALUES (8880,'A big table','Natrual Ash',1000.00,NULL),(8881,'A small table','White Ash',500.00,NULL),(8882,'Bossy chair','Natural Oak',5000.00,NULL),(8883,'Dinning table','Cherry',8800.00,NULL),(8884,'Classic bookshelf','Red Oak',9000.00,NULL),(8885,'Modern bookshelf','Walnut',4300.00,NULL),(8886,'Vector bookshelf','Natural Oak',2000.00,NULL),(8887,'Lousy bookshelf','Walnut',100.00,NULL),(8888,'Coffee table','Cherry',50.00,NULL),(8889,'Wooden school chair','Natural Ash',35.00,NULL);
/*!40000 ALTER TABLE `product_t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propertyforrent`
--

DROP TABLE IF EXISTS `propertyforrent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propertyforrent` (
  `propertyNo` varchar(10) NOT NULL,
  `street` varchar(100) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `postcode` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `rooms` int(11) DEFAULT NULL,
  `rent` int(11) DEFAULT NULL,
  `staffNo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`propertyNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propertyforrent`
--

LOCK TABLES `propertyforrent` WRITE;
/*!40000 ALTER TABLE `propertyforrent` DISABLE KEYS */;
INSERT INTO `propertyforrent` VALUES ('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'SG14'),('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'SG88888'),('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'SG5');
/*!40000 ALTER TABLE `propertyforrent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staffNo` varchar(4) NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `position` varchar(45) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `DOB` varchar(45) DEFAULT NULL,
  `salary` decimal(10,0) DEFAULT NULL,
  `branchNo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`staffNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('SA9','Mary','Howe','Assistant','F','19-Feb-70',9000,'B007'),('SG14','David','Ford','Supervisor','M','24-Mar-58',18000,'B003'),('SG37','Ann','Beech','Assistant','F','10-Nov-60',12000,'B003'),('SG5','Susan','Brand','Manager','F','3-Jun-40',24000,'B003'),('SL21','John','White','Manager','M','1-Oct-45',30000,'B005'),('SL41','Julie','Lee','Assistant','F','13-Jun-45',9000,'B005');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-05 13:48:58
