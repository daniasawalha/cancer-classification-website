-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: projct
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `pictures`
--

DROP TABLE IF EXISTS `pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pictures` (
  `idpictures` int NOT NULL,
  `states` varchar(45) NOT NULL,
  `directory` varchar(100) NOT NULL,
  PRIMARY KEY (`idpictures`),
  UNIQUE KEY `idpictures_UNIQUE` (`idpictures`),
  UNIQUE KEY `directory_UNIQUE` (`directory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pictures`
--

LOCK TABLES `pictures` WRITE;
/*!40000 ALTER TABLE `pictures` DISABLE KEYS */;
INSERT INTO `pictures` VALUES (114602024,'1','D:\\deployment\\prj\\images\\114602024.0.jpeg'),(123632024,'1','D:\\deployment\\prj\\images\\image_1.jpeg'),(221062024,'1','D:\\deployment\\prj\\images\\221062024.0.jpeg'),(232952024,'1','D:\\deployment\\prj\\images\\232952024.0.jpeg'),(234232024,'1','D:\\deployment\\prj\\images\\234232024.0.jpeg'),(246762024,'1','D:\\deployment\\prj\\images\\246762024.0.jpeg'),(304602024,'1','D:\\deployment\\prj\\images\\304602024.0.jpeg'),(340792024,'2','D:\\deployment\\prj\\images\\340792024.0.jpeg'),(390072024,'1','D:\\deployment\\prj\\images\\390072024.0.jpeg'),(470502024,'1','D:\\deployment\\prj\\images\\470502024.0.jpeg'),(613062024,'3','D:\\deployment\\prj\\images\\613062024.0.jpeg'),(662652024,'3','D:\\deployment\\prj\\images\\662652024.0.jpeg'),(680482024,'3','D:\\deployment\\prj\\images\\680482024.0.jpeg'),(681702024,'2','D:\\deployment\\prj\\images\\681702024.0.jpeg'),(738752024,'1','D:\\deployment\\prj\\images\\738752024.0.jpeg'),(772812024,'1','D:\\deployment\\prj\\images\\772812024.0.jpeg'),(790242024,'1','D:\\deployment\\prj\\images\\790242024.0.jpeg'),(798092024,'1','D:\\deployment\\prj\\images\\798092024.0.jpeg'),(833232024,'3','D:\\deployment\\prj\\images\\833232024.0.jpeg'),(834902024,'1','D:\\deployment\\prj\\images\\834902024.0.jpeg'),(851942024,'1','D:\\deployment\\prj\\images\\851942024.0.jpeg'),(878442024,'1','D:\\deployment\\prj\\images\\878442024.0.jpeg'),(945052024,'1','D:\\deployment\\prj\\images\\945052024.0.jpeg'),(963422024,'1','D:\\deployment\\prj\\images\\963422024.0.jpeg'),(967572024,'1','D:\\deployment\\prj\\images\\967572024.0.jpeg'),(969672024,'1','D:\\deployment\\prj\\images\\969672024.0.jpeg');
/*!40000 ALTER TABLE `pictures` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-24 23:20:59
