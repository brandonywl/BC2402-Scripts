CREATE DATABASE  IF NOT EXISTS `university` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `university`;
-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: university
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `course` (
  `CourseID` int(11) NOT NULL,
  `CourseName` varchar(255) DEFAULT NULL,
  `CourseCredit` int(11) DEFAULT NULL,
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (8881,'Database 1',4),(8882,'Database 2',4),(8883,'Financial Accounting',4),(8884,'Managerial Accounting',4),(8885,'Big Data 1',4),(8886,'Big Data 2',4),(9887,'Advanced Database Development',4);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseinsemester`
--

DROP TABLE IF EXISTS `courseinsemester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `courseinsemester` (
  `CourseID` int(11) NOT NULL,
  `Sem` int(11) NOT NULL,
  `Year` varchar(4) NOT NULL,
  `InstructorID` int(11) NOT NULL,
  PRIMARY KEY (`CourseID`,`Sem`,`Year`,`InstructorID`),
  KEY `CourseInSem_FK2_idx` (`InstructorID`),
  CONSTRAINT `CourseInSem_FK1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`courseid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CourseInSem_FK2` FOREIGN KEY (`InstructorID`) REFERENCES `instructor` (`instructorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseinsemester`
--

LOCK TABLES `courseinsemester` WRITE;
/*!40000 ALTER TABLE `courseinsemester` DISABLE KEYS */;
INSERT INTO `courseinsemester` VALUES (8881,1,'2018',5501),(8884,2,'2018',5501),(8885,2,'2018',5501),(8881,1,'2018',5502),(8882,1,'2018',5502),(8883,2,'2018',5502),(8885,2,'2018',5502),(8882,1,'2018',5503),(8884,2,'2018',5503),(8886,2,'2018',5503),(8882,1,'2018',5504),(8883,2,'2018',5505),(8885,2,'2018',5505),(8886,2,'2018',5505),(8884,1,'2018',5506),(9887,1,'2018',5507);
/*!40000 ALTER TABLE `courseinsemester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `enrollment` (
  `StudentID` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `Sem` int(11) NOT NULL,
  `Year` varchar(4) NOT NULL,
  `InstructorID` int(11) NOT NULL,
  `SectionID` int(11) DEFAULT NULL,
  `Grade` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`StudentID`,`CourseID`,`Year`,`InstructorID`,`Sem`),
  KEY `enrollment_FK3_idx` (`Sem`),
  KEY `enrollment_FK4_idx` (`Year`),
  KEY `enrollment_FK5_idx` (`InstructorID`),
  KEY `enrollment_FK2_idx` (`CourseID`,`Sem`,`Year`,`InstructorID`),
  KEY `enrollment_FK3_idx1` (`SectionID`),
  CONSTRAINT `enrollment_FK1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`studentid`),
  CONSTRAINT `enrollment_FK2` FOREIGN KEY (`CourseID`, `Sem`, `Year`, `InstructorID`) REFERENCES `courseinsemester` (`courseid`, `sem`, `year`, `instructorid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES (1000,8885,2,'2018',5501,10,'A'),(1000,8886,2,'2018',5505,14,'D'),(1001,8884,2,'2018',5501,11,'A'),(1001,8886,2,'2018',5505,14,'B'),(1002,8886,2,'2018',5505,14,'A'),(1003,8882,1,'2018',5502,12,'B'),(1003,8886,2,'2018',5505,14,'B'),(1004,8881,1,'2018',5502,13,'C'),(1006,8881,1,'2018',5502,13,'F'),(1006,8885,2,'2018',5501,10,'A'),(1007,8885,2,'2018',5501,10,'A'),(1007,8886,2,'2018',5505,14,'F');
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `instructor` (
  `InstructorID` int(11) NOT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`InstructorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES (5501,'John','Chua'),(5502,'Kris','Tan'),(5503,'Jonathan','Ng'),(5504,'Emily','Jo'),(5505,'CK','Park'),(5506,'Chris','Pattern'),(5507,'WuSin','Yi');
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `section` (`CourseID` int(11) NOT NULL,
  `Sem` int(11) NOT NULL,
  `Year` varchar(4) NOT NULL,
  `InstructorID` int(11) NOT NULL,
  `SectionID` int(11) NOT NULL,
  PRIMARY KEY (`SectionID`),
  KEY `section_FK1_idx` (`CourseID`,`Sem`,`Year`,`InstructorID`),
  CONSTRAINT `section_FK1` FOREIGN KEY (`CourseID`, `Sem`, `Year`, `InstructorID`) REFERENCES `courseinsemester` (`courseid`, `sem`, `year`, `instructorid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (8881,1,'2018',5502,13),(8882,1,'2018',5502,12),(8884,2,'2018',5501,11),(8885,2,'2018',5501,10),(8886,2,'2018',5505,14),(9887,1,'2018',5507,15);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `student` (
  `StudentID` int(11) NOT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  PRIMARY KEY (`StudentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1000,'Ben','Choi','M',21),(1001,'Jayden','Choi','M',20),(1002,'Cammy','Soh','F',22),(1003,'Kenny','Johnson','M',19),(1004,'Sharon','Tan','F',21),(1005,'Susan','Brown','F',23),(1006,'Ben','Tan','M',22),(1007,'Ben','Ng','F',20);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-09 11:57:43
