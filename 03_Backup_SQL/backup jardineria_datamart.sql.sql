-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: staging_jardineria
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `stg_cliente`
--

DROP TABLE IF EXISTS `stg_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stg_cliente` (
  `ID_cliente` int NOT NULL DEFAULT '0',
  `nombre_cliente` varchar(50) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `limite_credito` decimal(15,2) DEFAULT NULL,
  `ID_empleado_rep_ventas` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_cliente`
--

LOCK TABLES `stg_cliente` WRITE;
/*!40000 ALTER TABLE `stg_cliente` DISABLE KEYS */;
INSERT INTO `stg_cliente` VALUES (1,'Cliente Uno','Barcelona','España',5000.00,1),(2,'Cliente Dos','Madrid','España',8000.00,3),(3,'Cliente Tres','Sevilla','España',6000.00,1);
/*!40000 ALTER TABLE `stg_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stg_detalle_pedido`
--

DROP TABLE IF EXISTS `stg_detalle_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stg_detalle_pedido` (
  `ID_detalle_pedido` int NOT NULL DEFAULT '0',
  `ID_pedido` int DEFAULT NULL,
  `ID_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unidad` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_detalle_pedido`
--

LOCK TABLES `stg_detalle_pedido` WRITE;
/*!40000 ALTER TABLE `stg_detalle_pedido` DISABLE KEYS */;
INSERT INTO `stg_detalle_pedido` VALUES (1,1,1,10,10.50),(2,1,2,5,7.80),(3,2,3,3,25.00),(4,3,1,7,10.50);
/*!40000 ALTER TABLE `stg_detalle_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stg_empleado`
--

DROP TABLE IF EXISTS `stg_empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stg_empleado` (
  `ID_empleado` int NOT NULL DEFAULT '0',
  `nombre` varchar(50) DEFAULT NULL,
  `apellido1` varchar(50) DEFAULT NULL,
  `puesto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_empleado`
--

LOCK TABLES `stg_empleado` WRITE;
/*!40000 ALTER TABLE `stg_empleado` DISABLE KEYS */;
INSERT INTO `stg_empleado` VALUES (1,'Juan','Pérez','Representante Ventas'),(2,'María','Gómez','Gerente'),(3,'Carlos','López','Representante Ventas');
/*!40000 ALTER TABLE `stg_empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stg_pedido`
--

DROP TABLE IF EXISTS `stg_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stg_pedido` (
  `ID_pedido` int NOT NULL DEFAULT '0',
  `ID_cliente` int DEFAULT NULL,
  `fecha_pedido` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_pedido`
--

LOCK TABLES `stg_pedido` WRITE;
/*!40000 ALTER TABLE `stg_pedido` DISABLE KEYS */;
INSERT INTO `stg_pedido` VALUES (1,1,'2025-09-01'),(2,2,'2025-09-02'),(3,3,'2025-09-03');
/*!40000 ALTER TABLE `stg_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stg_producto`
--

DROP TABLE IF EXISTS `stg_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stg_producto` (
  `ID_producto` int NOT NULL DEFAULT '0',
  `CodigoProducto` varchar(15) DEFAULT NULL,
  `nombre` varchar(70) DEFAULT NULL,
  `Categoria` int DEFAULT NULL,
  `precio_venta` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_producto`
--

LOCK TABLES `stg_producto` WRITE;
/*!40000 ALTER TABLE `stg_producto` DISABLE KEYS */;
INSERT INTO `stg_producto` VALUES (1,'P001','Rosa Roja',1,10.50),(2,'P002','Tulipán Amarillo',1,7.80),(3,'P003','Orquídea Blanca',2,25.00);
/*!40000 ALTER TABLE `stg_producto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-29 22:19:23
