
-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: EMPROMED
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.21.10.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CompQuim`
--

DROP TABLE IF EXISTS `CompQuim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CompQuim` (
  `IDCQ` int NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `PH` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`IDCQ`,`nombre`),
  UNIQUE KEY `IDCQ` (`IDCQ`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CompQuim`
--

LOCK TABLES `CompQuim` WRITE;
/*!40000 ALTER TABLE `CompQuim` DISABLE KEYS */;
INSERT INTO `CompQuim` VALUES (201,'ciproheptadina','B'),(202,'dexclorfeniramina','B'),(203,'difenhidramina','B'),(204,'meclizina','B'),(205,'loratadina','B'),(207,'ketotifeno','B'),(208,'ambroxol','B');
/*!40000 ALTER TABLE `CompQuim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Departamentos`
--

DROP TABLE IF EXISTS `Departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Departamentos` (
  `IDDPT` int NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `tipo` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`IDDPT`),
  UNIQUE KEY `IDDPT` (`IDDPT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departamentos`
--

LOCK TABLES `Departamentos` WRITE;
/*!40000 ALTER TABLE `Departamentos` DISABLE KEYS */;
INSERT INTO `Departamentos` VALUES (305,'Dpto Tabp','P'),(306,'Dpto Jabp','P'),(307,'Dpto Tabc','C'),(308,'Dpto Jabc','C');
/*!40000 ALTER TABLE `Departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Elabora`
--

DROP TABLE IF EXISTS `Elabora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Elabora` (
  `CPROD` int NOT NULL,
  `CCQ` int NOT NULL,
  KEY `CPROD` (`CPROD`),
  KEY `CCQ` (`CCQ`),
  CONSTRAINT `Elabora_ibfk_1` FOREIGN KEY (`CPROD`) REFERENCES `ProdFarm` (`IDP`) ON DELETE CASCADE,
  CONSTRAINT `Elabora_ibfk_2` FOREIGN KEY (`CCQ`) REFERENCES `CompQuim` (`IDCQ`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Elabora`
--

LOCK TABLES `Elabora` WRITE;
/*!40000 ALTER TABLE `Elabora` DISABLE KEYS */;
INSERT INTO `Elabora` VALUES (101,202),(102,203),(103,204),(104,205),(105,208),(106,207),(108,201),(109,203),(110,202);
/*!40000 ALTER TABLE `Elabora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Evaluacion`
--

DROP TABLE IF EXISTS `Evaluacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Evaluacion` (
  `IDEVAL` int NOT NULL,
  `fecha` date DEFAULT NULL,
  `resultado` varchar(1) DEFAULT NULL,
  `CPROD` int NOT NULL,
  `CIRESP` bigint NOT NULL,
  PRIMARY KEY (`IDEVAL`),
  UNIQUE KEY `IDEVAL` (`IDEVAL`),
  KEY `CPROD` (`CPROD`),
  KEY `CIRESP` (`CIRESP`),
  CONSTRAINT `Evaluacion_ibfk_1` FOREIGN KEY (`CPROD`) REFERENCES `Produccion` (`IDPROC`) ON DELETE CASCADE,
  CONSTRAINT `Evaluacion_ibfk_2` FOREIGN KEY (`CIRESP`) REFERENCES `Trabajador` (`CI`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Evaluacion`
--

LOCK TABLES `Evaluacion` WRITE;
/*!40000 ALTER TABLE `Evaluacion` DISABLE KEYS */;
INSERT INTO `Evaluacion` VALUES (201,'2021-10-24','A',654,90051246041),(202,'2021-09-12','A',659,90051246041),(203,'2019-03-10','A',653,90051246041),(204,'2021-03-31','A',655,81031723668),(205,'2022-01-30','D',651,81031723668),(206,'2018-07-10','D',652,81031723668),(207,'2020-02-24','A',657,90051246041),(208,'2021-10-24','D',650,81031723668),(209,'2022-02-24','A',658,90051246041),(210,'2021-12-09','A',656,81031723668);
/*!40000 ALTER TABLE `Evaluacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProdFarm`
--

DROP TABLE IF EXISTS `ProdFarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProdFarm` (
  `IDP` int NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `fecha_venc` date DEFAULT NULL,
  `tipo` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`IDP`),
  UNIQUE KEY `IDP` (`IDP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProdFarm`
--

LOCK TABLES `ProdFarm` WRITE;
/*!40000 ALTER TABLE `ProdFarm` DISABLE KEYS */;
INSERT INTO `ProdFarm` VALUES (101,'Maleato Dexclorfeniramina','2030-10-05','T'),(102,'Clohidrato Difenhidramina','2026-03-02','T'),(103,'Clohidrato Meclizina','2022-05-06','T'),(104,'Loratadina','2025-09-03','J'),(105,'Ambroxol','2022-07-01','J'),(106,'Kogrip','2026-12-09','T'),(107,'Ketotifeno','2025-11-04','T'),(108,'Clohidrato Ciproheptain','2025-05-06','T'),(109,'Clohidrato Difenhidramina','2022-09-30','J'),(110,'Maleato Dexclorfeniramina','2024-03-26','J');
/*!40000 ALTER TABLE `ProdFarm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Produccion`
--

DROP TABLE IF EXISTS `Produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Produccion` (
  `IDPROC` int NOT NULL,
  `fecha` date DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `CPROD` int NOT NULL,
  `CDEP` int NOT NULL,
  `CIRESP` bigint NOT NULL,
  PRIMARY KEY (`IDPROC`),
  UNIQUE KEY `IDPROC` (`IDPROC`),
  KEY `CPROD` (`CPROD`),
  KEY `CDEP` (`CDEP`),
  KEY `CIRESP` (`CIRESP`),
  CONSTRAINT `Produccion_ibfk_1` FOREIGN KEY (`CPROD`) REFERENCES `ProdFarm` (`IDP`) ON DELETE CASCADE,
  CONSTRAINT `Produccion_ibfk_2` FOREIGN KEY (`CDEP`) REFERENCES `Departamentos` (`IDDPT`) ON DELETE CASCADE,
  CONSTRAINT `Produccion_ibfk_3` FOREIGN KEY (`CIRESP`) REFERENCES `Trabajador` (`CI`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Produccion`
--

LOCK TABLES `Produccion` WRITE;
/*!40000 ALTER TABLE `Produccion` DISABLE KEYS */;
INSERT INTO `Produccion` VALUES (650,'2021-10-22',1305,105,306,82061907233),(651,'2022-01-25',1400,110,306,82061907233),(652,'2018-06-30',2500,109,306,82061907233),(653,'2019-02-28',2700,101,305,93032245841),(654,'2021-10-22',6800,103,305,93032245841),(655,'2021-03-26',1500,109,306,82061907233),(656,'2021-11-30',3400,104,306,82061907233),(657,'2020-02-18',2287,106,305,93032245841),(658,'2022-02-13',2665,102,305,93032245841),(659,'2021-09-06',6412,103,305,93032245841);
/*!40000 ALTER TABLE `Produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Realiza`
--

DROP TABLE IF EXISTS `Realiza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Realiza` (
  `CPROD` int NOT NULL,
  `CDPT` int NOT NULL,
  KEY `CPROD` (`CPROD`),
  KEY `CDPT` (`CDPT`),
  CONSTRAINT `Realiza_ibfk_1` FOREIGN KEY (`CPROD`) REFERENCES `ProdFarm` (`IDP`) ON DELETE CASCADE,
  CONSTRAINT `Realiza_ibfk_2` FOREIGN KEY (`CDPT`) REFERENCES `Departamentos` (`IDDPT`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Realiza`
--

LOCK TABLES `Realiza` WRITE;
/*!40000 ALTER TABLE `Realiza` DISABLE KEYS */;
INSERT INTO `Realiza` VALUES (101,305),(102,305),(103,305),(104,306),(105,306),(106,305),(107,305),(108,305),(109,306),(110,306);
/*!40000 ALTER TABLE `Realiza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trabajador`
--

DROP TABLE IF EXISTS `Trabajador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trabajador` (
  `CI` bigint NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `edad` smallint DEFAULT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `cargo` varchar(250) DEFAULT NULL,
  `anhios_trabajo` smallint DEFAULT NULL,
  `CDEP` int NOT NULL,
  `salario` float DEFAULT NULL,
  PRIMARY KEY (`CI`),
  UNIQUE KEY `CI` (`CI`),
  KEY `CDEP` (`CDEP`),
  CONSTRAINT `Trabajador_ibfk_1` FOREIGN KEY (`CDEP`) REFERENCES `Departamentos` (`IDDPT`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trabajador`
--

LOCK TABLES `Trabajador` WRITE;
/*!40000 ALTER TABLE `Trabajador` DISABLE KEYS */;
INSERT INTO `Trabajador` VALUES (63101024320,'Alfredo Benitez Garcia',59,'M','Obrero',26,306,3587.5),(67092107791,'Rafael Aranon Leyva',55,'M','Obrero',22,308,3881.31),(73082610127,'Reymen E. Naturell Orozco',49,'M','Admon',20,306,3630.16),(74090510568,'Rose Pinza Castillo',48,'F','Admon',22,305,3630.14),(75030911703,'Eduardo Calas Fernadez',47,'M','Obrero',18,305,4719.6),(81031723668,'Yoandris Del Rosario Alvarez',41,'M','Jefa Personal',20,308,5663.59),(82061907233,'Yunaris Alfonzo Gamboa',40,'F','Jefa Dpto',18,306,6608.47),(86012626763,'Nacir Naster Rey',36,'M','Obrero',12,307,3146.25),(90051246041,'Andy Ernesto Lazaro Gomez',32,'M','Jefe Personal',10,307,4680.19),(93032245841,'Roger Luis Revilla limonta',29,'M','Jefe Dpto',5,305,5772.2);
/*!40000 ALTER TABLE `Trabajador` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-13  1:11:56
