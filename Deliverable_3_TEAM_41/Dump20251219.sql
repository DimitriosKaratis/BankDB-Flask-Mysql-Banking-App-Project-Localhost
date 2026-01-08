-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: BankDB
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `AccountID` int NOT NULL,
  `AccountNumber` char(27) NOT NULL,
  `OpeningDate` date NOT NULL,
  `Currency` char(3) NOT NULL,
  `Status` varchar(15) NOT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`AccountID`),
  UNIQUE KEY `AccountNumber_UNIQUE` (`AccountNumber`),
  KEY `fk_account_CustomerID_idx` (`CustomerID`),
  CONSTRAINT `fk_account_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'GR1634441234567890123456789','2020-03-02','EUR','Active',1),(2,'GR1311891434567890123456789','2021-10-02','EUR','Active',1),(3,'GR1223459876543210123456789','2021-07-10','EUR','Active',2),(4,'GR1034562345678901234567899','2022-01-15','EUR','Active',3),(5,'GR1745673456789012345678900','2023-05-12','USD','Active',3),(6,'GR1356784567890123456789010','2023-08-30','GBP','Active',3),(7,'GR1167895678901234567890121','2023-10-01','EUR','Active',4),(8,'GR1478906789012345678901231','2023-11-05','USD','Active',5),(9,'GR1589017890123456789012342','2023-12-15','GBP','Active',5),(10,'GR1990128901234567890123453','2024-01-20','EUR','Active',6),(11,'GR2001239012345678901234564','2024-02-10','USD','Closed',6);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_transaction`
--

DROP TABLE IF EXISTS `account_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_transaction` (
  `TransactionID` int NOT NULL,
  `AccountID` int NOT NULL,
  `MovementType` varchar(20) NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `fk_account_trans_AccountID_idx` (`AccountID`),
  CONSTRAINT `fk_account_trans_AccountID` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`),
  CONSTRAINT `fk_account_trans_TransactionID` FOREIGN KEY (`TransactionID`) REFERENCES `transaction` (`TransactionID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_transaction`
--

LOCK TABLES `account_transaction` WRITE;
/*!40000 ALTER TABLE `account_transaction` DISABLE KEYS */;
INSERT INTO `account_transaction` VALUES (1,3,'Withdrawal'),(2,4,'Deposit'),(3,3,'LoanPayment'),(4,3,'Transfer_IN'),(5,4,'Transfer_OUT'),(6,4,'LoanPayment');
/*!40000 ALTER TABLE `account_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `accounts_balance`
--

DROP TABLE IF EXISTS `accounts_balance`;
/*!50001 DROP VIEW IF EXISTS `accounts_balance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `accounts_balance` AS SELECT 
 1 AS `AccountID`,
 1 AS `AccSum`,
 1 AS `CrPaySum`,
 1 AS `DebSum`,
 1 AS `Balance`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bank_branch`
--

DROP TABLE IF EXISTS `bank_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_branch` (
  `BranchID` int NOT NULL,
  `OperatingHours` char(11) NOT NULL,
  `Address` varchar(60) NOT NULL,
  PRIMARY KEY (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_branch`
--

LOCK TABLES `bank_branch` WRITE;
/*!40000 ALTER TABLE `bank_branch` DISABLE KEYS */;
INSERT INTO `bank_branch` VALUES (1,'07:00-14:00','Peiraios 110, 11854, Gazi'),(2,'07:00-14:00','Sofokleous 10, 10552, Omonoia'),(3,'08:00-15:00','Aristotelous 62, 10433, Plateia Vathis'),(4,'08:00-15:00','3is Septemvriou 100, 10434, Plateia Attikis'),(5,'08:00-15:00','Ippokratous 15, 10679, Kolonaki');
/*!40000 ALTER TABLE `bank_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_branch_email`
--

DROP TABLE IF EXISTS `bank_branch_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_branch_email` (
  `BranchID` int NOT NULL,
  `Email` varchar(40) NOT NULL,
  PRIMARY KEY (`BranchID`,`Email`),
  CONSTRAINT `fk_email_BranchID` FOREIGN KEY (`BranchID`) REFERENCES `bank_branch` (`BranchID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_branch_email`
--

LOCK TABLES `bank_branch_email` WRITE;
/*!40000 ALTER TABLE `bank_branch_email` DISABLE KEYS */;
INSERT INTO `bank_branch_email` VALUES (1,'central@bank.gr'),(2,'second@bank.gr'),(3,'third@bank.gr'),(4,'fourth@bank.gr'),(4,'fourthB@bank.gr'),(5,'fifth@bank.gr');
/*!40000 ALTER TABLE `bank_branch_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_branch_tel`
--

DROP TABLE IF EXISTS `bank_branch_tel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_branch_tel` (
  `BranchID` int NOT NULL,
  `Tel` char(10) NOT NULL,
  PRIMARY KEY (`BranchID`,`Tel`),
  CONSTRAINT `fk_tel_BranchID` FOREIGN KEY (`BranchID`) REFERENCES `bank_branch` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_branch_tel`
--

LOCK TABLES `bank_branch_tel` WRITE;
/*!40000 ALTER TABLE `bank_branch_tel` DISABLE KEYS */;
INSERT INTO `bank_branch_tel` VALUES (1,'2101234567'),(2,'2310123456'),(3,'2107654321'),(4,'2316111054'),(4,'2316789054'),(5,'2103345678');
/*!40000 ALTER TABLE `bank_branch_tel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card` (
  `CardID` int NOT NULL,
  `CardNumber` char(16) NOT NULL,
  `CardholderName` varchar(40) NOT NULL,
  `CVV` char(3) NOT NULL,
  `ExpirationDate` date NOT NULL,
  `Status` varchar(15) NOT NULL,
  PRIMARY KEY (`CardID`),
  UNIQUE KEY `CardNumber_UNIQUE` (`CardNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (1,'1234567890123456','Maria Papadopoulou','123','2027-05-01','Active'),(2,'2345678901234567','Maria Papadopoulou','482','2026-11-01','Frozen'),(3,'3456789012345678','Maria Papadopoulou','301','2028-09-15','Active'),(4,'4567890123456789','Elena Dimitriou','559','2027-06-23','Active'),(5,'5678901234567890','Elena Dimitriou','741','2029-02-18','Active'),(6,'6789012345678901','Maria Papadopoulou','102','2028-03-14','Active'),(7,'7890123456789012','Nikos Georgiou','305','2029-07-12','Active'),(8,'8901234567890123','Nikos Georgiou','420','2027-01-29','Active'),(9,'9012345678901234','Elena Dimitriou','591','2029-11-10','Frozen'),(10,'0123456789012345','Elena Dimitriou','678','2028-06-25','Active');
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_transaction`
--

DROP TABLE IF EXISTS `card_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card_transaction` (
  `TransactionID` int NOT NULL,
  `TerminalNumber` int NOT NULL,
  `CardID` int NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `fk_card_trans_CardID_idx` (`CardID`),
  CONSTRAINT `fk_card_trans_CardID` FOREIGN KEY (`CardID`) REFERENCES `card` (`CardID`),
  CONSTRAINT `fk_card_trans_TransactionID` FOREIGN KEY (`TransactionID`) REFERENCES `transaction` (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_transaction`
--

LOCK TABLES `card_transaction` WRITE;
/*!40000 ALTER TABLE `card_transaction` DISABLE KEYS */;
INSERT INTO `card_transaction` VALUES (7,1,3),(8,2,3),(9,3,4),(10,3,5),(11,3,6);
/*!40000 ALTER TABLE `card_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checking_account`
--

DROP TABLE IF EXISTS `checking_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checking_account` (
  `AccountID` int NOT NULL,
  `OverdraftLimit` decimal(15,2) NOT NULL,
  PRIMARY KEY (`AccountID`),
  CONSTRAINT `fk_checking_AccountID` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checking_account`
--

LOCK TABLES `checking_account` WRITE;
/*!40000 ALTER TABLE `checking_account` DISABLE KEYS */;
INSERT INTO `checking_account` VALUES (6,800.00),(7,600.00),(8,1200.00),(9,950.00),(10,1100.00),(11,1100.00);
/*!40000 ALTER TABLE `checking_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_card` (
  `CardID` int NOT NULL,
  `CreditLimit` decimal(15,2) NOT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`CardID`),
  KEY `fk_credit_CustomerID_idx` (`CustomerID`),
  CONSTRAINT `fk_credit_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
INSERT INTO `credit_card` VALUES (1,5000.00,1),(2,6000.00,2),(3,7000.00,2),(4,8000.00,4),(5,9000.00,4);
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `credit_card_balance`
--

DROP TABLE IF EXISTS `credit_card_balance`;
/*!50001 DROP VIEW IF EXISTS `credit_card_balance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `credit_card_balance` AS SELECT 
 1 AS `CardID`,
 1 AS `CreditLimit`,
 1 AS `AvailableBalance`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `credit_payment_transaction`
--

DROP TABLE IF EXISTS `credit_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_payment_transaction` (
  `TransactionID` int NOT NULL,
  `AccountID` int NOT NULL,
  `CardID` int NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `fk_credit_payment_trans_AccountID_idx` (`AccountID`),
  KEY `fk_credit_payment_trans_CardID_idx` (`CardID`),
  CONSTRAINT `fk_credit_payment_trans_AccountID` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`),
  CONSTRAINT `fk_credit_payment_trans_CardID` FOREIGN KEY (`CardID`) REFERENCES `credit_card` (`CardID`),
  CONSTRAINT `fk_credit_payment_trans_TransactionID` FOREIGN KEY (`TransactionID`) REFERENCES `transaction` (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_payment_transaction`
--

LOCK TABLES `credit_payment_transaction` WRITE;
/*!40000 ALTER TABLE `credit_payment_transaction` DISABLE KEYS */;
INSERT INTO `credit_payment_transaction` VALUES (12,1,1),(13,3,2),(14,3,2),(15,7,4),(16,7,5);
/*!40000 ALTER TABLE `credit_payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerID` int NOT NULL,
  `TIN` char(9) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `DoB` date NOT NULL,
  `Address` varchar(60) NOT NULL,
  `LoanID` int DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `TIN_UNIQUE` (`TIN`),
  KEY `LoanID_idx` (`LoanID`),
  CONSTRAINT `fk_customer_LoanID` FOREIGN KEY (`LoanID`) REFERENCES `loan` (`LoanID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'123456789','Maria Papadopoulou','1985-06-15','Ermou 56, 10555, Monastiraki',NULL),(2,'321456789','Maria Papadopoulou','1991-01-05','Stadiou 1, 10561, Syntagma',1),(3,'987654321','Nikos Georgiou','1990-09-22','Kifisia 13, 11523, Ampelokipoi',2),(4,'112233445','Elena Dimitriou','1978-01-13','Patision 173, 11251, Agios Loukas',3),(5,'223344556','Kostas Vassilakis','1978-01-13','Evelpidon 38, 11362, Kypseli',4),(6,'334455667','Yiannis Papadakis','1988-05-20','Vasilissis Sofias 40, 10676, Kolonaki',5);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_accounts`
--

DROP TABLE IF EXISTS `customer_accounts`;
/*!50001 DROP VIEW IF EXISTS `customer_accounts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_accounts` AS SELECT 
 1 AS `CustomerID`,
 1 AS `TIN`,
 1 AS `Name`,
 1 AS `AccountID`,
 1 AS `AccountNumber`,
 1 AS `Currency`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customer_email`
--

DROP TABLE IF EXISTS `customer_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_email` (
  `CustomerID` int NOT NULL,
  `Email` varchar(40) NOT NULL,
  PRIMARY KEY (`CustomerID`,`Email`),
  CONSTRAINT `fk_email_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_email`
--

LOCK TABLES `customer_email` WRITE;
/*!40000 ALTER TABLE `customer_email` DISABLE KEYS */;
INSERT INTO `customer_email` VALUES (1,'mariapap@gmail.com'),(1,'mariapap@hotmail.com'),(2,'mpap@hotmail.com'),(3,'nikosg@gmail.com'),(4,'elenad@outlook.com'),(5,'kostasv@hotmail.com'),(6,'yiannis.papadakis@gmail.com');
/*!40000 ALTER TABLE `customer_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_tel`
--

DROP TABLE IF EXISTS `customer_tel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_tel` (
  `CustomerID` int NOT NULL,
  `Tel` char(10) NOT NULL,
  PRIMARY KEY (`CustomerID`,`Tel`),
  CONSTRAINT `fk_tel_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_tel`
--

LOCK TABLES `customer_tel` WRITE;
/*!40000 ALTER TABLE `customer_tel` DISABLE KEYS */;
INSERT INTO `customer_tel` VALUES (1,'6980000011'),(2,'2310934567'),(2,'6945567890'),(3,'6931122334'),(4,'6988991122'),(5,'6977889900'),(6,'6975919900');
/*!40000 ALTER TABLE `customer_tel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debit_card`
--

DROP TABLE IF EXISTS `debit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debit_card` (
  `CardID` int NOT NULL,
  `DailyTransactionLimit` decimal(15,2) NOT NULL,
  `AccountID` int NOT NULL,
  PRIMARY KEY (`CardID`),
  KEY `fk_debit_AccountID_idx` (`AccountID`),
  CONSTRAINT `fk_debit_AccountID` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debit_card`
--

LOCK TABLES `debit_card` WRITE;
/*!40000 ALTER TABLE `debit_card` DISABLE KEYS */;
INSERT INTO `debit_card` VALUES (6,500.00,3),(7,400.00,4),(8,500.00,6),(9,600.00,7),(10,1000.00,7);
/*!40000 ALTER TABLE `debit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `EmployeeID` int NOT NULL,
  `TIN` char(9) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `DoB` date NOT NULL,
  `Address` varchar(60) NOT NULL,
  `BranchID` int NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `TIN_UNIQUE` (`TIN`),
  KEY `fk_employee_BranchID_idx` (`BranchID`),
  CONSTRAINT `fk_employee_BranchID` FOREIGN KEY (`BranchID`) REFERENCES `bank_branch` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'111155667','Giorgos Kotsis','1978-04-12','Kapodistriou 5, 10682, Exarcheia',1),(2,'222255667','Eleni Markou','1988-11-30','Deligianni 33, 10438, Proastia',1),(3,'333355667','Nikos Stavropoulos','1990-02-01','Alexandras 17, 11473, Neapoli',2),(4,'444455667','Maria Korinthiou','1985-06-15','Syngrou 14, 11742, Koukaki',3),(5,'555555667','Kostas Nikandros','1982-09-18','Syngrou 4, 11742, Koukaki',4),(6,'555555999','Kostas Nikopoulos','1992-10-08','Syngrou 1, 11742, Koukaki',5);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `employee_branch_summary`
--

DROP TABLE IF EXISTS `employee_branch_summary`;
/*!50001 DROP VIEW IF EXISTS `employee_branch_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `employee_branch_summary` AS SELECT 
 1 AS `Name`,
 1 AS `TIN`,
 1 AS `EmpAddress`,
 1 AS `Tel`,
 1 AS `Email`,
 1 AS `BranchID`,
 1 AS `BranchAddress`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employee_email`
--

DROP TABLE IF EXISTS `employee_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_email` (
  `EmployeeID` int NOT NULL,
  `Email` varchar(40) NOT NULL,
  PRIMARY KEY (`EmployeeID`,`Email`),
  CONSTRAINT `fk_email_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_email`
--

LOCK TABLES `employee_email` WRITE;
/*!40000 ALTER TABLE `employee_email` DISABLE KEYS */;
INSERT INTO `employee_email` VALUES (1,'gkotsis@gmail.gr'),(1,'gkotsisG@gmail.gr'),(2,'emarkou@gmail.gr'),(3,'nstavropoulos@gmail.gr'),(4,'mkorinth@gmail.gr'),(5,'knikan@gmail.gr'),(6,'knikopoulos@gmail.gr');
/*!40000 ALTER TABLE `employee_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_tel`
--

DROP TABLE IF EXISTS `employee_tel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_tel` (
  `EmployeeID` int NOT NULL,
  `Tel` char(10) NOT NULL,
  PRIMARY KEY (`EmployeeID`,`Tel`),
  CONSTRAINT `fk_tel_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_tel`
--

LOCK TABLES `employee_tel` WRITE;
/*!40000 ALTER TABLE `employee_tel` DISABLE KEYS */;
INSERT INTO `employee_tel` VALUES (1,'2105678901'),(1,'6989744444'),(2,'2310789456'),(3,'2102345678'),(4,'2314567890'),(5,'2108765432'),(6,'2310934777');
/*!40000 ALTER TABLE `employee_tel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `LoanID` int NOT NULL,
  `Amount` decimal(15,2) NOT NULL,
  `OpeningDate` date NOT NULL,
  `ExpirationDate` date NOT NULL,
  `InterestRate` decimal(4,2) NOT NULL,
  `Type` varchar(20) NOT NULL,
  PRIMARY KEY (`LoanID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,7500.43,'2020-02-24','2025-02-15',3.12,'Housing'),(2,2100.03,'2022-03-21','2024-03-03',0.19,'Housing'),(3,1523.13,'2020-02-01','2025-04-15',4.12,'Consumer'),(4,5002.30,'2021-03-01','2024-04-21',2.20,'Student'),(5,400.43,'2021-12-15','2025-04-25',1.12,'Consumer');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `loan_debts`
--

DROP TABLE IF EXISTS `loan_debts`;
/*!50001 DROP VIEW IF EXISTS `loan_debts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `loan_debts` AS SELECT 
 1 AS `CustomerID`,
 1 AS `Name`,
 1 AS `TIN`,
 1 AS `LoanID`,
 1 AS `ExpirationDate`,
 1 AS `Type`,
 1 AS `Amount`,
 1 AS `Debt`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `savings_account`
--

DROP TABLE IF EXISTS `savings_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `savings_account` (
  `AccountID` int NOT NULL,
  `InterestRate` decimal(4,2) NOT NULL,
  PRIMARY KEY (`AccountID`),
  CONSTRAINT `fk_savings_AccountID` FOREIGN KEY (`AccountID`) REFERENCES `account` (`AccountID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savings_account`
--

LOCK TABLES `savings_account` WRITE;
/*!40000 ALTER TABLE `savings_account` DISABLE KEYS */;
INSERT INTO `savings_account` VALUES (1,1.20),(2,0.90),(3,1.50),(4,1.10),(5,0.85);
/*!40000 ALTER TABLE `savings_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `served_by`
--

DROP TABLE IF EXISTS `served_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `served_by` (
  `CustomerID` int NOT NULL,
  `BranchID` int NOT NULL,
  PRIMARY KEY (`CustomerID`,`BranchID`),
  KEY `fk_served_BranchID_idx` (`BranchID`),
  CONSTRAINT `fk_served_BranchID` FOREIGN KEY (`BranchID`) REFERENCES `bank_branch` (`BranchID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_served_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `served_by`
--

LOCK TABLES `served_by` WRITE;
/*!40000 ALTER TABLE `served_by` DISABLE KEYS */;
INSERT INTO `served_by` VALUES (1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(1,5),(2,5),(3,5),(4,5),(5,5),(6,5);
/*!40000 ALTER TABLE `served_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `TransactionID` int NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'2023-02-15','11:30:00',-150.00),(2,'2023-03-01','10:33:10',50000.00),(3,'2023-05-12','12:20:11',-500.00),(4,'2023-06-20','10:32:01',1200.00),(5,'2023-06-20','10:32:01',-1200.00),(6,'2023-08-01','09:12:02',-300.00),(7,'2024-08-01','15:38:03',-222.00),(8,'2023-12-01','14:39:04',-100.00),(9,'2020-03-11','15:37:05',-302.00),(10,'2019-08-21','16:37:06',-120.00),(11,'2017-08-01','17:36:07',-600.00),(12,'2018-08-21','18:35:08',-90.00),(13,'2018-10-01','19:34:09',-650.00),(14,'2022-11-29','20:30:19',-330.00),(15,'2021-12-30','21:20:24',-145.00),(16,'2018-01-15','22:10:00',-7340.00);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_customer_accounts_loan`
--

DROP TABLE IF EXISTS `v_customer_accounts_loan`;
/*!50001 DROP VIEW IF EXISTS `v_customer_accounts_loan`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_customer_accounts_loan` AS SELECT 
 1 AS `CustomerID`,
 1 AS `TIN`,
 1 AS `Name`,
 1 AS `DoB`,
 1 AS `Address`,
 1 AS `LoanID`,
 1 AS `AccountID`,
 1 AS `AccountNumber`,
 1 AS `AccountStatus`,
 1 AS `AccountOpeningDate`,
 1 AS `Currency`,
 1 AS `AccountBalance`,
 1 AS `Email`,
 1 AS `Tel`,
 1 AS `LoanType`,
 1 AS `LoanOpeningDate`,
 1 AS `LoanExpirationDate`,
 1 AS `InterestRate`,
 1 AS `LoanAmount`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `accounts_balance`
--

/*!50001 DROP VIEW IF EXISTS `accounts_balance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `accounts_balance` AS select `G`.`AccountID` AS `AccountID`,`G`.`AccSum` AS `AccSum`,`G`.`CrPaySum` AS `CrPaySum`,`G`.`DebSum` AS `DebSum`,((`G`.`AccSum` + `G`.`CrPaySum`) + `G`.`DebSum`) AS `Balance` from (select `acc`.`AccountID` AS `AccountID`,coalesce(`B`.`AccSum`,0) AS `AccSum`,coalesce(`D`.`CrPaySum`,0) AS `CrPaySum`,coalesce(`F`.`DebSum`,0) AS `DebSum` from (((`account` `acc` left join (select `at`.`AccountID` AS `AccountID`,sum(`t`.`Amount`) AS `AccSum` from (`account_transaction` `at` join `transaction` `t` on((`at`.`TransactionID` = `t`.`TransactionID`))) group by `at`.`AccountID`) `B` on((`acc`.`AccountID` = `B`.`AccountID`))) left join (select `cpt`.`AccountID` AS `AccountID`,sum(`t`.`Amount`) AS `CrPaySum` from (`credit_payment_transaction` `cpt` join `transaction` `t` on((`cpt`.`TransactionID` = `t`.`TransactionID`))) group by `cpt`.`AccountID`) `D` on((`acc`.`AccountID` = `D`.`AccountID`))) left join (select `dc`.`AccountID` AS `AccountID`,sum(`t`.`Amount`) AS `DebSum` from ((`card_transaction` `ct` join `transaction` `t` on((`ct`.`TransactionID` = `t`.`TransactionID`))) join `debit_card` `dc` on((`ct`.`CardID` = `dc`.`CardID`))) group by `dc`.`AccountID`) `F` on((`acc`.`AccountID` = `F`.`AccountID`)))) `G` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `credit_card_balance`
--

/*!50001 DROP VIEW IF EXISTS `credit_card_balance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `credit_card_balance` AS select `CC`.`CardID` AS `CardID`,`CC`.`CreditLimit` AS `CreditLimit`,(`CC`.`CreditLimit` + coalesce(`Pay`.`CreditPaySum`,0)) AS `AvailableBalance` from (`credit_card` `CC` left join (select `CPT`.`CardID` AS `CardID`,sum(`T`.`Amount`) AS `CreditPaySum` from (`credit_payment_transaction` `CPT` join `transaction` `T` on((`CPT`.`TransactionID` = `T`.`TransactionID`))) group by `CPT`.`CardID`) `Pay` on((`CC`.`CardID` = `Pay`.`CardID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customer_accounts`
--

/*!50001 DROP VIEW IF EXISTS `customer_accounts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_accounts` AS select `c`.`CustomerID` AS `CustomerID`,`c`.`TIN` AS `TIN`,`c`.`Name` AS `Name`,`a`.`AccountID` AS `AccountID`,`a`.`AccountNumber` AS `AccountNumber`,`a`.`Currency` AS `Currency` from (`customer` `c` join `account` `a` on((`c`.`CustomerID` = `a`.`CustomerID`))) order by `c`.`CustomerID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employee_branch_summary`
--

/*!50001 DROP VIEW IF EXISTS `employee_branch_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employee_branch_summary` AS select `ei`.`Name` AS `Name`,`ei`.`TIN` AS `TIN`,`ei`.`EmpAddress` AS `EmpAddress`,`ei`.`Tel` AS `Tel`,`ei`.`Email` AS `Email`,`bi`.`BranchID` AS `BranchID`,`bi`.`BranchAddress` AS `BranchAddress` from ((select `bank_branch`.`BranchID` AS `BranchID`,`bank_branch`.`Address` AS `BranchAddress` from `bank_branch`) `bi` join (select `e`.`EmployeeID` AS `EmployeeID`,`e`.`TIN` AS `TIN`,`e`.`Name` AS `Name`,`e`.`Address` AS `EmpAddress`,`e`.`BranchID` AS `BranchID`,`et`.`Tel` AS `Tel`,`ee`.`Email` AS `Email` from ((`employee` `e` join `employee_tel` `et` on((`e`.`EmployeeID` = `et`.`EmployeeID`))) join `employee_email` `ee` on((`e`.`EmployeeID` = `ee`.`EmployeeID`)))) `ei` on((`bi`.`BranchID` = `ei`.`BranchID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `loan_debts`
--

/*!50001 DROP VIEW IF EXISTS `loan_debts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `loan_debts` AS select `E`.`CustomerID` AS `CustomerID`,`E`.`Name` AS `Name`,`E`.`TIN` AS `TIN`,`E`.`LoanID` AS `LoanID`,`E`.`ExpirationDate` AS `ExpirationDate`,`E`.`Type` AS `Type`,`E`.`Amount` AS `Amount`,(`E`.`Amount` + coalesce(`E`.`custLoanPaymentSum`,0)) AS `Debt` from (select `C`.`CustomerID` AS `CustomerID`,`C`.`Name` AS `Name`,`C`.`TIN` AS `TIN`,`C`.`LoanID` AS `LoanID`,`C`.`ExpirationDate` AS `ExpirationDate`,`C`.`Type` AS `Type`,`C`.`Amount` AS `Amount`,`B`.`custLoanPaymentSum` AS `custLoanPaymentSum` from ((select `cust`.`CustomerID` AS `CustomerID`,`cust`.`Name` AS `Name`,`cust`.`TIN` AS `TIN`,`l`.`LoanID` AS `LoanID`,`l`.`ExpirationDate` AS `ExpirationDate`,`l`.`Type` AS `Type`,`l`.`Amount` AS `Amount` from (`customer` `cust` join `loan` `l` on((`cust`.`LoanID` = `l`.`LoanID`)))) `C` left join (select `acc`.`CustomerID` AS `CustomerID`,sum(`t`.`Amount`) AS `custLoanPaymentSum` from ((`account_transaction` `at` join `transaction` `t` on((`at`.`TransactionID` = `t`.`TransactionID`))) join `account` `acc` on((`at`.`AccountID` = `acc`.`AccountID`))) where (`at`.`MovementType` = 'LoanPayment') group by `acc`.`CustomerID`) `B` on((`C`.`CustomerID` = `B`.`CustomerID`)))) `E` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_customer_accounts_loan`
--

/*!50001 DROP VIEW IF EXISTS `v_customer_accounts_loan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_customer_accounts_loan` AS select `c`.`CustomerID` AS `CustomerID`,`c`.`TIN` AS `TIN`,`c`.`Name` AS `Name`,`c`.`DoB` AS `DoB`,`c`.`Address` AS `Address`,`c`.`LoanID` AS `LoanID`,`a`.`AccountID` AS `AccountID`,`a`.`AccountNumber` AS `AccountNumber`,`a`.`Status` AS `AccountStatus`,`a`.`OpeningDate` AS `AccountOpeningDate`,`a`.`Currency` AS `Currency`,`ab`.`Balance` AS `AccountBalance`,`ce`.`Email` AS `Email`,`ct`.`Tel` AS `Tel`,`l`.`Type` AS `LoanType`,`l`.`OpeningDate` AS `LoanOpeningDate`,`l`.`ExpirationDate` AS `LoanExpirationDate`,`l`.`InterestRate` AS `InterestRate`,`l`.`Amount` AS `LoanAmount` from (((((`customer` `c` join `customer_email` `ce` on((`c`.`CustomerID` = `ce`.`CustomerID`))) join `customer_tel` `ct` on((`c`.`CustomerID` = `ct`.`CustomerID`))) join `account` `a` on((`c`.`CustomerID` = `a`.`CustomerID`))) join `accounts_balance` `ab` on((`a`.`AccountID` = `ab`.`AccountID`))) join `loan` `l` on((`l`.`LoanID` = `c`.`LoanID`))) where (`c`.`TIN` = substring_index(user(),'@',1)) */;
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

-- Dump completed on 2025-12-19 23:58:24
