-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: wk_testetecnico
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `CLI_CODIGO` int NOT NULL AUTO_INCREMENT,
  `CLI_NOME` varchar(200) NOT NULL,
  `CLI_CIDADE` varchar(100) DEFAULT NULL,
  `CLI_UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`CLI_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'LUIZ SOUZA','ARACAJU','SE'),(2,'JULIANA','ARACAJU','SE'),(3,'MARIA ALICE','ARACAJU','SE'),(4,'JOAO','BOQUIM','SE'),(5,'ARAO','LARANJEIRAS','SE'),(6,'MARIA','ARACAJU','SE'),(7,'FIDELINA','ARACAJU','SE'),(8,'LINDAURA','ARACAJU','SE'),(9,'LAURA','ARACAJU','SE'),(10,'LUIZ','ARACAJU','SE'),(11,'DANIEL','ARACAJU','SE'),(12,'DEIVIDY','ARACAJU','SE'),(13,'CARLOS','ARACAJU','SE'),(14,'JADE','ARACAJU','SE'),(15,'APOLO','ARACAJU','SE'),(16,'DANTE','ARACAJU','SE'),(17,'PIUI','ARACAJU','SE'),(18,'JOHNNY','ARACAJU','SE'),(19,'CANDIDO','ARACAJU','SE'),(20,'JHON','ARACAJU','SE');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `PED_CODIGO` int NOT NULL AUTO_INCREMENT,
  `PED_DATA_EMISSAO` timestamp NOT NULL,
  `PED_CLI_CODIGO` int NOT NULL,
  `PED_TOTAL` double NOT NULL,
  PRIMARY KEY (`PED_CODIGO`),
  KEY `PEDIDO_FK` (`PED_CLI_CODIGO`),
  CONSTRAINT `PEDIDO_FK` FOREIGN KEY (`PED_CLI_CODIGO`) REFERENCES `cliente` (`CLI_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2021-12-01 13:12:49',5,5.98);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_detalhe`
--

DROP TABLE IF EXISTS `pedido_detalhe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_detalhe` (
  `DET_ID` int NOT NULL AUTO_INCREMENT,
  `DET_PED_CODIGO` int NOT NULL,
  `DET_PROD_CODIGO` int NOT NULL,
  `DET_QUANTIDADE` double NOT NULL DEFAULT '0',
  `DET_VALOR_UNIT` double DEFAULT '0',
  `DET_VALOR_TOTAL` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`DET_ID`),
  KEY `PEDIDO_DETALHE_FK` (`DET_PED_CODIGO`),
  KEY `PEDIDO_DETALHE_FK_1` (`DET_PROD_CODIGO`),
  CONSTRAINT `PEDIDO_DETALHE_FK` FOREIGN KEY (`DET_PED_CODIGO`) REFERENCES `pedido` (`PED_CODIGO`),
  CONSTRAINT `PEDIDO_DETALHE_FK_1` FOREIGN KEY (`DET_PROD_CODIGO`) REFERENCES `produto` (`PROD_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_detalhe`
--

LOCK TABLES `pedido_detalhe` WRITE;
/*!40000 ALTER TABLE `pedido_detalhe` DISABLE KEYS */;
INSERT INTO `pedido_detalhe` VALUES (35,1,4,1,1,1),(36,1,7,1,5,5);
/*!40000 ALTER TABLE `pedido_detalhe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `PROD_CODIGO` int NOT NULL AUTO_INCREMENT,
  `PROD_DESCRICAO` varchar(100) DEFAULT NULL,
  `PROD_PRECO_VENDA` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`PROD_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'FEIJAO 1K',5.99),(2,'ARROZ',2.99),(3,'REFRI COLA',8.99),(4,'TUBAINA',0.99),(5,'CERVEJA',3.99),(6,'CEREJA',7.99),(7,'FARINHA',4.99),(8,'PAPEL',4.99),(9,'CADEIRA',11.99),(10,'BORNAL',110.99),(11,'BISCOITO',0.99),(12,'QUEIJO',19.99),(13,'PRESUNTO',19.99),(14,'MANTEIGA',19.99),(15,'IOGURTE',19.99),(16,'BOLACHA',19.99),(17,'TINTA GUACHE',1.99),(18,'MASSA MODELAR',7.99),(19,'CARRINHO',5.99),(20,'AGUA',2.99);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wk_testetecnico'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-01 10:19:15
