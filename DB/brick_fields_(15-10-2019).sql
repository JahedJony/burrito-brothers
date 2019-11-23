-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table brick_factory.accounts_head
CREATE TABLE IF NOT EXISTS `accounts_head` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(55) NOT NULL,
  `head_name` varchar(55) NOT NULL,
  `head_type` varchar(50) NOT NULL DEFAULT 'bank' COMMENT '1:bank, 2: mobile_bank, 3:cash ',
  `balance` double(12,4) NOT NULL,
  `status` varchar(50) NOT NULL COMMENT '1:active, 2: in-active',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brick_factory.accounts_head: ~0 rows (approximately)
/*!40000 ALTER TABLE `accounts_head` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_head` ENABLE KEYS */;

-- Dumping structure for table brick_factory.accounts_transection
CREATE TABLE IF NOT EXISTS `accounts_transection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transection_no` varchar(50) NOT NULL,
  `from_head_id` int(11) DEFAULT NULL,
  `to_head_id` int(11) NOT NULL,
  `debit` double(12,4) NOT NULL,
  `credit` double(12,4) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `transfer` tinyint(1) NOT NULL COMMENT '1:transection, 0:General, 2:Deposit/Investment, 3withdraw',
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brick_factory.accounts_transection: ~0 rows (approximately)
/*!40000 ALTER TABLE `accounts_transection` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_transection` ENABLE KEYS */;

-- Dumping structure for table brick_factory.acc_bills
CREATE TABLE IF NOT EXISTS `acc_bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_reference_` varchar(50) DEFAULT NULL,
  `bill_type` int(11) DEFAULT NULL,
  `people_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `total_billed_amount` double(12,4) NOT NULL,
  `deduted_amount` double(12,4) NOT NULL,
  `total_payable_amount` double(12,4) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:pending,3:paid, 2:partial',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_daily_bills_companies` (`company_id`),
  KEY `FK_daily_bills_emp_infos` (`created_by`),
  KEY `FK_daily_bills_emp_infos_2` (`modified_by`),
  KEY `FK_daily_bills_peoples` (`people_id`),
  KEY `FK_daily_bills_seasons` (`season_id`),
  CONSTRAINT `FK_daily_bills_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_daily_bills_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_bills_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_bills_peoples` FOREIGN KEY (`people_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_daily_bills_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.acc_bills: ~0 rows (approximately)
/*!40000 ALTER TABLE `acc_bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_bills` ENABLE KEYS */;

-- Dumping structure for table brick_factory.acc_payments
CREATE TABLE IF NOT EXISTS `acc_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_reference_no` varchar(50) NOT NULL,
  `payment_type` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `bill_id` int(11) NOT NULL,
  `paid_amount` double(12,4) NOT NULL,
  `deduted_amount` double(12,4) NOT NULL,
  `total_payable_amount` double(12,4) NOT NULL,
  `payment_methode` tinyint(1) DEFAULT '1' COMMENT '1:cash,3:bank, 2:mobile_bank,4:others',
  `payment_methode_details` text,
  `attachment` text,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:pending,3:paid, 2:partial',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_acc_payments_companies` (`company_id`),
  KEY `FK_acc_payments_emp_infos` (`created_by`),
  KEY `FK_acc_payments_emp_infos_2` (`modified_by`),
  KEY `FK_acc_payments_peoples` (`people_id`),
  KEY `FK_acc_payments_seasons` (`season_id`),
  KEY `FK_acc_payments_people_type` (`payment_type`),
  CONSTRAINT `FK_acc_payments_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_acc_payments_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_acc_payments_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_acc_payments_people_type` FOREIGN KEY (`payment_type`) REFERENCES `people_type` (`id`),
  CONSTRAINT `FK_acc_payments_peoples` FOREIGN KEY (`people_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_acc_payments_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.acc_payments: ~0 rows (approximately)
/*!40000 ALTER TABLE `acc_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_payments` ENABLE KEYS */;

-- Dumping structure for table brick_factory.acc_receives
CREATE TABLE IF NOT EXISTS `acc_receives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receive_reference_no` varchar(50) NOT NULL,
  `receive_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:sell,2:others',
  `customer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `sale_id` int(11) NOT NULL,
  `received_amount` double(12,4) NOT NULL,
  `received_methode` tinyint(1) DEFAULT '1' COMMENT '1:cash,3:bank, 2:mobile_bank,4:others',
  `received_methode_details` text,
  `attachment` text,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:received,2:pending',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_acc_receives_companies` (`company_id`),
  KEY `FK_acc_receives_emp_infos` (`created_by`),
  KEY `FK_acc_receives_emp_infos_2` (`modified_by`),
  KEY `FK_acc_receives_peoples` (`customer_id`),
  KEY `FK_acc_receives_seasons` (`season_id`),
  CONSTRAINT `FK_acc_receives_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_acc_receives_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_acc_receives_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_acc_receives_peoples` FOREIGN KEY (`customer_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_acc_receives_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.acc_receives: ~0 rows (approximately)
/*!40000 ALTER TABLE `acc_receives` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_receives` ENABLE KEYS */;

-- Dumping structure for table brick_factory.adjustment_bricks
CREATE TABLE IF NOT EXISTS `adjustment_bricks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `note` text,
  `adjusted_by` int(11) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_damage_bricks_companies` (`company_id`),
  KEY `FK_damage_bricks_emp_infos` (`created_by`),
  KEY `FK_damage_bricks_emp_infos_2` (`modified_by`),
  KEY `FK_damage_bricks_stock_seasons` (`season_id`),
  CONSTRAINT `FK_damage_bricks_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_damage_bricks_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_damage_bricks_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_damage_bricks_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.adjustment_bricks: ~1 rows (approximately)
/*!40000 ALTER TABLE `adjustment_bricks` DISABLE KEYS */;
INSERT INTO `adjustment_bricks` (`id`, `date`, `note`, `adjusted_by`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(37, '2019-10-13', 'x df fdsf', 6, 1, 2, '1000001', '1000001', '2019-10-13 18:41:54', '2019-10-13 15:58:44');
/*!40000 ALTER TABLE `adjustment_bricks` ENABLE KEYS */;

-- Dumping structure for table brick_factory.adjustment_details
CREATE TABLE IF NOT EXISTS `adjustment_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adjustment_mst_id` int(11) NOT NULL,
  `brick_type` int(11) NOT NULL,
  `brick_quantity` int(11) NOT NULL,
  `adjustment_type` tinyint(1) DEFAULT NULL COMMENT '1:Damaged, 2: System Loss , 3: Added',
  `reason` text,
  PRIMARY KEY (`id`),
  KEY `FK5` (`brick_type`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- Dumping data for table brick_factory.adjustment_details: ~3 rows (approximately)
/*!40000 ALTER TABLE `adjustment_details` DISABLE KEYS */;
INSERT INTO `adjustment_details` (`id`, `adjustment_mst_id`, `brick_type`, `brick_quantity`, `adjustment_type`, `reason`) VALUES
	(13, 37, 2, 10, 1, NULL),
	(14, 37, 4, 20, 2, NULL),
	(15, 37, 9, 1, 2, NULL);
/*!40000 ALTER TABLE `adjustment_details` ENABLE KEYS */;

-- Dumping structure for table brick_factory.agreements
CREATE TABLE IF NOT EXISTS `agreements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agreement_name` varchar(100) DEFAULT NULL,
  `people_id` int(11) NOT NULL,
  `agreement_type` int(11) NOT NULL,
  `agreement_date` date DEFAULT NULL,
  `unit_qty` float(4,2) DEFAULT NULL,
  `unit_id` int(1) DEFAULT NULL,
  `unit_rate` double(12,2) DEFAULT NULL,
  `deduction_rate` double(12,2) DEFAULT '0.00',
  `deduction_by` tinyint(1) DEFAULT '1' COMMENT '1:by percentage, 2 : amount',
  `advance_payment` double(12,2) NOT NULL DEFAULT '0.00',
  `balance` double(12,2) NOT NULL DEFAULT '0.00',
  `daily_conveyance` double(12,2) NOT NULL DEFAULT '0.00' COMMENT 'soil team',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `act_start_date` date DEFAULT NULL,
  `act_end_date` date DEFAULT NULL,
  `agreement_by` int(11) DEFAULT NULL,
  `agreement_review` int(11) DEFAULT NULL COMMENT '1,2,3,4,5 = 5 top',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:upcoming, 2:Ongoing,3:Completed',
  `agreement_details` text,
  `completation_review` text,
  `attachment` varchar(300) DEFAULT NULL,
  `attachment1` varchar(300) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `people_id_agreement_type_company_id_season_id` (`people_id`,`agreement_type`,`company_id`,`season_id`,`unit_rate`),
  KEY `FK_agreements_companies` (`company_id`),
  KEY `FK_agreements_emp_infos` (`created_by`),
  KEY `FK_agreements_emp_infos_2` (`modified_by`),
  KEY `FK_agreements_seasons` (`season_id`),
  KEY `FK_agreements_peoples` (`people_id`),
  KEY `FK_agreements_units` (`unit_id`),
  KEY `FK_agreements_peoples_2` (`agreement_by`),
  KEY `FK_agreements_agreement_type` (`agreement_type`),
  CONSTRAINT `FK_agreements_agreement_type` FOREIGN KEY (`agreement_type`) REFERENCES `agreement_type` (`id`),
  CONSTRAINT `FK_agreements_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_agreements_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_agreements_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_agreements_peoples` FOREIGN KEY (`people_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_agreements_peoples_2` FOREIGN KEY (`agreement_by`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_agreements_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `FK_agreements_units` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.agreements: ~15 rows (approximately)
/*!40000 ALTER TABLE `agreements` DISABLE KEYS */;
INSERT INTO `agreements` (`id`, `agreement_name`, `people_id`, `agreement_type`, `agreement_date`, `unit_qty`, `unit_id`, `unit_rate`, `deduction_rate`, `deduction_by`, `advance_payment`, `balance`, `daily_conveyance`, `start_date`, `end_date`, `act_start_date`, `act_end_date`, `agreement_by`, `agreement_review`, `company_id`, `season_id`, `status`, `agreement_details`, `completation_review`, `attachment`, `attachment1`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(2, NULL, 6, 1, '2019-04-13', 10.00, 3, 20000.00, 0.00, 1, 0.00, 0.00, 0.00, '2019-04-13', '2029-04-30', NULL, NULL, 6, 0, 1, 2, 1, '', '', '', ' ', '1000001', '1000001', '2019-04-21 15:32:50', '2019-04-13 14:11:47'),
	(3, NULL, 9, 4, '2019-04-17', 1.00, 5, 1200.00, NULL, 1, 0.00, 0.00, 100.00, '2019-04-18', NULL, NULL, NULL, 6, NULL, 1, 2, 1, '   The UK\'s intention is to address the EU Single Market and customs union issues around the Irish border question through an overall EU-UK relationship. That is, through an EU-UK trade deal.', '', '', '', '1000001', NULL, '2019-08-04 11:39:45', '2019-04-17 17:29:03'),
	(4, NULL, 4, 3, '2019-04-19', NULL, 3, NULL, 0.00, 1, 50000.00, 0.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-04-26 11:28:28', '2019-04-19 11:58:34'),
	(8, 'Dry load', 11, 6, '2019-04-20', NULL, NULL, NULL, NULL, 1, 50000.00, 0.00, 0.00, '2019-04-20', '2019-04-20', NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 16:08:47', '2019-04-20 13:15:32'),
	(9, NULL, 13, 3, '2019-04-26', NULL, NULL, NULL, NULL, 1, 40000.00, 0.00, 0.00, '2019-04-30', NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', NULL, NULL, '2019-04-26 11:31:18'),
	(10, 'Kacha Bangla', 18, 5, '2019-08-05', 1.00, 7, 800.00, 10.00, 1, 100000.00, 98800.00, 100.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 14:19:12', '2019-08-05 22:07:14'),
	(11, NULL, 19, 5, '2019-08-05', 1.00, 7, 750.00, 5.00, 1, 20000.00, 0.00, 100.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', NULL, NULL, '2019-08-05 22:08:01'),
	(12, NULL, 20, 5, '2019-08-06', 1.00, 7, 600.00, 5.00, 1, 50000.00, 0.00, 100.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', NULL, NULL, '2019-08-05 22:08:50'),
	(14, 'Kacha Auto', 18, 5, '2019-08-05', 1.00, 7, 890.00, 200.00, 2, 20000.00, 20000.00, 200.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-18 16:46:06', '2019-08-05 22:17:42'),
	(15, 'Dry khamal', 18, 5, '2019-09-15', 1.00, 7, 500.00, NULL, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 14:52:16', '2019-09-15 13:02:36'),
	(16, 'Dry khamal', 19, 5, '2019-09-15', 1.00, 7, 480.00, NULL, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 14:52:07', '2019-09-15 13:03:22'),
	(17, 'Dry khamal', 20, 5, '2019-09-15', 1.00, 7, 550.00, 0.00, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 14:51:56', '2019-09-15 15:01:30'),
	(18, 'Dry Toma', 21, 6, '2019-09-16', NULL, 7, NULL, 50.00, 2, 10000.00, 8800.00, 0.00, '2019-09-16', NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-10-14 17:24:11', '2019-09-17 00:09:52'),
	(19, 'Dry drumstack', 23, 6, '2019-09-19', NULL, 7, NULL, 50.00, 2, 50000.00, 48900.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 15:55:30', '2019-09-19 18:07:10'),
	(20, 'Paka Unload ', 24, 6, '2019-09-23', NULL, NULL, NULL, 20.00, 2, 1000.00, 360.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-26 05:01:59', '2019-09-23 14:35:05');
/*!40000 ALTER TABLE `agreements` ENABLE KEYS */;

-- Dumping structure for table brick_factory.agreement_type
CREATE TABLE IF NOT EXISTS `agreement_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  `agreement_type` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:in-active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.agreement_type: ~14 rows (approximately)
/*!40000 ALTER TABLE `agreement_type` DISABLE KEYS */;
INSERT INTO `agreement_type` (`id`, `type`, `agreement_type`, `status`) VALUES
	(1, 'EMPLOYEE', 'EMPLOYE', 1),
	(2, 'LAND', 'LAND', 1),
	(3, 'SOIL', 'SOIL VENDOR/ OWENER', 1),
	(4, 'LANDEX', 'LAND EXCAVATOR', 1),
	(5, 'KCHA', 'KACHA BRICK / KHAMAL TEAM', 1),
	(6, 'LOAD', 'LOAD TEAM', 1),
	(7, 'FIRE', 'FIRE TEAM', 1),
	(8, 'UNLOAD', 'UNLOAD TEAM', 1),
	(9, 'SUPPLIR', 'SUPPLIER', 1),
	(10, 'CUSTOMER', 'CUSTOMER', 1),
	(11, 'LBR', 'LABOUR', 1),
	(12, 'TDRIVER', 'TRUCK DRIVER', 1),
	(13, 'VDRIVER', 'VAN DRIVER', 1),
	(14, 'BANK', 'BANK/ FINANCIAL ', 1);
/*!40000 ALTER TABLE `agreement_type` ENABLE KEYS */;

-- Dumping structure for table brick_factory.appuser
CREATE TABLE IF NOT EXISTS `appuser` (
  `user_id` varchar(12) NOT NULL DEFAULT '',
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `user_password` varchar(40) DEFAULT NULL,
  `user_level` varchar(10) NOT NULL DEFAULT 'General' COMMENT 'Admin,Developer,General',
  `login_status` tinyint(4) DEFAULT '0' COMMENT '1=login; 0=not login;',
  `is_active` int(1) NOT NULL DEFAULT '1' COMMENT '1=Active,0=Blocked',
  `modified_by` varchar(20) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  KEY `con_user_created_by_fk` (`created_by`),
  KEY `con_user_modified_by_fk` (`modified_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.appuser: ~3 rows (approximately)
/*!40000 ALTER TABLE `appuser` DISABLE KEYS */;
INSERT INTO `appuser` (`user_id`, `user_name`, `user_password`, `user_level`, `login_status`, `is_active`, `modified_by`, `modified_time`, `created_by`, `created_at`) VALUES
	('1000001', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'Admin', 0, 1, NULL, NULL, '1000001', '2018-08-07 13:33:40'),
	('1000002', 'munif', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 1, NULL, NULL, '1000001', '2019-03-20 20:40:19'),
	('EMP-000003', 'litu', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 1, NULL, NULL, '1000001', '2019-03-20 23:33:11');
/*!40000 ALTER TABLE `appuser` ENABLE KEYS */;

-- Dumping structure for table brick_factory.brick_stock
CREATE TABLE IF NOT EXISTS `brick_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kacha_prod_id` int(11) DEFAULT NULL,
  `load_id` int(11) DEFAULT NULL,
  `sale_item_id` int(11) DEFAULT NULL,
  `adjustment_dtls_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `quantity` int(11) NOT NULL COMMENT '+ add , - subtruct',
  `brick_type` int(11) NOT NULL,
  `balance_quantity` int(11) NOT NULL,
  `note` text,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_brick_stock_companies` (`company_id`),
  KEY `FK_brick_stock_emp_infos` (`created_by`),
  KEY `FK_brick_stock_emp_infos_2` (`modified_by`),
  KEY `FK_brick_stock_seasons` (`season_id`),
  KEY `FK_brick_stock_brick_types` (`brick_type`),
  CONSTRAINT `FK_brick_stock_brick_types` FOREIGN KEY (`brick_type`) REFERENCES `brick_types` (`id`),
  CONSTRAINT `FK_brick_stock_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_brick_stock_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_brick_stock_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_brick_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=453 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.brick_stock: ~56 rows (approximately)
/*!40000 ALTER TABLE `brick_stock` DISABLE KEYS */;
INSERT INTO `brick_stock` (`id`, `kacha_prod_id`, `load_id`, `sale_item_id`, `adjustment_dtls_id`, `date`, `quantity`, `brick_type`, `balance_quantity`, `note`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(174, 42, NULL, NULL, NULL, '2019-09-22', 10000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:01:59'),
	(175, 43, NULL, NULL, NULL, '2019-09-21', 10000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:02:58'),
	(176, 44, NULL, NULL, NULL, '2019-09-22', 9000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:03:24'),
	(177, 44, NULL, NULL, NULL, '2019-09-22', 1000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:04:27'),
	(178, 44, NULL, NULL, NULL, '2019-09-22', -100, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:04:44'),
	(179, 43, NULL, NULL, NULL, '2019-09-21', -100, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:04:54'),
	(180, 42, NULL, NULL, NULL, '2019-09-22', -100, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:05:04'),
	(181, 45, NULL, NULL, NULL, '2019-09-23', 8000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:19:11'),
	(182, 45, NULL, NULL, NULL, '2019-09-23', -8000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:19:11'),
	(183, 45, NULL, NULL, NULL, '2019-09-23', -100, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:19:12'),
	(184, 46, NULL, NULL, NULL, '2019-09-22', 9900, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:20:29'),
	(185, 46, NULL, NULL, NULL, '2019-09-22', -9900, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:20:29'),
	(186, 46, NULL, NULL, NULL, '2019-09-22', -100, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:20:29'),
	(187, 46, NULL, NULL, NULL, '2019-09-22', 10000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:22:45'),
	(188, 46, NULL, NULL, NULL, '2019-09-22', -10000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 14:22:45'),
	(286, NULL, 29, NULL, NULL, '2019-09-24', -3000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 15:51:55'),
	(287, NULL, 29, NULL, NULL, '2019-09-24', 3000, 12, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 15:51:55'),
	(288, NULL, 29, NULL, NULL, '2019-09-24', -200, 12, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 15:51:55'),
	(289, NULL, 29, NULL, NULL, '2019-09-24', -5000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 15:51:55'),
	(290, NULL, 29, NULL, NULL, '2019-09-24', 5000, 12, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 15:51:55'),
	(291, NULL, 29, NULL, NULL, '2019-09-24', -100, 12, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 15:51:55'),
	(350, NULL, 34, NULL, NULL, '2019-09-24', -3000, 12, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 16:57:55'),
	(351, NULL, 34, NULL, NULL, '2019-09-24', 3000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 16:57:55'),
	(352, NULL, 34, NULL, NULL, '2019-09-24', -100, 13, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 16:57:55'),
	(353, NULL, 34, NULL, NULL, '2019-09-24', -1000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 16:57:55'),
	(354, NULL, 34, NULL, NULL, '2019-09-24', 1000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 16:57:55'),
	(402, NULL, 37, NULL, NULL, '2019-09-25', -2000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(403, NULL, 37, NULL, NULL, '2019-09-25', 2000, 2, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(404, NULL, 37, NULL, NULL, '2019-09-25', 2, 7, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(405, NULL, 37, NULL, NULL, '2019-09-25', -1000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(406, NULL, 37, NULL, NULL, '2019-09-25', 1000, 4, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(407, NULL, 37, NULL, NULL, '2019-09-25', -100, 4, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(408, NULL, 37, NULL, NULL, '2019-09-25', -500, 13, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(409, NULL, 37, NULL, NULL, '2019-09-25', 500, 5, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(410, NULL, 37, NULL, NULL, '2019-09-25', -5, 5, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-25 18:20:21'),
	(415, NULL, 39, NULL, NULL, '2019-09-26', -100, 13, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-26 05:01:59'),
	(416, NULL, 39, NULL, NULL, '2019-09-26', 100, 2, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-26 05:01:59'),
	(417, NULL, 40, NULL, NULL, '2019-09-28', -10000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-28 12:16:43'),
	(418, NULL, 40, NULL, NULL, '2019-09-28', 10000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-09-28 12:16:43'),
	(426, NULL, NULL, 11, NULL, '2019-10-07', -200, 2, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-07 14:38:17'),
	(427, NULL, NULL, 14, NULL, '2019-10-10', -50, 2, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-10 11:52:31'),
	(428, NULL, NULL, 15, NULL, '2019-10-10', -50, 4, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-10 11:52:31'),
	(429, NULL, NULL, 11, NULL, '2019-10-10', -100, 2, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-10 11:56:27'),
	(430, NULL, NULL, 14, NULL, '2019-10-10', -50, 2, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-10 11:56:27'),
	(441, NULL, NULL, NULL, 13, '2019-10-13', -10, 2, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-13 18:44:16'),
	(442, NULL, NULL, NULL, 14, '2019-10-13', -20, 4, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-13 18:44:16'),
	(443, NULL, NULL, NULL, 15, '2019-10-13', -1, 9, 0, NULL, 1, 2, '1000001', NULL, '2019-10-14 15:48:45', '2019-10-14 15:48:45'),
	(444, NULL, 23, NULL, NULL, '2019-09-24', -5000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11'),
	(445, NULL, 23, NULL, NULL, '2019-09-24', 5000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11'),
	(446, NULL, 23, NULL, NULL, '2019-09-24', -20, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11'),
	(447, NULL, 23, NULL, NULL, '2019-09-24', -5000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11'),
	(448, NULL, 23, NULL, NULL, '2019-09-24', 5000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11'),
	(449, NULL, 23, NULL, NULL, '2019-09-24', -30, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11'),
	(450, NULL, 23, NULL, NULL, '2019-09-24', -5000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11'),
	(451, NULL, 23, NULL, NULL, '2019-09-24', 5000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11'),
	(452, NULL, 23, NULL, NULL, '2019-09-24', -10, 11, 0, NULL, 1, 2, '1000001', NULL, NULL, '2019-10-14 17:24:11');
/*!40000 ALTER TABLE `brick_stock` ENABLE KEYS */;

-- Dumping structure for table brick_factory.brick_types
CREATE TABLE IF NOT EXISTS `brick_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brick_name` varchar(100) DEFAULT NULL COMMENT '1stclass, 2ndclass, adhla, dry, kacha, khamal',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:kacha, 2:paka',
  `current_rate` float(8,2) NOT NULL DEFAULT '0.00',
  `selling_unit` int(11) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:inactive',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_brick_types_emp_infos` (`created_by`),
  KEY `FK_brick_types_emp_infos_2` (`modified_by`),
  CONSTRAINT `FK_brick_types_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_brick_types_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.brick_types: ~15 rows (approximately)
/*!40000 ALTER TABLE `brick_types` DISABLE KEYS */;
INSERT INTO `brick_types` (`id`, `brick_name`, `type`, `current_rate`, `selling_unit`, `note`, `status`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(2, '1No Bangla', 2, 8.00, 2, '1st class ', 1, '1000001', NULL, '2019-09-30 15:13:23', '2019-01-21 23:32:03'),
	(4, '2No Bangla', 2, 7.00, 2, '2nd class', 1, '1000001', NULL, '2019-09-30 15:13:24', '2019-01-21 23:32:28'),
	(5, '3No Bangla', 2, 6.00, 2, '3rd class', 1, '1000001', '1000001', '2019-09-30 15:13:26', '2019-03-11 21:31:47'),
	(7, 'Adhla', 2, 0.00, 10, NULL, 1, '1000001', NULL, '2019-09-30 15:28:16', '2019-01-21 23:33:19'),
	(8, 'Shurki', 2, 0.00, 10, NULL, 1, '1000001', NULL, '2019-09-30 15:13:32', '2019-01-21 23:33:40'),
	(9, 'Kacha', 1, 0.00, 0, 'Just Ready Brick', 1, '1000001', NULL, '2019-01-21 23:33:40', '2019-01-21 23:34:39'),
	(10, 'Khamal ', 1, 0.00, 0, 'dry khamal  Brick', 1, '1000001', NULL, '2019-01-21 23:33:40', '2019-01-21 23:36:35'),
	(11, 'TOMA', 1, 0.00, 0, 'dry Toma Brick', 1, '1000001', NULL, '2019-08-07 11:41:38', '2019-01-21 23:35:21'),
	(12, 'Drumstack', 1, 0.00, 0, 'dry drumstackBrick', 1, '1000001', NULL, '2019-01-21 23:33:40', '2019-01-21 23:35:21'),
	(13, 'Loaded', 1, 0.00, 0, 'Loaded to kill for fire ', 1, '1000001', NULL, '2019-01-21 23:33:40', '2019-01-21 23:36:52'),
	(14, 'Used Paka', 2, 0.00, 2, 'Used paka brick for brickfield purpose', 1, NULL, NULL, '2019-09-30 15:16:11', '2019-09-18 18:31:05'),
	(15, '1No Auto', 2, 8.50, 2, NULL, 1, NULL, NULL, '2019-09-30 15:13:37', '2019-09-24 16:26:34'),
	(16, '2No Auto', 2, 7.50, 2, NULL, 1, NULL, NULL, '2019-09-30 15:13:38', '2019-09-24 16:26:34'),
	(17, '3No Auto', 2, 6.50, 2, NULL, 1, NULL, NULL, '2019-09-30 15:13:39', '2019-09-24 16:26:34'),
	(18, 'Khoyaa', 2, 350.00, 10, NULL, 1, NULL, NULL, '2019-09-30 15:13:41', '2019-09-30 15:11:09');
/*!40000 ALTER TABLE `brick_types` ENABLE KEYS */;

-- Dumping structure for table brick_factory.companies
CREATE TABLE IF NOT EXISTS `companies` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(150) NOT NULL,
  `company_address` text,
  `phone` varchar(18) DEFAULT NULL,
  `note` text,
  `logo` longtext,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  0: inactive',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `con_company_name_uk` (`company_name`),
  KEY `FK_created_by` (`created_by`),
  KEY `FK_modified_by` (`modified_by`),
  CONSTRAINT `FK_created_by` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.companies: ~2 rows (approximately)
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` (`company_id`, `company_name`, `company_address`, `phone`, `note`, `logo`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
	(1, 'Molla Bricks Ltd.', 'dhora, maria, gabtoli bogura', '015754557', 'fdsfdsfdsfd', NULL, 1, '1000001', '1000001', '2019-01-14 23:08:53', '2019-03-11 21:27:34'),
	(2, 'Molla Bricks Ltd2', 'dhora, maria, gabtoli bogura', '015754557', 'fdsfdsfdsfd', NULL, 1, '1000001', '1000001', '2019-01-14 23:08:53', '2019-03-11 21:27:34');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;

-- Dumping structure for table brick_factory.daily_fire_status
CREATE TABLE IF NOT EXISTS `daily_fire_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `party_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `total_bill` double(12,4) NOT NULL,
  `door_from_id` int(11) NOT NULL,
  `door_to_id` int(11) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:inactive',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_daily_fire_status_companies` (`company_id`),
  KEY `FK_daily_fire_status_emp_infos` (`created_by`),
  KEY `FK_daily_fire_status_emp_infos_2` (`modified_by`),
  KEY `FK_daily_fire_status_peoples` (`party_id`),
  KEY `FK_daily_fire_status_seasons` (`season_id`),
  KEY `FK_daily_fire_status_agreements` (`agreement_id`),
  KEY `FK_daily_fire_status_rounds` (`round_id`),
  CONSTRAINT `FK_daily_fire_status_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  CONSTRAINT `FK_daily_fire_status_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_daily_fire_status_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_fire_status_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_fire_status_peoples` FOREIGN KEY (`party_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_daily_fire_status_rounds` FOREIGN KEY (`round_id`) REFERENCES `rounds` (`id`),
  CONSTRAINT `FK_daily_fire_status_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.daily_fire_status: ~0 rows (approximately)
/*!40000 ALTER TABLE `daily_fire_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_fire_status` ENABLE KEYS */;

-- Dumping structure for table brick_factory.daily_individual_production
CREATE TABLE IF NOT EXISTS `daily_individual_production` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lobour_id` int(11) DEFAULT NULL,
  `van_dr_id` int(11) DEFAULT NULL,
  `unit` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `daily_production_mst_id` int(11) NOT NULL,
  `daily_load_mst_id` int(11) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:inactive',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:kacha,2:khamal,3:load',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_daily_daily_individual_production_companies` (`company_id`),
  KEY `FK_daily_daily_individual_production_emp_infos` (`created_by`),
  KEY `FK_daily_daily_individual_production_emp_infos_2` (`modified_by`),
  KEY `FK_daily_daily_individual_production_peoples` (`lobour_id`),
  KEY `FK_daily_daily_individual_production_seasons` (`season_id`),
  KEY `FK6_van_dr_id` (`van_dr_id`),
  KEY `FK_daily_individual_production_units` (`unit`),
  KEY `FK_daily_individual_production_daily_kacha_production` (`daily_production_mst_id`),
  CONSTRAINT `FK6_van_dr_id` FOREIGN KEY (`van_dr_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_daily_daily_individual_production_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_daily_daily_individual_production_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_daily_individual_production_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_daily_individual_production_peoples` FOREIGN KEY (`lobour_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_daily_daily_individual_production_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `FK_daily_individual_production_daily_kacha_production` FOREIGN KEY (`daily_production_mst_id`) REFERENCES `daily_kacha_production` (`id`),
  CONSTRAINT `FK_daily_individual_production_units` FOREIGN KEY (`unit`) REFERENCES `units` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.daily_individual_production: ~0 rows (approximately)
/*!40000 ALTER TABLE `daily_individual_production` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_individual_production` ENABLE KEYS */;

-- Dumping structure for table brick_factory.daily_kacha_production
CREATE TABLE IF NOT EXISTS `daily_kacha_production` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `party_id` int(11) NOT NULL,
  `mill_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `producted_brick_type` int(11) NOT NULL,
  `brick_mill_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:auto,2:bangla',
  `rate` double(12,2) NOT NULL,
  `production_quantity` int(11) DEFAULT NULL,
  `damage_quantity` int(11) DEFAULT NULL,
  `actual_quantity` int(11) DEFAULT NULL,
  `total_bill` double(12,2) NOT NULL DEFAULT '0.00',
  `conveyance` double(12,2) NOT NULL DEFAULT '0.00',
  `bonus` double(12,2) NOT NULL DEFAULT '0.00',
  `deduction` double(12,2) NOT NULL DEFAULT '0.00',
  `adv_deduction` double(12,2) NOT NULL DEFAULT '0.00',
  `daily_bill` double(12,2) NOT NULL DEFAULT '0.00',
  `net_pay` double(12,2) NOT NULL DEFAULT '0.00',
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:inactive',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `counted_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_daily_kacha_production_companies` (`company_id`),
  KEY `FK_daily_kacha_production_emp_infos` (`created_by`),
  KEY `FK_daily_kacha_production_emp_infos_2` (`modified_by`),
  KEY `FK_daily_kacha_production_peoples` (`party_id`),
  KEY `FK_daily_kacha_production_seasons` (`season_id`),
  KEY `FK6` (`agreement_id`),
  KEY `FK_daily_kacha_production_mills` (`mill_id`),
  CONSTRAINT `FK6` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  CONSTRAINT `FK_daily_kacha_production_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_daily_kacha_production_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_kacha_production_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_kacha_production_mills` FOREIGN KEY (`mill_id`) REFERENCES `mills` (`id`),
  CONSTRAINT `FK_daily_kacha_production_peoples` FOREIGN KEY (`party_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_daily_kacha_production_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='    [prod_qty] => 5000\r\n    [bill] => 4000\r\n    [conveyance] => 100.00\r\n    [bonus] => \r\n    [deduction] => \r\n    [deduction_by] => 1\r\n    [deduction_rate] => 10.00\r\n    [advance_payment] => 100000.00\r\n    [balance] => 0.00\r\n    [adv_deduction] => 0\r\n    [daily_bill] => 4100\r\n    [net_pay] => 4100';

-- Dumping data for table brick_factory.daily_kacha_production: ~5 rows (approximately)
/*!40000 ALTER TABLE `daily_kacha_production` DISABLE KEYS */;
INSERT INTO `daily_kacha_production` (`id`, `party_id`, `mill_id`, `agreement_id`, `date`, `producted_brick_type`, `brick_mill_type`, `rate`, `production_quantity`, `damage_quantity`, `actual_quantity`, `total_bill`, `conveyance`, `bonus`, `deduction`, `adv_deduction`, `daily_bill`, `net_pay`, `note`, `status`, `company_id`, `season_id`, `counted_by`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(42, 18, 4, 10, '2019-09-22', 9, 2, 800.00, 10000, 100, 9900, 8000.00, 100.00, 0.00, 0.00, 800.00, 8100.00, 7300.00, NULL, 1, 1, 2, '6', '1000001', '1000001', '2019-09-25 14:05:04', '2019-09-25 14:01:59'),
	(43, 20, 2, 12, '2019-09-21', 9, 2, 600.00, 10000, 100, 9900, 6000.00, 100.00, 0.00, 0.00, 0.00, 6100.00, 6100.00, NULL, 1, 1, 2, '6', '1000001', '1000001', '2019-09-25 14:04:54', '2019-09-25 14:02:58'),
	(44, 20, 3, 12, '2019-09-22', 9, 2, 600.00, 10000, 100, 9900, 6000.00, 100.00, 0.00, 0.00, 0.00, 6100.00, 6100.00, NULL, 1, 1, 2, '6', '1000001', '1000001', '2019-09-25 14:04:44', '2019-09-25 14:03:24'),
	(45, 18, 4, 15, '2019-09-23', 10, 2, 500.00, 8000, 100, 7900, 4000.00, 0.00, 0.00, 0.00, 400.00, 4000.00, 3600.00, NULL, 1, 1, 2, '6', '1000001', NULL, NULL, '2019-09-25 14:19:11'),
	(46, 20, 2, 17, '2019-09-22', 10, 2, 550.00, 19900, 100, 19800, 10945.00, 0.00, 0.00, 0.00, 0.00, 10945.00, 10945.00, NULL, 1, 1, 2, '6', '1000001', '1000001', '2019-09-25 14:22:45', '2019-09-25 14:20:29');
/*!40000 ALTER TABLE `daily_kacha_production` ENABLE KEYS */;

-- Dumping structure for table brick_factory.daily_load_production
CREATE TABLE IF NOT EXISTS `daily_load_production` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `party_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `total_bill` double(12,2) NOT NULL,
  `conveyance` double(12,2) NOT NULL,
  `bonus` double(12,2) NOT NULL,
  `deduction` double(12,2) NOT NULL,
  `adv_deduction` double(12,2) NOT NULL,
  `dumpa_charge` double(12,2) NOT NULL DEFAULT '0.00',
  `total_prod` int(11) NOT NULL DEFAULT '0',
  `daily_bill` double(12,2) NOT NULL,
  `net_pay` double(12,2) NOT NULL,
  `load_type` int(11) NOT NULL COMMENT '1: /TODO-fire, 2: Drumstack  to fire/load; 3: TODO to Drumstack, 4: khamal to TOMA',
  `no_of_dumpa` int(11) DEFAULT NULL,
  `door_id` int(11) DEFAULT NULL,
  `round_id` int(11) DEFAULT NULL,
  `to_drstack_id` int(11) DEFAULT NULL,
  `from_drstack_id` int(11) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:inactive',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `counted_by` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_daily_load_production_companies` (`company_id`),
  KEY `FK_daily_load_production_emp_infos` (`created_by`),
  KEY `FK_daily_load_production_emp_infos_2` (`modified_by`),
  KEY `FK_daily_load_production_peoples` (`party_id`),
  KEY `FK_daily_load_production_seasons` (`season_id`),
  KEY `FK_daily_load_production_agreements` (`agreement_id`),
  KEY `FK_daily_load_production_doors` (`door_id`),
  KEY `FK_daily_load_production_rounds` (`round_id`),
  KEY `FK_daily_load_production_peoples_2` (`counted_by`),
  CONSTRAINT `FK_daily_load_production_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  CONSTRAINT `FK_daily_load_production_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_daily_load_production_doors` FOREIGN KEY (`door_id`) REFERENCES `doors` (`id`),
  CONSTRAINT `FK_daily_load_production_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_load_production_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_load_production_peoples` FOREIGN KEY (`party_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_daily_load_production_peoples_2` FOREIGN KEY (`counted_by`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_daily_load_production_rounds` FOREIGN KEY (`round_id`) REFERENCES `rounds` (`id`),
  CONSTRAINT `FK_daily_load_production_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.daily_load_production: ~4 rows (approximately)
/*!40000 ALTER TABLE `daily_load_production` DISABLE KEYS */;
INSERT INTO `daily_load_production` (`id`, `party_id`, `agreement_id`, `date`, `total_bill`, `conveyance`, `bonus`, `deduction`, `adv_deduction`, `dumpa_charge`, `total_prod`, `daily_bill`, `net_pay`, `load_type`, `no_of_dumpa`, `door_id`, `round_id`, `to_drstack_id`, `from_drstack_id`, `note`, `status`, `company_id`, `season_id`, `counted_by`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(23, 21, 18, '2019-09-24', 14500.00, 0.00, 0.00, 0.00, 50.00, 0.00, 15000, 14500.00, 14450.00, 4, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', '1000001', '2019-09-25 14:45:58', '2019-09-25 14:41:57'),
	(29, 23, 19, '2019-09-24', 9750.00, 0.00, 0.00, 0.00, 50.00, 0.00, 8000, 9750.00, 9700.00, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', '1000001', '2019-09-25 15:51:55', '2019-09-25 15:49:34'),
	(34, 11, 8, '2019-09-24', 5350.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4000, 5350.00, 5350.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', '1000001', '2019-09-25 16:57:55', '2019-09-25 16:36:56'),
	(37, 24, 20, '2019-09-25', 3700.00, 0.00, 0.00, 0.00, 20.00, 0.00, 3500, 3700.00, 3680.00, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', '1000001', '2019-09-25 18:20:21', '2019-09-25 17:48:57'),
	(39, 24, 20, '2019-09-26', 110.00, 0.00, 0.00, 0.00, 20.00, 0.00, 100, 110.00, 90.00, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', NULL, '2019-09-26 05:01:59', '2019-09-26 05:01:59'),
	(40, 11, 8, '2019-09-28', 9000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000, 9000.00, 9000.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', NULL, '2019-09-28 12:16:43', '2019-09-28 12:16:43');
/*!40000 ALTER TABLE `daily_load_production` ENABLE KEYS */;

-- Dumping structure for table brick_factory.daily_load_production_details
CREATE TABLE IF NOT EXISTS `daily_load_production_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `load_prod_id` int(11) NOT NULL,
  `load_agreement_id` int(11) NOT NULL,
  `rate` double(12,2) NOT NULL,
  `brick_type` int(11) NOT NULL,
  `load_quantity` int(11) NOT NULL,
  `damage_quantity` int(11) NOT NULL,
  `actual_quantity` int(11) NOT NULL,
  `total_bill` double(12,2) NOT NULL,
  `to_drstack_id` int(11) DEFAULT NULL,
  `from_drstack_id` int(11) DEFAULT NULL,
  `round_id` int(11) DEFAULT NULL,
  `door_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.daily_load_production_details: ~13 rows (approximately)
/*!40000 ALTER TABLE `daily_load_production_details` DISABLE KEYS */;
INSERT INTO `daily_load_production_details` (`id`, `load_prod_id`, `load_agreement_id`, `rate`, `brick_type`, `load_quantity`, `damage_quantity`, `actual_quantity`, `total_bill`, `to_drstack_id`, `from_drstack_id`, `round_id`, `door_id`) VALUES
	(91, 29, 56, 1250.00, 11, 3000, 200, 2800, 3750.00, 3, NULL, NULL, NULL),
	(92, 29, 55, 1200.00, 11, 5000, 100, 4900, 6000.00, 2, NULL, NULL, NULL),
	(117, 34, 59, 1350.00, 12, 3000, 100, 2900, 4050.00, NULL, 2, 1, 1),
	(118, 34, 58, 1300.00, 11, 1000, 0, 1000, 1300.00, NULL, NULL, 1, 1),
	(144, 37, 41, 1000.00, 2, 2000, 0, 2000, 2000.00, NULL, NULL, 1, 1),
	(145, 37, 44, 50.00, 7, 2, 0, 2, 100.00, NULL, NULL, 1, 1),
	(146, 37, 42, 1050.00, 4, 1000, 100, 900, 1050.00, NULL, NULL, 1, 1),
	(147, 37, 43, 1100.00, 5, 500, 5, 495, 550.00, NULL, NULL, 1, 1),
	(150, 39, 43, 1100.00, 2, 100, 0, 100, 110.00, NULL, NULL, 1, 1),
	(151, 40, 63, 900.00, 10, 10000, 0, 10000, 9000.00, NULL, NULL, 1, 1),
	(152, 23, 49, 900.00, 10, 5000, 20, 4980, 5000.00, NULL, NULL, NULL, NULL),
	(153, 23, 50, 1000.00, 10, 5000, 30, 4970, 5000.00, NULL, NULL, NULL, NULL),
	(154, 23, 51, 1000.00, 10, 5000, 10, 4990, 4500.00, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `daily_load_production_details` ENABLE KEYS */;

-- Dumping structure for table brick_factory.daily_unload_production
CREATE TABLE IF NOT EXISTS `daily_unload_production` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `party_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `total_first_class` int(11) NOT NULL,
  `total_second_class` int(11) NOT NULL,
  `total_third_class` int(11) NOT NULL,
  `total_quantity` int(11) NOT NULL,
  `adhla_quantity` int(11) NOT NULL,
  `adhla_bill` double(12,4) NOT NULL,
  `total_bill` double(12,4) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `from_door_id` int(11) DEFAULT NULL,
  `to_door_id` int(11) DEFAULT NULL,
  `round_id` int(11) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:inactive',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_daily_unload_production_agreements` (`agreement_id`),
  KEY `FK_daily_unload_production_companies` (`company_id`),
  KEY `FK_daily_unload_production_doors` (`from_door_id`),
  KEY `FK_daily_unload_production_doorss` (`to_door_id`),
  KEY `FK_daily_unload_production_emp_infos` (`created_by`),
  KEY `FK_daily_unload_production_emp_infos_2` (`modified_by`),
  KEY `FK_daily_unload_production_peoples` (`party_id`),
  KEY `FK_daily_unload_production_rounds` (`round_id`),
  KEY `FK_daily_unload_production_seasons` (`season_id`),
  CONSTRAINT `FK_daily_unload_production_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  CONSTRAINT `FK_daily_unload_production_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_daily_unload_production_doors` FOREIGN KEY (`from_door_id`) REFERENCES `doors` (`id`),
  CONSTRAINT `FK_daily_unload_production_doorss` FOREIGN KEY (`to_door_id`) REFERENCES `doors` (`id`),
  CONSTRAINT `FK_daily_unload_production_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_unload_production_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_daily_unload_production_peoples` FOREIGN KEY (`party_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_daily_unload_production_rounds` FOREIGN KEY (`round_id`) REFERENCES `rounds` (`id`),
  CONSTRAINT `FK_daily_unload_production_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.daily_unload_production: ~0 rows (approximately)
/*!40000 ALTER TABLE `daily_unload_production` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_unload_production` ENABLE KEYS */;

-- Dumping structure for table brick_factory.deliveries
CREATE TABLE IF NOT EXISTS `deliveries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `truck_id` int(11) DEFAULT NULL,
  `truck_driver_id` int(11) DEFAULT NULL,
  `delivery_date` date NOT NULL,
  `total_quantity` int(11) NOT NULL,
  `transport_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '12:truck, 13:van, 0:Own Transport',
  `transport_bill` double(12,4) NOT NULL,
  `labour_bill` double(12,4) NOT NULL,
  `note` text,
  `delivery_by` varchar(20) DEFAULT NULL,
  `attachment` varchar(200) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_deleveries_companies` (`company_id`),
  KEY `FK_deleveries_emp_infos` (`created_by`),
  KEY `FK_deleveries_emp_infos_2` (`modified_by`),
  KEY `FK_deleveries_stock_seasons` (`season_id`),
  KEY `FK_deleveries_truck_info` (`truck_id`),
  KEY `FK_deleveries_peoples` (`truck_driver_id`),
  CONSTRAINT `FK_deleveries_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_deleveries_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_deleveries_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_deleveries_peoples` FOREIGN KEY (`truck_driver_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_deleveries_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `FK_deleveries_truck_info` FOREIGN KEY (`truck_id`) REFERENCES `trucks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.deliveries: ~3 rows (approximately)
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
INSERT INTO `deliveries` (`id`, `truck_id`, `truck_driver_id`, `delivery_date`, `total_quantity`, `transport_type`, `transport_bill`, `labour_bill`, `note`, `delivery_by`, `attachment`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(3, NULL, NULL, '2019-10-07', 200, 0, 500.0000, 500.0000, '', '6', '', 1, 2, '1000001', NULL, '2019-10-10 12:38:43', '2019-10-07 14:38:17'),
	(4, 1, 14, '2019-10-10', 100, 12, 100.0000, 50.0000, '', '6', '', 1, 2, '1000001', NULL, NULL, '2019-10-10 11:52:31'),
	(5, 1, 15, '2019-10-10', 150, 12, 100.0000, 50.0000, '', '6', '', 1, 2, '1000001', NULL, NULL, '2019-10-10 11:56:27');
/*!40000 ALTER TABLE `deliveries` ENABLE KEYS */;

-- Dumping structure for table brick_factory.delivery_items
CREATE TABLE IF NOT EXISTS `delivery_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_id` int(11) NOT NULL,
  `sale_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_delevery_items_sales` (`sale_item_id`),
  KEY `FK_delevery_items_deleveries` (`delivery_id`),
  CONSTRAINT `FK_delevery_items_deleveries` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`),
  CONSTRAINT `FK_delevery_items_sales` FOREIGN KEY (`sale_item_id`) REFERENCES `sale_items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.delivery_items: ~5 rows (approximately)
/*!40000 ALTER TABLE `delivery_items` DISABLE KEYS */;
INSERT INTO `delivery_items` (`id`, `delivery_id`, `sale_item_id`, `quantity`) VALUES
	(3, 3, 11, 200),
	(4, 4, 14, 50),
	(5, 4, 15, 50),
	(6, 5, 11, 100),
	(7, 5, 14, 50);
/*!40000 ALTER TABLE `delivery_items` ENABLE KEYS */;

-- Dumping structure for table brick_factory.doors
CREATE TABLE IF NOT EXISTS `doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `door_number` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:inactive',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:strating, 0;not Starting point , 2:ending door',
  `company_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_doors_companies` (`company_id`),
  KEY `FK_doors_emp_infos` (`created_by`),
  KEY `FK_doors_emp_infos_2` (`modified_by`),
  CONSTRAINT `FK_doors_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_doors_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_doors_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.doors: ~3 rows (approximately)
/*!40000 ALTER TABLE `doors` DISABLE KEYS */;
INSERT INTO `doors` (`id`, `door_number`, `location`, `note`, `status`, `type`, `company_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(1, 'Door-1', 'Right side of Chimni', 'Test', 1, 1, 1, '1000001', '1000001', '2019-03-12 20:30:08', '2019-03-12 20:53:51'),
	(2, 'Door-2', 'Right side of Door-1', NULL, 1, 0, 1, '1000001', '1000001', '2019-03-12 20:32:52', '2019-03-12 20:53:56'),
	(3, 'Door-3', 'Right side of Door-2', 'sdfsdf fd', 1, 0, 1, '1000001', '1000001', '2019-03-12 22:02:16', '2019-03-12 22:02:30');
/*!40000 ALTER TABLE `doors` ENABLE KEYS */;

-- Dumping structure for table brick_factory.drumstacks
CREATE TABLE IF NOT EXISTS `drumstacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(50) DEFAULT NULL,
  `location` varchar(300) DEFAULT NULL,
  `drumstack_id` int(11) DEFAULT NULL,
  `season_id` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `loaded_stock` int(11) NOT NULL DEFAULT '0',
  `unloaded_stock` int(11) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:Stock,  2:Closed,  3:used',
  `used_date` date DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_drumstacks_companies` (`company_id`),
  KEY `FK_drumstacks_emp_infos` (`created_by`),
  KEY `FK_drumstacks_emp_infos_2` (`modified_by`),
  KEY `FK_drumstacks_seasons` (`season_id`),
  CONSTRAINT `FK_drumstacks_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_drumstacks_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_drumstacks_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_drumstacks_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.drumstacks: ~3 rows (approximately)
/*!40000 ALTER TABLE `drumstacks` DISABLE KEYS */;
INSERT INTO `drumstacks` (`id`, `number`, `location`, `drumstack_id`, `season_id`, `capacity`, `loaded_stock`, `unloaded_stock`, `start_date`, `end_date`, `note`, `status`, `used_date`, `company_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(2, 'DR-0001', 'South-West', NULL, 2, 10000, 4900, 3000, '2019-09-25', NULL, NULL, 1, NULL, 1, NULL, '1000001', '2019-09-25 18:51:32', '2019-09-19 18:34:48'),
	(3, 'DR-0002', 'South East', NULL, 2, 10000, 2800, 0, NULL, NULL, NULL, 2, NULL, 1, '1000001', NULL, '2019-09-25 18:57:06', '2019-09-20 00:17:50'),
	(4, 'DR-0003', 'South East', NULL, 2, 10000, 0, 0, NULL, NULL, NULL, 3, NULL, 1, '1000001', '1000001', '2019-09-25 18:57:07', '2019-09-20 00:20:54');
/*!40000 ALTER TABLE `drumstacks` ENABLE KEYS */;

-- Dumping structure for table brick_factory.emp_increment
CREATE TABLE IF NOT EXISTS `emp_increment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_id` varchar(20) NOT NULL,
  `old_deg` int(11) NOT NULL COMMENT 'old designation',
  `new_deg` int(11) NOT NULL COMMENT 'new designation',
  `inr_year` int(11) NOT NULL,
  `inr_date` date NOT NULL COMMENT 'increment effective form',
  `old_salary` double NOT NULL,
  `new_salary` double NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `modified_by` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UN1_emp_increment` (`new_salary`,`emp_id`),
  KEY `FK1_emp_increment` (`emp_id`),
  KEY `FK2_emp_increment` (`created_by`),
  KEY `FK3_emp_increment` (`old_deg`),
  KEY `FK4_emp_increment` (`new_deg`),
  KEY `FK5_modified_by` (`modified_by`),
  CONSTRAINT `FK1_emp_increment` FOREIGN KEY (`emp_id`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK2_emp_increment` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK3_emp_increment` FOREIGN KEY (`old_deg`) REFERENCES `hrm_designations` (`id`),
  CONSTRAINT `FK4_emp_increment` FOREIGN KEY (`new_deg`) REFERENCES `hrm_designations` (`id`),
  CONSTRAINT `FK5_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.emp_increment: ~0 rows (approximately)
/*!40000 ALTER TABLE `emp_increment` DISABLE KEYS */;
/*!40000 ALTER TABLE `emp_increment` ENABLE KEYS */;

-- Dumping structure for table brick_factory.emp_infos
CREATE TABLE IF NOT EXISTS `emp_infos` (
  `emp_id` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `designation_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `emp_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 = Permanent, 2 = Probetion',
  `is_salary` tinyint(1) unsigned zerofill NOT NULL DEFAULT '1' COMMENT '1 = will get salary, 2 = no',
  `is_bonus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 = will get bonus, 2 = no',
  `address` text NOT NULL,
  `age` varchar(100) NOT NULL,
  `nid_no` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `blood_group` varchar(50) DEFAULT NULL,
  `salary` double(10,2) NOT NULL DEFAULT '0.00',
  `mobile_bill` double(10,2) NOT NULL DEFAULT '0.00',
  `conveyence` double(10,2) NOT NULL DEFAULT '0.00',
  `ta_da` double(10,2) NOT NULL DEFAULT '0.00',
  `bonus` double(10,2) NOT NULL DEFAULT '0.00',
  `special_allowance` double(10,2) NOT NULL DEFAULT '0.00',
  `deduction` double(10,2) NOT NULL DEFAULT '0.00',
  `remarks` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  0: inactive',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`emp_id`),
  KEY `FK1_created_by` (`created_by`),
  KEY `FK2_updated_by` (`modified_by`),
  KEY `FK_emp_infos_hrm_departments` (`department_id`),
  CONSTRAINT `FK1_created_by` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK2_updated_by` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.emp_infos: ~3 rows (approximately)
/*!40000 ALTER TABLE `emp_infos` DISABLE KEYS */;
INSERT INTO `emp_infos` (`emp_id`, `full_name`, `designation_id`, `department_id`, `company_id`, `emp_type`, `is_salary`, `is_bonus`, `address`, `age`, `nid_no`, `photo`, `contact_no`, `email`, `blood_group`, `salary`, `mobile_bill`, `conveyence`, `ta_da`, `bonus`, `special_allowance`, `deduction`, `remarks`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
	('1000001', 'Momit', 10, 1, 1, 1, 1, 1, 'dhora, maria, gabtoli bogura', '32', '34543543741', 'images/employee/20170915_155851.jpg', '01980340482', 'momit.litu@gmail.com', 'B+', 150000.00, 1500.00, 2000.00, 0.00, 80000.00, 1000.00, 0.00, '', 1, NULL, '1000001', '2018-08-07 15:39:13', '2019-01-21 22:30:13'),
	('1000002', 'Munif Hasann', 2, 1, 1, 1, 1, 1, '', '', '2347243243', '', '0354378441', 'fg dfg@dfg.dfg', '', 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 1, '1000001', '1000001', '2019-03-20 20:40:19', '2019-03-20 23:26:33'),
	('EMP-000003', 'Litu Hasan', 5, 1, 1, 1, 1, 1, '', '25', '45645644654', '', '01980340482', 'fcgfcb@fjhf.dfg', '', 30000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 1, '1000001', NULL, '2019-03-20 23:33:11', NULL);
/*!40000 ALTER TABLE `emp_infos` ENABLE KEYS */;

-- Dumping structure for table brick_factory.expenses
CREATE TABLE IF NOT EXISTS `expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_reference_no` varchar(50) NOT NULL,
  `expense_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expense_amount` double(12,4) NOT NULL,
  `expense_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:cash, 2:credit',
  `description` text,
  `paid_amount` double(12,4) NOT NULL DEFAULT '0.0000',
  `balance` double(12,4) NOT NULL DEFAULT '0.0000',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,0: Deleted',
  `payment_status` tinyint(1) DEFAULT '1' COMMENT '1:due, 2:partialy paid,3:paid',
  `resposible_person_id` int(11) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `attachment` varchar(200) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_expenses_companies` (`company_id`),
  KEY `FK_expenses_emp_infos` (`created_by`),
  KEY `FK_expenses_emp_infos_2` (`modified_by`),
  KEY `FK5_respo` (`resposible_person_id`),
  KEY `FK_expenses_seasons` (`season_id`),
  CONSTRAINT `FK5_respo` FOREIGN KEY (`resposible_person_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_expenses_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_expenses_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_expenses_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_expenses_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.expenses: ~0 rows (approximately)
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
INSERT INTO `expenses` (`id`, `expense_reference_no`, `expense_date`, `expense_amount`, `expense_type`, `description`, `paid_amount`, `balance`, `status`, `payment_status`, `resposible_person_id`, `company_id`, `season_id`, `attachment`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(8, 'EXP2019/04/000001', '2019-04-07 00:00:00', 600.0000, 1, '', 0.0000, 600.0000, 1, 1, 6, 1, 2, '', '1000001', '1000001', '2019-04-08 16:46:46', '2019-04-07 17:36:15'),
	(9, 'EXP2019/10/000001', '2019-10-14 00:00:00', 10000.0000, 1, '', 0.0000, 10000.0000, 1, 1, 6, 1, 2, '', '1000001', NULL, NULL, '2019-10-14 17:36:17');
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;

-- Dumping structure for table brick_factory.expense_categories
CREATE TABLE IF NOT EXISTS `expense_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_cat_name` varchar(200) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active,0:inactive',
  PRIMARY KEY (`id`),
  KEY `FK_expense_categories_expense_categories` (`parent_id`),
  CONSTRAINT `FK_expense_categories_expense_categories` FOREIGN KEY (`parent_id`) REFERENCES `expense_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.expense_categories: ~8 rows (approximately)
/*!40000 ALTER TABLE `expense_categories` DISABLE KEYS */;
INSERT INTO `expense_categories` (`id`, `expense_cat_name`, `parent_id`, `status`) VALUES
	(1, 'Bills', NULL, 1),
	(2, 'Electric  Bills', 1, 1),
	(3, 'Gas Bills', 1, 1),
	(4, 'Palli Electric Bills', 2, 1),
	(5, 'PDB Electric Bills', 2, 1),
	(6, 'gg', 2, 1),
	(7, 'Govt Fees', NULL, 1),
	(8, 'Tax', 7, 1);
/*!40000 ALTER TABLE `expense_categories` ENABLE KEYS */;

-- Dumping structure for table brick_factory.expense_details
CREATE TABLE IF NOT EXISTS `expense_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_id` int(11) NOT NULL,
  `expense_head_id` int(11) NOT NULL,
  `amount` varchar(200) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `FK_expense_details_expenses` (`expense_id`),
  KEY `FK_expense_details_expense_heads` (`expense_head_id`),
  CONSTRAINT `FK_expense_details_expense_heads` FOREIGN KEY (`expense_head_id`) REFERENCES `expense_heads` (`id`),
  CONSTRAINT `FK_expense_details_expenses` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.expense_details: ~2 rows (approximately)
/*!40000 ALTER TABLE `expense_details` DISABLE KEYS */;
INSERT INTO `expense_details` (`id`, `expense_id`, `expense_head_id`, `amount`, `description`) VALUES
	(8, 8, 1, '100.00', 'hdgfg'),
	(9, 8, 2, '500.00', 'jkhjkhgkjhkkjk'),
	(10, 9, 4, '10000.00', '');
/*!40000 ALTER TABLE `expense_details` ENABLE KEYS */;

-- Dumping structure for table brick_factory.expense_heads
CREATE TABLE IF NOT EXISTS `expense_heads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_category_id` int(11) NOT NULL,
  `expense_head_name` varchar(200) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:inactive',
  PRIMARY KEY (`id`),
  KEY `FK_expense_heads_expense_categories` (`expense_category_id`),
  CONSTRAINT `FK_expense_heads_expense_categories` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.expense_heads: ~4 rows (approximately)
/*!40000 ALTER TABLE `expense_heads` DISABLE KEYS */;
INSERT INTO `expense_heads` (`id`, `expense_category_id`, `expense_head_name`, `note`, `status`) VALUES
	(1, 5, 'Mollabrick PDB electric billl', 'sdfg sfsfsd fsdfsdfdzfdsa fdasfasd', 1),
	(2, 4, 'Mollabrick Palli  electric billl', 'sdfg sfsfsd fsdfsdfdzfdsa fdasfasd', 1),
	(3, 8, 'Yearly Tax', NULL, 1),
	(4, 8, 'Income tax', NULL, 1);
/*!40000 ALTER TABLE `expense_heads` ENABLE KEYS */;

-- Dumping structure for table brick_factory.hrm_departments
CREATE TABLE IF NOT EXISTS `hrm_departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(50) NOT NULL,
  `dept_head` varchar(20) DEFAULT NULL,
  `display` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 show, 1 hide',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `con_department_uk` (`department_name`),
  KEY `con_dept_head_fk` (`dept_head`),
  KEY `FK2_created_by` (`created_by`),
  KEY `FK3_modified_by` (`modified_by`),
  CONSTRAINT `FK2_created_by` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK3_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `con_dept_head_fk` FOREIGN KEY (`dept_head`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.hrm_departments: ~3 rows (approximately)
/*!40000 ALTER TABLE `hrm_departments` DISABLE KEYS */;
INSERT INTO `hrm_departments` (`department_id`, `department_name`, `dept_head`, `display`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
	(1, 'Admin', '1000001', 0, NULL, '1000001', '2018-08-07 15:45:54', '2018-08-07 17:16:03'),
	(2, 'Accounts', '1000001', 0, NULL, NULL, '2018-08-07 15:46:16', NULL),
	(3, 'Marketing', NULL, 0, NULL, NULL, '2018-08-07 16:54:07', NULL);
/*!40000 ALTER TABLE `hrm_departments` ENABLE KEYS */;

-- Dumping structure for table brick_factory.hrm_designations
CREATE TABLE IF NOT EXISTS `hrm_designations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `designation_title` varchar(50) NOT NULL,
  `short_name` varchar(50) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `designation_title` (`designation_title`),
  KEY `FK1_createtd` (`created_by`),
  KEY `FK2_modified` (`modified_by`),
  CONSTRAINT `FK1_createtd` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK2_modified` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.hrm_designations: ~12 rows (approximately)
/*!40000 ALTER TABLE `hrm_designations` DISABLE KEYS */;
INSERT INTO `hrm_designations` (`id`, `designation_title`, `short_name`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(1, 'Executive', 'EX', NULL, '1000001', '2018-08-29 12:49:23', '2018-08-07 15:47:01'),
	(2, 'Jr. Officer', 'JO', NULL, NULL, NULL, '2018-08-07 15:46:58'),
	(3, 'Sr. Officer', 'SO', NULL, '1000001', '2018-08-07 17:11:59', '2018-08-07 15:47:22'),
	(4, 'HR & Admin', 'HR', '1000001', '1000001', '2018-08-07 17:12:54', '2018-08-07 17:12:42'),
	(5, 'Manager', 'Restaurant Manager', '1000001', '1000001', '2018-08-29 09:57:51', '2018-08-29 08:55:13'),
	(6, 'Cashier', 'Restaurant Cashier', '1000001', NULL, NULL, '2018-08-29 10:00:38'),
	(9, 'Chairman', '     Chairman', '1000001', NULL, NULL, '2018-08-29 20:17:56'),
	(10, 'Managing Director', 'Managing Director', '1000001', NULL, NULL, '2018-08-29 20:18:12'),
	(12, 'Store in-charge', 'Store in-charge', '1000001', NULL, NULL, '2018-08-29 20:18:49'),
	(13, 'Sales Officer', 'Sales Officer', '1000001', '1000001', '2018-08-29 20:21:29', '2018-08-29 20:20:24'),
	(14, 'Security Guard', 'Security Guard', '1000001', NULL, NULL, '2018-08-29 20:21:38'),
	(15, 'Labor', 'Labor', '1000001', NULL, NULL, '2018-08-29 20:21:49');
/*!40000 ALTER TABLE `hrm_designations` ENABLE KEYS */;

-- Dumping structure for table brick_factory.hrm_leaves
CREATE TABLE IF NOT EXISTS `hrm_leaves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(20) NOT NULL,
  `application_date` date NOT NULL,
  `leave_category` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `res_person_on_leave` varchar(20) DEFAULT NULL COMMENT 'responsible person during leave',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `no_of_days` int(4) NOT NULL,
  `leave_reason` varchar(250) NOT NULL,
  `address_on_leave` varchar(250) NOT NULL,
  `application_status` varchar(15) DEFAULT 'Pending' COMMENT 'Pending,Checked,Approved,Canceled',
  `recommended_by` varchar(20) DEFAULT NULL,
  `approve_by` varchar(20) DEFAULT NULL,
  `remarks` text,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UN1_hrm_leaves` (`employee_id`,`end_date`,`start_date`),
  KEY `FK_hrm_leaves_companies` (`company_id`),
  KEY `FK_hrm_leaves_emp_infos_2` (`approve_by`),
  KEY `FK_hrm_leaves_emp_infos_3` (`created_by`),
  KEY `FK_hrm_leaves_emp_infos_4` (`modified_by`),
  CONSTRAINT `FK_hrm_leaves_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_hrm_leaves_emp_infos` FOREIGN KEY (`employee_id`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_hrm_leaves_emp_infos_2` FOREIGN KEY (`approve_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_hrm_leaves_emp_infos_3` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_hrm_leaves_emp_infos_4` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.hrm_leaves: ~0 rows (approximately)
/*!40000 ALTER TABLE `hrm_leaves` DISABLE KEYS */;
/*!40000 ALTER TABLE `hrm_leaves` ENABLE KEYS */;

-- Dumping structure for table brick_factory.hrm_leave_categories
CREATE TABLE IF NOT EXISTS `hrm_leave_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(20) NOT NULL,
  `day_allow` mediumint(9) NOT NULL,
  `description` text,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `con_leave_category_name_uk` (`category_name`),
  KEY `FK1_leave_categories` (`created_by`),
  KEY `FK_hrm_leave_categories_emp_infos` (`modified_by`),
  CONSTRAINT `FK1_leave_categories` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_hrm_leave_categories_emp_infos` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.hrm_leave_categories: ~3 rows (approximately)
/*!40000 ALTER TABLE `hrm_leave_categories` DISABLE KEYS */;
INSERT INTO `hrm_leave_categories` (`id`, `category_name`, `day_allow`, `description`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
	(1, 'Casual Leave', 20, '', '1000001', NULL, '2018-08-29 17:21:44', NULL),
	(3, 'Special Leave', 10, '', '1000001', NULL, '2018-08-11 11:12:35', NULL),
	(5, 'Medical Leave', 15, '', '1000001', NULL, '2018-08-11 11:07:10', NULL);
/*!40000 ALTER TABLE `hrm_leave_categories` ENABLE KEYS */;

-- Dumping structure for table brick_factory.items
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `item_name` varchar(200) DEFAULT NULL,
  `brand_name` varchar(200) DEFAULT NULL,
  `price` double(12,4) DEFAULT NULL,
  `description` text,
  `is_asset` tinyint(1) DEFAULT '0' COMMENT '0:not asset, 1:asset',
  `lasting_years` tinyint(1) DEFAULT NULL,
  `salvage_value` double(12,4) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2: in-active',
  `company_id` int(11) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_damage_items_companies` (`company_id`),
  KEY `FK_damage_items_emp_infos` (`created_by`),
  KEY `FK_damage_items_emp_infos_2` (`modified_by`),
  KEY `FK_items_item_categories` (`category_id`),
  CONSTRAINT `FK_damage_items_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_damage_items_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_damage_items_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_items_item_categories` FOREIGN KEY (`category_id`) REFERENCES `item_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.items: ~3 rows (approximately)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`id`, `category_id`, `item_name`, `brand_name`, `price`, `description`, `is_asset`, `lasting_years`, `salvage_value`, `status`, `company_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(2, 2, 'Auto Mill Belt', NULL, 0.0000, 'sdff,sad fnsa lsdfsdf', 0, 0, 0.0000, 1, NULL, '1000001', NULL, NULL, '2019-03-17 12:33:39'),
	(3, 1, 'Auto Mill', 'JKN', 120000.0000, 'fsdgdfg dfgdfgdfgdfgdfg', 1, 5, 10000.0000, 1, 1, '1000001', '1000001', '2019-03-17 13:36:06', '2019-03-17 13:35:15'),
	(4, 2, 'Engine Valve', NULL, 500.0000, NULL, 0, 0, 0.0000, 1, NULL, '1000001', NULL, NULL, '2019-03-26 13:29:50');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table brick_factory.item_categories
CREATE TABLE IF NOT EXISTS `item_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_cat_name` varchar(200) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1:active, 2 :in-active',
  PRIMARY KEY (`id`),
  KEY `FK_item_categories_item_categories` (`parent_id`),
  CONSTRAINT `FK_item_categories_item_categories` FOREIGN KEY (`parent_id`) REFERENCES `item_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.item_categories: ~2 rows (approximately)
/*!40000 ALTER TABLE `item_categories` DISABLE KEYS */;
INSERT INTO `item_categories` (`id`, `item_cat_name`, `parent_id`, `status`) VALUES
	(1, 'Machinaries', NULL, 1),
	(2, 'Auto Mill Machinaries', 1, 1);
/*!40000 ALTER TABLE `item_categories` ENABLE KEYS */;

-- Dumping structure for table brick_factory.land_ex_bill
CREATE TABLE IF NOT EXISTS `land_ex_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DATE` date DEFAULT NULL,
  `driver_id` int(11) NOT NULL DEFAULT '0',
  `agreements_id` int(11) NOT NULL,
  `land_ex_id` int(11) NOT NULL,
  `total_hour` double(12,2) NOT NULL DEFAULT '0.00',
  `total_bill` double(12,2) NOT NULL,
  `daily_conv` double(12,2) NOT NULL,
  `deduction` double(12,2) NOT NULL,
  `net_pay` double(12,2) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:inactive',
  `billed_by` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_land_ex_companies` (`company_id`),
  KEY `FK_land_ex_emp_infos` (`created_by`),
  KEY `FK_land_ex_emp_infos_2` (`modified_by`),
  KEY `FK_land_ex_seasons` (`season_id`),
  KEY `FK_land_ex_agreements` (`agreements_id`),
  KEY `FK_land_ex_peoples` (`land_ex_id`),
  CONSTRAINT `FK_land_ex_agreements` FOREIGN KEY (`agreements_id`) REFERENCES `agreements` (`id`),
  CONSTRAINT `FK_land_ex_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_land_ex_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_land_ex_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_land_ex_peoples` FOREIGN KEY (`land_ex_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_land_ex_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.land_ex_bill: ~0 rows (approximately)
/*!40000 ALTER TABLE `land_ex_bill` DISABLE KEYS */;
INSERT INTO `land_ex_bill` (`id`, `DATE`, `driver_id`, `agreements_id`, `land_ex_id`, `total_hour`, `total_bill`, `daily_conv`, `deduction`, `net_pay`, `note`, `status`, `billed_by`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(1, '2019-08-04', 17, 3, 9, 4.00, 4800.00, 100.00, 400.00, 4400.00, 'This is a test entry', 1, 6, 1, 2, '1000001', '1000001', '2019-08-04 22:27:27', '2019-08-04 19:51:33');
/*!40000 ALTER TABLE `land_ex_bill` ENABLE KEYS */;

-- Dumping structure for table brick_factory.load_agreements
CREATE TABLE IF NOT EXISTS `load_agreements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agreement_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `unit_qty` int(11) NOT NULL,
  `rate` double(12,4) DEFAULT NULL,
  `daily_conveynce` double(12,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_load_agreements_agreements` (`agreement_id`),
  KEY `FK_load_agreements_load_agreements` (`location_id`),
  CONSTRAINT `FK_load_agreements_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  CONSTRAINT `FK_load_agreements_load_agreements` FOREIGN KEY (`location_id`) REFERENCES `load_locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.load_agreements: ~16 rows (approximately)
/*!40000 ALTER TABLE `load_agreements` DISABLE KEYS */;
INSERT INTO `load_agreements` (`id`, `agreement_id`, `location_id`, `unit_id`, `unit_qty`, `rate`, `daily_conveynce`) VALUES
	(41, 20, 7, 7, 1, 1000.0000, 0.0000),
	(42, 20, 8, 7, 1, 1050.0000, 0.0000),
	(43, 20, 9, 7, 1, 1100.0000, 0.0000),
	(44, 20, 21, 9, 1, 50.0000, 0.0000),
	(49, 18, 12, 7, 1, 900.0000, 0.0000),
	(50, 18, 13, 7, 1, 1000.0000, 0.0000),
	(51, 18, 14, 7, 1, 1000.0000, 0.0000),
	(52, 18, 15, 7, 1, 900.0000, 0.0000),
	(53, 18, 16, 7, 1, 1050.0000, 0.0000),
	(54, 18, 18, 7, 1, 1150.0000, 0.0000),
	(55, 19, 3, 7, 1, 1200.0000, 0.0000),
	(56, 19, 4, 7, 1, 1250.0000, 0.0000),
	(60, 8, 3, 7, 1, 1200.0000, 0.0000),
	(61, 8, 20, 7, 1, 1300.0000, 0.0000),
	(62, 8, 6, 7, 1, 1350.0000, 0.0000),
	(63, 8, 22, 7, 1, 900.0000, 0.0000);
/*!40000 ALTER TABLE `load_agreements` ENABLE KEYS */;

-- Dumping structure for table brick_factory.load_locations
CREATE TABLE IF NOT EXISTS `load_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_to_to_location_name` varchar(300) DEFAULT NULL,
  `drumstack_id` int(11) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:inactive',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_load_locations_companies` (`company_id`),
  KEY `FK_load_locations_emp_infos` (`created_by`),
  KEY `FK_load_locations_emp_infos_2` (`modified_by`),
  KEY `FK_load_locations_seasons` (`season_id`),
  CONSTRAINT `FK_load_locations_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_load_locations_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_load_locations_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_load_locations_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.load_locations: ~18 rows (approximately)
/*!40000 ALTER TABLE `load_locations` DISABLE KEYS */;
INSERT INTO `load_locations` (`id`, `from_to_to_location_name`, `drumstack_id`, `note`, `status`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(2, 'Bangla mill1 to center khamal', NULL, NULL, 1, 1, 2, '1000001', NULL, '2019-04-24 22:57:35', '2019-04-19 00:08:55'),
	(3, 'Bangla mill1 to Drumstack 1', NULL, NULL, 1, 1, 2, '1000001', NULL, '2019-04-24 22:57:37', '2019-04-19 00:08:55'),
	(4, 'Bangla mill1 to Drumstack 2', NULL, NULL, 1, 1, 2, '1000001', NULL, '2019-04-24 22:57:39', '2019-04-19 00:08:55'),
	(5, 'Drumstack 2 to load', 3, NULL, 1, 1, 2, '1000001', '1000001', '2019-09-20 23:27:02', '2019-04-19 00:08:55'),
	(6, 'Drumstack 1 to load', 2, NULL, 1, 1, 2, '1000001', '1000001', '2019-09-20 20:00:57', '2019-04-19 00:08:55'),
	(7, 'unload 1st door', NULL, NULL, 1, 1, 2, '1000001', '1000001', '2019-09-22 18:48:05', '2019-04-19 00:08:55'),
	(8, 'unload after 1 door right', NULL, NULL, 1, 1, 2, '1000001', '1000001', '2019-09-22 18:48:18', '2019-04-19 00:08:55'),
	(9, 'unload after 1 door left', NULL, NULL, 1, 1, 2, '1000001', NULL, '2019-04-24 22:57:51', '2019-04-19 00:08:55'),
	(11, 'Unload to West side of the kill', NULL, 'df ghdf gdfgfd fdg dfgfdg  fdg dffdfhgp;iuo', 0, 1, 2, '1000001', '1000001', '2019-04-24 23:04:35', '2019-04-24 22:55:33'),
	(12, 'East Auto Mill to East TOMA', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 23:45:40'),
	(13, 'East Auto Mill to West TOMA', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 23:45:56'),
	(14, 'West Auto Mill to East TOMA', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 23:46:25'),
	(15, 'West Auto Mill to West TOMA', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 23:46:38'),
	(16, 'South Paka to East Toma', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-17 00:24:51'),
	(17, 'South Paka to WestToma', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-17 00:25:04'),
	(18, 'North Paka to East Toma', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-17 00:25:26'),
	(19, 'North Paka to West Toma', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-17 00:25:43'),
	(20, 'East TOMA to Load', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-20 23:26:43'),
	(21, 'kill to adhla place', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-23 14:57:19'),
	(22, 'East Khamal to load', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-28 12:15:18');
/*!40000 ALTER TABLE `load_locations` ENABLE KEYS */;

-- Dumping structure for table brick_factory.mills
CREATE TABLE IF NOT EXISTS `mills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mill_name` varchar(100) DEFAULT NULL,
  `capacity` varchar(200) DEFAULT NULL,
  `current_shardar` int(11) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `type` tinyint(1) DEFAULT '1' COMMENT '1:auto, 2:bangla',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:in-active',
  `note` text,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_seasons_companies` (`company_id`),
  KEY `FK_seasons_emp_infos` (`created_by`),
  KEY `FK_seasons_emp_infos_2` (`modified_by`),
  KEY `FK_mills_peoples` (`current_shardar`),
  CONSTRAINT `FK_mills_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_mills_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_mills_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_mills_peoples` FOREIGN KEY (`current_shardar`) REFERENCES `peoples` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.mills: ~3 rows (approximately)
/*!40000 ALTER TABLE `mills` DISABLE KEYS */;
INSERT INTO `mills` (`id`, `mill_name`, `capacity`, `current_shardar`, `company_id`, `type`, `status`, `note`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(2, 'East Auto Mill', '20000', NULL, 1, 1, 1, 'Test', '1000001', '1000001', '2019-03-11 23:35:05', '2019-03-11 23:35:05'),
	(3, 'West Auto Mill', '25000', NULL, 1, 1, 1, NULL, '1000001', NULL, '2019-03-12 18:50:16', '2019-03-12 18:50:16'),
	(4, 'Bangla Mill 1', '20000', NULL, 1, 2, 1, NULL, '1000001', '1000001', '2019-03-12 19:14:03', '2019-03-12 19:14:03');
/*!40000 ALTER TABLE `mills` ENABLE KEYS */;

-- Dumping structure for table brick_factory.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sale_id` int(11) DEFAULT NULL,
  `return_id` int(11) unsigned DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `expence_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `reference_no` varchar(50) NOT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `paid_by` varchar(200) DEFAULT 'cash',
  `account_head_id` int(11) DEFAULT '1',
  `account_head_name` varchar(100) DEFAULT 'Cash',
  `pmbank_name` varchar(200) NOT NULL,
  `pmbank_number` varchar(200) NOT NULL,
  `pmbank_ref_number` varchar(200) NOT NULL,
  `pbank_name` varchar(200) NOT NULL,
  `pbank_acc_no` varchar(200) NOT NULL,
  `cheque_no` varchar(20) DEFAULT NULL,
  `amount` decimal(25,4) NOT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `note` varchar(1000) DEFAULT NULL COMMENT '"Opening Balance" only for opening balance',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table brick_factory.payments: ~0 rows (approximately)
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;

-- Dumping structure for table brick_factory.pay_salary_sheet_details
CREATE TABLE IF NOT EXISTS `pay_salary_sheet_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `salary_sheet_id` bigint(20) NOT NULL,
  `emp_id` varchar(20) NOT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `emp_working_day` int(11) DEFAULT NULL COMMENT 'Employee Working Day',
  `salary` double(10,2) NOT NULL DEFAULT '0.00',
  `overtime` double(10,2) NOT NULL DEFAULT '0.00',
  `mobile_bill` double(10,2) NOT NULL DEFAULT '0.00',
  `conveyence` double(10,2) NOT NULL DEFAULT '0.00',
  `ta_da` double(10,2) NOT NULL DEFAULT '0.00',
  `bonus` double(10,2) NOT NULL DEFAULT '0.00',
  `special_allowance` double(10,2) NOT NULL DEFAULT '0.00',
  `deduction` double(10,2) NOT NULL DEFAULT '0.00',
  `advance` double(10,2) NOT NULL DEFAULT '0.00',
  `emp_leave` int(11) NOT NULL DEFAULT '0',
  `absent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_pay_salary_sheet_details_pay_salary_sheet_main` (`salary_sheet_id`),
  KEY `FK_pay_salary_sheet_details_emp_infos` (`emp_id`),
  KEY `FK_pay_salary_sheet_details_hrm_departments` (`dept_id`),
  KEY `FK_pay_salary_sheet_details_companies` (`company_id`),
  CONSTRAINT `FK_pay_salary_sheet_details_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_pay_salary_sheet_details_emp_infos` FOREIGN KEY (`emp_id`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_pay_salary_sheet_details_hrm_departments` FOREIGN KEY (`dept_id`) REFERENCES `hrm_departments` (`department_id`),
  CONSTRAINT `FK_pay_salary_sheet_details_pay_salary_sheet_main` FOREIGN KEY (`salary_sheet_id`) REFERENCES `pay_salary_sheet_main` (`SALARY_SHEET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.pay_salary_sheet_details: ~0 rows (approximately)
/*!40000 ALTER TABLE `pay_salary_sheet_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_salary_sheet_details` ENABLE KEYS */;

-- Dumping structure for table brick_factory.pay_salary_sheet_main
CREATE TABLE IF NOT EXISTS `pay_salary_sheet_main` (
  `SALARY_SHEET_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SALARY_YEAR` int(11) NOT NULL,
  `SALARY_MONTH` int(11) NOT NULL,
  `PREPARED_BY` varchar(20) DEFAULT NULL,
  `PREPARED_DATE` date NOT NULL,
  `remarks` text,
  `company_id` int(11) NOT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:Pending, 2:Paid',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SALARY_SHEET_ID`),
  UNIQUE KEY `CON_SALARY_SHEET_MAIN_UK` (`SALARY_YEAR`,`SALARY_MONTH`),
  KEY `FK_pay_salary_sheet_main_emp_infos` (`created_by`),
  KEY `FK_pay_salary_sheet_main_emp_infos_2` (`modified_by`),
  KEY `FK_pay_salary_sheet_main_emp_infos_3` (`PREPARED_BY`),
  KEY `FK_pay_salary_sheet_main_companies` (`company_id`),
  CONSTRAINT `FK_pay_salary_sheet_main_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_pay_salary_sheet_main_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_pay_salary_sheet_main_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_pay_salary_sheet_main_emp_infos_3` FOREIGN KEY (`PREPARED_BY`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.pay_salary_sheet_main: ~0 rows (approximately)
/*!40000 ALTER TABLE `pay_salary_sheet_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_salary_sheet_main` ENABLE KEYS */;

-- Dumping structure for table brick_factory.peoples
CREATE TABLE IF NOT EXISTS `peoples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_number` varchar(20) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `address` text,
  `mobile_no` varchar(11) NOT NULL,
  `alt_mobile_no` varchar(11) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:in-active',
  `team_leader` tinyint(1) DEFAULT '0' COMMENT '0:no, 1:team leader',
  `team_name` int(11) DEFAULT NULL,
  `team_member_no` int(11) DEFAULT NULL,
  `lex_capacity` varchar(50) DEFAULT NULL,
  `truck_capacity` varchar(50) DEFAULT NULL,
  `note` text,
  `photo` varchar(200) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_number` (`id_number`),
  KEY `FK_people_emp_infos` (`created_by`),
  KEY `FK_people_emp_infos_2` (`modified_by`),
  KEY `FK_peoples_people_type` (`type`),
  KEY `FK_peoples_peoples` (`team_name`),
  CONSTRAINT `FK_people_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_people_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_peoples_people_type` FOREIGN KEY (`type`) REFERENCES `people_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.peoples: ~20 rows (approximately)
/*!40000 ALTER TABLE `peoples` DISABLE KEYS */;
INSERT INTO `peoples` (`id`, `id_number`, `name`, `address`, `mobile_no`, `alt_mobile_no`, `email`, `type`, `status`, `team_leader`, `team_name`, `team_member_no`, `lex_capacity`, `truck_capacity`, `note`, `photo`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(2, 'EMP-000001', 'dfg gdfg', 'dfgdfg', '2147483647', NULL, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-03-06 21:04:02', '2019-03-06 21:36:08'),
	(4, 'SOL-000001', 'Soil Brocker', '', '4564654564', '456544546', 'sdfsdf@fghfg.fghg', 3, 1, 0, 0, 10, NULL, NULL, 'hf hghfhgh', '', '1000001', '1000001', '2019-03-11 16:01:26', '2019-03-11 16:04:09'),
	(5, 'LND-000001', 'Land owner1', '', '35355454', '', '', 2, 1, 0, 0, 0, NULL, NULL, '', NULL, '1000001', '1000001', '2019-03-11 16:24:57', '2019-03-11 16:30:13'),
	(6, 'EMP-000002', 'Munif Hasan', '', '0354378441', NULL, 'fg dfg@dfg.dfg', 1, 1, 0, NULL, NULL, NULL, NULL, '', '', '1000001', NULL, '2019-03-20 20:43:20', '2019-03-20 20:40:19'),
	(7, 'EMP-000003', 'Litu Hasan', '', '01980340482', NULL, 'fcgfcb@fjhf.dfg', 1, 1, 0, NULL, NULL, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-03-20 23:33:11'),
	(8, 'SUP-000001', 'Mamun', '', '35435454', '', '', 9, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-03-23 23:49:45'),
	(9, 'LEX-000001', 'Land Excavetor', '', '45654445646', '', '', 4, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-04-17 16:45:41'),
	(11, 'LOD-000001', 'Load team1', '', '0154545556', '', '', 6, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', '1000001', '2019-09-20 23:24:57', '2019-04-20 12:50:57'),
	(12, 'ULD-000001', 'Unload Momit', '', '53454544554', '', '', 8, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-04-20 12:51:10'),
	(13, 'SOL-000002', 'Soil brocker 2', '', '456546', '', '', 3, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-04-26 11:27:28'),
	(14, 'TDV-000001', 'Truck Driver 1', '', '0454555', '', '', 12, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-07-10 11:35:26'),
	(15, 'TDV-000002', 'Truck Driver 2', '', '5644545', '', '', 12, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-07-10 11:35:59'),
	(16, 'TDV-000003', 'Truck Driver 3', '', '6547654645', '', '', 12, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-07-10 11:36:20'),
	(17, 'TDV-000004', 'Ex-Driver', '', 'dfgfdg', '', '', 12, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, '2019-08-04 11:53:30', '2019-08-04 11:27:20'),
	(18, 'KBR-000001', 'Kacha Sardar', '', '0255555655', '', '', 5, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-08-05 22:04:35'),
	(19, 'KBR-000002', 'Kacha Sardar 2', '', '64564564565', '', '', 5, 1, 1, 0, 12, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-08-05 22:05:41'),
	(20, 'KBR-000003', 'Kacha Team Auto', '', '45645646', '', '', 5, 1, 1, 0, 15, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-08-05 22:06:18'),
	(21, 'LOD-000002', 'Toma team 1', '', '5464848', '', '', 6, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-16 23:40:56'),
	(22, 'LOD-000003', 'Toma team 2', '', '4564655', '', '', 6, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-16 23:41:19'),
	(23, 'LOD-000004', 'Drumstack team1', '', '56456456', '', '', 6, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-19 17:55:12'),
	(24, 'LOD-000005', 'Unload team1', '', '6546415', '', '', 6, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-22 18:47:24'),
	(25, 'CST-000001', 'Walk In Customer', 'some address', '000000', '', '', 10, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, '2019-09-30 14:13:59', '2019-09-28 13:12:28'),
	(26, 'CST-000002', 'Customer2', 'some address2', '654654', '', '', 10, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-28 13:17:24'),
	(27, 'CST-000003', 'Customer1', '', '444444', '', '', 10, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', '1000001', '2019-09-30 14:14:03', '2019-09-30 14:12:33');
/*!40000 ALTER TABLE `peoples` ENABLE KEYS */;

-- Dumping structure for table brick_factory.people_type
CREATE TABLE IF NOT EXISTS `people_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  `people_type` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:in-active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.people_type: ~14 rows (approximately)
/*!40000 ALTER TABLE `people_type` DISABLE KEYS */;
INSERT INTO `people_type` (`id`, `type`, `people_type`, `status`) VALUES
	(1, 'EMP', 'EMPLOYE', 1),
	(2, 'LND', 'LAND OWNER', 1),
	(3, 'SOL', 'SOIL VENDOR/ OWNER', 1),
	(4, 'LEX', 'LAND EXCAVATOR', 1),
	(5, 'KBR', 'KACHA BRICK / KHAMAL TEAM', 1),
	(6, 'LOD', 'LOAD TEAM', 1),
	(7, 'FIR', 'FIRE TEAM', 1),
	(8, 'ULD', 'UNLOAD TEAM', 1),
	(9, 'SUP', 'SUPPLIER', 1),
	(10, 'CST', 'CUTOMER', 1),
	(11, 'LBR', 'LABOUR', 1),
	(12, 'TDV', 'TRUCK DRIVER', 1),
	(13, 'VDV', 'VAN DRIVER', 1),
	(14, 'BNK', 'BANK/ FINANCIAL ', 1);
/*!40000 ALTER TABLE `people_type` ENABLE KEYS */;

-- Dumping structure for table brick_factory.purchases
CREATE TABLE IF NOT EXISTS `purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL,
  `purchase_reference_no` varchar(50) NOT NULL,
  `purchase_date` date NOT NULL,
  `purchased_by` int(11) NOT NULL,
  `discount` double(12,4) NOT NULL,
  `labour_bill` double(12,4) NOT NULL,
  `transport_bill` double(12,4) NOT NULL,
  `total_bill` double(12,4) NOT NULL,
  `paid` double(12,4) NOT NULL,
  `balance` double(12,4) NOT NULL,
  `payment_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:due, 2: partial, 3:paid ',
  `purchase_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:purchased, 2:partial received , 3:received',
  `possible_payment_date` date DEFAULT NULL,
  `note` text,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active,0:deleted',
  `attachment` varchar(200) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_purchases_companies` (`company_id`),
  KEY `FK_purchases_customer_id` (`supplier_id`),
  KEY `FK_purchases_purchased_by` (`purchased_by`),
  KEY `FK_purchases_emp_infos` (`created_by`),
  KEY `FK_purchases_emp_infos_2` (`modified_by`),
  KEY `FK_purchases_stock_seasons` (`season_id`),
  CONSTRAINT `FK_purchases_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_purchases_customer_id` FOREIGN KEY (`supplier_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_purchases_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_purchases_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_purchases_purchased_by` FOREIGN KEY (`purchased_by`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_purchases_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.purchases: ~2 rows (approximately)
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` (`id`, `supplier_id`, `purchase_reference_no`, `purchase_date`, `purchased_by`, `discount`, `labour_bill`, `transport_bill`, `total_bill`, `paid`, `balance`, `payment_status`, `purchase_status`, `possible_payment_date`, `note`, `company_id`, `season_id`, `status`, `attachment`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(7, 8, 'PO2019/04/000001', '2019-04-02', 6, 100.0000, 20.0000, 50.0000, 120470.0000, 0.0000, 120470.0000, 1, 1, NULL, '', 1, 2, 1, '', '1000001', NULL, NULL, '2019-04-02 12:03:22'),
	(8, 8, 'PO2019/04/000002', '2019-04-06', 6, 100.0000, 20.0000, 50.0000, 120970.0000, 0.0000, 120970.0000, 1, 1, NULL, '', 1, 2, 1, '', '1000001', '1000001', '2019-04-07 12:49:54', '2019-04-06 13:27:39');
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;

-- Dumping structure for table brick_factory.purchase_items
CREATE TABLE IF NOT EXISTS `purchase_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `rate` double(12,4) NOT NULL,
  `quantity` int(11) NOT NULL,
  `received_quantity` int(11) NOT NULL,
  `balance_quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_purchase_items_units` (`unit`),
  KEY `FK_purchase_items_purchases` (`purchase_id`),
  KEY `FK_purchase_items_items` (`item_id`),
  CONSTRAINT `FK_purchase_items_items` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `FK_purchase_items_purchases` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  CONSTRAINT `FK_purchase_items_units` FOREIGN KEY (`unit`) REFERENCES `units` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.purchase_items: ~4 rows (approximately)
/*!40000 ALTER TABLE `purchase_items` DISABLE KEYS */;
INSERT INTO `purchase_items` (`id`, `purchase_id`, `item_id`, `unit`, `rate`, `quantity`, `received_quantity`, `balance_quantity`) VALUES
	(7, 7, 3, 2, 1.0000, 1, 0, 0),
	(8, 7, 4, 1, 500.0000, 1, 0, 0),
	(11, 8, 3, 2, 120000.0000, 1, 0, 0),
	(12, 8, 4, 2, 500.0000, 2, 0, 0);
/*!40000 ALTER TABLE `purchase_items` ENABLE KEYS */;

-- Dumping structure for table brick_factory.purchase_receives
CREATE TABLE IF NOT EXISTS `purchase_receives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receive_reference_no` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `transport_bill` double(12,4) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:pending, 3:received',
  `note` text,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_purchase_receives_companies` (`company_id`),
  KEY `FK_purchase_receives_emp_infos` (`created_by`),
  KEY `FK_purchase_receives_emp_infos_2` (`modified_by`),
  KEY `FK_purchase_receives_stock_seasons` (`season_id`),
  CONSTRAINT `FK_purchase_receives_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_purchase_receives_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_purchase_receives_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_purchase_receives_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.purchase_receives: ~0 rows (approximately)
/*!40000 ALTER TABLE `purchase_receives` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_receives` ENABLE KEYS */;

-- Dumping structure for table brick_factory.purchase_receive_items
CREATE TABLE IF NOT EXISTS `purchase_receive_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_receive_id` int(11) NOT NULL,
  `purchase_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_purchase_receive_items_purchase_receives` (`purchase_receive_id`),
  KEY `FK_purchase_receive_items_purchase_items` (`purchase_item_id`),
  CONSTRAINT `FK_purchase_receive_items_purchase_items` FOREIGN KEY (`purchase_item_id`) REFERENCES `purchase_items` (`id`),
  CONSTRAINT `FK_purchase_receive_items_purchase_receives` FOREIGN KEY (`purchase_receive_id`) REFERENCES `purchase_receives` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.purchase_receive_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `purchase_receive_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_receive_items` ENABLE KEYS */;

-- Dumping structure for table brick_factory.rounds
CREATE TABLE IF NOT EXISTS `rounds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `round_number` varchar(50) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `load_start_date` date NOT NULL,
  `load_end_date` date DEFAULT NULL,
  `fire_start_date` date DEFAULT NULL,
  `fire_end_date` date DEFAULT NULL,
  `unload_start_date` date DEFAULT NULL,
  `unload_end_date` date DEFAULT NULL,
  `total_loaded` int(11) DEFAULT NULL,
  `total_unloaded` int(11) DEFAULT NULL,
  `total_days` int(11) DEFAULT NULL,
  `total_koyla` int(11) DEFAULT NULL,
  `total_oil` int(11) DEFAULT NULL,
  `total_khori` int(11) DEFAULT NULL,
  `total_charkol` int(11) DEFAULT NULL,
  `note` text,
  `round_status` tinyint(1) DEFAULT '1' COMMENT '1:upcoming, 2:Ongoing,3:Completed',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,0:inactive',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_rounds_companies` (`company_id`),
  KEY `FK_rounds_emp_infos` (`created_by`),
  KEY `FK_rounds_emp_infos_2` (`modified_by`),
  KEY `FK_rounds_seasons` (`season_id`),
  CONSTRAINT `FK_rounds_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_rounds_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_rounds_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_rounds_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.rounds: ~1 rows (approximately)
/*!40000 ALTER TABLE `rounds` DISABLE KEYS */;
INSERT INTO `rounds` (`id`, `round_number`, `company_id`, `season_id`, `load_start_date`, `load_end_date`, `fire_start_date`, `fire_end_date`, `unload_start_date`, `unload_end_date`, `total_loaded`, `total_unloaded`, `total_days`, `total_koyla`, `total_oil`, `total_khori`, `total_charkol`, `note`, `round_status`, `status`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(1, 'Round-1', 1, 2, '2019-03-13', NULL, NULL, NULL, NULL, NULL, 13900, 3600, NULL, 0, 0, 0, 0, 'dfgdfg dffdgfdgfdg', 1, 1, '1000001', '1000001', '2019-09-28 12:16:43', '2019-03-13 17:48:18');
/*!40000 ALTER TABLE `rounds` ENABLE KEYS */;

-- Dumping structure for table brick_factory.sales
CREATE TABLE IF NOT EXISTS `sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `sale_reference_no` varchar(50) NOT NULL DEFAULT '',
  `sale_date` date NOT NULL,
  `total_bill` double(12,4) NOT NULL,
  `discount` double(12,4) NOT NULL,
  `labour_bill` double(12,4) NOT NULL,
  `transport_bill` double(12,4) NOT NULL,
  `total_amount` double(12,4) NOT NULL,
  `paid` double(12,4) NOT NULL,
  `balance` double(12,4) NOT NULL,
  `payment_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:due, 2: partial, 3:paid ',
  `sale_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:sold, 2: partial-delivered, 3:delivered ',
  `delivery_address` text,
  `delivery_name` varchar(200) DEFAULT NULL,
  `delivery_mobile` varchar(50) DEFAULT NULL,
  `delivery_mobile_alt` varchar(50) DEFAULT NULL,
  `delivery_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:at a time, 2: partial',
  `delivery_date` date DEFAULT NULL,
  `note` text,
  `sold_by` varchar(20) DEFAULT NULL,
  `attachment` varchar(200) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_sales_companies` (`company_id`),
  KEY `FK_sales_customer_id` (`customer_id`),
  KEY `FK_sales_emp_infos` (`created_by`),
  KEY `FK_sales_emp_infos_2` (`modified_by`),
  KEY `FK_sales_stock_seasons` (`season_id`),
  CONSTRAINT `FK_sales_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_sales_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_sales_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_sales_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_sales_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.sales: ~2 rows (approximately)
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` (`id`, `customer_id`, `sale_reference_no`, `sale_date`, `total_bill`, `discount`, `labour_bill`, `transport_bill`, `total_amount`, `paid`, `balance`, `payment_status`, `sale_status`, `delivery_address`, `delivery_name`, `delivery_mobile`, `delivery_mobile_alt`, `delivery_type`, `delivery_date`, `note`, `sold_by`, `attachment`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(4, 25, 'SO2019/09/000001', '2019-09-29', 2150.0000, 100.0000, 200.0000, 500.0000, 0.0000, 0.0000, 2150.0000, 1, 1, 'fsd ht hrty', 'Hasan', '5346346315', '', 1, '0000-00-00', '', '6', '', 1, 2, '1000001', '1000001', '2019-10-10 11:47:51', '2019-09-29 15:52:30'),
	(5, 26, 'SO2019/09/000002', '2019-09-29', 3350.0000, 100.0000, 200.0000, 50.0000, 0.0000, 0.0000, 3350.0000, 1, 1, 'sfsf', 'momit', '4563456', '565565', 1, '2019-09-30', '', '6', '', 1, 2, '1000001', '1000001', '2019-10-06 16:46:20', '2019-09-29 16:41:45');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;

-- Dumping structure for table brick_factory.sale_items
CREATE TABLE IF NOT EXISTS `sale_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `rate` double(12,4) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sale_items_brick_types` (`item_id`),
  KEY `FK_sale_items_units` (`unit`),
  KEY `FK_sale_items_sales` (`sale_id`),
  CONSTRAINT `FK_sale_items_brick_types` FOREIGN KEY (`item_id`) REFERENCES `brick_types` (`id`),
  CONSTRAINT `FK_sale_items_sales` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  CONSTRAINT `FK_sale_items_units` FOREIGN KEY (`unit`) REFERENCES `units` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.sale_items: ~3 rows (approximately)
/*!40000 ALTER TABLE `sale_items` DISABLE KEYS */;
INSERT INTO `sale_items` (`id`, `sale_id`, `item_id`, `unit`, `rate`, `quantity`) VALUES
	(11, 5, 2, 2, 8.0000, 400),
	(14, 4, 2, 2, 8.0000, 100),
	(15, 4, 4, 2, 7.5000, 100);
/*!40000 ALTER TABLE `sale_items` ENABLE KEYS */;

-- Dumping structure for table brick_factory.seasons
CREATE TABLE IF NOT EXISTS `seasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `season_name` varchar(50) NOT NULL DEFAULT '0',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `total_days` int(11) DEFAULT '0',
  `company_id` int(11) NOT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '0:deleted, 1:upcoming, 2:Ongoing,3:Completed',
  `total_produced_brick` int(11) DEFAULT '0',
  `total_damage_brick` int(11) DEFAULT '0',
  `total_costing` int(11) DEFAULT '0',
  `total_sales` int(11) DEFAULT '0',
  `estimated_total_brick` int(11) DEFAULT '0',
  `estimated_damage_brick` int(11) DEFAULT '0',
  `estimated_costing` int(11) DEFAULT '0',
  `estimated_sales` int(11) DEFAULT '0',
  `estimated_per_brick` float(8,2) DEFAULT '0.00',
  `costing_per_brick` float(8,2) DEFAULT '0.00',
  `completation_note` text,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_seasons_companies` (`company_id`),
  KEY `FK_seasons_emp_infos` (`created_by`),
  KEY `FK_seasons_emp_infos_2` (`modified_by`),
  CONSTRAINT `FK_seasons_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_seasons_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_seasons_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.seasons: ~2 rows (approximately)
/*!40000 ALTER TABLE `seasons` DISABLE KEYS */;
INSERT INTO `seasons` (`id`, `season_name`, `start_date`, `end_date`, `total_days`, `company_id`, `status`, `total_produced_brick`, `total_damage_brick`, `total_costing`, `total_sales`, `estimated_total_brick`, `estimated_damage_brick`, `estimated_costing`, `estimated_sales`, `estimated_per_brick`, `costing_per_brick`, `completation_note`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(1, '2018-2019', '2018-08-01', NULL, 0, 1, 1, 10000, NULL, NULL, NULL, 0, 0, 0, 0, 0.00, NULL, 'This is  test', '1000001', '1000001', '2019-02-13 20:59:35', '2019-03-12 23:05:41'),
	(2, '2019-2020', '2019-07-18', NULL, 0, 1, 1, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0.00, NULL, NULL, '1000001', NULL, '2019-02-13 22:23:29', '2019-02-13 22:23:29');
/*!40000 ALTER TABLE `seasons` ENABLE KEYS */;

-- Dumping structure for table brick_factory.soil_agreements
CREATE TABLE IF NOT EXISTS `soil_agreements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agreement_id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `unit_qty` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `truck_fare` double(12,2) DEFAULT NULL,
  `daily_conveynce` double(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_soil_agreements_agreements` (`agreement_id`),
  KEY `FK_soil_agreements_soil_points` (`point_id`),
  CONSTRAINT `FK_soil_agreements_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  CONSTRAINT `FK_soil_agreements_soil_points` FOREIGN KEY (`point_id`) REFERENCES `soil_points` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.soil_agreements: ~4 rows (approximately)
/*!40000 ALTER TABLE `soil_agreements` DISABLE KEYS */;
INSERT INTO `soil_agreements` (`id`, `agreement_id`, `point_id`, `unit_id`, `unit_qty`, `rate`, `truck_fare`, `daily_conveynce`) VALUES
	(7, 4, 6, 8, 1, 1500, 150.00, 100.00),
	(8, 4, 5, 8, 1, 1600, 250.00, 100.00),
	(9, 9, 7, 8, 1, 1400, 100.00, 100.00),
	(10, 9, 8, 8, 1, 1400, 100.00, 100.00);
/*!40000 ALTER TABLE `soil_agreements` ENABLE KEYS */;

-- Dumping structure for table brick_factory.soil_collection_details
CREATE TABLE IF NOT EXISTS `soil_collection_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soil_coll_mst_id` int(11) NOT NULL,
  `truck_id` int(11) NOT NULL,
  `truck_driver_id` int(11) NOT NULL,
  `total_truck_trip` int(11) NOT NULL,
  `total_truck_bill` double(12,2) NOT NULL,
  `conveyance` double(12,2) NOT NULL,
  `deduction` double(12,2) NOT NULL,
  `total_bill` double(12,2) NOT NULL,
  `net_payment` double(12,2) NOT NULL,
  `total_paid` double(12,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active, 0:inactive',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.soil_collection_details: ~2 rows (approximately)
/*!40000 ALTER TABLE `soil_collection_details` DISABLE KEYS */;
INSERT INTO `soil_collection_details` (`id`, `soil_coll_mst_id`, `truck_id`, `truck_driver_id`, `total_truck_trip`, `total_truck_bill`, `conveyance`, `deduction`, `total_bill`, `net_payment`, `total_paid`, `status`) VALUES
	(3, 4, 1, 14, 5, 750.00, 500.00, 1.00, 7500.00, 7499.00, 0.00, 1),
	(4, 4, 6, 15, 2, 300.00, 200.00, 100.00, 3000.00, 2900.00, 0.00, 1);
/*!40000 ALTER TABLE `soil_collection_details` ENABLE KEYS */;

-- Dumping structure for table brick_factory.soil_collection_master
CREATE TABLE IF NOT EXISTS `soil_collection_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `soil_agreement_point` int(11) NOT NULL,
  `total_trip` int(11) NOT NULL,
  `total_truck_bill` double(12,2) NOT NULL,
  `total_conveyance` double(12,2) NOT NULL,
  `total_bill` double(12,2) NOT NULL,
  `total_deduction` double(12,2) NOT NULL,
  `net_payable` double(12,2) NOT NULL,
  `total_paid` double(12,2) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:inactive',
  `season_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `collected_by` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_soil_collection_companies` (`company_id`),
  KEY `FK_soil_collection_emp_infos` (`created_by`),
  KEY `FK_soil_collection_emp_infos_2` (`modified_by`),
  KEY `FK_soil_collection_seasons` (`season_id`),
  KEY `FK_soil_collection_peoples` (`vendor_id`),
  KEY `FK_soil_collection_master_soil_points` (`soil_agreement_point`),
  KEY `FK_soil_collection_master_peoples` (`collected_by`),
  CONSTRAINT `FK_soil_collection_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_soil_collection_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_soil_collection_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_soil_collection_master_peoples` FOREIGN KEY (`collected_by`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_soil_collection_master_soil_points` FOREIGN KEY (`soil_agreement_point`) REFERENCES `soil_points` (`id`),
  CONSTRAINT `FK_soil_collection_peoples` FOREIGN KEY (`vendor_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_soil_collection_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.soil_collection_master: ~0 rows (approximately)
/*!40000 ALTER TABLE `soil_collection_master` DISABLE KEYS */;
INSERT INTO `soil_collection_master` (`id`, `date`, `vendor_id`, `soil_agreement_point`, `total_trip`, `total_truck_bill`, `total_conveyance`, `total_bill`, `total_deduction`, `net_payable`, `total_paid`, `note`, `status`, `season_id`, `company_id`, `collected_by`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(4, '2019-07-12', 4, 6, 7, 1050.00, 700.00, 10500.00, 101.00, 10399.00, 0.00, 'this is note', 1, 2, 1, 6, '1000001', '1000001', '2019-08-03 11:03:57', '2019-07-12 14:42:53');
/*!40000 ALTER TABLE `soil_collection_master` ENABLE KEYS */;

-- Dumping structure for table brick_factory.soil_points
CREATE TABLE IF NOT EXISTS `soil_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `point_address` varchar(200) DEFAULT NULL,
  `vendor_id` int(11) NOT NULL,
  `total_estimated_soil` varchar(100) DEFAULT NULL,
  `total_actual_soil` varchar(100) DEFAULT NULL,
  `note` text,
  `point_status` tinyint(4) DEFAULT '1' COMMENT '1:Intack, 2:Collecting, 3: Collected , 2: ',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:upcoming, 2:Ongoing,3:Completed',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `point_address` (`point_address`),
  KEY `FK_soil_points_companies` (`company_id`),
  KEY `FK_soil_points_emp_infos` (`created_by`),
  KEY `FK_soil_points_emp_infos_2` (`modified_by`),
  KEY `FK_soil_points_peoples` (`vendor_id`),
  KEY `FK_soil_points_seasons` (`season_id`),
  CONSTRAINT `FK_soil_points_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_soil_points_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_soil_points_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_soil_points_peoples` FOREIGN KEY (`vendor_id`) REFERENCES `peoples` (`id`),
  CONSTRAINT `FK_soil_points_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.soil_points: ~4 rows (approximately)
/*!40000 ALTER TABLE `soil_points` DISABLE KEYS */;
INSERT INTO `soil_points` (`id`, `point_address`, `vendor_id`, `total_estimated_soil`, `total_actual_soil`, `note`, `point_status`, `status`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(5, 'Hindupara ', 4, NULL, NULL, NULL, 1, 1, 1, 2, '1000001', NULL, '2019-04-19 11:37:10', '2019-04-19 11:36:03'),
	(6, 'Mohishaban', 4, '260', '20', 'sdfv sf ddskljfn flsdjfnlk sdflsdj fsdf sdf', 2, 1, 1, 2, '1000001', '1000001', '2019-04-24 21:55:11', '2019-04-19 11:36:03'),
	(7, 'Perir Hut', 13, '', '', NULL, 1, 1, 1, 2, '1000001', NULL, NULL, '2019-04-26 11:29:20'),
	(8, 'Shokuntola', 13, '', '', NULL, 1, 1, 1, 2, '1000001', NULL, NULL, '2019-04-26 11:29:51');
/*!40000 ALTER TABLE `soil_points` ENABLE KEYS */;

-- Dumping structure for table brick_factory.trucks
CREATE TABLE IF NOT EXISTS `trucks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registration_no` varchar(50) NOT NULL,
  `owner_name` varchar(200) NOT NULL,
  `capacity` varchar(50) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:not-running',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:personal,2:rent',
  `company_id` int(11) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_truck_info_companies` (`company_id`),
  KEY `FK_truck_info_emp_infos` (`created_by`),
  KEY `FK_truck_info_emp_infos_2` (`modified_by`),
  CONSTRAINT `FK_truck_info_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `FK_truck_info_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_truck_info_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.trucks: ~3 rows (approximately)
/*!40000 ALTER TABLE `trucks` DISABLE KEYS */;
INSERT INTO `trucks` (`id`, `registration_no`, `owner_name`, `capacity`, `note`, `status`, `type`, `company_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(1, 'Dhaka-La-1234556t', 'Momitt', '5 Ton', 'dfg dfg', 1, 1, 1, '1000001', '1000001', '2019-03-18 22:40:37', '2019-03-17 15:16:27'),
	(5, 'Bogra-Ga-1235', 'Hamid Islam', '5 Ton', NULL, 1, 2, 1, '1000001', '1000001', '2019-07-10 11:34:15', '2019-07-10 11:31:20'),
	(6, 'Dhaka-045555', 'Mahbub Alam', '5 Ton', NULL, 1, 1, 1, '1000001', NULL, NULL, '2019-07-10 11:34:09');
/*!40000 ALTER TABLE `trucks` ENABLE KEYS */;

-- Dumping structure for table brick_factory.units
CREATE TABLE IF NOT EXISTS `units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(100) DEFAULT NULL,
  `short_name` varchar(10) DEFAULT NULL,
  `conversion_rate` double(12,2) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:inactive',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_units_emp_infos` (`created_by`),
  KEY `FK_units_emp_infos_2` (`modified_by`),
  CONSTRAINT `FK_units_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  CONSTRAINT `FK_units_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.units: ~9 rows (approximately)
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` (`id`, `unit_name`, `short_name`, `conversion_rate`, `note`, `status`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
	(1, 'Kilogram', 'KG', 1000.00, 'asd asddfgdfg dfgdfg ', 1, '1000001', '1000001', '2019-08-06 20:10:07', '2019-03-15 00:09:38'),
	(2, 'Pices', 'Pcs', 1.00, NULL, 1, '1000001', NULL, '2019-08-06 20:10:09', '2019-03-29 19:17:11'),
	(3, 'Years', 'yrs', 1.00, NULL, 1, '1000001', NULL, '2019-08-06 20:10:12', '2019-04-13 12:41:03'),
	(4, 'Days', 'days', 1.00, NULL, 1, '1000001', NULL, '2019-08-06 20:10:13', '2019-04-13 12:41:18'),
	(5, 'Hours', 'hrs', NULL, NULL, 1, '1000001', NULL, '2019-04-13 12:43:51', '2019-04-13 12:41:24'),
	(6, 'Seasons', 'sns', NULL, NULL, 1, '1000001', NULL, '2019-04-13 12:43:54', '2019-04-13 12:41:47'),
	(7, 'Hazar', 'hzr', 1000.00, NULL, 1, '1000001', NULL, '2019-08-06 20:10:26', '2019-04-13 12:43:28'),
	(8, 'Truck', 'Truck', 1.00, NULL, 1, '1000001', NULL, '2019-09-23 15:20:16', '2019-04-19 11:34:45'),
	(9, 'Van', 'Van', 1.00, NULL, 1, NULL, NULL, '2019-09-23 15:20:15', '2019-08-06 20:10:39'),
	(10, 'Cft', '', 1.00, NULL, 1, NULL, NULL, NULL, '2019-09-30 15:12:43');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;

-- Dumping structure for table brick_factory.user_group
CREATE TABLE IF NOT EXISTS `user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0:active, 1:inactive',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.user_group: ~2 rows (approximately)
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` (`id`, `group_name`, `status`) VALUES
	(14, 'Owner', 0),
	(21, 'Admin', 0);
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;

-- Dumping structure for table brick_factory.user_group_member
CREATE TABLE IF NOT EXISTS `user_group_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT '0',
  `emp_id` varchar(20) NOT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0: no access ; 1:access',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`group_id`,`emp_id`),
  KEY `FK_user_group_member_emp_infos` (`emp_id`),
  CONSTRAINT `FK_user_group_member_emp_infos` FOREIGN KEY (`emp_id`) REFERENCES `emp_infos` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.user_group_member: ~6 rows (approximately)
/*!40000 ALTER TABLE `user_group_member` DISABLE KEYS */;
INSERT INTO `user_group_member` (`id`, `group_id`, `emp_id`, `status`) VALUES
	(1, 14, '1000001', 1),
	(2, 21, '1000001', 1),
	(5, 14, '1000002', 1),
	(6, 21, '1000002', 1),
	(7, 14, 'EMP-000003', 1),
	(8, 21, 'EMP-000003', 0);
/*!40000 ALTER TABLE `user_group_member` ENABLE KEYS */;

-- Dumping structure for table brick_factory.user_group_permission
CREATE TABLE IF NOT EXISTS `user_group_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT '0',
  `action_id` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0: Not Permit, 1: Permit',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 2` (`group_id`,`action_id`),
  KEY `FK_user_group_permission_web_actions` (`action_id`),
  CONSTRAINT `FK_user_group_permission_user_group` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  CONSTRAINT `FK_user_group_permission_web_actions` FOREIGN KEY (`action_id`) REFERENCES `web_actions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.user_group_permission: ~165 rows (approximately)
/*!40000 ALTER TABLE `user_group_permission` DISABLE KEYS */;
INSERT INTO `user_group_permission` (`id`, `group_id`, `action_id`, `status`) VALUES
	(241, 14, 10, 1),
	(242, 14, 15, 1),
	(243, 14, 11, 1),
	(244, 14, 12, 1),
	(245, 14, 13, 1),
	(246, 14, 14, 1),
	(247, 14, 16, 1),
	(248, 14, 43, 1),
	(249, 14, 44, 1),
	(250, 21, 10, 1),
	(251, 21, 11, 1),
	(252, 21, 12, 1),
	(253, 21, 13, 1),
	(254, 21, 14, 1),
	(255, 21, 15, 1),
	(256, 21, 16, 1),
	(257, 21, 43, 1),
	(258, 21, 44, 1),
	(259, 14, 45, 1),
	(260, 21, 45, 1),
	(261, 14, 46, 1),
	(262, 21, 46, 1),
	(263, 14, 47, 1),
	(264, 21, 47, 1),
	(265, 14, 48, 1),
	(266, 21, 48, 1),
	(267, 14, 49, 1),
	(268, 21, 49, 1),
	(269, 14, 50, 1),
	(270, 21, 50, 1),
	(271, 14, 51, 1),
	(272, 21, 51, 1),
	(273, 14, 52, 1),
	(274, 21, 52, 1),
	(275, 14, 53, 1),
	(276, 21, 53, 1),
	(277, 14, 54, 1),
	(278, 21, 54, 1),
	(279, 14, 55, 1),
	(280, 21, 55, 1),
	(281, 14, 56, 1),
	(282, 21, 56, 1),
	(283, 14, 57, 1),
	(284, 21, 57, 1),
	(285, 14, 58, 1),
	(286, 21, 58, 1),
	(287, 14, 59, 1),
	(288, 21, 59, 1),
	(289, 14, 60, 1),
	(290, 21, 60, 1),
	(291, 14, 61, 1),
	(292, 21, 61, 1),
	(293, 14, 62, 1),
	(294, 21, 62, 1),
	(295, 14, 63, 1),
	(296, 21, 63, 1),
	(297, 14, 64, 1),
	(298, 21, 64, 1),
	(319, 14, 75, 1),
	(320, 21, 75, 1),
	(321, 14, 76, 1),
	(322, 21, 76, 1),
	(323, 14, 77, 1),
	(324, 21, 77, 1),
	(325, 14, 78, 1),
	(326, 21, 78, 1),
	(343, 14, 87, 1),
	(344, 21, 87, 1),
	(345, 14, 88, 1),
	(346, 21, 88, 1),
	(347, 14, 89, 1),
	(348, 21, 89, 1),
	(349, 14, 90, 1),
	(350, 21, 90, 1),
	(351, 14, 91, 1),
	(352, 21, 91, 1),
	(355, 14, 93, 1),
	(356, 21, 93, 1),
	(357, 14, 94, 1),
	(358, 21, 94, 1),
	(359, 14, 95, 1),
	(360, 21, 95, 1),
	(361, 14, 96, 1),
	(362, 21, 96, 1),
	(363, 14, 97, 1),
	(364, 21, 97, 1),
	(365, 14, 98, 1),
	(366, 21, 98, 1),
	(367, 14, 99, 1),
	(368, 21, 99, 1),
	(369, 14, 100, 1),
	(370, 21, 100, 1),
	(371, 14, 101, 1),
	(372, 21, 101, 1),
	(373, 14, 102, 1),
	(374, 21, 102, 1),
	(375, 14, 103, 1),
	(376, 21, 103, 0),
	(377, 14, 104, 1),
	(378, 21, 104, 0),
	(379, 14, 105, 1),
	(380, 21, 105, 0),
	(381, 14, 106, 1),
	(382, 21, 106, 0),
	(383, 14, 108, 1),
	(384, 21, 108, 0),
	(385, 14, 109, 1),
	(386, 21, 109, 0),
	(387, 14, 112, 1),
	(388, 21, 112, 0),
	(389, 14, 113, 1),
	(390, 21, 113, 0),
	(391, 14, 114, 1),
	(392, 21, 114, 0),
	(393, 14, 115, 1),
	(394, 21, 115, 0),
	(395, 14, 116, 1),
	(396, 21, 116, 0),
	(397, 14, 117, 1),
	(398, 21, 117, 0),
	(399, 14, 118, 1),
	(400, 21, 118, 0),
	(401, 14, 119, 1),
	(402, 21, 119, 0),
	(403, 14, 120, 1),
	(404, 21, 120, 0),
	(405, 14, 121, 1),
	(406, 21, 121, 0),
	(407, 14, 122, 1),
	(408, 21, 122, 0),
	(409, 14, 123, 1),
	(410, 21, 123, 0),
	(411, 14, 124, 1),
	(412, 21, 124, 0),
	(413, 14, 125, 1),
	(414, 21, 125, 0),
	(415, 14, 126, 1),
	(416, 21, 126, 0),
	(417, 14, 127, 1),
	(418, 21, 127, 0),
	(419, 14, 128, 1),
	(420, 21, 128, 0),
	(421, 14, 129, 1),
	(422, 21, 129, 0),
	(423, 14, 130, 1),
	(424, 21, 130, 0),
	(425, 14, 131, 1),
	(426, 21, 131, 0),
	(427, 14, 132, 1),
	(428, 21, 132, 0),
	(429, 14, 133, 1),
	(430, 21, 133, 0),
	(431, 14, 134, 1),
	(432, 21, 134, 0),
	(433, 14, 135, 1),
	(434, 21, 135, 0),
	(435, 14, 136, 1),
	(436, 21, 136, 0),
	(437, 14, 137, 1),
	(438, 21, 137, 0),
	(439, 14, 138, 1),
	(440, 21, 138, 0),
	(441, 14, 139, 1),
	(442, 21, 139, 0),
	(443, 14, 140, 1),
	(444, 21, 140, 0),
	(445, 14, 141, 1),
	(446, 21, 141, 0),
	(447, 14, 142, 1),
	(448, 21, 142, 0),
	(449, 14, 143, 1),
	(450, 21, 143, 0),
	(451, 14, 144, 1),
	(452, 21, 144, 0),
	(453, 14, 145, 1),
	(454, 21, 145, 0),
	(455, 14, 146, 1),
	(456, 21, 146, 0),
	(457, 14, 147, 1),
	(458, 21, 147, 0);
/*!40000 ALTER TABLE `user_group_permission` ENABLE KEYS */;

-- Dumping structure for table brick_factory.web_actions
CREATE TABLE IF NOT EXISTS `web_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(50) NOT NULL,
  `module_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_name_module_id` (`activity_name`,`module_id`),
  KEY `module_id` (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.web_actions: ~65 rows (approximately)
/*!40000 ALTER TABLE `web_actions` DISABLE KEYS */;
INSERT INTO `web_actions` (`id`, `activity_name`, `module_id`, `status`) VALUES
	(10, 'Employee enrty', 1, 0),
	(11, 'Employee permission', 1, 0),
	(12, 'Employee update', 1, 0),
	(13, 'Employee delete', 1, 0),
	(14, 'Control panel', 1, 0),
	(15, 'Employee List', 1, 0),
	(16, 'Permission grid', 1, 0),
	(43, 'Action access', 1, 0),
	(44, 'Group permission', 1, 0),
	(45, 'Department Entry', 1, 0),
	(46, 'Department Update', 1, 0),
	(47, 'Department Delete', 1, 0),
	(48, 'Department  List', 1, 0),
	(49, 'Designation Update', 1, 0),
	(50, 'Designation Entry', 1, 0),
	(51, 'Designation Delete', 1, 0),
	(52, 'Designation  List', 1, 0),
	(53, 'Project Entry', 1, 0),
	(54, 'Project Delete', 1, 0),
	(55, 'Project Update', 1, 0),
	(56, 'Project List', 1, 0),
	(57, 'Customer Entry', 1, 0),
	(58, 'Customer Update', 1, 0),
	(59, 'Customer Delete', 1, 0),
	(60, 'Customer List', 1, 0),
	(61, 'Department Permission', 1, 0),
	(62, 'Designation Permission', 1, 0),
	(63, 'Project Permission', 1, 0),
	(64, 'Customer Permission', 1, 0),
	(75, 'Leave Category Entry', 1, 0),
	(76, 'Leave Category Update', 1, 0),
	(77, 'Leave Category Delete', 1, 0),
	(78, 'Leave Category List', 1, 0),
	(87, 'Leave Entry', 1, 0),
	(88, 'Leave Update', 1, 0),
	(89, 'Leave Delete', 1, 0),
	(90, 'Leave List', 1, 0),
	(91, 'Generate Salary', 1, 0),
	(93, 'Salary Update', 1, 0),
	(94, 'Salary Delete', 1, 0),
	(95, 'Salary List', 1, 0),
	(96, 'Salary Entry', 1, 0),
	(97, 'Employee List Report', 1, 0),
	(98, 'Individual Leave Report', 1, 0),
	(99, 'Monthly Salary Report', 1, 0),
	(100, 'settings CRUD', 9, 0),
	(101, 'people CRUD', 7, 0),
	(102, 'Expense CRUD', 3, 0),
	(103, 'Purchase CRUD', 3, 0),
	(104, 'Agreement CRUD', 7, 0),
	(105, 'Soil Point', 11, 0),
	(106, 'Soil Collection CRUD', 11, 0),
	(108, 'land Exc. CRUD', 11, 0),
	(109, 'Kacha Production', 2, 0),
	(112, 'Kacha Production Edit', 2, 0),
	(113, 'Kacha Production Delete', 2, 0),
	(114, ' Load', 2, 0),
	(115, 'Load Edit', 2, 0),
	(116, 'Load Delete', 2, 0),
	(117, 'kacha Khamal', 2, 0),
	(118, 'kacha Khamal edit', 2, 0),
	(119, 'kacha Khamal Delete', 2, 0),
	(120, 'Drumstack Production ', 2, 0),
	(121, 'Drumstack Production edit', 2, 0),
	(122, 'Drumstack Production Delete', 2, 0),
	(123, 'Unload', 2, 0),
	(124, 'Unload Edit', 2, 0),
	(125, 'Unload Delete', 2, 0),
	(126, 'Stock Summary', 12, 0),
	(127, 'Drumstack Stock', 12, 0),
	(128, 'Production Summary', 2, 0),
	(129, 'Sale view', 8, 0),
	(130, 'Sale Entry', 8, 0),
	(131, 'Sale Update', 8, 0),
	(132, 'Sale Delete', 8, 0),
	(133, 'Delevery view', 8, 0),
	(134, 'Delevery Entry', 8, 0),
	(135, 'Delevery Update', 8, 0),
	(136, 'Delevery Delete', 8, 0),
	(137, 'Stock Adjustment', 12, 0),
	(138, 'Stock Adjustment Edit', 12, 0),
	(139, 'Stock Adjustment Delete', 12, 0),
	(140, 'Stock Adjustment Entry', 12, 0),
	(141, 'Soil Bills', 14, 0),
	(142, 'Payments', 15, 0),
	(143, 'Truck Bills', 14, 0),
	(144, 'Production Bills', 14, 0),
	(145, 'Expense Bills', 14, 0),
	(146, 'Purchase Bills', 14, 0),
	(147, 'Delivery Billls', 14, 0);
/*!40000 ALTER TABLE `web_actions` ENABLE KEYS */;

-- Dumping structure for table brick_factory.web_module
CREATE TABLE IF NOT EXISTS `web_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Dumping data for table brick_factory.web_module: ~10 rows (approximately)
/*!40000 ALTER TABLE `web_module` DISABLE KEYS */;
INSERT INTO `web_module` (`id`, `module_name`, `status`) VALUES
	(1, 'HRM', 0),
	(2, 'Production', 0),
	(3, 'Purchse', 0),
	(4, 'Inventory', 0),
	(5, 'Accounts', 0),
	(7, 'People', 0),
	(8, 'Sales', 0),
	(9, 'Settings', 0),
	(10, 'Report', 0),
	(11, 'Soil', 0),
	(12, 'Stock', 0),
	(14, 'Bill', 0),
	(15, 'Payments', 0),
	(16, 'Receives', 0);
/*!40000 ALTER TABLE `web_module` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
