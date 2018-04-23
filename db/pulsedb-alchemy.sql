-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: alchemy.ct7j0bplabvw.ap-south-1.rds.amazonaws.com    Database: alchemy
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Table structure for table `advisor_user_mapper`
--

DROP TABLE IF EXISTS `advisor_user_mapper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advisor_user_mapper` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `advisor_id` int(100) DEFAULT NULL,
  `client_id` int(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100004 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `asset_category_mapper`
--

DROP TABLE IF EXISTS `asset_category_mapper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_category_mapper` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `asset_class` varchar(250) NOT NULL,
  `asset_category` varchar(250) DEFAULT '',
  `asset_sub_category` varchar(250) DEFAULT '',
  `asset_code` varchar(25) NOT NULL,
  `asset_category_code` varchar(25) NOT NULL,
  `asset_sub_category_code` varchar(25) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `asset_sub_category_code_2` varchar(25) DEFAULT '',
  `asset_sub_category_2` varchar(250) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_asset_category` (`asset_code`,`asset_category_code`,`asset_sub_category_code`)
) ENGINE=InnoDB AUTO_INCREMENT=412 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `scheme_name` varchar(250) DEFAULT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  `client_id` int(100) DEFAULT NULL,
  `advisor_id` int(100) DEFAULT NULL,
  `purchased_date` date DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100005 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `benchmark_matrix`
--

DROP TABLE IF EXISTS `benchmark_matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `benchmark_matrix` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `benchmark` varchar(250) DEFAULT '',
  `benchmark_code` varchar(25) NOT NULL,
  `benchmark_value` decimal(24,4) DEFAULT '0.0000',
  `alt_benchmark` varchar(250) DEFAULT '',
  `alt_benchmark_code` varchar(25) NOT NULL,
  `as_on_date` varchar(10) NOT NULL,
  `final_benchmark` varchar(250) DEFAULT '',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_benchmark` (`final_benchmark`,`as_on_date`),
  KEY `as_on_date_idx` (`as_on_date`)
) ENGINE=InnoDB AUTO_INCREMENT=591435 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `benchmark_matrix_latest`
--

DROP TABLE IF EXISTS `benchmark_matrix_latest`;
/*!50001 DROP VIEW IF EXISTS `benchmark_matrix_latest`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `benchmark_matrix_latest` AS SELECT 
 1 AS `benchmark`,
 1 AS `benchmark_code`,
 1 AS `alt_benchmark`,
 1 AS `alt_benchmark_code`,
 1 AS `final_benchmark`,
 1 AS `as_on_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(250) DEFAULT NULL,
  `last_name` varchar(250) DEFAULT NULL,
  `mobile` varchar(250) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `pan` varchar(250) DEFAULT NULL,
  `contact_type` enum('Client','Prospect','Advisor') DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_pwd_changed` tinyint(1) DEFAULT NULL,
  `activation_url` varchar(800) DEFAULT NULL,
  `advisor_id` int(100) DEFAULT NULL,
  `client_id` int(100) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100004 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db_upload_reports`
--

DROP TABLE IF EXISTS `db_upload_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_upload_reports` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `freq` varchar(250) DEFAULT 'Any Time',
  `template_headers` varchar(2000) DEFAULT '[]',
  `table_name` varchar(100) DEFAULT '',
  `search_parms` varchar(250) DEFAULT NULL,
  `insert_query` varchar(2000) DEFAULT '',
  `search_query` varchar(2000) DEFAULT '',
  `struct` varchar(4000) DEFAULT '[]',
  `update_query` varchar(2000) DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_db_upload_report` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1000009 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db_upload_stats`
--

DROP TABLE IF EXISTS `db_upload_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_upload_stats` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `report_id` int(12) NOT NULL,
  `report_name` varchar(250) NOT NULL,
  `upload_date` datetime NOT NULL,
  `upload_by` int(12) NOT NULL,
  `add_count` int(12) NOT NULL DEFAULT '0',
  `del_count` int(12) NOT NULL DEFAULT '0',
  `upd_count` int(12) NOT NULL DEFAULT '0',
  `status` varchar(100) DEFAULT 'Success',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_mf_nav_daily`
--

DROP TABLE IF EXISTS `es_mf_nav_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `es_mf_nav_daily` (
  `scheme_code` varchar(20) CHARACTER SET utf8 NOT NULL,
  `scheme_name` varchar(250) CHARACTER SET utf8 NOT NULL,
  `asset_category` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `asset_sub_category` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `isin_dividend_payout_or_growth` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `isin_dividend_reinvest` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `nav` decimal(24,4) DEFAULT NULL,
  `nav_date` date NOT NULL,
  `final_benchmark` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `benchmark` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `benchmark_value` decimal(24,4) DEFAULT NULL,
  `alt_benchmark` varchar(250) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mf_fu_amc_master`
--

DROP TABLE IF EXISTS `mf_fu_amc_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mf_fu_amc_master` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `scheme_code` varchar(20) NOT NULL,
  `amc_name` varchar(250) NOT NULL,
  `fund_name` varchar(250) NOT NULL,
  `scheme_name` varchar(250) NOT NULL,
  `scheme_name_unique` varchar(250) NOT NULL,
  `isin_dividend_payout_or_growth` varchar(20) DEFAULT NULL,
  `isin_dividend_reinvest` varchar(20) DEFAULT NULL,
  `dividend_payout_frequency` varchar(20) DEFAULT '',
  `plan_name` varchar(20) NOT NULL,
  `option_name` varchar(20) NOT NULL,
  `asset_class` varchar(50) NOT NULL,
  `asset_category` varchar(250) NOT NULL,
  `asset_sub_category` varchar(250) NOT NULL,
  `asset_code` varchar(25) NOT NULL,
  `asset_category_code` varchar(25) NOT NULL,
  `asset_sub_category_code` varchar(25) NOT NULL,
  `date_of_inception` varchar(10) NOT NULL DEFAULT '',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `asset_sub_category_code_2` varchar(25) DEFAULT '',
  `asset_sub_category_2` varchar(250) DEFAULT '',
  `unique_variant` varchar(250) DEFAULT '',
  `final_benchmark` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_amc_rec` (`scheme_code`),
  KEY `am_scheme_code_idx` (`scheme_code`,`final_benchmark`),
  KEY `scheme_code_idx` (`scheme_code`)
) ENGINE=InnoDB AUTO_INCREMENT=143186 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `mf_fu_amc_master_latest`
--

DROP TABLE IF EXISTS `mf_fu_amc_master_latest`;
/*!50001 DROP VIEW IF EXISTS `mf_fu_amc_master_latest`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mf_fu_amc_master_latest` AS SELECT 
 1 AS `scheme_code`,
 1 AS `amc_name`,
 1 AS `fund_name`,
 1 AS `scheme_name`,
 1 AS `scheme_name_unique`,
 1 AS `isin_dividend_payout_or_growth`,
 1 AS `isin_dividend_reinvest`,
 1 AS `dividend_payout_frequency`,
 1 AS `plan_name`,
 1 AS `option_name`,
 1 AS `asset_class`,
 1 AS `asset_category`,
 1 AS `asset_sub_category`,
 1 AS `asset_code`,
 1 AS `asset_category_code`,
 1 AS `asset_sub_category_code`,
 1 AS `asset_sub_category_2`,
 1 AS `asset_sub_category_code_2`,
 1 AS `date_of_inception`,
 1 AS `unique_variant`,
 1 AS `final_benchmark`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `mf_metadata_view`
--

DROP TABLE IF EXISTS `mf_metadata_view`;
/*!50001 DROP VIEW IF EXISTS `mf_metadata_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mf_metadata_view` AS SELECT 
 1 AS `scheme_code`,
 1 AS `amc_name`,
 1 AS `fund_name`,
 1 AS `scheme_name`,
 1 AS `scheme_name_unique`,
 1 AS `isin_dividend_payout_or_growth`,
 1 AS `isin_dividend_reinvest`,
 1 AS `dividend_payout_frequency`,
 1 AS `plan_name`,
 1 AS `option_name`,
 1 AS `asset_class`,
 1 AS `asset_category`,
 1 AS `asset_sub_category`,
 1 AS `asset_code`,
 1 AS `asset_category_code`,
 1 AS `asset_sub_category_code`,
 1 AS `asset_sub_category_2`,
 1 AS `asset_sub_category_code_2`,
 1 AS `date_of_inception`,
 1 AS `unique_variant`,
 1 AS `final_benchmark`,
 1 AS `benchmark`,
 1 AS `benchmark_code`,
 1 AS `alt_benchmark`,
 1 AS `alt_benchmark_code`,
 1 AS `fund_manager`,
 1 AS `exit_load_rate`,
 1 AS `exit_load_period`,
 1 AS `exit_load_period_remark`,
 1 AS `sec_fund_manager`,
 1 AS `min_invest`,
 1 AS `min_invest_x`,
 1 AS `min_invest_sip`,
 1 AS `min_invest_sip_x`,
 1 AS `risk_code`,
 1 AS `risk_profile`,
 1 AS `risk_rating`,
 1 AS `amfi_code`,
 1 AS `fund_size`,
 1 AS `expense_ratio_s_d`,
 1 AS `pe_ratio`,
 1 AS `portfolio_turnover_ratio`,
 1 AS `market_cap_large`,
 1 AS `market_cap_mid`,
 1 AS `market_cap_small`,
 1 AS `market_cap_others`,
 1 AS `credit_profile_A`,
 1 AS `credit_profile_A_Minus`,
 1 AS `credit_profile_A_IND`,
 1 AS `credit_profile_A_SO`,
 1 AS `credit_profile_A_Plus`,
 1 AS `credit_profile_A_Plus_IND`,
 1 AS `credit_profile_A_Plus_SO`,
 1 AS `credit_profile_A_1`,
 1 AS `credit_profile_A_MINUS_SO_BWR`,
 1 AS `credit_profile_A_PLUS_SO_BWR`,
 1 AS `credit_profile_AA`,
 1 AS `credit_profile_AA_Minus`,
 1 AS `credit_profile_AA_MINUS_IND`,
 1 AS `credit_profile_AA_SO`,
 1 AS `credit_profile_AA_MINUS_SO`,
 1 AS `credit_profile_AA_PLUS`,
 1 AS `credit_profile_AA_PLUS_SO`,
 1 AS `credit_profile_AA_BWR`,
 1 AS `credit_profile_AA_MINUS_SO_BWR`,
 1 AS `credit_profile_AA_PLUS_BWR`,
 1 AS `credit_profile_A1_PLUS`,
 1 AS `credit_profile_A1_PLUS_SO`,
 1 AS `credit_profile_AAA`,
 1 AS `credit_profile_AAA_IND`,
 1 AS `credit_profile_AAA_SO`,
 1 AS `credit_profile_A_MINUS_BWR`,
 1 AS `credit_profile_cash_eq`,
 1 AS `credit_profile_SOV`,
 1 AS `avg_maturity_days`,
 1 AS `avg_maturity_months`,
 1 AS `avg_maturity_years`,
 1 AS `modified_maturity_days`,
 1 AS `modified_maturity_months`,
 1 AS `modified_maturity_years`,
 1 AS `yield_to_maturity`,
 1 AS `as_on_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mf_nav_aggs`
--

DROP TABLE IF EXISTS `mf_nav_aggs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mf_nav_aggs` (
  `scheme_code` varchar(20) CHARACTER SET utf8 NOT NULL,
  `min_nav` decimal(24,4) DEFAULT NULL,
  `max_nav` decimal(24,4) DEFAULT NULL,
  `nav_month` varchar(7) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mf_nav_daily`
--

DROP TABLE IF EXISTS `mf_nav_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mf_nav_daily` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `scheme_code` varchar(20) NOT NULL,
  `isin_dividend_payout_or_growth` varchar(20) DEFAULT NULL,
  `isin_dividend_reinvest` varchar(20) DEFAULT NULL,
  `scheme_name` varchar(250) NOT NULL,
  `net_asset_val` decimal(24,4) DEFAULT '0.0000',
  `repurchase_price` decimal(24,4) DEFAULT '0.0000',
  `sale_price` decimal(24,4) DEFAULT '0.0000',
  `date` varchar(50) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nav_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nav_daily_unique` (`scheme_code`,`date`),
  KEY `nav_date_index` (`nav_date`),
  KEY `scheme_nav_idx` (`scheme_code`,`nav_date`)
) ENGINE=InnoDB AUTO_INCREMENT=110949580 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `mf_nav_daily_v`
--

DROP TABLE IF EXISTS `mf_nav_daily_v`;
/*!50001 DROP VIEW IF EXISTS `mf_nav_daily_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mf_nav_daily_v` AS SELECT 
 1 AS `id`,
 1 AS `scheme_code`,
 1 AS `isin_dividend_payout_or_growth`,
 1 AS `isin_dividend_reinvest`,
 1 AS `scheme_name`,
 1 AS `net_asset_val`,
 1 AS `repurchase_price`,
 1 AS `sale_price`,
 1 AS `date`,
 1 AS `created_date`,
 1 AS `nav_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mf_nav_load_stats`
--

DROP TABLE IF EXISTS `mf_nav_load_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mf_nav_load_stats` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `nav_date` date NOT NULL,
  `load_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `es_loaded` int(12) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000030 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `mf_navdata_view`
--

DROP TABLE IF EXISTS `mf_navdata_view`;
/*!50001 DROP VIEW IF EXISTS `mf_navdata_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mf_navdata_view` AS SELECT 
 1 AS `scheme_code`,
 1 AS `scheme_name`,
 1 AS `asset_category`,
 1 AS `asset_sub_category`,
 1 AS `isin_dividend_payout_or_growth`,
 1 AS `isin_dividend_reinvest`,
 1 AS `nav`,
 1 AS `nav_date`,
 1 AS `final_benchmark`,
 1 AS `benchmark`,
 1 AS `benchmark_value`,
 1 AS `alt_benchmark`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mf_schemes_supported`
--

DROP TABLE IF EXISTS `mf_schemes_supported`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mf_schemes_supported` (
  `scheme_code` varchar(20) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mf_ufd_exit_info`
--

DROP TABLE IF EXISTS `mf_ufd_exit_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mf_ufd_exit_info` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `amfi_code` varchar(20) NOT NULL,
  `as_on_date` varchar(7) NOT NULL,
  `fund_manager` varchar(250) NOT NULL,
  `scheme_name` varchar(250) DEFAULT NULL,
  `scheme_name_unique` varchar(250) DEFAULT NULL,
  `exit_load_rate` decimal(24,4) DEFAULT '0.0000',
  `exit_load_period` decimal(24,4) DEFAULT '0.0000',
  `exit_load_period_remark` varchar(100) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sec_fund_manager` varchar(250) DEFAULT '',
  `min_invest` decimal(24,4) DEFAULT '0.0000',
  `min_invest_x` decimal(24,4) DEFAULT '0.0000',
  `min_invest_sip` decimal(24,4) DEFAULT '0.0000',
  `min_invest_sip_x` decimal(24,4) DEFAULT '0.0000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_exit_rec` (`amfi_code`,`as_on_date`)
) ENGINE=InnoDB AUTO_INCREMENT=9274 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mf_ufm_scheme_details`
--

DROP TABLE IF EXISTS `mf_ufm_scheme_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mf_ufm_scheme_details` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `amfi_code` varchar(20) CHARACTER SET utf8 NOT NULL,
  `as_on_date` varchar(7) CHARACTER SET utf8 NOT NULL,
  `scheme_name` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `scheme_name_unique` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `fund_size` decimal(24,4) DEFAULT '0.0000',
  `expense_ratio_s_d` varchar(50) CHARACTER SET utf8 DEFAULT '100',
  `pe_ratio` varchar(50) CHARACTER SET utf8 DEFAULT '100',
  `portfolio_turnover_ratio` varchar(50) CHARACTER SET utf8 DEFAULT '100',
  `market_cap_large` decimal(24,4) DEFAULT '0.0000',
  `market_cap_mid` decimal(24,4) DEFAULT '0.0000',
  `market_cap_small` decimal(24,4) DEFAULT '0.0000',
  `market_cap_others` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_Minus` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_IND` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_SO` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_Plus` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_Plus_IND` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_Plus_SO` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_1` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_MINUS_SO_BWR` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_PLUS_SO_BWR` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_Minus` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_MINUS_IND` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_SO` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_MINUS_SO` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_PLUS` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_PLUS_SO` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_BWR` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_MINUS_SO_BWR` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AA_PLUS_BWR` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A1_PLUS` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A1_PLUS_SO` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AAA` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AAA_IND` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_AAA_SO` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_A_MINUS_BWR` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_cash_eq` decimal(24,4) DEFAULT '0.0000',
  `credit_profile_SOV` decimal(24,4) DEFAULT '0.0000',
  `avg_maturity_days` decimal(24,4) DEFAULT '0.0000',
  `avg_maturity_months` decimal(24,4) DEFAULT '0.0000',
  `avg_maturity_years` decimal(24,4) DEFAULT '0.0000',
  `modified_maturity_days` decimal(24,4) DEFAULT '0.0000',
  `modified_maturity_months` decimal(24,4) DEFAULT '0.0000',
  `modified_maturity_years` decimal(24,4) DEFAULT '0.0000',
  `yield_to_maturity` decimal(24,4) DEFAULT '0.0000',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_scheme_details_rec` (`amfi_code`,`as_on_date`)
) ENGINE=InnoDB AUTO_INCREMENT=9469 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `mf_ufm_scheme_details_latest`
--

DROP TABLE IF EXISTS `mf_ufm_scheme_details_latest`;
/*!50001 DROP VIEW IF EXISTS `mf_ufm_scheme_details_latest`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mf_ufm_scheme_details_latest` AS SELECT 
 1 AS `amfi_code`,
 1 AS `fund_size`,
 1 AS `expense_ratio_s_d`,
 1 AS `pe_ratio`,
 1 AS `portfolio_turnover_ratio`,
 1 AS `market_cap_large`,
 1 AS `market_cap_mid`,
 1 AS `market_cap_small`,
 1 AS `market_cap_others`,
 1 AS `credit_profile_A`,
 1 AS `credit_profile_A_Minus`,
 1 AS `credit_profile_A_IND`,
 1 AS `credit_profile_A_SO`,
 1 AS `credit_profile_A_Plus`,
 1 AS `credit_profile_A_Plus_IND`,
 1 AS `credit_profile_A_Plus_SO`,
 1 AS `credit_profile_A_1`,
 1 AS `credit_profile_A_MINUS_SO_BWR`,
 1 AS `credit_profile_A_PLUS_SO_BWR`,
 1 AS `credit_profile_AA`,
 1 AS `credit_profile_AA_Minus`,
 1 AS `credit_profile_AA_MINUS_IND`,
 1 AS `credit_profile_AA_SO`,
 1 AS `credit_profile_AA_MINUS_SO`,
 1 AS `credit_profile_AA_PLUS`,
 1 AS `credit_profile_AA_PLUS_SO`,
 1 AS `credit_profile_AA_BWR`,
 1 AS `credit_profile_AA_MINUS_SO_BWR`,
 1 AS `credit_profile_AA_PLUS_BWR`,
 1 AS `credit_profile_A1_PLUS`,
 1 AS `credit_profile_A1_PLUS_SO`,
 1 AS `credit_profile_AAA`,
 1 AS `credit_profile_AAA_IND`,
 1 AS `credit_profile_AAA_SO`,
 1 AS `credit_profile_A_MINUS_BWR`,
 1 AS `credit_profile_cash_eq`,
 1 AS `credit_profile_SOV`,
 1 AS `avg_maturity_days`,
 1 AS `avg_maturity_months`,
 1 AS `avg_maturity_years`,
 1 AS `modified_maturity_days`,
 1 AS `modified_maturity_months`,
 1 AS `modified_maturity_years`,
 1 AS `yield_to_maturity`,
 1 AS `as_on_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mf_ufs_scheme_info`
--

DROP TABLE IF EXISTS `mf_ufs_scheme_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mf_ufs_scheme_info` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `amfi_code` varchar(20) NOT NULL,
  `as_on_date` varchar(7) NOT NULL,
  `amc_name` varchar(250) NOT NULL,
  `scheme_name` varchar(250) DEFAULT NULL,
  `scheme_name_unique` varchar(250) DEFAULT NULL,
  `date_of_inception` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `asset_class` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `asset_category` varchar(250) NOT NULL,
  `asset_sub_category` varchar(250) NOT NULL,
  `asset_sub_category_2` varchar(250) DEFAULT '',
  `asset_code` varchar(25) NOT NULL,
  `asset_category_code` varchar(25) NOT NULL,
  `asset_sub_category_code` varchar(25) NOT NULL,
  `asset_sub_category_code_2` varchar(25) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_scheme_rec` (`amfi_code`,`as_on_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1005481 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risk_profile_matrix`
--

DROP TABLE IF EXISTS `risk_profile_matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risk_profile_matrix` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `risk_code` varchar(250) NOT NULL,
  `risk_profile` varchar(250) DEFAULT '',
  `risk_rating` decimal(24,4) DEFAULT '0.0000',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_risk_rec` (`risk_code`)
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_auth` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `first_name` varchar(250) NOT NULL,
  `last_name` varchar(250) DEFAULT NULL,
  `mobile` varchar(25) DEFAULT NULL,
  `role` varchar(7) DEFAULT '0010000',
  `status` int(1) DEFAULT '1',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000008 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `pos` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_role` (`name`,`pos`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'alchemy'
--
/*!50003 DROP FUNCTION IF EXISTS `capitalize` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alchemy`@`%` FUNCTION `capitalize`(input VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
	DECLARE len INT;
	DECLARE i INT;

	SET len   = CHAR_LENGTH(input);
	SET input = LOWER(input);
	SET i = 0;

	WHILE (i < len) DO
		IF (MID(input,i,1) = ' ' OR i = 0) THEN
			IF (i < len) THEN
				SET input = CONCAT(
					LEFT(input,i),
					UPPER(MID(input,i + 1,1)),
					RIGHT(input,len - i - 1)
				);
			END IF;
		END IF;
		SET i = i + 1;
	END WHILE;

	RETURN input;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fund_growth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alchemy`@`%` FUNCTION `fund_growth`(_scheme_code int(12), _from varchar(7), _to varchar(7)) RETURNS decimal(24,4)
    DETERMINISTIC
BEGIN

 DECLARE growth decimal(24,4);
 
 select (maxi-mini)/mini into growth from (
select sum(case when is_mini=1 then net_asset_val end) mini,  sum(case when is_mini=0 then net_asset_val end)  maxi from (
SELECT a.*, mini=nav_date is_mini
FROM   mf_nav_daily a, (SELECT scheme_code, MIN(nav_date) AS mini,
                            MAX(nav_date) AS maxi
                     FROM   mf_nav_daily 
                     where date_format(nav_date, '%Y-%m') >= _from and date_format(nav_date, '%Y-%m') <= _to 
                     and scheme_code = _scheme_code
                     group by scheme_code ) AS m
WHERE m.scheme_code = a.scheme_code and (m.maxi = a.nav_date OR m.mini = a.nav_date)
) x
)z;
 
 RETURN (growth);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `topcharts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alchemy`@`%` FUNCTION `topcharts`(_from varchar(10), _to varchar(10), _asset_cat varchar(250), _scheme varchar(20)) RETURNS varchar(250) CHARSET latin1
    DETERMINISTIC
BEGIN

    DECLARE rownr INT;
    DECLARE result varchar(1000);
    SET rownr = 0;

    select concat("{","\"best\":", max(growth_rate),", \"worst\":", min(growth_rate), ",\"category_avg\":", avg(growth_rate),", \"rank\":", max(r), "}") into result from (select r1.*, case when scheme_code = _scheme then pos else 0 end r from ( select y.scheme_code, (pow((b/a), 1)-1)*100 growth_rate, @abc := @abc + 1 pos from ( select x.scheme_code,substr(min(concat(nav_month, '_', min_nav)), 9) a, substr(max(concat(nav_month, '_', max_nav)), 9) b from ( select a.scheme_code, min_nav, max_nav, nav_month FROM mf_nav_aggs a, (SELECT scheme_code, MIN(nav_month) AS mini, MAX(nav_month) AS maxi FROM mf_nav_aggs where (nav_month > _from and nav_month <= _to) and scheme_code in (select scheme_code from mf_fu_amc_master where asset_category = _asset_cat and option_name = 'Growth' and plan_name = 'Broker' ) group by scheme_code ) m WHERE m.scheme_code = a.scheme_code and (m.maxi = a.nav_month OR m.mini = a.nav_month) )x group by scheme_code ) y order by growth_rate desc) r1 JOIN (SELECT @abc := 0) r2) stats;
    
    RETURN(result);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `topcharts_new` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alchemy`@`%` FUNCTION `topcharts_new`(_from varchar(10), _to varchar(10), _asset_cat varchar(250), _scheme varchar(20)) RETURNS varchar(250) CHARSET latin1
    DETERMINISTIC
BEGIN

    DECLARE rownr INT;
    DECLARE result varchar(1000);
    DECLARE _CTR INT;
    DECLARE _POW DECIMAL(24,4);
    
    SET rownr = 0;
    SET _CTR = TIMESTAMPDIFF(MONTH, concat(_from, '-01'), concat(_to, '-01'));
    
    select case when _CTR >= 12 then (1/_CTR) else 1 end into _POW;
    SET _CTR = _CTR*2;
    

    select concat("{","\"best\":", max(growth_rate),", \"worst\":", min(growth_rate), ",\"category_avg\":", avg(growth_rate),", \"rank\":", max(r), "}") into result from (select r1.*, case when scheme_code = _scheme then pos else 0 end r from ( select y.scheme_code, (pow((b/a), _POW)-1)*100 growth_rate, @abc := @abc + 1 pos from ( select x.scheme_code,substr(min(concat(nav_month, '_', min_nav)), 9) a, substr(max(concat(nav_month, '_', max_nav)), 9) b from ( select a.scheme_code, min_nav, max_nav, nav_month FROM mf_nav_aggs a, (SELECT scheme_code, MIN(nav_month) AS mini, MAX(nav_month) AS maxi, count(nav_month) ctr FROM mf_nav_aggs where (nav_month > _from and nav_month <= _to) and scheme_code in (select scheme_code from mf_fu_amc_master where asset_category = _asset_cat and option_name = 'Growth' and plan_name = 'Broker' ) group by scheme_code ) m WHERE m.scheme_code = a.scheme_code and ctr = _CTR and  (m.maxi = a.nav_month OR m.mini = a.nav_month) )x group by scheme_code ) y order by growth_rate desc) r1 JOIN (SELECT @abc := 0) r2) stats;
    
    RETURN(result);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prepare_navdata_daily` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alchemy`@`%` PROCEDURE `prepare_navdata_daily`(_date varchar(10))
    DETERMINISTIC
BEGIN

   CREATE TABLE IF NOT EXISTS `t1` (
  `scheme_code` varchar(20) CHARACTER SET utf8 NOT NULL,
  `scheme_name` varchar(250) CHARACTER SET utf8,
  `asset_category` varchar(250) CHARACTER SET utf8,
  `asset_sub_category` varchar(250) CHARACTER SET utf8,
  `isin_dividend_payout_or_growth` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `isin_dividend_reinvest` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `nav` decimal(24,4) DEFAULT NULL,
  `nav_date` date NOT NULL,
  `final_benchmark` varchar(250) CHARACTER SET utf8,
  PRIMARY KEY (`nav_date`,`scheme_code`),
  KEY `benchmark_idx` (`final_benchmark`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `t2` (
  `benchmark` varchar(250) CHARACTER SET utf8 DEFAULT '',
  `benchmark_code` varchar(25) CHARACTER SET utf8 NOT NULL,
  `benchmark_value` decimal(24,4) DEFAULT '0.0000',
  `alt_benchmark` varchar(250) CHARACTER SET utf8 DEFAULT '',
  `alt_benchmark_code` varchar(25) CHARACTER SET utf8 NOT NULL,
  `final_benchmark` varchar(250) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `as_on_date` date NOT NULL,
  PRIMARY KEY (`final_benchmark`,`as_on_date`),
  KEY `bm_idx` (`final_benchmark`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delete from t2;
delete from t1;

insert into t2
select `benchmark_matrix`.`benchmark` AS `benchmark`,`benchmark_matrix`.`benchmark_code` AS `benchmark_code`,`benchmark_matrix`.`benchmark_value` AS `benchmark_value`,`benchmark_matrix`.`alt_benchmark` AS `alt_benchmark`,`benchmark_matrix`.`alt_benchmark_code` AS `alt_benchmark_code`,`benchmark_matrix`.`final_benchmark` AS `final_benchmark`,str_to_date(`benchmark_matrix`.`as_on_date`,'%d-%b-%Y') AS `as_on_date` from `benchmark_matrix` where str_to_date(`benchmark_matrix`.`as_on_date`,'%d-%b-%Y') = _date;

insert into t1
select `a`.`scheme_code` AS `scheme_code`,`b`.`scheme_name` AS `scheme_name`,`b`.`asset_category` AS `asset_category`,`b`.`asset_sub_category` AS `asset_sub_category`,`a`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`a`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`a`.`net_asset_val` AS `nav`,`a`.`nav_date` AS `nav_date`,`b`.`final_benchmark` AS `final_benchmark` from (((select `alchemy`.`mf_nav_daily`.`id` AS `id`,`alchemy`.`mf_nav_daily`.`scheme_code` AS `scheme_code`,`alchemy`.`mf_nav_daily`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`alchemy`.`mf_nav_daily`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`alchemy`.`mf_nav_daily`.`scheme_name` AS `scheme_name`,`alchemy`.`mf_nav_daily`.`net_asset_val` AS `net_asset_val`,`alchemy`.`mf_nav_daily`.`repurchase_price` AS `repurchase_price`,`alchemy`.`mf_nav_daily`.`sale_price` AS `sale_price`,`alchemy`.`mf_nav_daily`.`date` AS `date`,`alchemy`.`mf_nav_daily`.`created_date` AS `created_date`,str_to_date(`alchemy`.`mf_nav_daily`.`nav_date`,'%Y-%m-%d') AS `nav_date` from `alchemy`.`mf_nav_daily` where str_to_date(`alchemy`.`mf_nav_daily`.`nav_date`,'%Y-%m-%d') = _date )) `a` left join `alchemy`.`mf_fu_amc_master` `b` on((`a`.`scheme_code` = `b`.`scheme_code`)));

CREATE TABLE IF NOT EXISTS `es_mf_nav_daily` (
  `scheme_code` varchar(20) CHARACTER SET utf8 NOT NULL,
  `scheme_name` varchar(250) CHARACTER SET utf8 NOT NULL,
  `asset_category` varchar(250) CHARACTER SET utf8,
  `asset_sub_category` varchar(250) CHARACTER SET utf8,
  `isin_dividend_payout_or_growth` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `isin_dividend_reinvest` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `nav` decimal(24,4) DEFAULT NULL,
  `nav_date` date NOT NULL,
  `final_benchmark` varchar(250) CHARACTER SET utf8,
  `benchmark` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `benchmark_value` decimal(24,4) DEFAULT NULL,
  `alt_benchmark` varchar(250) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

delete from es_mf_nav_daily;

insert into es_mf_nav_daily
select a.*, b.benchmark, b.benchmark_value, b.alt_benchmark
from t1 a left join t2 b  
on a.nav_date = b.as_on_date and a.final_benchmark = b.final_benchmark 
where a.scheme_code != '';

drop table t1;
drop table t2;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `prepare_topcharts_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alchemy`@`%` PROCEDURE `prepare_topcharts_monthly`(_date varchar(10))
    DETERMINISTIC
BEGIN

    delete from mf_nav_aggs where nav_month = date_format(_date, '%Y-%m'); 
    
    insert into mf_nav_aggs
    SELECT a.scheme_code, 
    case when mini=nav_date then net_asset_val end min_nav,
    case when maxi=nav_date then net_asset_val end max_nav,
    date_format(nav_date, '%Y-%m') nav_month
    FROM mf_nav_daily a, (SELECT scheme_code, MIN(nav_date) AS mini,
                                MAX(nav_date) AS maxi
                         FROM mf_nav_daily where date_format(nav_date, '%Y-%m') = date_format(_date, '%Y-%m') and scheme_code in (select scheme_code from mf_fu_amc_master) group by scheme_code ) AS m
    WHERE m.scheme_code = a.scheme_code and (m.maxi = a.nav_date OR m.mini = a.nav_date);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `benchmark_matrix_latest`
--

/*!50001 DROP VIEW IF EXISTS `benchmark_matrix_latest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alchemy`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `benchmark_matrix_latest` AS select `benchmark_matrix`.`benchmark` AS `benchmark`,`benchmark_matrix`.`benchmark_code` AS `benchmark_code`,`benchmark_matrix`.`alt_benchmark` AS `alt_benchmark`,`benchmark_matrix`.`alt_benchmark_code` AS `alt_benchmark_code`,`benchmark_matrix`.`final_benchmark` AS `final_benchmark`,max(str_to_date(`benchmark_matrix`.`as_on_date`,'%d-%b-%Y')) AS `as_on_date` from `benchmark_matrix` group by `benchmark_matrix`.`benchmark`,`benchmark_matrix`.`benchmark_code`,`benchmark_matrix`.`alt_benchmark`,`benchmark_matrix`.`alt_benchmark_code`,`benchmark_matrix`.`final_benchmark` order by `benchmark_matrix`.`final_benchmark` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mf_fu_amc_master_latest`
--

/*!50001 DROP VIEW IF EXISTS `mf_fu_amc_master_latest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alchemy`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `mf_fu_amc_master_latest` AS select `m`.`scheme_code` AS `scheme_code`,`m`.`amc_name` AS `amc_name`,`m`.`fund_name` AS `fund_name`,`m`.`scheme_name` AS `scheme_name`,`m`.`scheme_name_unique` AS `scheme_name_unique`,`m`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`m`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`m`.`dividend_payout_frequency` AS `dividend_payout_frequency`,`m`.`plan_name` AS `plan_name`,`m`.`option_name` AS `option_name`,`m`.`asset_class` AS `asset_class`,`m`.`asset_category` AS `asset_category`,`m`.`asset_sub_category` AS `asset_sub_category`,`m`.`asset_code` AS `asset_code`,`m`.`asset_category_code` AS `asset_category_code`,`m`.`asset_sub_category_code` AS `asset_sub_category_code`,`m`.`asset_sub_category_2` AS `asset_sub_category_2`,`m`.`asset_sub_category_code_2` AS `asset_sub_category_code_2`,`m`.`date_of_inception` AS `date_of_inception`,`m`.`unique_variant` AS `unique_variant`,`m`.`final_benchmark` AS `final_benchmark` from `mf_fu_amc_master` `m` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mf_metadata_view`
--

/*!50001 DROP VIEW IF EXISTS `mf_metadata_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alchemy`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `mf_metadata_view` AS select `mber`.`scheme_code` AS `scheme_code`,`mber`.`amc_name` AS `amc_name`,`mber`.`fund_name` AS `fund_name`,`mber`.`scheme_name` AS `scheme_name`,`mber`.`scheme_name_unique` AS `scheme_name_unique`,`mber`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`mber`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`mber`.`dividend_payout_frequency` AS `dividend_payout_frequency`,`mber`.`plan_name` AS `plan_name`,`mber`.`option_name` AS `option_name`,`mber`.`asset_class` AS `asset_class`,`mber`.`asset_category` AS `asset_category`,`mber`.`asset_sub_category` AS `asset_sub_category`,`mber`.`asset_code` AS `asset_code`,`mber`.`asset_category_code` AS `asset_category_code`,`mber`.`asset_sub_category_code` AS `asset_sub_category_code`,`mber`.`asset_sub_category_2` AS `asset_sub_category_2`,`mber`.`asset_sub_category_code_2` AS `asset_sub_category_code_2`,`mber`.`date_of_inception` AS `date_of_inception`,`mber`.`unique_variant` AS `unique_variant`,`mber`.`final_benchmark` AS `final_benchmark`,`mber`.`benchmark` AS `benchmark`,`mber`.`benchmark_code` AS `benchmark_code`,`mber`.`alt_benchmark` AS `alt_benchmark`,`mber`.`alt_benchmark_code` AS `alt_benchmark_code`,`mber`.`fund_manager` AS `fund_manager`,`mber`.`exit_load_rate` AS `exit_load_rate`,`mber`.`exit_load_period` AS `exit_load_period`,`mber`.`exit_load_period_remark` AS `exit_load_period_remark`,`mber`.`sec_fund_manager` AS `sec_fund_manager`,`mber`.`min_invest` AS `min_invest`,`mber`.`min_invest_x` AS `min_invest_x`,`mber`.`min_invest_sip` AS `min_invest_sip`,`mber`.`min_invest_sip_x` AS `min_invest_sip_x`,`mber`.`risk_code` AS `risk_code`,`mber`.`risk_profile` AS `risk_profile`,`mber`.`risk_rating` AS `risk_rating`,`s`.`amfi_code` AS `amfi_code`,`s`.`fund_size` AS `fund_size`,`s`.`expense_ratio_s_d` AS `expense_ratio_s_d`,`s`.`pe_ratio` AS `pe_ratio`,`s`.`portfolio_turnover_ratio` AS `portfolio_turnover_ratio`,`s`.`market_cap_large` AS `market_cap_large`,`s`.`market_cap_mid` AS `market_cap_mid`,`s`.`market_cap_small` AS `market_cap_small`,`s`.`market_cap_others` AS `market_cap_others`,`s`.`credit_profile_A` AS `credit_profile_A`,`s`.`credit_profile_A_Minus` AS `credit_profile_A_Minus`,`s`.`credit_profile_A_IND` AS `credit_profile_A_IND`,`s`.`credit_profile_A_SO` AS `credit_profile_A_SO`,`s`.`credit_profile_A_Plus` AS `credit_profile_A_Plus`,`s`.`credit_profile_A_Plus_IND` AS `credit_profile_A_Plus_IND`,`s`.`credit_profile_A_Plus_SO` AS `credit_profile_A_Plus_SO`,`s`.`credit_profile_A_1` AS `credit_profile_A_1`,`s`.`credit_profile_A_MINUS_SO_BWR` AS `credit_profile_A_MINUS_SO_BWR`,`s`.`credit_profile_A_PLUS_SO_BWR` AS `credit_profile_A_PLUS_SO_BWR`,`s`.`credit_profile_AA` AS `credit_profile_AA`,`s`.`credit_profile_AA_Minus` AS `credit_profile_AA_Minus`,`s`.`credit_profile_AA_MINUS_IND` AS `credit_profile_AA_MINUS_IND`,`s`.`credit_profile_AA_SO` AS `credit_profile_AA_SO`,`s`.`credit_profile_AA_MINUS_SO` AS `credit_profile_AA_MINUS_SO`,`s`.`credit_profile_AA_PLUS` AS `credit_profile_AA_PLUS`,`s`.`credit_profile_AA_PLUS_SO` AS `credit_profile_AA_PLUS_SO`,`s`.`credit_profile_AA_BWR` AS `credit_profile_AA_BWR`,`s`.`credit_profile_AA_MINUS_SO_BWR` AS `credit_profile_AA_MINUS_SO_BWR`,`s`.`credit_profile_AA_PLUS_BWR` AS `credit_profile_AA_PLUS_BWR`,`s`.`credit_profile_A1_PLUS` AS `credit_profile_A1_PLUS`,`s`.`credit_profile_A1_PLUS_SO` AS `credit_profile_A1_PLUS_SO`,`s`.`credit_profile_AAA` AS `credit_profile_AAA`,`s`.`credit_profile_AAA_IND` AS `credit_profile_AAA_IND`,`s`.`credit_profile_AAA_SO` AS `credit_profile_AAA_SO`,`s`.`credit_profile_A_MINUS_BWR` AS `credit_profile_A_MINUS_BWR`,`s`.`credit_profile_cash_eq` AS `credit_profile_cash_eq`,`s`.`credit_profile_SOV` AS `credit_profile_SOV`,`s`.`avg_maturity_days` AS `avg_maturity_days`,`s`.`avg_maturity_months` AS `avg_maturity_months`,`s`.`avg_maturity_years` AS `avg_maturity_years`,`s`.`modified_maturity_days` AS `modified_maturity_days`,`s`.`modified_maturity_months` AS `modified_maturity_months`,`s`.`modified_maturity_years` AS `modified_maturity_years`,`s`.`yield_to_maturity` AS `yield_to_maturity`,`s`.`as_on_date` AS `as_on_date` from (((select `mbe`.`scheme_code` AS `scheme_code`,`mbe`.`amc_name` AS `amc_name`,`mbe`.`fund_name` AS `fund_name`,`mbe`.`scheme_name` AS `scheme_name`,`mbe`.`scheme_name_unique` AS `scheme_name_unique`,`mbe`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`mbe`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`mbe`.`dividend_payout_frequency` AS `dividend_payout_frequency`,`mbe`.`plan_name` AS `plan_name`,`mbe`.`option_name` AS `option_name`,`mbe`.`asset_class` AS `asset_class`,`mbe`.`asset_category` AS `asset_category`,`mbe`.`asset_sub_category` AS `asset_sub_category`,`mbe`.`asset_code` AS `asset_code`,`mbe`.`asset_category_code` AS `asset_category_code`,`mbe`.`asset_sub_category_code` AS `asset_sub_category_code`,`mbe`.`asset_sub_category_2` AS `asset_sub_category_2`,`mbe`.`asset_sub_category_code_2` AS `asset_sub_category_code_2`,`mbe`.`date_of_inception` AS `date_of_inception`,`mbe`.`unique_variant` AS `unique_variant`,`mbe`.`final_benchmark` AS `final_benchmark`,`mbe`.`benchmark` AS `benchmark`,`mbe`.`benchmark_code` AS `benchmark_code`,`mbe`.`alt_benchmark` AS `alt_benchmark`,`mbe`.`alt_benchmark_code` AS `alt_benchmark_code`,`mbe`.`fund_manager` AS `fund_manager`,`mbe`.`exit_load_rate` AS `exit_load_rate`,`mbe`.`exit_load_period` AS `exit_load_period`,`mbe`.`exit_load_period_remark` AS `exit_load_period_remark`,`mbe`.`sec_fund_manager` AS `sec_fund_manager`,`mbe`.`min_invest` AS `min_invest`,`mbe`.`min_invest_x` AS `min_invest_x`,`mbe`.`min_invest_sip` AS `min_invest_sip`,`mbe`.`min_invest_sip_x` AS `min_invest_sip_x`,`r`.`risk_code` AS `risk_code`,`r`.`risk_profile` AS `risk_profile`,`r`.`risk_rating` AS `risk_rating` from (((select `mb`.`scheme_code` AS `scheme_code`,`mb`.`amc_name` AS `amc_name`,`mb`.`fund_name` AS `fund_name`,`mb`.`scheme_name` AS `scheme_name`,`mb`.`scheme_name_unique` AS `scheme_name_unique`,`mb`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`mb`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`mb`.`dividend_payout_frequency` AS `dividend_payout_frequency`,`mb`.`plan_name` AS `plan_name`,`mb`.`option_name` AS `option_name`,`mb`.`asset_class` AS `asset_class`,`mb`.`asset_category` AS `asset_category`,`mb`.`asset_sub_category` AS `asset_sub_category`,`mb`.`asset_code` AS `asset_code`,`mb`.`asset_category_code` AS `asset_category_code`,`mb`.`asset_sub_category_code` AS `asset_sub_category_code`,`mb`.`asset_sub_category_2` AS `asset_sub_category_2`,`mb`.`asset_sub_category_code_2` AS `asset_sub_category_code_2`,`mb`.`date_of_inception` AS `date_of_inception`,`mb`.`unique_variant` AS `unique_variant`,`mb`.`final_benchmark` AS `final_benchmark`,`mb`.`benchmark` AS `benchmark`,`mb`.`benchmark_code` AS `benchmark_code`,`mb`.`alt_benchmark` AS `alt_benchmark`,`mb`.`alt_benchmark_code` AS `alt_benchmark_code`,`e`.`fund_manager` AS `fund_manager`,`e`.`exit_load_rate` AS `exit_load_rate`,`e`.`exit_load_period` AS `exit_load_period`,`e`.`exit_load_period_remark` AS `exit_load_period_remark`,`e`.`sec_fund_manager` AS `sec_fund_manager`,`e`.`min_invest` AS `min_invest`,`e`.`min_invest_x` AS `min_invest_x`,`e`.`min_invest_sip` AS `min_invest_sip`,`e`.`min_invest_sip_x` AS `min_invest_sip_x` from (((select `m`.`scheme_code` AS `scheme_code`,`m`.`amc_name` AS `amc_name`,`m`.`fund_name` AS `fund_name`,`m`.`scheme_name` AS `scheme_name`,`m`.`scheme_name_unique` AS `scheme_name_unique`,`m`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`m`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`m`.`dividend_payout_frequency` AS `dividend_payout_frequency`,`m`.`plan_name` AS `plan_name`,`m`.`option_name` AS `option_name`,`m`.`asset_class` AS `asset_class`,`m`.`asset_category` AS `asset_category`,`m`.`asset_sub_category` AS `asset_sub_category`,`m`.`asset_code` AS `asset_code`,`m`.`asset_category_code` AS `asset_category_code`,`m`.`asset_sub_category_code` AS `asset_sub_category_code`,`m`.`asset_sub_category_2` AS `asset_sub_category_2`,`m`.`asset_sub_category_code_2` AS `asset_sub_category_code_2`,`m`.`date_of_inception` AS `date_of_inception`,`m`.`unique_variant` AS `unique_variant`,`m`.`final_benchmark` AS `final_benchmark`,`b`.`benchmark` AS `benchmark`,`b`.`benchmark_code` AS `benchmark_code`,`b`.`alt_benchmark` AS `alt_benchmark`,`b`.`alt_benchmark_code` AS `alt_benchmark_code` from (`alchemy`.`mf_fu_amc_master` `m` left join `alchemy`.`benchmark_matrix_latest` `b` on((`m`.`final_benchmark` = `b`.`final_benchmark`))))) `mb` left join `alchemy`.`mf_ufd_exit_info` `e` on((`mb`.`scheme_code` = `e`.`amfi_code`))))) `mbe` left join `alchemy`.`risk_profile_matrix` `r` on((concat(`mbe`.`asset_code`,`mbe`.`asset_category_code`) = `r`.`risk_code`))))) `mber` left join `alchemy`.`mf_ufm_scheme_details_latest` `s` on((`mber`.`scheme_code` = `s`.`amfi_code`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mf_nav_daily_v`
--

/*!50001 DROP VIEW IF EXISTS `mf_nav_daily_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alchemy`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `mf_nav_daily_v` AS select `x`.`id` AS `id`,`x`.`scheme_code` AS `scheme_code`,`x`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`x`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`x`.`scheme_name` AS `scheme_name`,`x`.`net_asset_val` AS `net_asset_val`,`x`.`repurchase_price` AS `repurchase_price`,`x`.`sale_price` AS `sale_price`,`x`.`date` AS `date`,`x`.`created_date` AS `created_date`,`x`.`nav_date` AS `nav_date` from (select `n1`.`id` AS `id`,`n1`.`scheme_code` AS `scheme_code`,`n1`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`n1`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`n1`.`scheme_name` AS `scheme_name`,`n1`.`net_asset_val` AS `net_asset_val`,`n1`.`repurchase_price` AS `repurchase_price`,`n1`.`sale_price` AS `sale_price`,`n1`.`date` AS `date`,`n1`.`created_date` AS `created_date`,`n1`.`nav_date` AS `nav_date` from (`alchemy`.`mf_nav_daily` `n1` join (select `alchemy`.`mf_nav_daily`.`scheme_code` AS `scheme_code`,max(`alchemy`.`mf_nav_daily`.`nav_date`) AS `nav_date` from `alchemy`.`mf_nav_daily` group by `alchemy`.`mf_nav_daily`.`scheme_code`) `n2`) where ((`n1`.`scheme_code` = `n2`.`scheme_code`) and (`n1`.`nav_date` = `n2`.`nav_date`))) `x` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mf_navdata_view`
--

/*!50001 DROP VIEW IF EXISTS `mf_navdata_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alchemy`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `mf_navdata_view` AS select `es_mf_nav_daily`.`scheme_code` AS `scheme_code`,`es_mf_nav_daily`.`scheme_name` AS `scheme_name`,`es_mf_nav_daily`.`asset_category` AS `asset_category`,`es_mf_nav_daily`.`asset_sub_category` AS `asset_sub_category`,`es_mf_nav_daily`.`isin_dividend_payout_or_growth` AS `isin_dividend_payout_or_growth`,`es_mf_nav_daily`.`isin_dividend_reinvest` AS `isin_dividend_reinvest`,`es_mf_nav_daily`.`nav` AS `nav`,`es_mf_nav_daily`.`nav_date` AS `nav_date`,`es_mf_nav_daily`.`final_benchmark` AS `final_benchmark`,`es_mf_nav_daily`.`benchmark` AS `benchmark`,`es_mf_nav_daily`.`benchmark_value` AS `benchmark_value`,`es_mf_nav_daily`.`alt_benchmark` AS `alt_benchmark` from `es_mf_nav_daily` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mf_ufm_scheme_details_latest`
--

/*!50001 DROP VIEW IF EXISTS `mf_ufm_scheme_details_latest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`alchemy`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `mf_ufm_scheme_details_latest` AS select `s`.`amfi_code` AS `amfi_code`,`s`.`fund_size` AS `fund_size`,`s`.`expense_ratio_s_d` AS `expense_ratio_s_d`,`s`.`pe_ratio` AS `pe_ratio`,`s`.`portfolio_turnover_ratio` AS `portfolio_turnover_ratio`,`s`.`market_cap_large` AS `market_cap_large`,`s`.`market_cap_mid` AS `market_cap_mid`,`s`.`market_cap_small` AS `market_cap_small`,`s`.`market_cap_others` AS `market_cap_others`,`s`.`credit_profile_A` AS `credit_profile_A`,`s`.`credit_profile_A_Minus` AS `credit_profile_A_Minus`,`s`.`credit_profile_A_IND` AS `credit_profile_A_IND`,`s`.`credit_profile_A_SO` AS `credit_profile_A_SO`,`s`.`credit_profile_A_Plus` AS `credit_profile_A_Plus`,`s`.`credit_profile_A_Plus_IND` AS `credit_profile_A_Plus_IND`,`s`.`credit_profile_A_Plus_SO` AS `credit_profile_A_Plus_SO`,`s`.`credit_profile_A_1` AS `credit_profile_A_1`,`s`.`credit_profile_A_MINUS_SO_BWR` AS `credit_profile_A_MINUS_SO_BWR`,`s`.`credit_profile_A_PLUS_SO_BWR` AS `credit_profile_A_PLUS_SO_BWR`,`s`.`credit_profile_AA` AS `credit_profile_AA`,`s`.`credit_profile_AA_Minus` AS `credit_profile_AA_Minus`,`s`.`credit_profile_AA_MINUS_IND` AS `credit_profile_AA_MINUS_IND`,`s`.`credit_profile_AA_SO` AS `credit_profile_AA_SO`,`s`.`credit_profile_AA_MINUS_SO` AS `credit_profile_AA_MINUS_SO`,`s`.`credit_profile_AA_PLUS` AS `credit_profile_AA_PLUS`,`s`.`credit_profile_AA_PLUS_SO` AS `credit_profile_AA_PLUS_SO`,`s`.`credit_profile_AA_BWR` AS `credit_profile_AA_BWR`,`s`.`credit_profile_AA_MINUS_SO_BWR` AS `credit_profile_AA_MINUS_SO_BWR`,`s`.`credit_profile_AA_PLUS_BWR` AS `credit_profile_AA_PLUS_BWR`,`s`.`credit_profile_A1_PLUS` AS `credit_profile_A1_PLUS`,`s`.`credit_profile_A1_PLUS_SO` AS `credit_profile_A1_PLUS_SO`,`s`.`credit_profile_AAA` AS `credit_profile_AAA`,`s`.`credit_profile_AAA_IND` AS `credit_profile_AAA_IND`,`s`.`credit_profile_AAA_SO` AS `credit_profile_AAA_SO`,`s`.`credit_profile_A_MINUS_BWR` AS `credit_profile_A_MINUS_BWR`,`s`.`credit_profile_cash_eq` AS `credit_profile_cash_eq`,`s`.`credit_profile_SOV` AS `credit_profile_SOV`,`s`.`avg_maturity_days` AS `avg_maturity_days`,`s`.`avg_maturity_months` AS `avg_maturity_months`,`s`.`avg_maturity_years` AS `avg_maturity_years`,`s`.`modified_maturity_days` AS `modified_maturity_days`,`s`.`modified_maturity_months` AS `modified_maturity_months`,`s`.`modified_maturity_years` AS `modified_maturity_years`,`s`.`yield_to_maturity` AS `yield_to_maturity`,max(`s`.`as_on_date`) AS `as_on_date` from `mf_ufm_scheme_details` `s` group by `s`.`amfi_code` */;
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

-- Dump completed on 2017-12-29 18:42:00
