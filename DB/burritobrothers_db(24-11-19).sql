-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 24, 2019 at 04:48 PM
-- Server version: 8.0.17
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `brick_factory`
--
CREATE DATABASE IF NOT EXISTS `brick_factory` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `brick_factory`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts_head`
--

CREATE TABLE `accounts_head` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `head_name` varchar(55) NOT NULL,
  `head_type` varchar(50) NOT NULL DEFAULT 'bank' COMMENT '1:bank, 2: mobile_bank, 3:cash ',
  `balance` double(12,4) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT '1' COMMENT '1:active, 2: in-active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accounts_head`
--

INSERT INTO `accounts_head` (`id`, `code`, `head_name`, `head_type`, `balance`, `status`) VALUES
(1, '00001', 'Cash', 'Cash', 193750.0000, '1'),
(2, '00002', 'DBBL (116.103.124.21)', 'bank', 100000.0000, '1');

-- --------------------------------------------------------

--
-- Table structure for table `accounts_transection`
--

CREATE TABLE `accounts_transection` (
  `id` int(11) NOT NULL,
  `transection_reference` varchar(50) NOT NULL,
  `account_head_id` int(11) NOT NULL,
  `debit` double(12,4) NOT NULL,
  `credit` double(12,4) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) NOT NULL DEFAULT '',
  `transection_type` tinyint(1) NOT NULL COMMENT '1:transfer, 0:General/Openning Bl, 2:Deposit/Investment, 3withdraw, 4: payment, 5: Receive',
  `note` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accounts_transection`
--

INSERT INTO `accounts_transection` (`id`, `transection_reference`, `account_head_id`, `debit`, `credit`, `date`, `created_by`, `transection_type`, `note`) VALUES
(1, '', 1, 200000.0000, 0.0000, '2019-11-04 06:57:12', '1000001', 0, ''),
(2, '', 2, 100000.0000, 0.0000, '2019-11-04 06:57:32', '1000001', 0, ''),
(7, 'PAY/11/19-000001', 1, 0.0000, 100.0000, '2019-11-06 12:48:57', '1000001', 4, NULL),
(8, 'PAY/11/19-000006', 1, 0.0000, 5000.0000, '2019-11-12 09:08:20', '1000001', 4, NULL),
(9, 'PAY/11/19-000001', 1, 0.0000, 1150.0000, '2019-11-12 09:57:33', '1000001', 4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `acc_payments`
--

CREATE TABLE `acc_payments` (
  `id` int(11) NOT NULL,
  `payment_reference_no` varchar(50) NOT NULL,
  `payment_type` int(11) NOT NULL,
  `paid_to_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `paid_amount` double(12,2) NOT NULL,
  `account_head` int(11) NOT NULL,
  `expense_head` int(11) NOT NULL,
  `payment_methode` tinyint(1) DEFAULT '1' COMMENT '1:cash,2:bank, 3:creditcard,4:mobile_bank, 5:others',
  `attachment` text,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:paid, 2:deleted',
  `paid_by` int(11) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `acc_payments`
--

INSERT INTO `acc_payments` (`id`, `payment_reference_no`, `payment_type`, `paid_to_id`, `date`, `paid_amount`, `account_head`, `expense_head`, `payment_methode`, `attachment`, `note`, `status`, `paid_by`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(5, 'PAY/11/19-000005', 12, 15, '2019-11-06', 100.00, 1, 6, 1, NULL, NULL, 1, 6, 1, 1, '1000001', NULL, '2019-11-12 08:01:23', '2019-11-06 12:48:57'),
(6, 'PAY/11/19-000006', 12, 17, '2019-11-12', 5000.00, 1, 6, 1, NULL, NULL, 1, 6, 1, 1, '1000001', NULL, NULL, '2019-11-12 09:08:20'),
(7, 'PAY/11/19-000001', 12, 15, '2019-11-12', 1150.00, 1, 6, 1, NULL, NULL, 1, 6, 1, 1, '1000001', NULL, NULL, '2019-11-12 09:57:33');

-- --------------------------------------------------------

--
-- Table structure for table `acc_receives`
--

CREATE TABLE `acc_receives` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `adjustment_bricks`
--

CREATE TABLE `adjustment_bricks` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `note` text,
  `adjusted_by` int(11) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `adjustment_bricks`
--

INSERT INTO `adjustment_bricks` (`id`, `date`, `note`, `adjusted_by`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(37, '2019-10-13', 'x df fdsf', 6, 1, 2, '1000001', '1000001', '2019-10-13 12:41:54', '2019-10-13 09:58:44');

-- --------------------------------------------------------

--
-- Table structure for table `adjustment_details`
--

CREATE TABLE `adjustment_details` (
  `id` int(11) NOT NULL,
  `adjustment_mst_id` int(11) NOT NULL,
  `brick_type` int(11) NOT NULL,
  `brick_quantity` int(11) NOT NULL,
  `adjustment_type` tinyint(1) DEFAULT NULL COMMENT '1:Damaged, 2: System Loss , 3: Added',
  `reason` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adjustment_details`
--

INSERT INTO `adjustment_details` (`id`, `adjustment_mst_id`, `brick_type`, `brick_quantity`, `adjustment_type`, `reason`) VALUES
(13, 37, 2, 10, 1, NULL),
(14, 37, 4, 20, 2, NULL),
(15, 37, 9, 1, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `agreements`
--

CREATE TABLE `agreements` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `agreements`
--

INSERT INTO `agreements` (`id`, `agreement_name`, `people_id`, `agreement_type`, `agreement_date`, `unit_qty`, `unit_id`, `unit_rate`, `deduction_rate`, `deduction_by`, `advance_payment`, `balance`, `daily_conveyance`, `start_date`, `end_date`, `act_start_date`, `act_end_date`, `agreement_by`, `agreement_review`, `company_id`, `season_id`, `status`, `agreement_details`, `completation_review`, `attachment`, `attachment1`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(2, NULL, 6, 1, '2019-04-13', 10.00, 3, 20000.00, 0.00, 1, 0.00, 0.00, 0.00, '2019-04-13', '2029-04-30', NULL, NULL, 6, 0, 1, 2, 1, '', '', '', ' ', '1000001', '1000001', '2019-04-21 09:32:50', '2019-04-13 08:11:47'),
(3, NULL, 9, 4, '2019-04-17', 1.00, 5, 1200.00, NULL, 1, 0.00, 0.00, 100.00, '2019-04-18', NULL, NULL, NULL, 6, NULL, 1, 2, 1, '   The UK\'s intention is to address the EU Single Market and customs union issues around the Irish border question through an overall EU-UK relationship. That is, through an EU-UK trade deal.', '', '', '', '1000001', NULL, '2019-08-04 05:39:45', '2019-04-17 11:29:03'),
(4, NULL, 4, 3, '2019-04-19', NULL, 3, NULL, 0.00, 1, 50000.00, 0.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-04-26 05:28:28', '2019-04-19 05:58:34'),
(8, 'Dry load', 11, 6, '2019-04-20', NULL, NULL, NULL, NULL, 1, 50000.00, 0.00, 0.00, '2019-04-20', '2019-04-20', NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 10:08:47', '2019-04-20 07:15:32'),
(9, NULL, 13, 3, '2019-04-26', NULL, NULL, NULL, NULL, 1, 40000.00, 0.00, 0.00, '2019-04-30', NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', NULL, NULL, '2019-04-26 05:31:18'),
(10, 'Kacha Bangla', 18, 5, '2019-08-05', 1.00, 7, 800.00, 10.00, 1, 100000.00, 98800.00, 100.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 08:19:12', '2019-08-05 16:07:14'),
(11, NULL, 19, 5, '2019-08-05', 1.00, 7, 750.00, 5.00, 1, 20000.00, 0.00, 100.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', NULL, NULL, '2019-08-05 16:08:01'),
(12, NULL, 20, 5, '2019-08-06', 1.00, 7, 600.00, 5.00, 1, 50000.00, 0.00, 100.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', NULL, NULL, '2019-08-05 16:08:50'),
(14, 'Kacha Auto', 18, 5, '2019-08-05', 1.00, 7, 890.00, 200.00, 2, 20000.00, 20000.00, 200.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-18 10:46:06', '2019-08-05 16:17:42'),
(15, 'Dry khamal', 18, 5, '2019-09-15', 1.00, 7, 500.00, NULL, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 08:52:16', '2019-09-15 07:02:36'),
(16, 'Dry khamal', 19, 5, '2019-09-15', 1.00, 7, 480.00, NULL, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 08:52:07', '2019-09-15 07:03:22'),
(17, 'Dry khamal', 20, 5, '2019-09-15', 1.00, 7, 550.00, 0.00, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 08:51:56', '2019-09-15 09:01:30'),
(18, 'Dry Toma', 21, 6, '2019-09-16', NULL, 7, NULL, 50.00, 2, 10000.00, 8800.00, 0.00, '2019-09-16', NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-10-14 11:24:11', '2019-09-16 18:09:52'),
(19, 'Dry drumstack', 23, 6, '2019-09-19', NULL, 7, NULL, 50.00, 2, 50000.00, 48900.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 09:55:30', '2019-09-19 12:07:10'),
(20, 'Paka Unload ', 24, 6, '2019-09-23', NULL, NULL, NULL, 20.00, 2, 1000.00, 360.00, 0.00, NULL, NULL, NULL, NULL, 6, NULL, 1, 2, 1, '', '', '', '', '1000001', '1000001', '2019-09-25 23:01:59', '2019-09-23 08:35:05');

-- --------------------------------------------------------

--
-- Table structure for table `agreement_type`
--

CREATE TABLE `agreement_type` (
  `id` int(11) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `agreement_type` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:in-active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `agreement_type`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `appuser`
--

CREATE TABLE `appuser` (
  `user_id` varchar(12) NOT NULL DEFAULT '',
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `user_password` varchar(40) DEFAULT NULL,
  `user_level` varchar(10) NOT NULL DEFAULT 'General' COMMENT 'Admin,Developer,General',
  `login_status` tinyint(4) DEFAULT '0' COMMENT '1=login; 0=not login;',
  `is_active` int(1) NOT NULL DEFAULT '1' COMMENT '1=Active,0=Blocked',
  `modified_by` varchar(20) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appuser`
--

INSERT INTO `appuser` (`user_id`, `user_name`, `user_password`, `user_level`, `login_status`, `is_active`, `modified_by`, `modified_time`, `created_by`, `created_at`) VALUES
('1000001', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'Admin', 0, 1, NULL, NULL, '1000001', '2018-08-07 07:33:40'),
('1000002', 'munif', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 1, NULL, NULL, '1000001', '2019-03-20 14:40:19'),
('EMP-000003', 'litu', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 1, NULL, NULL, '1000001', '2019-03-20 17:33:11');

-- --------------------------------------------------------

--
-- Table structure for table `brick_stock`
--

CREATE TABLE `brick_stock` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `brick_stock`
--

INSERT INTO `brick_stock` (`id`, `kacha_prod_id`, `load_id`, `sale_item_id`, `adjustment_dtls_id`, `date`, `quantity`, `brick_type`, `balance_quantity`, `note`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`) VALUES
(174, 42, NULL, NULL, NULL, '2019-09-22', 10000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(175, 43, NULL, NULL, NULL, '2019-09-21', 10000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(176, 44, NULL, NULL, NULL, '2019-09-22', 9000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(177, 44, NULL, NULL, NULL, '2019-09-22', 1000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(178, 44, NULL, NULL, NULL, '2019-09-22', -100, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(179, 43, NULL, NULL, NULL, '2019-09-21', -100, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(180, 42, NULL, NULL, NULL, '2019-09-22', -100, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(181, 45, NULL, NULL, NULL, '2019-09-23', 8000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(182, 45, NULL, NULL, NULL, '2019-09-23', -8000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(183, 45, NULL, NULL, NULL, '2019-09-23', -100, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(184, 46, NULL, NULL, NULL, '2019-09-22', 9900, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(185, 46, NULL, NULL, NULL, '2019-09-22', -9900, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(186, 46, NULL, NULL, NULL, '2019-09-22', -100, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(187, 46, NULL, NULL, NULL, '2019-09-22', 10000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(188, 46, NULL, NULL, NULL, '2019-09-22', -10000, 9, 0, NULL, 1, 2, '1000001', NULL, NULL),
(286, NULL, 29, NULL, NULL, '2019-09-24', -3000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL),
(287, NULL, 29, NULL, NULL, '2019-09-24', 3000, 12, 0, NULL, 1, 2, '1000001', NULL, NULL),
(288, NULL, 29, NULL, NULL, '2019-09-24', -200, 12, 0, NULL, 1, 2, '1000001', NULL, NULL),
(289, NULL, 29, NULL, NULL, '2019-09-24', -5000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL),
(290, NULL, 29, NULL, NULL, '2019-09-24', 5000, 12, 0, NULL, 1, 2, '1000001', NULL, NULL),
(291, NULL, 29, NULL, NULL, '2019-09-24', -100, 12, 0, NULL, 1, 2, '1000001', NULL, NULL),
(350, NULL, 34, NULL, NULL, '2019-09-24', -3000, 12, 0, NULL, 1, 2, '1000001', NULL, NULL),
(351, NULL, 34, NULL, NULL, '2019-09-24', 3000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL),
(352, NULL, 34, NULL, NULL, '2019-09-24', -100, 13, 0, NULL, 1, 2, '1000001', NULL, NULL),
(353, NULL, 34, NULL, NULL, '2019-09-24', -1000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL),
(354, NULL, 34, NULL, NULL, '2019-09-24', 1000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL),
(402, NULL, 37, NULL, NULL, '2019-09-25', -2000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL),
(403, NULL, 37, NULL, NULL, '2019-09-25', 2000, 2, 0, NULL, 1, 2, '1000001', NULL, NULL),
(404, NULL, 37, NULL, NULL, '2019-09-25', 2, 7, 0, NULL, 1, 2, '1000001', NULL, NULL),
(405, NULL, 37, NULL, NULL, '2019-09-25', -1000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL),
(406, NULL, 37, NULL, NULL, '2019-09-25', 1000, 4, 0, NULL, 1, 2, '1000001', NULL, NULL),
(407, NULL, 37, NULL, NULL, '2019-09-25', -100, 4, 0, NULL, 1, 2, '1000001', NULL, NULL),
(408, NULL, 37, NULL, NULL, '2019-09-25', -500, 13, 0, NULL, 1, 2, '1000001', NULL, NULL),
(409, NULL, 37, NULL, NULL, '2019-09-25', 500, 5, 0, NULL, 1, 2, '1000001', NULL, NULL),
(410, NULL, 37, NULL, NULL, '2019-09-25', -5, 5, 0, NULL, 1, 2, '1000001', NULL, NULL),
(415, NULL, 39, NULL, NULL, '2019-09-26', -100, 13, 0, NULL, 1, 2, '1000001', NULL, NULL),
(416, NULL, 39, NULL, NULL, '2019-09-26', 100, 2, 0, NULL, 1, 2, '1000001', NULL, NULL),
(417, NULL, 40, NULL, NULL, '2019-09-28', -10000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(418, NULL, 40, NULL, NULL, '2019-09-28', 10000, 13, 0, NULL, 1, 2, '1000001', NULL, NULL),
(426, NULL, NULL, 11, NULL, '2019-10-07', -200, 2, 0, NULL, 1, 2, '1000001', NULL, NULL),
(427, NULL, NULL, 14, NULL, '2019-10-10', -50, 2, 0, NULL, 1, 2, '1000001', NULL, NULL),
(428, NULL, NULL, 15, NULL, '2019-10-10', -50, 4, 0, NULL, 1, 2, '1000001', NULL, NULL),
(429, NULL, NULL, 11, NULL, '2019-10-10', -100, 2, 0, NULL, 1, 2, '1000001', NULL, NULL),
(430, NULL, NULL, 14, NULL, '2019-10-10', -50, 2, 0, NULL, 1, 2, '1000001', NULL, NULL),
(441, NULL, NULL, NULL, 13, '2019-10-13', -10, 2, 0, NULL, 1, 2, '1000001', NULL, NULL),
(442, NULL, NULL, NULL, 14, '2019-10-13', -20, 4, 0, NULL, 1, 2, '1000001', NULL, NULL),
(443, NULL, NULL, NULL, 15, '2019-10-13', -1, 9, 0, NULL, 1, 2, '1000001', NULL, '2019-10-14 09:48:45'),
(444, NULL, 23, NULL, NULL, '2019-09-24', -5000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(445, NULL, 23, NULL, NULL, '2019-09-24', 5000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL),
(446, NULL, 23, NULL, NULL, '2019-09-24', -20, 11, 0, NULL, 1, 2, '1000001', NULL, NULL),
(447, NULL, 23, NULL, NULL, '2019-09-24', -5000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(448, NULL, 23, NULL, NULL, '2019-09-24', 5000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL),
(449, NULL, 23, NULL, NULL, '2019-09-24', -30, 11, 0, NULL, 1, 2, '1000001', NULL, NULL),
(450, NULL, 23, NULL, NULL, '2019-09-24', -5000, 10, 0, NULL, 1, 2, '1000001', NULL, NULL),
(451, NULL, 23, NULL, NULL, '2019-09-24', 5000, 11, 0, NULL, 1, 2, '1000001', NULL, NULL),
(452, NULL, 23, NULL, NULL, '2019-09-24', -10, 11, 0, NULL, 1, 2, '1000001', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `brick_types`
--

CREATE TABLE `brick_types` (
  `id` int(11) NOT NULL,
  `brick_name` varchar(100) DEFAULT NULL COMMENT '1stclass, 2ndclass, adhla, dry, kacha, khamal',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:kacha, 2:paka',
  `current_rate` float(8,2) NOT NULL DEFAULT '0.00',
  `selling_unit` int(11) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:inactive',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `brick_types`
--

INSERT INTO `brick_types` (`id`, `brick_name`, `type`, `current_rate`, `selling_unit`, `note`, `status`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(2, '1No Bangla', 2, 8.00, 2, '1st class ', 1, '1000001', NULL, '2019-09-30 09:13:23', '2019-01-21 17:32:03'),
(4, '2No Bangla', 2, 7.00, 2, '2nd class', 1, '1000001', NULL, '2019-09-30 09:13:24', '2019-01-21 17:32:28'),
(5, '3No Bangla', 2, 6.00, 2, '3rd class', 1, '1000001', '1000001', '2019-09-30 09:13:26', '2019-03-11 15:31:47'),
(7, 'Adhla', 2, 0.00, 10, NULL, 1, '1000001', NULL, '2019-09-30 09:28:16', '2019-01-21 17:33:19'),
(8, 'Shurki', 2, 0.00, 10, NULL, 1, '1000001', NULL, '2019-09-30 09:13:32', '2019-01-21 17:33:40'),
(9, 'Kacha', 1, 0.00, 0, 'Just Ready Brick', 1, '1000001', NULL, '2019-01-21 17:33:40', '2019-01-21 17:34:39'),
(10, 'Khamal ', 1, 0.00, 0, 'dry khamal  Brick', 1, '1000001', NULL, '2019-01-21 17:33:40', '2019-01-21 17:36:35'),
(11, 'TOMA', 1, 0.00, 0, 'dry Toma Brick', 1, '1000001', NULL, '2019-08-07 05:41:38', '2019-01-21 17:35:21'),
(12, 'Drumstack', 1, 0.00, 0, 'dry drumstackBrick', 1, '1000001', NULL, '2019-01-21 17:33:40', '2019-01-21 17:35:21'),
(13, 'Loaded', 1, 0.00, 0, 'Loaded to kill for fire ', 1, '1000001', NULL, '2019-01-21 17:33:40', '2019-01-21 17:36:52'),
(14, 'Used Paka', 2, 0.00, 2, 'Used paka brick for brickfield purpose', 1, NULL, NULL, '2019-09-30 09:16:11', '2019-09-18 12:31:05'),
(15, '1No Auto', 2, 8.50, 2, NULL, 1, NULL, NULL, '2019-09-30 09:13:37', '2019-09-24 10:26:34'),
(16, '2No Auto', 2, 7.50, 2, NULL, 1, NULL, NULL, '2019-09-30 09:13:38', '2019-09-24 10:26:34'),
(17, '3No Auto', 2, 6.50, 2, NULL, 1, NULL, NULL, '2019-09-30 09:13:39', '2019-09-24 10:26:34'),
(18, 'Khoyaa', 2, 350.00, 10, NULL, 1, NULL, NULL, '2019-09-30 09:13:41', '2019-09-30 09:11:09');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `company_id` int(11) NOT NULL,
  `company_name` varchar(150) NOT NULL,
  `company_address` text,
  `phone` varchar(18) DEFAULT NULL,
  `note` text,
  `logo` longtext,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  0: inactive',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`company_id`, `company_name`, `company_address`, `phone`, `note`, `logo`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Molla Bricks Ltd.', 'dhora, maria, gabtoli bogura', '015754557', 'fdsfdsfdsfd', NULL, 1, '1000001', '1000001', '2019-01-14 17:08:53', '2019-03-11 15:27:34'),
(2, 'Molla Bricks Ltd2', 'dhora, maria, gabtoli bogura', '015754557', 'fdsfdsfdsfd', NULL, 1, '1000001', '1000001', '2019-01-14 17:08:53', '2019-03-11 15:27:34');

-- --------------------------------------------------------

--
-- Table structure for table `daily_fire_status`
--

CREATE TABLE `daily_fire_status` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `daily_individual_production`
--

CREATE TABLE `daily_individual_production` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `daily_kacha_production`
--

CREATE TABLE `daily_kacha_production` (
  `id` int(11) NOT NULL,
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
  `total_paid` double(12,2) NOT NULL DEFAULT '0.00',
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:inactive',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `counted_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='    [prod_qty] => 5000\r\n    [bill] => 4000\r\n    [conveyance] => 100.00\r\n    [bonus] => \r\n    [deduction] => \r\n    [deduction_by] => 1\r\n    [deduction_rate] => 10.00\r\n    [advance_payment] => 100000.00\r\n    [balance] => 0.00\r\n    [adv_deduction] => 0\r\n    [daily_bill] => 4100\r\n    [net_pay] => 4100';

--
-- Dumping data for table `daily_kacha_production`
--

INSERT INTO `daily_kacha_production` (`id`, `party_id`, `mill_id`, `agreement_id`, `date`, `producted_brick_type`, `brick_mill_type`, `rate`, `production_quantity`, `damage_quantity`, `actual_quantity`, `total_bill`, `conveyance`, `bonus`, `deduction`, `adv_deduction`, `daily_bill`, `net_pay`, `total_paid`, `note`, `status`, `company_id`, `season_id`, `counted_by`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(42, 18, 4, 10, '2019-09-22', 9, 2, 800.00, 10000, 100, 9900, 8000.00, 100.00, 0.00, 0.00, 800.00, 8100.00, 7300.00, 0.00, NULL, 1, 1, 2, '6', '1000001', '1000001', '2019-09-25 08:05:04', '2019-09-25 08:01:59'),
(43, 20, 2, 12, '2019-09-21', 9, 2, 600.00, 10000, 100, 9900, 6000.00, 100.00, 0.00, 0.00, 0.00, 6100.00, 6100.00, 0.00, NULL, 1, 1, 2, '6', '1000001', '1000001', '2019-09-25 08:04:54', '2019-09-25 08:02:58'),
(44, 20, 3, 12, '2019-09-22', 9, 2, 600.00, 10000, 100, 9900, 6000.00, 100.00, 0.00, 0.00, 0.00, 6100.00, 6100.00, 0.00, NULL, 1, 1, 2, '6', '1000001', '1000001', '2019-09-25 08:04:44', '2019-09-25 08:03:24'),
(45, 18, 4, 15, '2019-09-23', 10, 2, 500.00, 8000, 100, 7900, 4000.00, 0.00, 0.00, 0.00, 400.00, 4000.00, 3600.00, 0.00, NULL, 1, 1, 2, '6', '1000001', NULL, NULL, '2019-09-25 08:19:11'),
(46, 20, 2, 17, '2019-09-22', 10, 2, 550.00, 19900, 100, 19800, 10945.00, 0.00, 0.00, 0.00, 0.00, 10945.00, 10945.00, 0.00, NULL, 1, 1, 2, '6', '1000001', '1000001', '2019-09-25 08:22:45', '2019-09-25 08:20:29');

-- --------------------------------------------------------

--
-- Table structure for table `daily_load_production`
--

CREATE TABLE `daily_load_production` (
  `id` int(11) NOT NULL,
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
  `total_paid` double(12,2) NOT NULL,
  `load_type` int(11) NOT NULL COMMENT '1: FIRE-LOAD, 2: UNLOAD  to fire/load; 3: DAM-LOAD, 4:TOMA-LOAD ',
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `daily_load_production`
--

INSERT INTO `daily_load_production` (`id`, `party_id`, `agreement_id`, `date`, `total_bill`, `conveyance`, `bonus`, `deduction`, `adv_deduction`, `dumpa_charge`, `total_prod`, `daily_bill`, `net_pay`, `total_paid`, `load_type`, `no_of_dumpa`, `door_id`, `round_id`, `to_drstack_id`, `from_drstack_id`, `note`, `status`, `company_id`, `season_id`, `counted_by`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(23, 21, 18, '2019-09-24', 14500.00, 0.00, 0.00, 0.00, 50.00, 0.00, 15000, 14500.00, 14450.00, 0.00, 4, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', '1000001', '2019-09-25 08:45:58', '2019-09-25 08:41:57'),
(29, 23, 19, '2019-09-24', 9750.00, 0.00, 0.00, 0.00, 50.00, 0.00, 8000, 9750.00, 9700.00, 0.00, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', '1000001', '2019-09-25 09:51:55', '2019-09-25 09:49:34'),
(34, 11, 8, '2019-09-24', 5350.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4000, 5350.00, 5350.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', '1000001', '2019-09-25 10:57:55', '2019-09-25 10:36:56'),
(37, 24, 20, '2019-09-25', 3700.00, 0.00, 0.00, 0.00, 20.00, 0.00, 3500, 3700.00, 3680.00, 0.00, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', '1000001', '2019-09-25 12:20:21', '2019-09-25 11:48:57'),
(39, 24, 20, '2019-09-26', 110.00, 0.00, 0.00, 0.00, 20.00, 0.00, 100, 110.00, 90.00, 0.00, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', NULL, '2019-09-25 23:01:59', '2019-09-25 23:01:59'),
(40, 11, 8, '2019-09-28', 9000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 10000, 9000.00, 9000.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 6, '1000001', NULL, '2019-09-28 06:16:43', '2019-09-28 06:16:43');

-- --------------------------------------------------------

--
-- Table structure for table `daily_load_production_details`
--

CREATE TABLE `daily_load_production_details` (
  `id` int(11) NOT NULL,
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
  `door_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `daily_load_production_details`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `truck_id`, `truck_driver_id`, `delivery_date`, `total_quantity`, `transport_type`, `transport_bill`, `labour_bill`, `note`, `delivery_by`, `attachment`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(3, NULL, NULL, '2019-10-07', 200, 0, 500.0000, 500.0000, '', '6', '', 1, 2, '1000001', NULL, '2019-10-10 06:38:43', '2019-10-07 08:38:17'),
(4, 1, 14, '2019-10-10', 100, 12, 100.0000, 50.0000, '', '6', '', 1, 2, '1000001', NULL, NULL, '2019-10-10 05:52:31'),
(5, 1, 15, '2019-10-10', 150, 12, 100.0000, 50.0000, '', '6', '', 1, 2, '1000001', NULL, NULL, '2019-10-10 05:56:27');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_items`
--

CREATE TABLE `delivery_items` (
  `id` int(11) NOT NULL,
  `delivery_id` int(11) NOT NULL,
  `sale_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery_items`
--

INSERT INTO `delivery_items` (`id`, `delivery_id`, `sale_item_id`, `quantity`) VALUES
(3, 3, 11, 200),
(4, 4, 14, 50),
(5, 4, 15, 50),
(6, 5, 11, 100),
(7, 5, 14, 50);

-- --------------------------------------------------------

--
-- Table structure for table `doors`
--

CREATE TABLE `doors` (
  `id` int(11) NOT NULL,
  `door_number` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:inactive',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:strating, 0;not Starting point , 2:ending door',
  `company_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doors`
--

INSERT INTO `doors` (`id`, `door_number`, `location`, `note`, `status`, `type`, `company_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, 'Door-1', 'Right side of Chimni', 'Test', 1, 1, 1, '1000001', '1000001', '2019-03-12 14:30:08', '2019-03-12 14:53:51'),
(2, 'Door-2', 'Right side of Door-1', NULL, 1, 0, 1, '1000001', '1000001', '2019-03-12 14:32:52', '2019-03-12 14:53:56'),
(3, 'Door-3', 'Right side of Door-2', 'sdfsdf fd', 1, 0, 1, '1000001', '1000001', '2019-03-12 16:02:16', '2019-03-12 16:02:30');

-- --------------------------------------------------------

--
-- Table structure for table `drumstacks`
--

CREATE TABLE `drumstacks` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `drumstacks`
--

INSERT INTO `drumstacks` (`id`, `number`, `location`, `drumstack_id`, `season_id`, `capacity`, `loaded_stock`, `unloaded_stock`, `start_date`, `end_date`, `note`, `status`, `used_date`, `company_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(2, 'DR-0001', 'South-West', NULL, 2, 10000, 4900, 3000, '2019-09-25', NULL, NULL, 1, NULL, 1, NULL, '1000001', '2019-09-25 12:51:32', '2019-09-19 12:34:48'),
(3, 'DR-0002', 'South East', NULL, 2, 10000, 2800, 0, NULL, NULL, NULL, 2, NULL, 1, '1000001', NULL, '2019-09-25 12:57:06', '2019-09-19 18:17:50'),
(4, 'DR-0003', 'South East', NULL, 2, 10000, 0, 0, NULL, NULL, NULL, 3, NULL, 1, '1000001', '1000001', '2019-09-25 12:57:07', '2019-09-19 18:20:54');

-- --------------------------------------------------------

--
-- Table structure for table `emp_increment`
--

CREATE TABLE `emp_increment` (
  `id` bigint(20) NOT NULL,
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
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `emp_infos`
--

CREATE TABLE `emp_infos` (
  `emp_id` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `designation_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `emp_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 = Permanent, 2 = Probetion',
  `is_salary` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT '1' COMMENT '1 = will get salary, 2 = no',
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
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `emp_infos`
--

INSERT INTO `emp_infos` (`emp_id`, `full_name`, `designation_id`, `department_id`, `company_id`, `emp_type`, `is_salary`, `is_bonus`, `address`, `age`, `nid_no`, `photo`, `contact_no`, `email`, `blood_group`, `salary`, `mobile_bill`, `conveyence`, `ta_da`, `bonus`, `special_allowance`, `deduction`, `remarks`, `status`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
('1000001', 'Momit', 10, 1, 1, 1, 1, 1, 'dhora, maria, gabtoli bogura', '32', '34543543741', 'images/employee/20170915_155851.jpg', '01980340482', 'momit.litu@gmail.com', 'B+', 150000.00, 1500.00, 2000.00, 0.00, 80000.00, 1000.00, 0.00, '', 1, NULL, '1000001', '2018-08-07 09:39:13', '2019-01-21 16:30:13'),
('1000002', 'Munif Hasann', 2, 1, 1, 1, 1, 1, '', '', '2347243243', '', '0354378441', 'fg dfg@dfg.dfg', '', 20000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 1, '1000001', '1000001', '2019-03-20 14:40:19', '2019-03-20 17:26:33'),
('EMP-000003', 'Litu Hasan', 5, 1, 1, 1, 1, 1, '', '25', '45645644654', '', '01980340482', 'fcgfcb@fjhf.dfg', '', 30000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 1, '1000001', NULL, '2019-03-20 17:33:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `expense_reference_no`, `expense_date`, `expense_amount`, `expense_type`, `description`, `paid_amount`, `balance`, `status`, `payment_status`, `resposible_person_id`, `company_id`, `season_id`, `attachment`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(8, 'EXP2019/04/000001', '2019-04-06 18:00:00', 600.0000, 1, '', 0.0000, 600.0000, 1, 1, 6, 1, 2, '', '1000001', '1000001', '2019-04-08 10:46:46', '2019-04-07 11:36:15'),
(9, 'EXP2019/10/000001', '2019-10-13 18:00:00', 10000.0000, 1, '', 0.0000, 10000.0000, 1, 1, 6, 1, 2, '', '1000001', NULL, NULL, '2019-10-14 11:36:17');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(11) NOT NULL,
  `expense_cat_name` varchar(200) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active,0:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `expense_cat_name`, `parent_id`, `status`) VALUES
(1, 'Bills', NULL, 1),
(2, 'Electric  Bills', 1, 1),
(3, 'Gas Bills', 1, 1),
(4, 'Palli Electric Bills', 2, 1),
(5, 'PDB Electric Bills', 2, 1),
(6, 'gg', 2, 1),
(7, 'Govt Fees', NULL, 1),
(8, 'Tax', 7, 1),
(9, 'Productiuon Cost', NULL, 1),
(10, 'Soil Expense', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `expense_details`
--

CREATE TABLE `expense_details` (
  `id` int(11) NOT NULL,
  `expense_id` int(11) NOT NULL,
  `expense_head_id` int(11) NOT NULL,
  `amount` varchar(200) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expense_details`
--

INSERT INTO `expense_details` (`id`, `expense_id`, `expense_head_id`, `amount`, `description`) VALUES
(8, 8, 1, '100.00', 'hdgfg'),
(9, 8, 2, '500.00', 'jkhjkhgkjhkkjk'),
(10, 9, 4, '10000.00', '');

-- --------------------------------------------------------

--
-- Table structure for table `expense_heads`
--

CREATE TABLE `expense_heads` (
  `id` int(11) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `expense_head_name` varchar(200) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expense_heads`
--

INSERT INTO `expense_heads` (`id`, `expense_category_id`, `expense_head_name`, `note`, `status`) VALUES
(1, 5, 'Mollabrick PDB electric billl', 'sdfg sfsfsd fsdfsdfdzfdsa fdasfasd', 1),
(2, 4, 'Mollabrick Palli  electric billl', 'sdfg sfsfsd fsdfsdfdzfdsa fdasfasd', 1),
(3, 8, 'Yearly Tax', NULL, 1),
(4, 8, 'Income tax', NULL, 1),
(5, 10, 'Soil Purchase Cost', 'Not Deletable', 1),
(6, 10, 'Soil Carry Truck Fair  ', 'Not Deletable', 1),
(8, 10, 'Land Excevetor Cost', 'Not Deletable', 1);

-- --------------------------------------------------------

--
-- Table structure for table `hrm_departments`
--

CREATE TABLE `hrm_departments` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(50) NOT NULL,
  `dept_head` varchar(20) DEFAULT NULL,
  `display` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 show, 1 hide',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hrm_departments`
--

INSERT INTO `hrm_departments` (`department_id`, `department_name`, `dept_head`, `display`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Admin', '1000001', 0, NULL, '1000001', '2018-08-07 09:45:54', '2018-08-07 11:16:03'),
(2, 'Accounts', '1000001', 0, NULL, NULL, '2018-08-07 09:46:16', NULL),
(3, 'Marketing', NULL, 0, NULL, NULL, '2018-08-07 10:54:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hrm_designations`
--

CREATE TABLE `hrm_designations` (
  `id` int(11) NOT NULL,
  `designation_title` varchar(50) NOT NULL,
  `short_name` varchar(50) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hrm_designations`
--

INSERT INTO `hrm_designations` (`id`, `designation_title`, `short_name`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, 'Executive', 'EX', NULL, '1000001', '2018-08-29 06:49:23', '2018-08-07 09:47:01'),
(2, 'Jr. Officer', 'JO', NULL, NULL, NULL, '2018-08-07 09:46:58'),
(3, 'Sr. Officer', 'SO', NULL, '1000001', '2018-08-07 11:11:59', '2018-08-07 09:47:22'),
(4, 'HR & Admin', 'HR', '1000001', '1000001', '2018-08-07 11:12:54', '2018-08-07 11:12:42'),
(5, 'Manager', 'Restaurant Manager', '1000001', '1000001', '2018-08-29 03:57:51', '2018-08-29 02:55:13'),
(6, 'Cashier', 'Restaurant Cashier', '1000001', NULL, NULL, '2018-08-29 04:00:38'),
(9, 'Chairman', '     Chairman', '1000001', NULL, NULL, '2018-08-29 14:17:56'),
(10, 'Managing Director', 'Managing Director', '1000001', NULL, NULL, '2018-08-29 14:18:12'),
(12, 'Store in-charge', 'Store in-charge', '1000001', NULL, NULL, '2018-08-29 14:18:49'),
(13, 'Sales Officer', 'Sales Officer', '1000001', '1000001', '2018-08-29 14:21:29', '2018-08-29 14:20:24'),
(14, 'Security Guard', 'Security Guard', '1000001', NULL, NULL, '2018-08-29 14:21:38'),
(15, 'Labor', 'Labor', '1000001', NULL, NULL, '2018-08-29 14:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `hrm_leaves`
--

CREATE TABLE `hrm_leaves` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hrm_leave_categories`
--

CREATE TABLE `hrm_leave_categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(20) NOT NULL,
  `day_allow` mediumint(9) NOT NULL,
  `description` text,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hrm_leave_categories`
--

INSERT INTO `hrm_leave_categories` (`id`, `category_name`, `day_allow`, `description`, `created_by`, `modified_by`, `created_at`, `updated_at`) VALUES
(1, 'Casual Leave', 20, '', '1000001', NULL, '2018-08-29 11:21:44', NULL),
(3, 'Special Leave', 10, '', '1000001', NULL, '2018-08-11 05:12:35', NULL),
(5, 'Medical Leave', 15, '', '1000001', NULL, '2018-08-11 05:07:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `category_id`, `item_name`, `brand_name`, `price`, `description`, `is_asset`, `lasting_years`, `salvage_value`, `status`, `company_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(2, 2, 'Auto Mill Belt', NULL, 0.0000, 'sdff,sad fnsa lsdfsdf', 0, 0, 0.0000, 1, NULL, '1000001', NULL, NULL, '2019-03-17 06:33:39'),
(3, 1, 'Auto Mill', 'JKN', 120000.0000, 'fsdgdfg dfgdfgdfgdfgdfg', 1, 5, 10000.0000, 1, 1, '1000001', '1000001', '2019-03-17 07:36:06', '2019-03-17 07:35:15'),
(4, 2, 'Engine Valve', NULL, 500.0000, NULL, 0, 0, 0.0000, 1, NULL, '1000001', NULL, NULL, '2019-03-26 07:29:50');

-- --------------------------------------------------------

--
-- Table structure for table `item_categories`
--

CREATE TABLE `item_categories` (
  `id` int(11) NOT NULL,
  `item_cat_name` varchar(200) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1:active, 2 :in-active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_categories`
--

INSERT INTO `item_categories` (`id`, `item_cat_name`, `parent_id`, `status`) VALUES
(1, 'Machinaries', NULL, 1),
(2, 'Auto Mill Machinaries', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `land_ex_bill`
--

CREATE TABLE `land_ex_bill` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `driver_id` int(11) NOT NULL DEFAULT '0',
  `agreements_id` int(11) NOT NULL,
  `land_ex_id` int(11) NOT NULL,
  `total_hour` double(12,2) NOT NULL DEFAULT '0.00',
  `total_bill` double(12,2) NOT NULL,
  `daily_conv` double(12,2) NOT NULL,
  `deduction` double(12,2) NOT NULL,
  `net_pay` double(12,2) NOT NULL,
  `total_paid` double(12,2) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:running, 0:inactive',
  `billed_by` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `land_ex_bill`
--

INSERT INTO `land_ex_bill` (`id`, `date`, `driver_id`, `agreements_id`, `land_ex_id`, `total_hour`, `total_bill`, `daily_conv`, `deduction`, `net_pay`, `total_paid`, `note`, `status`, `billed_by`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, '2019-08-04', 17, 3, 9, 4.00, 4800.00, 100.00, 400.00, 4400.00, 4400.00, 'This is a test entry', 1, 6, 1, 2, '1000001', '1000001', '2019-11-12 09:08:20', '2019-08-04 13:51:33'),
(2, '2019-11-11', 17, 3, 9, 10.00, 12000.00, 100.00, 100.00, 11900.00, 600.00, NULL, 1, 6, 1, 2, '1000001', NULL, '2019-11-12 09:08:20', '2019-11-11 11:44:30');

-- --------------------------------------------------------

--
-- Table structure for table `load_agreements`
--

CREATE TABLE `load_agreements` (
  `id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `unit_qty` int(11) NOT NULL,
  `rate` double(12,4) DEFAULT NULL,
  `daily_conveynce` double(12,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `load_agreements`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `load_locations`
--

CREATE TABLE `load_locations` (
  `id` int(11) NOT NULL,
  `from_to_to_location_name` varchar(300) DEFAULT NULL,
  `drumstack_id` int(11) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:inactive',
  `company_id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `load_locations`
--

INSERT INTO `load_locations` (`id`, `from_to_to_location_name`, `drumstack_id`, `note`, `status`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(2, 'Bangla mill1 to center khamal', NULL, NULL, 1, 1, 2, '1000001', NULL, '2019-04-24 16:57:35', '2019-04-18 18:08:55'),
(3, 'Bangla mill1 to Drumstack 1', NULL, NULL, 1, 1, 2, '1000001', NULL, '2019-04-24 16:57:37', '2019-04-18 18:08:55'),
(4, 'Bangla mill1 to Drumstack 2', NULL, NULL, 1, 1, 2, '1000001', NULL, '2019-04-24 16:57:39', '2019-04-18 18:08:55'),
(5, 'Drumstack 2 to load', 3, NULL, 1, 1, 2, '1000001', '1000001', '2019-09-20 17:27:02', '2019-04-18 18:08:55'),
(6, 'Drumstack 1 to load', 2, NULL, 1, 1, 2, '1000001', '1000001', '2019-09-20 14:00:57', '2019-04-18 18:08:55'),
(7, 'unload 1st door', NULL, NULL, 1, 1, 2, '1000001', '1000001', '2019-09-22 12:48:05', '2019-04-18 18:08:55'),
(8, 'unload after 1 door right', NULL, NULL, 1, 1, 2, '1000001', '1000001', '2019-09-22 12:48:18', '2019-04-18 18:08:55'),
(9, 'unload after 1 door left', NULL, NULL, 1, 1, 2, '1000001', NULL, '2019-04-24 16:57:51', '2019-04-18 18:08:55'),
(11, 'Unload to West side of the kill', NULL, 'df ghdf gdfgfd fdg dfgfdg  fdg dffdfhgp;iuo', 0, 1, 2, '1000001', '1000001', '2019-04-24 17:04:35', '2019-04-24 16:55:33'),
(12, 'East Auto Mill to East TOMA', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 17:45:40'),
(13, 'East Auto Mill to West TOMA', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 17:45:56'),
(14, 'West Auto Mill to East TOMA', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 17:46:25'),
(15, 'West Auto Mill to West TOMA', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 17:46:38'),
(16, 'South Paka to East Toma', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 18:24:51'),
(17, 'South Paka to WestToma', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 18:25:04'),
(18, 'North Paka to East Toma', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 18:25:26'),
(19, 'North Paka to West Toma', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-16 18:25:43'),
(20, 'East TOMA to Load', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-20 17:26:43'),
(21, 'kill to adhla place', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-23 08:57:19'),
(22, 'East Khamal to load', NULL, NULL, 1, 1, 2, '1000001', NULL, NULL, '2019-09-28 06:15:18');

-- --------------------------------------------------------

--
-- Table structure for table `mills`
--

CREATE TABLE `mills` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mills`
--

INSERT INTO `mills` (`id`, `mill_name`, `capacity`, `current_shardar`, `company_id`, `type`, `status`, `note`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(2, 'East Auto Mill', '20000', NULL, 1, 1, 1, 'Test', '1000001', '1000001', '2019-03-11 17:35:05', '2019-03-11 17:35:05'),
(3, 'West Auto Mill', '25000', NULL, 1, 1, 1, NULL, '1000001', NULL, '2019-03-12 12:50:16', '2019-03-12 12:50:16'),
(4, 'Bangla Mill 1', '20000', NULL, 1, 2, 1, NULL, '1000001', '1000001', '2019-03-12 13:14:03', '2019-03-12 13:14:03');

-- --------------------------------------------------------

--
-- Table structure for table `pay_salary_sheet_details`
--

CREATE TABLE `pay_salary_sheet_details` (
  `id` bigint(20) NOT NULL,
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
  `absent` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pay_salary_sheet_main`
--

CREATE TABLE `pay_salary_sheet_main` (
  `SALARY_SHEET_ID` bigint(20) NOT NULL,
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
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `peoples`
--

CREATE TABLE `peoples` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `peoples`
--

INSERT INTO `peoples` (`id`, `id_number`, `name`, `address`, `mobile_no`, `alt_mobile_no`, `email`, `type`, `status`, `team_leader`, `team_name`, `team_member_no`, `lex_capacity`, `truck_capacity`, `note`, `photo`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(2, 'EMP-000001', 'dfg gdfg', 'dfgdfg', '2147483647', NULL, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-03-06 15:04:02', '2019-03-06 15:36:08'),
(4, 'SOL-000001', 'Soil Brocker', '', '4564654564', '456544546', 'sdfsdf@fghfg.fghg', 3, 1, 0, 0, 10, NULL, NULL, 'hf hghfhgh', '', '1000001', '1000001', '2019-03-11 10:01:26', '2019-03-11 10:04:09'),
(5, 'LND-000001', 'Land owner1', '', '35355454', '', '', 2, 1, 0, 0, 0, NULL, NULL, '', NULL, '1000001', '1000001', '2019-03-11 10:24:57', '2019-03-11 10:30:13'),
(6, 'EMP-000002', 'Munif Hasan', '', '0354378441', NULL, 'fg dfg@dfg.dfg', 1, 1, 0, NULL, NULL, NULL, NULL, '', '', '1000001', NULL, '2019-03-20 14:43:20', '2019-03-20 14:40:19'),
(7, 'EMP-000003', 'Litu Hasan', '', '01980340482', NULL, 'fcgfcb@fjhf.dfg', 1, 1, 0, NULL, NULL, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-03-20 17:33:11'),
(8, 'SUP-000001', 'Mamun', '', '35435454', '', '', 9, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-03-23 17:49:45'),
(9, 'LEX-000001', 'Land Excavetor', '', '45654445646', '', '', 4, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-04-17 10:45:41'),
(11, 'LOD-000001', 'Load team1', '', '0154545556', '', '', 6, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', '1000001', '2019-09-20 17:24:57', '2019-04-20 06:50:57'),
(12, 'ULD-000001', 'Unload Momit', '', '53454544554', '', '', 8, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-04-20 06:51:10'),
(13, 'SOL-000002', 'Soil brocker 2', '', '456546', '', '', 3, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-04-26 05:27:28'),
(14, 'TDV-000001', 'Truck Driver 1', '', '0454555', '', '', 12, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-07-10 05:35:26'),
(15, 'TDV-000002', 'Truck Driver 2', '', '5644545', '', '', 12, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-07-10 05:35:59'),
(16, 'TDV-000003', 'Truck Driver 3', '', '6547654645', '', '', 12, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-07-10 05:36:20'),
(17, 'TDV-000004', 'Ex-Driver', '', 'dfgfdg', '', '', 12, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, '2019-08-04 05:53:30', '2019-08-04 05:27:20'),
(18, 'KBR-000001', 'Kacha Sardar', '', '0255555655', '', '', 5, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-08-05 16:04:35'),
(19, 'KBR-000002', 'Kacha Sardar 2', '', '64564564565', '', '', 5, 1, 1, 0, 12, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-08-05 16:05:41'),
(20, 'KBR-000003', 'Kacha Team Auto', '', '45645646', '', '', 5, 1, 1, 0, 15, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-08-05 16:06:18'),
(21, 'LOD-000002', 'Toma team 1', '', '5464848', '', '', 6, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-16 17:40:56'),
(22, 'LOD-000003', 'Toma team 2', '', '4564655', '', '', 6, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-16 17:41:19'),
(23, 'LOD-000004', 'Drumstack team1', '', '56456456', '', '', 6, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-19 11:55:12'),
(24, 'LOD-000005', 'Unload team1', '', '6546415', '', '', 6, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-22 12:47:24'),
(25, 'CST-000001', 'Walk In Customer', 'some address', '000000', '', '', 10, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, '2019-09-30 08:13:59', '2019-09-28 07:12:28'),
(26, 'CST-000002', 'Customer2', 'some address2', '654654', '', '', 10, 1, 1, 0, 0, NULL, NULL, '', '', '1000001', NULL, NULL, '2019-09-28 07:17:24'),
(27, 'CST-000003', 'Customer1', '', '444444', '', '', 10, 1, 0, 0, 0, NULL, NULL, '', '', '1000001', '1000001', '2019-09-30 08:14:03', '2019-09-30 08:12:33');

-- --------------------------------------------------------

--
-- Table structure for table `people_type`
--

CREATE TABLE `people_type` (
  `id` int(11) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `people_type` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:in-active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `people_type`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `supplier_id`, `purchase_reference_no`, `purchase_date`, `purchased_by`, `discount`, `labour_bill`, `transport_bill`, `total_bill`, `paid`, `balance`, `payment_status`, `purchase_status`, `possible_payment_date`, `note`, `company_id`, `season_id`, `status`, `attachment`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(7, 8, 'PO2019/04/000001', '2019-04-02', 6, 100.0000, 20.0000, 50.0000, 120470.0000, 0.0000, 120470.0000, 1, 1, NULL, '', 1, 2, 1, '', '1000001', NULL, NULL, '2019-04-02 06:03:22'),
(8, 8, 'PO2019/04/000002', '2019-04-06', 6, 100.0000, 20.0000, 50.0000, 120970.0000, 0.0000, 120970.0000, 1, 1, NULL, '', 1, 2, 1, '', '1000001', '1000001', '2019-04-07 06:49:54', '2019-04-06 07:27:39');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` int(11) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `rate` double(12,4) NOT NULL,
  `quantity` int(11) NOT NULL,
  `received_quantity` int(11) NOT NULL,
  `balance_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `purchase_items`
--

INSERT INTO `purchase_items` (`id`, `purchase_id`, `item_id`, `unit`, `rate`, `quantity`, `received_quantity`, `balance_quantity`) VALUES
(7, 7, 3, 2, 1.0000, 1, 0, 0),
(8, 7, 4, 1, 500.0000, 1, 0, 0),
(11, 8, 3, 2, 120000.0000, 1, 0, 0),
(12, 8, 4, 2, 500.0000, 2, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_receives`
--

CREATE TABLE `purchase_receives` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_receive_items`
--

CREATE TABLE `purchase_receive_items` (
  `id` int(11) NOT NULL,
  `purchase_receive_id` int(11) NOT NULL,
  `purchase_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rounds`
--

CREATE TABLE `rounds` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rounds`
--

INSERT INTO `rounds` (`id`, `round_number`, `company_id`, `season_id`, `load_start_date`, `load_end_date`, `fire_start_date`, `fire_end_date`, `unload_start_date`, `unload_end_date`, `total_loaded`, `total_unloaded`, `total_days`, `total_koyla`, `total_oil`, `total_khori`, `total_charkol`, `note`, `round_status`, `status`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, 'Round-1', 1, 2, '2019-03-13', NULL, NULL, NULL, NULL, NULL, 13900, 3600, NULL, 0, 0, 0, 0, 'dfgdfg dffdgfdgfdg', 1, 1, '1000001', '1000001', '2019-09-28 06:16:43', '2019-03-13 11:48:18');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `customer_id`, `sale_reference_no`, `sale_date`, `total_bill`, `discount`, `labour_bill`, `transport_bill`, `total_amount`, `paid`, `balance`, `payment_status`, `sale_status`, `delivery_address`, `delivery_name`, `delivery_mobile`, `delivery_mobile_alt`, `delivery_type`, `delivery_date`, `note`, `sold_by`, `attachment`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(4, 25, 'SO2019/09/000001', '2019-09-29', 2150.0000, 100.0000, 200.0000, 500.0000, 0.0000, 0.0000, 2150.0000, 1, 1, 'fsd ht hrty', 'Hasan', '5346346315', '', 1, '0000-00-00', '', '6', '', 1, 2, '1000001', '1000001', '2019-10-10 05:47:51', '2019-09-29 09:52:30'),
(5, 26, 'SO2019/09/000002', '2019-09-29', 3350.0000, 100.0000, 200.0000, 50.0000, 0.0000, 0.0000, 3350.0000, 1, 1, 'sfsf', 'momit', '4563456', '565565', 1, '2019-09-30', '', '6', '', 1, 2, '1000001', '1000001', '2019-10-06 10:46:20', '2019-09-29 10:41:45');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `rate` double(12,4) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `item_id`, `unit`, `rate`, `quantity`) VALUES
(11, 5, 2, 2, 8.0000, 400),
(14, 4, 2, 2, 8.0000, 100),
(15, 4, 4, 2, 7.5000, 100);

-- --------------------------------------------------------

--
-- Table structure for table `seasons`
--

CREATE TABLE `seasons` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `seasons`
--

INSERT INTO `seasons` (`id`, `season_name`, `start_date`, `end_date`, `total_days`, `company_id`, `status`, `total_produced_brick`, `total_damage_brick`, `total_costing`, `total_sales`, `estimated_total_brick`, `estimated_damage_brick`, `estimated_costing`, `estimated_sales`, `estimated_per_brick`, `costing_per_brick`, `completation_note`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, '2018-2019', '2018-08-01', NULL, 0, 1, 1, 10000, NULL, NULL, NULL, 0, 0, 0, 0, 0.00, NULL, 'This is  test', '1000001', '1000001', '2019-02-13 14:59:35', '2019-03-12 17:05:41'),
(2, '2019-2020', '2019-07-18', NULL, 0, 1, 1, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0.00, NULL, NULL, '1000001', NULL, '2019-02-13 16:23:29', '2019-02-13 16:23:29');

-- --------------------------------------------------------

--
-- Table structure for table `soil_agreements`
--

CREATE TABLE `soil_agreements` (
  `id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `unit_qty` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `truck_fare` double(12,2) DEFAULT NULL,
  `daily_conveynce` double(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `soil_agreements`
--

INSERT INTO `soil_agreements` (`id`, `agreement_id`, `point_id`, `unit_id`, `unit_qty`, `rate`, `truck_fare`, `daily_conveynce`) VALUES
(7, 4, 6, 8, 1, 1500, 150.00, 100.00),
(8, 4, 5, 8, 1, 1600, 250.00, 100.00),
(9, 9, 7, 8, 1, 1400, 100.00, 100.00),
(10, 9, 8, 8, 1, 1400, 100.00, 100.00);

-- --------------------------------------------------------

--
-- Table structure for table `soil_collection_details`
--

CREATE TABLE `soil_collection_details` (
  `id` int(11) NOT NULL,
  `soil_coll_mst_id` int(11) NOT NULL,
  `truck_id` int(11) NOT NULL,
  `truck_driver_id` int(11) NOT NULL,
  `total_truck_trip` int(11) NOT NULL,
  `total_truck_bill` double(12,2) NOT NULL,
  `conveyance` double(12,2) NOT NULL,
  `deduction` double(12,2) NOT NULL,
  `total_bill` double(12,2) NOT NULL,
  `net_payment` double(12,2) NOT NULL,
  `total_truck_bill_paid` double(12,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active, 0:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `soil_collection_details`
--

INSERT INTO `soil_collection_details` (`id`, `soil_coll_mst_id`, `truck_id`, `truck_driver_id`, `total_truck_trip`, `total_truck_bill`, `conveyance`, `deduction`, `total_bill`, `net_payment`, `total_truck_bill_paid`, `status`) VALUES
(3, 4, 1, 14, 5, 750.00, 500.00, 1.00, 7500.00, 7499.00, 0.00, 1),
(4, 4, 6, 15, 2, 300.00, 200.00, 100.00, 3000.00, 2900.00, 0.00, 1),
(7, 5, 1, 16, 5, 1250.00, 500.00, 100.00, 8000.00, 7900.00, 0.00, 1),
(8, 5, 5, 15, 5, 1250.00, 500.00, 0.00, 8000.00, 8000.00, 1250.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `soil_collection_master`
--

CREATE TABLE `soil_collection_master` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `soil_agreement_point` int(11) NOT NULL,
  `total_trip` int(11) NOT NULL,
  `total_truck_bill` double(12,2) NOT NULL,
  `total_conveyance` double(12,2) NOT NULL,
  `total_bill` double(12,2) NOT NULL,
  `total_deduction` double(12,2) NOT NULL,
  `net_payable` double(12,2) NOT NULL,
  `bill_payable` double(12,2) NOT NULL,
  `total_paid` double(12,2) NOT NULL,
  `total_truck_fair_paid` double(12,2) NOT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 0:inactive',
  `season_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `collected_by` int(11) NOT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `soil_collection_master`
--

INSERT INTO `soil_collection_master` (`id`, `date`, `vendor_id`, `soil_agreement_point`, `total_trip`, `total_truck_bill`, `total_conveyance`, `total_bill`, `total_deduction`, `net_payable`, `bill_payable`, `total_paid`, `total_truck_fair_paid`, `note`, `status`, `season_id`, `company_id`, `collected_by`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(4, '2019-07-12', 4, 6, 7, 1050.00, 700.00, 10500.00, 101.00, 10399.00, 9349.00, 0.00, 0.00, 'this is note', 1, 2, 1, 6, '1000001', '1000001', '2019-11-06 12:32:08', '2019-07-12 08:42:53'),
(5, '2019-07-12', 4, 5, 10, 2500.00, 1000.00, 16000.00, 100.00, 15900.00, 13400.00, 0.00, 1250.00, NULL, 1, 2, 1, 6, '1000001', '1000001', '2019-11-12 09:57:33', '2019-11-02 09:35:28');

-- --------------------------------------------------------

--
-- Table structure for table `soil_points`
--

CREATE TABLE `soil_points` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `soil_points`
--

INSERT INTO `soil_points` (`id`, `point_address`, `vendor_id`, `total_estimated_soil`, `total_actual_soil`, `note`, `point_status`, `status`, `company_id`, `season_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(5, 'Hindupara ', 4, NULL, NULL, NULL, 1, 1, 1, 2, '1000001', NULL, '2019-04-19 05:37:10', '2019-04-19 05:36:03'),
(6, 'Mohishaban', 4, '260', '20', 'sdfv sf ddskljfn flsdjfnlk sdflsdj fsdf sdf', 2, 1, 1, 2, '1000001', '1000001', '2019-04-24 15:55:11', '2019-04-19 05:36:03'),
(7, 'Perir Hut', 13, '', '', NULL, 1, 1, 1, 2, '1000001', NULL, NULL, '2019-04-26 05:29:20'),
(8, 'Shokuntola', 13, '', '', NULL, 1, 1, 1, 2, '1000001', NULL, NULL, '2019-04-26 05:29:51');

-- --------------------------------------------------------

--
-- Table structure for table `trucks`
--

CREATE TABLE `trucks` (
  `id` int(11) NOT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trucks`
--

INSERT INTO `trucks` (`id`, `registration_no`, `owner_name`, `capacity`, `note`, `status`, `type`, `company_id`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, 'Dhaka-La-1234556t', 'Momitt', '5 Ton', 'dfg dfg', 1, 1, 1, '1000001', '1000001', '2019-03-18 16:40:37', '2019-03-17 09:16:27'),
(5, 'Bogra-Ga-1235', 'Hamid Islam', '5 Ton', NULL, 1, 2, 1, '1000001', '1000001', '2019-07-10 05:34:15', '2019-07-10 05:31:20'),
(6, 'Dhaka-045555', 'Mahbub Alam', '5 Ton', NULL, 1, 1, 1, '1000001', NULL, NULL, '2019-07-10 05:34:09');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `unit_name` varchar(100) DEFAULT NULL,
  `short_name` varchar(10) DEFAULT NULL,
  `conversion_rate` double(12,2) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:inactive',
  `created_by` varchar(20) DEFAULT NULL,
  `modified_by` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_name`, `short_name`, `conversion_rate`, `note`, `status`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, 'Kilogram', 'KG', 1000.00, 'asd asddfgdfg dfgdfg ', 1, '1000001', '1000001', '2019-08-06 14:10:07', '2019-03-14 18:09:38'),
(2, 'Pices', 'Pcs', 1.00, NULL, 1, '1000001', NULL, '2019-08-06 14:10:09', '2019-03-29 13:17:11'),
(3, 'Years', 'yrs', 1.00, NULL, 1, '1000001', NULL, '2019-08-06 14:10:12', '2019-04-13 06:41:03'),
(4, 'Days', 'days', 1.00, NULL, 1, '1000001', NULL, '2019-08-06 14:10:13', '2019-04-13 06:41:18'),
(5, 'Hours', 'hrs', NULL, NULL, 1, '1000001', NULL, '2019-04-13 06:43:51', '2019-04-13 06:41:24'),
(6, 'Seasons', 'sns', NULL, NULL, 1, '1000001', NULL, '2019-04-13 06:43:54', '2019-04-13 06:41:47'),
(7, 'Hazar', 'hzr', 1000.00, NULL, 1, '1000001', NULL, '2019-08-06 14:10:26', '2019-04-13 06:43:28'),
(8, 'Truck', 'Truck', 1.00, NULL, 1, '1000001', NULL, '2019-09-23 09:20:16', '2019-04-19 05:34:45'),
(9, 'Van', 'Van', 1.00, NULL, 1, NULL, NULL, '2019-09-23 09:20:15', '2019-08-06 14:10:39'),
(10, 'Cft', '', 1.00, NULL, 1, NULL, NULL, NULL, '2019-09-30 09:12:43');

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) NOT NULL,
  `group_name` varchar(100) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `group_name`, `status`) VALUES
(14, 'Owner', 0),
(21, 'Admin', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_member`
--

CREATE TABLE `user_group_member` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT '0',
  `emp_id` varchar(20) NOT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0: no access ; 1:access'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group_member`
--

INSERT INTO `user_group_member` (`id`, `group_id`, `emp_id`, `status`) VALUES
(1, 14, '1000001', 1),
(2, 21, '1000001', 1),
(5, 14, '1000002', 1),
(6, 21, '1000002', 1),
(7, 14, 'EMP-000003', 1),
(8, 21, 'EMP-000003', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_permission`
--

CREATE TABLE `user_group_permission` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT '0',
  `action_id` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0: Not Permit, 1: Permit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group_permission`
--

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
(458, 21, 147, 0),
(459, 14, 148, 1),
(460, 21, 148, 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_actions`
--

CREATE TABLE `web_actions` (
  `id` int(11) NOT NULL,
  `activity_name` varchar(50) NOT NULL,
  `module_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_actions`
--

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
(147, 'Delivery Billls', 14, 0),
(148, 'Land Excavitor Bill', 14, 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_module`
--

CREATE TABLE `web_module` (
  `id` int(11) NOT NULL,
  `module_name` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_module`
--

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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_head`
--
ALTER TABLE `accounts_head`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `accounts_transection`
--
ALTER TABLE `accounts_transection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `acc_payments`
--
ALTER TABLE `acc_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_acc_payments_companies` (`company_id`),
  ADD KEY `FK_acc_payments_emp_infos` (`created_by`),
  ADD KEY `FK_acc_payments_emp_infos_2` (`modified_by`),
  ADD KEY `FK_acc_payments_peoples` (`paid_to_id`),
  ADD KEY `FK_acc_payments_seasons` (`season_id`),
  ADD KEY `FK_acc_payments_people_type` (`payment_type`),
  ADD KEY `FK_acc_payments_peoples_2` (`paid_by`);

--
-- Indexes for table `acc_receives`
--
ALTER TABLE `acc_receives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_acc_receives_companies` (`company_id`),
  ADD KEY `FK_acc_receives_emp_infos` (`created_by`),
  ADD KEY `FK_acc_receives_emp_infos_2` (`modified_by`),
  ADD KEY `FK_acc_receives_peoples` (`customer_id`),
  ADD KEY `FK_acc_receives_seasons` (`season_id`);

--
-- Indexes for table `adjustment_bricks`
--
ALTER TABLE `adjustment_bricks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_damage_bricks_companies` (`company_id`),
  ADD KEY `FK_damage_bricks_emp_infos` (`created_by`),
  ADD KEY `FK_damage_bricks_emp_infos_2` (`modified_by`),
  ADD KEY `FK_damage_bricks_stock_seasons` (`season_id`);

--
-- Indexes for table `adjustment_details`
--
ALTER TABLE `adjustment_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK5` (`brick_type`);

--
-- Indexes for table `agreements`
--
ALTER TABLE `agreements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `people_id_agreement_type_company_id_season_id` (`people_id`,`agreement_type`,`company_id`,`season_id`,`unit_rate`),
  ADD KEY `FK_agreements_companies` (`company_id`),
  ADD KEY `FK_agreements_emp_infos` (`created_by`),
  ADD KEY `FK_agreements_emp_infos_2` (`modified_by`),
  ADD KEY `FK_agreements_seasons` (`season_id`),
  ADD KEY `FK_agreements_peoples` (`people_id`),
  ADD KEY `FK_agreements_units` (`unit_id`),
  ADD KEY `FK_agreements_peoples_2` (`agreement_by`),
  ADD KEY `FK_agreements_agreement_type` (`agreement_type`);

--
-- Indexes for table `agreement_type`
--
ALTER TABLE `agreement_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appuser`
--
ALTER TABLE `appuser`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `con_user_created_by_fk` (`created_by`),
  ADD KEY `con_user_modified_by_fk` (`modified_by`);

--
-- Indexes for table `brick_stock`
--
ALTER TABLE `brick_stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_brick_stock_companies` (`company_id`),
  ADD KEY `FK_brick_stock_emp_infos` (`created_by`),
  ADD KEY `FK_brick_stock_emp_infos_2` (`modified_by`),
  ADD KEY `FK_brick_stock_seasons` (`season_id`),
  ADD KEY `FK_brick_stock_brick_types` (`brick_type`);

--
-- Indexes for table `brick_types`
--
ALTER TABLE `brick_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_brick_types_emp_infos` (`created_by`),
  ADD KEY `FK_brick_types_emp_infos_2` (`modified_by`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `con_company_name_uk` (`company_name`),
  ADD KEY `FK_created_by` (`created_by`),
  ADD KEY `FK_modified_by` (`modified_by`);

--
-- Indexes for table `daily_fire_status`
--
ALTER TABLE `daily_fire_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_daily_fire_status_companies` (`company_id`),
  ADD KEY `FK_daily_fire_status_emp_infos` (`created_by`),
  ADD KEY `FK_daily_fire_status_emp_infos_2` (`modified_by`),
  ADD KEY `FK_daily_fire_status_peoples` (`party_id`),
  ADD KEY `FK_daily_fire_status_seasons` (`season_id`),
  ADD KEY `FK_daily_fire_status_agreements` (`agreement_id`),
  ADD KEY `FK_daily_fire_status_rounds` (`round_id`);

--
-- Indexes for table `daily_individual_production`
--
ALTER TABLE `daily_individual_production`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_daily_daily_individual_production_companies` (`company_id`),
  ADD KEY `FK_daily_daily_individual_production_emp_infos` (`created_by`),
  ADD KEY `FK_daily_daily_individual_production_emp_infos_2` (`modified_by`),
  ADD KEY `FK_daily_daily_individual_production_peoples` (`lobour_id`),
  ADD KEY `FK_daily_daily_individual_production_seasons` (`season_id`),
  ADD KEY `FK6_van_dr_id` (`van_dr_id`),
  ADD KEY `FK_daily_individual_production_units` (`unit`),
  ADD KEY `FK_daily_individual_production_daily_kacha_production` (`daily_production_mst_id`);

--
-- Indexes for table `daily_kacha_production`
--
ALTER TABLE `daily_kacha_production`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_daily_kacha_production_companies` (`company_id`),
  ADD KEY `FK_daily_kacha_production_emp_infos` (`created_by`),
  ADD KEY `FK_daily_kacha_production_emp_infos_2` (`modified_by`),
  ADD KEY `FK_daily_kacha_production_peoples` (`party_id`),
  ADD KEY `FK_daily_kacha_production_seasons` (`season_id`),
  ADD KEY `FK6` (`agreement_id`),
  ADD KEY `FK_daily_kacha_production_mills` (`mill_id`);

--
-- Indexes for table `daily_load_production`
--
ALTER TABLE `daily_load_production`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_daily_load_production_companies` (`company_id`),
  ADD KEY `FK_daily_load_production_emp_infos` (`created_by`),
  ADD KEY `FK_daily_load_production_emp_infos_2` (`modified_by`),
  ADD KEY `FK_daily_load_production_peoples` (`party_id`),
  ADD KEY `FK_daily_load_production_seasons` (`season_id`),
  ADD KEY `FK_daily_load_production_agreements` (`agreement_id`),
  ADD KEY `FK_daily_load_production_doors` (`door_id`),
  ADD KEY `FK_daily_load_production_rounds` (`round_id`),
  ADD KEY `FK_daily_load_production_peoples_2` (`counted_by`);

--
-- Indexes for table `daily_load_production_details`
--
ALTER TABLE `daily_load_production_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_deleveries_companies` (`company_id`),
  ADD KEY `FK_deleveries_emp_infos` (`created_by`),
  ADD KEY `FK_deleveries_emp_infos_2` (`modified_by`),
  ADD KEY `FK_deleveries_stock_seasons` (`season_id`),
  ADD KEY `FK_deleveries_truck_info` (`truck_id`),
  ADD KEY `FK_deleveries_peoples` (`truck_driver_id`);

--
-- Indexes for table `delivery_items`
--
ALTER TABLE `delivery_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_delevery_items_sales` (`sale_item_id`),
  ADD KEY `FK_delevery_items_deleveries` (`delivery_id`);

--
-- Indexes for table `doors`
--
ALTER TABLE `doors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_doors_companies` (`company_id`),
  ADD KEY `FK_doors_emp_infos` (`created_by`),
  ADD KEY `FK_doors_emp_infos_2` (`modified_by`);

--
-- Indexes for table `drumstacks`
--
ALTER TABLE `drumstacks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_drumstacks_companies` (`company_id`),
  ADD KEY `FK_drumstacks_emp_infos` (`created_by`),
  ADD KEY `FK_drumstacks_emp_infos_2` (`modified_by`),
  ADD KEY `FK_drumstacks_seasons` (`season_id`);

--
-- Indexes for table `emp_increment`
--
ALTER TABLE `emp_increment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UN1_emp_increment` (`new_salary`,`emp_id`),
  ADD KEY `FK1_emp_increment` (`emp_id`),
  ADD KEY `FK2_emp_increment` (`created_by`),
  ADD KEY `FK3_emp_increment` (`old_deg`),
  ADD KEY `FK4_emp_increment` (`new_deg`),
  ADD KEY `FK5_modified_by` (`modified_by`);

--
-- Indexes for table `emp_infos`
--
ALTER TABLE `emp_infos`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `FK1_created_by` (`created_by`),
  ADD KEY `FK2_updated_by` (`modified_by`),
  ADD KEY `FK_emp_infos_hrm_departments` (`department_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expenses_companies` (`company_id`),
  ADD KEY `FK_expenses_emp_infos` (`created_by`),
  ADD KEY `FK_expenses_emp_infos_2` (`modified_by`),
  ADD KEY `FK5_respo` (`resposible_person_id`),
  ADD KEY `FK_expenses_seasons` (`season_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_categories_expense_categories` (`parent_id`);

--
-- Indexes for table `expense_details`
--
ALTER TABLE `expense_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_details_expenses` (`expense_id`),
  ADD KEY `FK_expense_details_expense_heads` (`expense_head_id`);

--
-- Indexes for table `expense_heads`
--
ALTER TABLE `expense_heads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_heads_expense_categories` (`expense_category_id`);

--
-- Indexes for table `hrm_departments`
--
ALTER TABLE `hrm_departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `con_department_uk` (`department_name`),
  ADD KEY `con_dept_head_fk` (`dept_head`),
  ADD KEY `FK2_created_by` (`created_by`),
  ADD KEY `FK3_modified_by` (`modified_by`);

--
-- Indexes for table `hrm_designations`
--
ALTER TABLE `hrm_designations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `designation_title` (`designation_title`),
  ADD KEY `FK1_createtd` (`created_by`),
  ADD KEY `FK2_modified` (`modified_by`);

--
-- Indexes for table `hrm_leaves`
--
ALTER TABLE `hrm_leaves`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UN1_hrm_leaves` (`employee_id`,`end_date`,`start_date`),
  ADD KEY `FK_hrm_leaves_companies` (`company_id`),
  ADD KEY `FK_hrm_leaves_emp_infos_2` (`approve_by`),
  ADD KEY `FK_hrm_leaves_emp_infos_3` (`created_by`),
  ADD KEY `FK_hrm_leaves_emp_infos_4` (`modified_by`);

--
-- Indexes for table `hrm_leave_categories`
--
ALTER TABLE `hrm_leave_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `con_leave_category_name_uk` (`category_name`),
  ADD KEY `FK1_leave_categories` (`created_by`),
  ADD KEY `FK_hrm_leave_categories_emp_infos` (`modified_by`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_damage_items_companies` (`company_id`),
  ADD KEY `FK_damage_items_emp_infos` (`created_by`),
  ADD KEY `FK_damage_items_emp_infos_2` (`modified_by`),
  ADD KEY `FK_items_item_categories` (`category_id`);

--
-- Indexes for table `item_categories`
--
ALTER TABLE `item_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_item_categories_item_categories` (`parent_id`);

--
-- Indexes for table `land_ex_bill`
--
ALTER TABLE `land_ex_bill`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_land_ex_companies` (`company_id`),
  ADD KEY `FK_land_ex_emp_infos` (`created_by`),
  ADD KEY `FK_land_ex_emp_infos_2` (`modified_by`),
  ADD KEY `FK_land_ex_seasons` (`season_id`),
  ADD KEY `FK_land_ex_agreements` (`agreements_id`),
  ADD KEY `FK_land_ex_peoples` (`land_ex_id`);

--
-- Indexes for table `load_agreements`
--
ALTER TABLE `load_agreements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_load_agreements_agreements` (`agreement_id`),
  ADD KEY `FK_load_agreements_load_agreements` (`location_id`);

--
-- Indexes for table `load_locations`
--
ALTER TABLE `load_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_load_locations_companies` (`company_id`),
  ADD KEY `FK_load_locations_emp_infos` (`created_by`),
  ADD KEY `FK_load_locations_emp_infos_2` (`modified_by`),
  ADD KEY `FK_load_locations_seasons` (`season_id`);

--
-- Indexes for table `mills`
--
ALTER TABLE `mills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_seasons_companies` (`company_id`),
  ADD KEY `FK_seasons_emp_infos` (`created_by`),
  ADD KEY `FK_seasons_emp_infos_2` (`modified_by`),
  ADD KEY `FK_mills_peoples` (`current_shardar`);

--
-- Indexes for table `pay_salary_sheet_details`
--
ALTER TABLE `pay_salary_sheet_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_pay_salary_sheet_details_pay_salary_sheet_main` (`salary_sheet_id`),
  ADD KEY `FK_pay_salary_sheet_details_emp_infos` (`emp_id`),
  ADD KEY `FK_pay_salary_sheet_details_hrm_departments` (`dept_id`),
  ADD KEY `FK_pay_salary_sheet_details_companies` (`company_id`);

--
-- Indexes for table `pay_salary_sheet_main`
--
ALTER TABLE `pay_salary_sheet_main`
  ADD PRIMARY KEY (`SALARY_SHEET_ID`),
  ADD UNIQUE KEY `CON_SALARY_SHEET_MAIN_UK` (`SALARY_YEAR`,`SALARY_MONTH`),
  ADD KEY `FK_pay_salary_sheet_main_emp_infos` (`created_by`),
  ADD KEY `FK_pay_salary_sheet_main_emp_infos_2` (`modified_by`),
  ADD KEY `FK_pay_salary_sheet_main_emp_infos_3` (`PREPARED_BY`),
  ADD KEY `FK_pay_salary_sheet_main_companies` (`company_id`);

--
-- Indexes for table `peoples`
--
ALTER TABLE `peoples`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_number` (`id_number`),
  ADD KEY `FK_people_emp_infos` (`created_by`),
  ADD KEY `FK_people_emp_infos_2` (`modified_by`),
  ADD KEY `FK_peoples_people_type` (`type`),
  ADD KEY `FK_peoples_peoples` (`team_name`);

--
-- Indexes for table `people_type`
--
ALTER TABLE `people_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_purchases_companies` (`company_id`),
  ADD KEY `FK_purchases_customer_id` (`supplier_id`),
  ADD KEY `FK_purchases_purchased_by` (`purchased_by`),
  ADD KEY `FK_purchases_emp_infos` (`created_by`),
  ADD KEY `FK_purchases_emp_infos_2` (`modified_by`),
  ADD KEY `FK_purchases_stock_seasons` (`season_id`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_purchase_items_units` (`unit`),
  ADD KEY `FK_purchase_items_purchases` (`purchase_id`),
  ADD KEY `FK_purchase_items_items` (`item_id`);

--
-- Indexes for table `purchase_receives`
--
ALTER TABLE `purchase_receives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_purchase_receives_companies` (`company_id`),
  ADD KEY `FK_purchase_receives_emp_infos` (`created_by`),
  ADD KEY `FK_purchase_receives_emp_infos_2` (`modified_by`),
  ADD KEY `FK_purchase_receives_stock_seasons` (`season_id`);

--
-- Indexes for table `purchase_receive_items`
--
ALTER TABLE `purchase_receive_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_purchase_receive_items_purchase_receives` (`purchase_receive_id`),
  ADD KEY `FK_purchase_receive_items_purchase_items` (`purchase_item_id`);

--
-- Indexes for table `rounds`
--
ALTER TABLE `rounds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_rounds_companies` (`company_id`),
  ADD KEY `FK_rounds_emp_infos` (`created_by`),
  ADD KEY `FK_rounds_emp_infos_2` (`modified_by`),
  ADD KEY `FK_rounds_seasons` (`season_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_sales_companies` (`company_id`),
  ADD KEY `FK_sales_customer_id` (`customer_id`),
  ADD KEY `FK_sales_emp_infos` (`created_by`),
  ADD KEY `FK_sales_emp_infos_2` (`modified_by`),
  ADD KEY `FK_sales_stock_seasons` (`season_id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_sale_items_brick_types` (`item_id`),
  ADD KEY `FK_sale_items_units` (`unit`),
  ADD KEY `FK_sale_items_sales` (`sale_id`);

--
-- Indexes for table `seasons`
--
ALTER TABLE `seasons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_seasons_companies` (`company_id`),
  ADD KEY `FK_seasons_emp_infos` (`created_by`),
  ADD KEY `FK_seasons_emp_infos_2` (`modified_by`);

--
-- Indexes for table `soil_agreements`
--
ALTER TABLE `soil_agreements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_soil_agreements_agreements` (`agreement_id`),
  ADD KEY `FK_soil_agreements_soil_points` (`point_id`);

--
-- Indexes for table `soil_collection_details`
--
ALTER TABLE `soil_collection_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `soil_collection_master`
--
ALTER TABLE `soil_collection_master`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_soil_collection_companies` (`company_id`),
  ADD KEY `FK_soil_collection_emp_infos` (`created_by`),
  ADD KEY `FK_soil_collection_emp_infos_2` (`modified_by`),
  ADD KEY `FK_soil_collection_seasons` (`season_id`),
  ADD KEY `FK_soil_collection_peoples` (`vendor_id`),
  ADD KEY `FK_soil_collection_master_soil_points` (`soil_agreement_point`),
  ADD KEY `FK_soil_collection_master_peoples` (`collected_by`);

--
-- Indexes for table `soil_points`
--
ALTER TABLE `soil_points`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `point_address` (`point_address`),
  ADD KEY `FK_soil_points_companies` (`company_id`),
  ADD KEY `FK_soil_points_emp_infos` (`created_by`),
  ADD KEY `FK_soil_points_emp_infos_2` (`modified_by`),
  ADD KEY `FK_soil_points_peoples` (`vendor_id`),
  ADD KEY `FK_soil_points_seasons` (`season_id`);

--
-- Indexes for table `trucks`
--
ALTER TABLE `trucks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_truck_info_companies` (`company_id`),
  ADD KEY `FK_truck_info_emp_infos` (`created_by`),
  ADD KEY `FK_truck_info_emp_infos_2` (`modified_by`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_units_emp_infos` (`created_by`),
  ADD KEY `FK_units_emp_infos_2` (`modified_by`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group_member`
--
ALTER TABLE `user_group_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Index 2` (`group_id`,`emp_id`),
  ADD KEY `FK_user_group_member_emp_infos` (`emp_id`);

--
-- Indexes for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Index 2` (`group_id`,`action_id`),
  ADD KEY `FK_user_group_permission_web_actions` (`action_id`);

--
-- Indexes for table `web_actions`
--
ALTER TABLE `web_actions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `activity_name_module_id` (`activity_name`,`module_id`),
  ADD KEY `module_id` (`module_id`);

--
-- Indexes for table `web_module`
--
ALTER TABLE `web_module`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_head`
--
ALTER TABLE `accounts_head`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `accounts_transection`
--
ALTER TABLE `accounts_transection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `acc_payments`
--
ALTER TABLE `acc_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `acc_receives`
--
ALTER TABLE `acc_receives`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustment_bricks`
--
ALTER TABLE `adjustment_bricks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `adjustment_details`
--
ALTER TABLE `adjustment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `agreements`
--
ALTER TABLE `agreements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `agreement_type`
--
ALTER TABLE `agreement_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `brick_stock`
--
ALTER TABLE `brick_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=453;

--
-- AUTO_INCREMENT for table `brick_types`
--
ALTER TABLE `brick_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `daily_fire_status`
--
ALTER TABLE `daily_fire_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `daily_individual_production`
--
ALTER TABLE `daily_individual_production`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `daily_kacha_production`
--
ALTER TABLE `daily_kacha_production`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `daily_load_production`
--
ALTER TABLE `daily_load_production`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `daily_load_production_details`
--
ALTER TABLE `daily_load_production_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `delivery_items`
--
ALTER TABLE `delivery_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `doors`
--
ALTER TABLE `doors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `drumstacks`
--
ALTER TABLE `drumstacks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `emp_increment`
--
ALTER TABLE `emp_increment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `expense_details`
--
ALTER TABLE `expense_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `expense_heads`
--
ALTER TABLE `expense_heads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `hrm_departments`
--
ALTER TABLE `hrm_departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hrm_designations`
--
ALTER TABLE `hrm_designations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `hrm_leaves`
--
ALTER TABLE `hrm_leaves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hrm_leave_categories`
--
ALTER TABLE `hrm_leave_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `item_categories`
--
ALTER TABLE `item_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `land_ex_bill`
--
ALTER TABLE `land_ex_bill`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `load_agreements`
--
ALTER TABLE `load_agreements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `load_locations`
--
ALTER TABLE `load_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `mills`
--
ALTER TABLE `mills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pay_salary_sheet_details`
--
ALTER TABLE `pay_salary_sheet_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pay_salary_sheet_main`
--
ALTER TABLE `pay_salary_sheet_main`
  MODIFY `SALARY_SHEET_ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `peoples`
--
ALTER TABLE `peoples`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `people_type`
--
ALTER TABLE `people_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `purchase_receives`
--
ALTER TABLE `purchase_receives`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_receive_items`
--
ALTER TABLE `purchase_receive_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rounds`
--
ALTER TABLE `rounds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `seasons`
--
ALTER TABLE `seasons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `soil_agreements`
--
ALTER TABLE `soil_agreements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `soil_collection_details`
--
ALTER TABLE `soil_collection_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `soil_collection_master`
--
ALTER TABLE `soil_collection_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `soil_points`
--
ALTER TABLE `soil_points`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `trucks`
--
ALTER TABLE `trucks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_group_member`
--
ALTER TABLE `user_group_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=461;

--
-- AUTO_INCREMENT for table `web_actions`
--
ALTER TABLE `web_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `web_module`
--
ALTER TABLE `web_module`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acc_payments`
--
ALTER TABLE `acc_payments`
  ADD CONSTRAINT `FK_acc_payments_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_acc_payments_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_acc_payments_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_acc_payments_people_type` FOREIGN KEY (`payment_type`) REFERENCES `people_type` (`id`),
  ADD CONSTRAINT `FK_acc_payments_peoples` FOREIGN KEY (`paid_to_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_acc_payments_peoples_2` FOREIGN KEY (`paid_by`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_acc_payments_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `acc_receives`
--
ALTER TABLE `acc_receives`
  ADD CONSTRAINT `FK_acc_receives_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_acc_receives_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_acc_receives_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_acc_receives_peoples` FOREIGN KEY (`customer_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_acc_receives_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `adjustment_bricks`
--
ALTER TABLE `adjustment_bricks`
  ADD CONSTRAINT `FK_damage_bricks_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_damage_bricks_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_damage_bricks_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_damage_bricks_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `agreements`
--
ALTER TABLE `agreements`
  ADD CONSTRAINT `FK_agreements_agreement_type` FOREIGN KEY (`agreement_type`) REFERENCES `agreement_type` (`id`),
  ADD CONSTRAINT `FK_agreements_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_agreements_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_agreements_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_agreements_peoples` FOREIGN KEY (`people_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_agreements_peoples_2` FOREIGN KEY (`agreement_by`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_agreements_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  ADD CONSTRAINT `FK_agreements_units` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `brick_stock`
--
ALTER TABLE `brick_stock`
  ADD CONSTRAINT `FK_brick_stock_brick_types` FOREIGN KEY (`brick_type`) REFERENCES `brick_types` (`id`),
  ADD CONSTRAINT `FK_brick_stock_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_brick_stock_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_brick_stock_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_brick_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `brick_types`
--
ALTER TABLE `brick_types`
  ADD CONSTRAINT `FK_brick_types_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_brick_types_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `FK_created_by` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `daily_fire_status`
--
ALTER TABLE `daily_fire_status`
  ADD CONSTRAINT `FK_daily_fire_status_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  ADD CONSTRAINT `FK_daily_fire_status_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_daily_fire_status_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_daily_fire_status_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_daily_fire_status_peoples` FOREIGN KEY (`party_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_daily_fire_status_rounds` FOREIGN KEY (`round_id`) REFERENCES `rounds` (`id`),
  ADD CONSTRAINT `FK_daily_fire_status_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `daily_individual_production`
--
ALTER TABLE `daily_individual_production`
  ADD CONSTRAINT `FK6_van_dr_id` FOREIGN KEY (`van_dr_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_daily_daily_individual_production_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_daily_daily_individual_production_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_daily_daily_individual_production_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_daily_daily_individual_production_peoples` FOREIGN KEY (`lobour_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_daily_daily_individual_production_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  ADD CONSTRAINT `FK_daily_individual_production_daily_kacha_production` FOREIGN KEY (`daily_production_mst_id`) REFERENCES `daily_kacha_production` (`id`),
  ADD CONSTRAINT `FK_daily_individual_production_units` FOREIGN KEY (`unit`) REFERENCES `units` (`id`);

--
-- Constraints for table `daily_kacha_production`
--
ALTER TABLE `daily_kacha_production`
  ADD CONSTRAINT `FK6` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  ADD CONSTRAINT `FK_daily_kacha_production_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_daily_kacha_production_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_daily_kacha_production_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_daily_kacha_production_mills` FOREIGN KEY (`mill_id`) REFERENCES `mills` (`id`),
  ADD CONSTRAINT `FK_daily_kacha_production_peoples` FOREIGN KEY (`party_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_daily_kacha_production_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `daily_load_production`
--
ALTER TABLE `daily_load_production`
  ADD CONSTRAINT `FK_daily_load_production_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  ADD CONSTRAINT `FK_daily_load_production_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_daily_load_production_doors` FOREIGN KEY (`door_id`) REFERENCES `doors` (`id`),
  ADD CONSTRAINT `FK_daily_load_production_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_daily_load_production_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_daily_load_production_peoples` FOREIGN KEY (`party_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_daily_load_production_peoples_2` FOREIGN KEY (`counted_by`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_daily_load_production_rounds` FOREIGN KEY (`round_id`) REFERENCES `rounds` (`id`),
  ADD CONSTRAINT `FK_daily_load_production_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `FK_deleveries_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_deleveries_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_deleveries_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_deleveries_peoples` FOREIGN KEY (`truck_driver_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_deleveries_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  ADD CONSTRAINT `FK_deleveries_truck_info` FOREIGN KEY (`truck_id`) REFERENCES `trucks` (`id`);

--
-- Constraints for table `delivery_items`
--
ALTER TABLE `delivery_items`
  ADD CONSTRAINT `FK_delevery_items_deleveries` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`),
  ADD CONSTRAINT `FK_delevery_items_sales` FOREIGN KEY (`sale_item_id`) REFERENCES `sale_items` (`id`);

--
-- Constraints for table `doors`
--
ALTER TABLE `doors`
  ADD CONSTRAINT `FK_doors_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_doors_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_doors_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `drumstacks`
--
ALTER TABLE `drumstacks`
  ADD CONSTRAINT `FK_drumstacks_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_drumstacks_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_drumstacks_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_drumstacks_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `emp_increment`
--
ALTER TABLE `emp_increment`
  ADD CONSTRAINT `FK1_emp_increment` FOREIGN KEY (`emp_id`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK2_emp_increment` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK3_emp_increment` FOREIGN KEY (`old_deg`) REFERENCES `hrm_designations` (`id`),
  ADD CONSTRAINT `FK4_emp_increment` FOREIGN KEY (`new_deg`) REFERENCES `hrm_designations` (`id`),
  ADD CONSTRAINT `FK5_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `emp_infos`
--
ALTER TABLE `emp_infos`
  ADD CONSTRAINT `FK1_created_by` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK2_updated_by` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `FK5_respo` FOREIGN KEY (`resposible_person_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_expenses_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_expenses_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_expenses_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_expenses_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `FK_expense_categories_expense_categories` FOREIGN KEY (`parent_id`) REFERENCES `expense_categories` (`id`);

--
-- Constraints for table `expense_details`
--
ALTER TABLE `expense_details`
  ADD CONSTRAINT `FK_expense_details_expense_heads` FOREIGN KEY (`expense_head_id`) REFERENCES `expense_heads` (`id`),
  ADD CONSTRAINT `FK_expense_details_expenses` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`);

--
-- Constraints for table `expense_heads`
--
ALTER TABLE `expense_heads`
  ADD CONSTRAINT `FK_expense_heads_expense_categories` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`);

--
-- Constraints for table `hrm_departments`
--
ALTER TABLE `hrm_departments`
  ADD CONSTRAINT `FK2_created_by` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK3_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `con_dept_head_fk` FOREIGN KEY (`dept_head`) REFERENCES `emp_infos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `hrm_designations`
--
ALTER TABLE `hrm_designations`
  ADD CONSTRAINT `FK1_createtd` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK2_modified` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `hrm_leaves`
--
ALTER TABLE `hrm_leaves`
  ADD CONSTRAINT `FK_hrm_leaves_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_hrm_leaves_emp_infos` FOREIGN KEY (`employee_id`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_hrm_leaves_emp_infos_2` FOREIGN KEY (`approve_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_hrm_leaves_emp_infos_3` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_hrm_leaves_emp_infos_4` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `hrm_leave_categories`
--
ALTER TABLE `hrm_leave_categories`
  ADD CONSTRAINT `FK1_leave_categories` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_hrm_leave_categories_emp_infos` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `FK_damage_items_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_damage_items_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_damage_items_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_items_item_categories` FOREIGN KEY (`category_id`) REFERENCES `item_categories` (`id`);

--
-- Constraints for table `item_categories`
--
ALTER TABLE `item_categories`
  ADD CONSTRAINT `FK_item_categories_item_categories` FOREIGN KEY (`parent_id`) REFERENCES `item_categories` (`id`);

--
-- Constraints for table `land_ex_bill`
--
ALTER TABLE `land_ex_bill`
  ADD CONSTRAINT `FK_land_ex_agreements` FOREIGN KEY (`agreements_id`) REFERENCES `agreements` (`id`),
  ADD CONSTRAINT `FK_land_ex_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_land_ex_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_land_ex_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_land_ex_peoples` FOREIGN KEY (`land_ex_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_land_ex_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `load_agreements`
--
ALTER TABLE `load_agreements`
  ADD CONSTRAINT `FK_load_agreements_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  ADD CONSTRAINT `FK_load_agreements_load_agreements` FOREIGN KEY (`location_id`) REFERENCES `load_locations` (`id`);

--
-- Constraints for table `load_locations`
--
ALTER TABLE `load_locations`
  ADD CONSTRAINT `FK_load_locations_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_load_locations_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_load_locations_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_load_locations_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `mills`
--
ALTER TABLE `mills`
  ADD CONSTRAINT `FK_mills_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_mills_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_mills_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_mills_peoples` FOREIGN KEY (`current_shardar`) REFERENCES `peoples` (`id`);

--
-- Constraints for table `pay_salary_sheet_details`
--
ALTER TABLE `pay_salary_sheet_details`
  ADD CONSTRAINT `FK_pay_salary_sheet_details_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_pay_salary_sheet_details_emp_infos` FOREIGN KEY (`emp_id`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_pay_salary_sheet_details_hrm_departments` FOREIGN KEY (`dept_id`) REFERENCES `hrm_departments` (`department_id`),
  ADD CONSTRAINT `FK_pay_salary_sheet_details_pay_salary_sheet_main` FOREIGN KEY (`salary_sheet_id`) REFERENCES `pay_salary_sheet_main` (`SALARY_SHEET_ID`);

--
-- Constraints for table `pay_salary_sheet_main`
--
ALTER TABLE `pay_salary_sheet_main`
  ADD CONSTRAINT `FK_pay_salary_sheet_main_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_pay_salary_sheet_main_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_pay_salary_sheet_main_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_pay_salary_sheet_main_emp_infos_3` FOREIGN KEY (`PREPARED_BY`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `peoples`
--
ALTER TABLE `peoples`
  ADD CONSTRAINT `FK_people_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_people_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_peoples_people_type` FOREIGN KEY (`type`) REFERENCES `people_type` (`id`);

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `FK_purchases_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_purchases_customer_id` FOREIGN KEY (`supplier_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_purchases_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_purchases_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_purchases_purchased_by` FOREIGN KEY (`purchased_by`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_purchases_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `FK_purchase_items_items` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `FK_purchase_items_purchases` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  ADD CONSTRAINT `FK_purchase_items_units` FOREIGN KEY (`unit`) REFERENCES `units` (`id`);

--
-- Constraints for table `purchase_receives`
--
ALTER TABLE `purchase_receives`
  ADD CONSTRAINT `FK_purchase_receives_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_purchase_receives_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_purchase_receives_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_purchase_receives_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `purchase_receive_items`
--
ALTER TABLE `purchase_receive_items`
  ADD CONSTRAINT `FK_purchase_receive_items_purchase_items` FOREIGN KEY (`purchase_item_id`) REFERENCES `purchase_items` (`id`),
  ADD CONSTRAINT `FK_purchase_receive_items_purchase_receives` FOREIGN KEY (`purchase_receive_id`) REFERENCES `purchase_receives` (`id`);

--
-- Constraints for table `rounds`
--
ALTER TABLE `rounds`
  ADD CONSTRAINT `FK_rounds_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_rounds_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_rounds_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_rounds_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `FK_sales_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_sales_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_sales_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_sales_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_sales_stock_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `FK_sale_items_brick_types` FOREIGN KEY (`item_id`) REFERENCES `brick_types` (`id`),
  ADD CONSTRAINT `FK_sale_items_sales` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  ADD CONSTRAINT `FK_sale_items_units` FOREIGN KEY (`unit`) REFERENCES `units` (`id`);

--
-- Constraints for table `seasons`
--
ALTER TABLE `seasons`
  ADD CONSTRAINT `FK_seasons_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_seasons_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_seasons_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `soil_agreements`
--
ALTER TABLE `soil_agreements`
  ADD CONSTRAINT `FK_soil_agreements_agreements` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`),
  ADD CONSTRAINT `FK_soil_agreements_soil_points` FOREIGN KEY (`point_id`) REFERENCES `soil_points` (`id`);

--
-- Constraints for table `soil_collection_master`
--
ALTER TABLE `soil_collection_master`
  ADD CONSTRAINT `FK_soil_collection_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_soil_collection_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_soil_collection_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_soil_collection_master_peoples` FOREIGN KEY (`collected_by`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_soil_collection_master_soil_points` FOREIGN KEY (`soil_agreement_point`) REFERENCES `soil_points` (`id`),
  ADD CONSTRAINT `FK_soil_collection_peoples` FOREIGN KEY (`vendor_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_soil_collection_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `soil_points`
--
ALTER TABLE `soil_points`
  ADD CONSTRAINT `FK_soil_points_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_soil_points_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_soil_points_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_soil_points_peoples` FOREIGN KEY (`vendor_id`) REFERENCES `peoples` (`id`),
  ADD CONSTRAINT `FK_soil_points_seasons` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`);

--
-- Constraints for table `trucks`
--
ALTER TABLE `trucks`
  ADD CONSTRAINT `FK_truck_info_companies` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`),
  ADD CONSTRAINT `FK_truck_info_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_truck_info_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `FK_units_emp_infos` FOREIGN KEY (`created_by`) REFERENCES `emp_infos` (`emp_id`),
  ADD CONSTRAINT `FK_units_emp_infos_2` FOREIGN KEY (`modified_by`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `user_group_member`
--
ALTER TABLE `user_group_member`
  ADD CONSTRAINT `FK_user_group_member_emp_infos` FOREIGN KEY (`emp_id`) REFERENCES `emp_infos` (`emp_id`);

--
-- Constraints for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  ADD CONSTRAINT `FK_user_group_permission_user_group` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  ADD CONSTRAINT `FK_user_group_permission_web_actions` FOREIGN KEY (`action_id`) REFERENCES `web_actions` (`id`);
--
-- Database: `burritobrothers_db`
--
CREATE DATABASE IF NOT EXISTS `burritobrothers_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `burritobrothers_db`;

-- --------------------------------------------------------

--
-- Table structure for table `appuser`
--

CREATE TABLE `appuser` (
  `user_id` varchar(12) NOT NULL DEFAULT '',
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `user_password` varchar(40) DEFAULT NULL,
  `user_level` varchar(10) NOT NULL DEFAULT 'General' COMMENT 'Admin,Developer,General',
  `login_status` tinyint(4) DEFAULT '0' COMMENT '1=login; 0=not login;',
  `is_active` int(1) NOT NULL DEFAULT '1' COMMENT '1=Active,0=Blocked',
  `modified_by` varchar(20) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appuser`
--

INSERT INTO `appuser` (`user_id`, `user_name`, `user_password`, `user_level`, `login_status`, `is_active`, `modified_by`, `modified_time`, `created_by`) VALUES
('1000001', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'ROLE_USER', 0, 1, NULL, NULL, '1000001'),
('1000002', 'kajol', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 1, NULL, NULL, '1000002'),
('1000003', 'jahed', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 0, NULL, NULL, '1000001'),
('1000004', 'biplob', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 0, NULL, NULL, '1000001');

-- --------------------------------------------------------

--
-- Table structure for table `banner_image`
--

CREATE TABLE `banner_image` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text,
  `photo` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2 in-active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `banner_image`
--

INSERT INTO `banner_image` (`id`, `title`, `text`, `photo`, `status`) VALUES
(29, 'Banner3', 'Savory/Pastry/Cake/Coffee/Cookies/Bread', 'images/banner/3.jpg', 1),
(36, 'banner4', 'Brownie', 'images/banner/8.jpg', 1),
(37, 'Banner2', 'Makeup kit', 'images/banner/Mac Structured Cake.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `code`, `name`, `parent_id`, `photo`, `status`) VALUES
(25, '0001', 'Bakary', NULL, 'images/no_image.png', 1),
(26, '0002', 'Burger', NULL, 'images/no_image.png', 1),
(27, '0003', 'Pizza', NULL, 'images/no_image.png', 1),
(28, '0004', 'Noodlse', NULL, 'images/no_image.png', 1),
(29, '0005', 'Pasta', NULL, 'images/no_image.png', 1),
(30, '0006', 'Fry Item', NULL, 'images/no_image.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cupons`
--

CREATE TABLE `cupons` (
  `id` int(11) NOT NULL,
  `cupon_no` varchar(100) NOT NULL,
  `c_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: flat_rate; 2:percentage_rate',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL,
  `amount` float(10,2) DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active; 0:In-Active',
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cupons`
--

INSERT INTO `cupons` (`id`, `cupon_no`, `c_type`, `start_date`, `end_date`, `entry_date`, `amount`, `status`, `customer_id`) VALUES
(1, '1111', 1, '2017-10-02 17:30:20', '2019-10-02 17:30:24', '2018-10-02 17:30:28', 100.00, 1, NULL),
(2, '2222', 2, '2017-10-02 17:30:20', '2019-10-02 17:30:24', '2018-10-02 17:30:28', 10.00, 1, NULL),
(3, '444', 1, '2018-11-08 00:00:00', '2019-02-07 00:00:00', '2019-03-21 00:00:00', 33.00, 1, 1),
(4, '123321', 2, '2018-08-27 00:00:00', '2019-02-14 00:00:00', '2018-11-20 00:00:00', 10.00, 1, 0),
(5, '55555', 1, '2018-06-03 00:00:00', '2019-04-26 00:00:00', '0000-00-00 00:00:00', 55.00, 1, 8),
(6, '2018', 1, '2018-11-22 00:00:00', '2018-11-22 00:00:00', '2018-11-22 00:00:00', 100.00, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_infos`
--

CREATE TABLE `customer_infos` (
  `customer_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `address` text NOT NULL,
  `age` date NOT NULL,
  `photo` varchar(100) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `remarks` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  0: inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_infos`
--

INSERT INTO `customer_infos` (`customer_id`, `full_name`, `username`, `password`, `address`, `age`, `photo`, `contact_no`, `email`, `remarks`, `status`) VALUES
(1, 'Moynul Hasan Momit', 'momit', 'e10adc3949ba59abbe56e057f20f883e', 'aaaaaaaaaaa', '0000-00-00', 'images/customer/momit.jpg', '012100000', 'momit.litu@gmail.com', 'aaaaaaaaaaaa', 1),
(2, 'MUntakim Hasan', 'munif', 'e10adc3949ba59abbe56e057f20f883e', 'aaaaaaaaaaaaaaaa', '0000-00-00', 'images/customer/1537339731jahed.jpg', '012554455', 'munif.litu@gmail.com', 'aaaaaaaaaaaaaaa', 1),
(5, 'hasan', 'hasan', 'e10adc3949ba59abbe56e057f20f883e', 's sfdf,sdf ,sdfsd,dsf,', '0000-00-00', '', '01980340482', 'momi.df@gmaad.com', NULL, 1),
(6, 'muntakim', 'muntakim', 'e10adc3949ba59abbe56e057f20f883e', 'sgfsf sdfdsfdfdsfs', '0000-00-00', '', '0198034082', 'm.k@gmail.com', NULL, 1),
(7, 'Mir Abu Sayef', 'M.A Sayef', 'e10adc3949ba59abbe56e057f20f883e', 'Mohammadpur, Chanmia Housing, 41/10, Road # 1, 5-A. Dhaka - 1207', '0000-00-00', '', '01630325935', 'mirabu.sayef@yahoo.com', NULL, 1),
(8, 'Shabir Alkama', 'Shabir', 'e10adc3949ba59abbe56e057f20f883e', 'Mohammadpur, Chanmia Housing, 41/10, Road # 1, 5-A. Dhaka - 1207', '0000-00-00', '', '01133', 'Shabiralkama@gmail.com', NULL, 1),
(9, 'Anika Thasin', 'Anika', '827ccb0eea8a706c4c34a16891f84e7b', 'House-463, Road-31, Mohakhali Dohs', '0000-00-00', '', '01779574169', 'anikathasin.tonni@gmail.com', NULL, 1),
(10, 'shabir', 'Alkama', 'addcec5c2816e7b9277a56b3b1f12a96', 'H# 1/B, R# 11, Nikunja-2, Khilkhet, Dhaka 1229', '0000-00-00', '', '01712341127', 'shabiralkama_5700@yahoo.com', NULL, 1),
(11, 'Nazmul', 'Nazmul Ahsan', '25f9e794323b453885f5181f1b624d0b', 'Dhaka', '0000-00-00', '', '01613313666', 'it@nafisagroup.com', NULL, 1),
(12, 'mmmmomit', 'mmmmomit', 'e10adc3949ba59abbe56e057f20f883e', '', '0000-00-00', '', '0198034045', 'm.k@gmail.com', NULL, 1),
(13, 'Walk In Customer', NULL, NULL, 'no address', '0000-00-00', 'images/no_image.png', '456456464', '', '', 1),
(14, 'POS Customer', NULL, NULL, 'dfgdgdfg', '0000-00-00', 'images/no_image.png', '45645646', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `custom_cake`
--

CREATE TABLE `custom_cake` (
  `id` int(11) NOT NULL,
  `cc_cake_weight` varchar(50) DEFAULT NULL,
  `cc_cake_tyre` tinyint(1) DEFAULT NULL,
  `cc_delevery_date` datetime DEFAULT NULL,
  `cc_details` text NOT NULL,
  `cc_name` varchar(200) NOT NULL,
  `cc_email` varchar(200) NOT NULL,
  `cc_mobile` varchar(20) NOT NULL,
  `cc_image` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:not seen, 2:seen, 3:varified',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active, 0: Deleted',
  `varified_by` varchar(20) DEFAULT NULL,
  `varified_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remarks` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `custom_cake`
--

INSERT INTO `custom_cake` (`id`, `cc_cake_weight`, `cc_cake_tyre`, `cc_delevery_date`, `cc_details`, `cc_name`, `cc_email`, `cc_mobile`, `cc_image`, `status`, `active`, `varified_by`, `varified_time`, `remarks`) VALUES
(1, '0', 0, '2018-11-13 12:00:00', 'sdf sdf', 'sdf ', 'sdfs', '45435', 'images/custom/momit_singara.jpg', 2, 1, NULL, '2018-11-15 10:51:19', NULL),
(2, '0', 0, '2018-11-25 12:00:00', 'hhhhhhhh', 'Mir Abu Sayef', 'mirabu.sayef@yahoo.com', '01630325935', 'images/custom/kit.jpg', 2, 1, NULL, '2018-11-25 17:01:12', NULL),
(3, '3', 0, '2018-11-25 12:00:00', 'rectangular', 'shabir', 'shabiralkama@gmail.com', '01712341127', 'images/custom/8.jpg', 3, 1, '1000001', '2018-11-25 17:57:53', ''),
(4, '', 1, '2018-11-29 03:30:00', 'Write up : happy birthday', 'shabir', 'shabiralkama@gmail.com', '01712341127', 'images/custom/5.jpg', 1, 1, NULL, NULL, NULL),
(5, '5', 3, '2018-11-29 12:00:00', 'from momit', 'momit', 'momit.litu@gmails.com', '654541', 'images/no_image.png', 1, 1, NULL, NULL, NULL),
(6, '', 0, '2018-12-03 12:00:00', 'square', 'happy birthday to sumaiya', 'shabiralkama@gmail.com', 'shabir', 'images/custom/15438304268.jpg', 1, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_charge`
--

CREATE TABLE `delivery_charge` (
  `id` int(11) NOT NULL,
  `type` varchar(200) NOT NULL,
  `rate` float(8,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active, 0: inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery_charge`
--

INSERT INTO `delivery_charge` (`id`, `type`, `rate`, `status`) VALUES
(1, 'Inside  Dhaka', 100.00, 1),
(2, 'Outside Dhaka', 250.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `expense_reference_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `expense_date` date DEFAULT NULL,
  `expense_amount` double(12,4) NOT NULL,
  `expense_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:cash, 2:credit',
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `paid_amount` double(12,4) NOT NULL DEFAULT '0.0000',
  `balance` double(12,4) NOT NULL DEFAULT '0.0000',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,0: Deleted',
  `payment_status` tinyint(1) DEFAULT '1' COMMENT '1:due, 2:partialy paid,3:paid',
  `attachment` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `expense_reference_no`, `expense_date`, `expense_amount`, `expense_type`, `description`, `paid_amount`, `balance`, `status`, `payment_status`, `attachment`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, 'EXP2019/10/000001', '2019-10-24', 300.0000, 1, 'Electric bill of November', 0.0000, 300.0000, 1, NULL, '', '1000001', '1000001', '2019-11-02 18:13:45', '2019-10-24 14:56:24');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(11) NOT NULL,
  `expense_cat_name` varchar(200) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active,0:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `expense_cat_name`, `parent_id`, `status`) VALUES
(1, 'Bills', NULL, 1),
(2, 'Electric  Bills', 1, 1),
(3, 'Gas Bills', 1, 1),
(4, 'Palli Electric Bills', 2, 1),
(5, 'PDB Electric Bills', 2, 1),
(6, 'gg', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `expense_details`
--

CREATE TABLE `expense_details` (
  `id` int(11) NOT NULL,
  `expense_id` int(11) NOT NULL,
  `expense_head_id` int(11) NOT NULL,
  `amount` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `expense_details`
--

INSERT INTO `expense_details` (`id`, `expense_id`, `expense_head_id`, `amount`, `description`) VALUES
(10, 1, 1, '200.00', ''),
(11, 1, 2, '100.00', '');

-- --------------------------------------------------------

--
-- Table structure for table `expense_heads`
--

CREATE TABLE `expense_heads` (
  `id` int(11) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `expense_head_name` varchar(200) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expense_heads`
--

INSERT INTO `expense_heads` (`id`, `expense_category_id`, `expense_head_name`, `note`, `status`) VALUES
(1, 5, 'Mollabrick PDB electric billl', 'sdfg sfsfsd fsdfsdfdzfdsa fdasfasd', 1),
(2, 4, 'Mollabrick Palli  electric billl', 'sdfg sfsfsd fsdfsdfdzfdsa fdasfasd', 1);

-- --------------------------------------------------------

--
-- Table structure for table `external_contact`
--

CREATE TABLE `external_contact` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `organization` varchar(50) NOT NULL DEFAULT '0',
  `designation` varchar(50) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL DEFAULT '0',
  `mobile_no` varchar(50) NOT NULL DEFAULT '0',
  `created_by` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `external_contact`
--

INSERT INTO `external_contact` (`id`, `name`, `organization`, `designation`, `email`, `mobile_no`, `created_by`) VALUES
(2, 'Rony Talukdar', 'ABC', 'ABC', 'fdsgsdfg', '454235345', '1000001'),
(3, 'ABC', 'ewgvsdagdf', 'btgfewft', 'wrewtgfvdv', '32424', '1000001');

-- --------------------------------------------------------

--
-- Table structure for table `gallary_images`
--

CREATE TABLE `gallary_images` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `album_id` int(11) NOT NULL DEFAULT '0',
  `attachment` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallary_images`
--

INSERT INTO `gallary_images` (`id`, `title`, `album_id`, `attachment`) VALUES
(52, 'cake', 23, '36.jpg'),
(53, 'cake', 23, '32.jpg'),
(54, 'Pizza Bun', 21, '2.jpg'),
(55, 'Mini Chicken Burger', 21, '8.jpg'),
(56, 'Sausage Delight', 21, '3.jpg'),
(58, 'cake', 23, '38.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `image_album`
--

CREATE TABLE `image_album` (
  `id` int(11) NOT NULL,
  `album_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image_album`
--

INSERT INTO `image_album` (`id`, `album_name`) VALUES
(21, 'Food'),
(22, 'Outlet'),
(23, 'Decorated Cake');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

CREATE TABLE `ingredient` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `photo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredient`
--

INSERT INTO `ingredient` (`id`, `code`, `name`, `photo`) VALUES
(4, '10002', 'Eggs', 'images/no_image.png'),
(7, '10005', 'Milk', 'images/no_image.png'),
(8, '10007', 'Suger', 'images/no_image.png'),
(11, '10009', 'Butter', 'images/no_image.png'),
(15, '10013', 'Cheese', 'images/no_image.png'),
(16, '10014', 'Chocolate', 'images/no_image.png'),
(17, '10015', 'Dark Chocolate', 'images/no_image.png'),
(24, '10022', 'Chicken', 'images/no_image.png'),
(26, '10024', 'Vegetable', 'images/no_image.png'),
(29, '10001', 'Beef', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_rate` float(8,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  2: canceled '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `size_id`, `unit_id`, `quantity`, `product_rate`, `status`) VALUES
(66, 30, 1, 7, 3, 1, 1720.00, 1),
(67, 30, 2, 1, 3, 12, 150.00, 1),
(68, 30, 1, 500, 3, 1, 1720.00, 1),
(69, 30, 2, 0, 3, 12, 150.00, 1),
(70, 30, 1, 7, 3, 3, 1720.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_master`
--

CREATE TABLE `order_master` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` datetime DEFAULT NULL,
  `delivery_type` tinyint(1) DEFAULT '1' COMMENT '1:takeout, 2: delivery, 3:dine in',
  `outlet_id` int(11) DEFAULT NULL,
  `delivery_charge_id` int(11) DEFAULT NULL,
  `cupon_id` int(11) DEFAULT NULL,
  `discount_amount` float(12,2) DEFAULT '0.00',
  `delivery_charge` float(12,2) DEFAULT '0.00',
  `total_order_amt` float(12,2) DEFAULT '0.00',
  `total_paid_amount` float(12,2) DEFAULT '0.00',
  `tax_amount` float(12,2) DEFAULT '0.00',
  `address` text NOT NULL,
  `remarks` text,
  `order_status` tinyint(1) DEFAULT '1' COMMENT '1:ordered,  2: ready ,  3: delivered',
  `order_noticed` tinyint(1) DEFAULT '1' COMMENT '1:not seen, 2:seen',
  `order_noticed_time` timestamp NULL DEFAULT NULL,
  `payment_time` timestamp NULL DEFAULT NULL,
  `payment_status` tinyint(1) DEFAULT '1' COMMENT '1:not paid,  2: paid ',
  `payment_method` tinyint(1) DEFAULT NULL COMMENT '1:bkash,  2: rocket ',
  `payment_reference_no` varchar(20) DEFAULT NULL,
  `invoice_no` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_master`
--

INSERT INTO `order_master` (`order_id`, `customer_id`, `order_date`, `delivery_date`, `delivery_type`, `outlet_id`, `delivery_charge_id`, `cupon_id`, `discount_amount`, `delivery_charge`, `total_order_amt`, `total_paid_amount`, `tax_amount`, `address`, `remarks`, `order_status`, `order_noticed`, `order_noticed_time`, `payment_time`, `payment_status`, `payment_method`, `payment_reference_no`, `invoice_no`) VALUES
(30, 14, '2019-11-10 19:21:09', '2019-11-10 12:00:00', 3, NULL, 3, NULL, 50.00, 0.00, 8680.00, 3470.00, 0.00, '', 'dfgdfg', 2, 2, '2019-11-10 08:28:14', '2019-11-10 12:59:24', 2, 3, '4544545', 'INV111900001');

-- --------------------------------------------------------

--
-- Table structure for table `outlets`
--

CREATE TABLE `outlets` (
  `id` int(11) NOT NULL,
  `address` varchar(500) NOT NULL,
  `outlet_name` varchar(200) DEFAULT NULL,
  `longitud` varchar(50) NOT NULL,
  `incharge_name` varchar(200) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `mobile` varchar(11) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active; 0:In-Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `outlets`
--

INSERT INTO `outlets` (`id`, `address`, `outlet_name`, `longitud`, `incharge_name`, `image`, `mobile`, `latitude`, `status`) VALUES
(1, '4/1 Salimullah Road, Mohammadpur, Dhaka', 'Mohammodpur ', '90.363841', '', 'images/outlets/outlate1.jpg', '01613313677', '23.759467', 1),
(2, 'Shaplar More, Kamarpara, Uttara, Dhaka', 'Uttara', '', '', 'images/outlets/outlate2.jpg', '01613313676', '', 1),
(3, 'H # 41, R # 04, B # 6, South Banasree, Dhaka', 'Banasree # 1', '', '', 'images/outlets/outlate3.jpg', '', '', 1),
(4, 'H # 227, R # 16, B # K, South Banasree, Dhaka', 'Banasree # 2', '', '', 'images/outlets/outlate4.jpg', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `code` varchar(200) NOT NULL,
  `tags` varchar(200) NOT NULL,
  `details` text,
  `short_description` text,
  `category_id` int(11) NOT NULL,
  `brand_name` varchar(50) DEFAULT NULL,
  `availability` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: available, 0: not avalable',
  `sell_from_stock` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Yes, 0: No',
  `feature_image` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `code`, `tags`, `details`, `short_description`, `category_id`, `brand_name`, `availability`, `sell_from_stock`, `feature_image`) VALUES
(1, 'Pestry', '00001', '', '', NULL, 25, NULL, 1, 1, ''),
(2, 'Plain Cake', '0002', '', '', NULL, 25, NULL, 1, 1, ''),
(3, 'Product A', '101', '', 'hjhj khjkhjh', NULL, 26, NULL, 1, 0, ''),
(4, 'AAAA', '2100', '', '', NULL, 25, NULL, 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `product_image`
--

CREATE TABLE `product_image` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_image` varchar(55) NOT NULL,
  `is_featured` tinyint(1) DEFAULT '0' COMMENT '1:featured, 0 not '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_image`
--

INSERT INTO `product_image` (`id`, `product_id`, `product_image`, `is_featured`) VALUES
(1, 1, '15723716584.jpg', 0),
(2, 2, '15733204197.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_ingredient`
--

CREATE TABLE `product_ingredient` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_ingredient`
--

INSERT INTO `product_ingredient` (`id`, `product_id`, `ingredient_id`) VALUES
(13, 1, 4),
(14, 1, 8),
(15, 1, 11),
(16, 1, 17),
(17, 2, 4),
(18, 2, 7),
(19, 2, 8),
(20, 2, 11),
(21, 2, 15),
(22, 2, 16),
(23, 2, 17),
(24, 2, 24),
(25, 2, 26),
(26, 2, 29),
(30, 3, 4),
(31, 3, 15),
(32, 3, 16),
(37, 4, 16),
(38, 4, 29);

-- --------------------------------------------------------

--
-- Table structure for table `product_rate`
--

CREATE TABLE `product_rate` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT '0',
  `production_rate` float(10,2) NOT NULL,
  `rate` float(10,2) NOT NULL,
  `discount_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: flat_rate; 2:percentage_rate',
  `discount_amount` float(10,2) NOT NULL,
  `discounted_rate` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_rate`
--

INSERT INTO `product_rate` (`id`, `product_id`, `size_id`, `unit_id`, `stock_quantity`, `production_rate`, `rate`, `discount_type`, `discount_amount`, `discounted_rate`) VALUES
(7, 1, 7, 3, 40, 1510.00, 1720.00, 1, 0.00, 1720.00),
(8, 1, 5, 3, 223, 510.00, 620.00, 1, 0.00, 620.00),
(9, 2, 1, 3, 32, 120.00, 150.00, 1, 0.00, 150.00),
(12, 3, 1, 3, 20, 0.00, 100.00, 1, 0.00, 100.00),
(13, 3, 14, 3, 20, 0.00, 80.00, 1, 0.00, 80.00),
(16, 4, 1, 3, 104, 875.00, 950.00, 1, 5.00, 875.00),
(17, 4, 0, 0, 0, 0.00, 0.00, 1, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `product_review`
--

CREATE TABLE `product_review` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `review_details` text,
  `review_point` int(1) NOT NULL,
  `review_by_name` varchar(200) NOT NULL,
  `review_by_email` varchar(200) NOT NULL,
  `review_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_stock`
--

CREATE TABLE `product_stock` (
  `id` int(11) NOT NULL,
  `product_rate_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `note` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product_stock`
--

INSERT INTO `product_stock` (`id`, `product_rate_id`, `date`, `quantity`, `note`) VALUES
(1, 8, '2019-11-20', 5, 'product added'),
(2, 7, '2019-11-21', 33, 'product added'),
(3, 8, '2019-11-13', 6, 'product added'),
(4, 7, '2019-11-20', 33, 'product added'),
(5, 8, '2019-11-13', 6, 'product added'),
(6, 7, '2019-11-20', 33, 'product added'),
(7, 8, '2019-11-13', -6, 'product damaged'),
(8, 7, '2019-11-20', 33, 'product added'),
(9, 9, '2019-11-13', 3, 'product added'),
(10, 9, '2019-11-12', 22, 'product added'),
(25, 8, '2019-11-14', 33, 'sdf'),
(26, 7, '2019-11-22', 2, 'update'),
(27, 9, '2019-11-21', 10, 'Product receive from shopno'),
(28, 12, '2019-11-21', 12, 'Product receive from shopno'),
(29, 16, '2019-11-21', 2, 'add product'),
(30, 13, '2019-11-21', 2, 'add product'),
(31, 12, '2019-11-21', 3, 'add product'),
(32, 7, '2019-11-22', 5, 'none'),
(33, 7, '2019-11-21', 10, 'none');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `company_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `stock_alert_quantity` int(11) NOT NULL,
  `tax` float NOT NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `company_name`, `site_title`, `site_url`, `stock_alert_quantity`, `tax`, `logo`) VALUES
(1, 'Fastfood', 'Fastfood POS', 'http://localhost/fastfood/admin/', 62, 52, 'images/banner/moumit.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `size`
--

CREATE TABLE `size` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `size`
--

INSERT INTO `size` (`id`, `code`, `name`) VALUES
(1, '10001', 'Small'),
(3, '10002', 'Mini'),
(4, '10003', 'Large'),
(5, '10004', '200 gm'),
(6, '10005', 'Per Piece'),
(7, '10006', '500 gm'),
(8, '10007', '100ml'),
(9, '10008', '250ml'),
(10, '10009', '500 ml'),
(11, '10010', '1ltr'),
(12, '10011', '250 gm'),
(14, '10013', 'Family'),
(17, '10016', 'Regular'),
(19, '10018', '1 kg'),
(20, '10019', '2 kg'),
(21, '10020', '3 kg'),
(22, '10021', '4 kg');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `unit_name` varchar(100) DEFAULT NULL,
  `short_name` varchar(10) DEFAULT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(3) DEFAULT NULL COMMENT 'add, sub, mul, div',
  `conversion_rate` double(12,2) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_name`, `short_name`, `base_unit`, `operator`, `conversion_rate`, `note`, `status`) VALUES
(1, 'Kilogram', 'KG', NULL, NULL, 0.00, NULL, 1),
(2, 'Gram', 'gm', 1, 'sub', 1000.00, NULL, 1),
(3, 'Pices', 'Pcs', NULL, NULL, 0.00, NULL, 1),
(4, 'Dozen', 'Dzn', 3, 'mul', 12.00, NULL, 1),
(5, 'Liter', 'Ltr', NULL, 'mul', 0.00, NULL, 1),
(6, 'Mililiter', 'ml', 5, 'div', 1000.00, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) NOT NULL,
  `group_name` varchar(100) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `group_name`, `status`) VALUES
(21, 'admin', 0),
(24, 'Sells man', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_member`
--

CREATE TABLE `user_group_member` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT '0',
  `emp_id` varchar(20) NOT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0: no access ; 1:access'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group_member`
--

INSERT INTO `user_group_member` (`id`, `group_id`, `emp_id`, `status`) VALUES
(2, 21, '1000001', 1),
(3, 21, '1000002', 1),
(6, 21, '1000004', 0),
(9, 24, '1000001', 0),
(10, 24, '1000002', 0),
(11, 24, '1000003', 0),
(12, 24, '1000004', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_permission`
--

CREATE TABLE `user_group_permission` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT '0',
  `action_id` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0: Not Permit, 1: Permit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group_permission`
--

INSERT INTO `user_group_permission` (`id`, `group_id`, `action_id`, `status`) VALUES
(251, 21, 11, 1),
(252, 21, 12, 1),
(253, 21, 13, 1),
(254, 21, 14, 1),
(255, 21, 15, 1),
(256, 21, 16, 1),
(257, 21, 43, 1),
(258, 21, 44, 1),
(260, 21, 45, 1),
(583, 21, 10, 1),
(588, 21, 50, 1),
(589, 21, 51, 1),
(590, 21, 52, 1),
(591, 21, 53, 1),
(592, 21, 54, 1),
(593, 21, 55, 1),
(594, 21, 56, 1),
(595, 21, 57, 1),
(596, 21, 58, 1),
(597, 21, 59, 1),
(598, 21, 60, 1),
(599, 21, 61, 1),
(600, 21, 62, 1),
(601, 21, 63, 1),
(602, 21, 64, 1),
(603, 21, 65, 1),
(604, 21, 66, 1),
(605, 21, 67, 1),
(606, 21, 68, 1),
(607, 21, 69, 1),
(608, 21, 70, 0),
(609, 21, 71, 0),
(610, 21, 72, 0),
(611, 21, 73, 0),
(612, 21, 74, 1),
(613, 21, 75, 1),
(614, 21, 76, 1),
(615, 21, 77, 1),
(616, 21, 78, 1),
(617, 21, 79, 1),
(618, 21, 80, 1),
(619, 21, 81, 1),
(620, 21, 82, 1),
(621, 21, 83, 1),
(622, 21, 84, 1),
(623, 21, 85, 1),
(624, 21, 86, 1),
(625, 21, 87, 1),
(626, 21, 88, 0),
(627, 21, 89, 0),
(628, 21, 90, 0),
(629, 21, 94, 0),
(630, 21, 95, 0),
(631, 21, 96, 0),
(632, 21, 97, 0),
(633, 21, 98, 1),
(634, 21, 99, 1),
(635, 21, 100, 1),
(636, 21, 101, 1),
(637, 21, 102, 1),
(638, 24, 10, 0),
(639, 24, 11, 0),
(640, 24, 12, 0),
(641, 24, 13, 0),
(642, 24, 14, 0),
(643, 24, 15, 0),
(644, 24, 16, 0),
(645, 24, 43, 0),
(646, 24, 44, 0),
(647, 24, 45, 0),
(648, 24, 50, 0),
(649, 24, 51, 0),
(650, 24, 52, 0),
(651, 24, 53, 0),
(652, 24, 54, 0),
(653, 24, 55, 0),
(654, 24, 56, 0),
(655, 24, 57, 0),
(656, 24, 58, 0),
(657, 24, 59, 0),
(658, 24, 60, 0),
(659, 24, 61, 0),
(660, 24, 62, 0),
(661, 24, 63, 0),
(662, 24, 64, 0),
(663, 24, 65, 0),
(664, 24, 66, 0),
(665, 24, 67, 0),
(666, 24, 68, 0),
(667, 24, 69, 0),
(668, 24, 74, 0),
(669, 24, 75, 0),
(670, 24, 76, 0),
(671, 24, 77, 0),
(672, 24, 82, 0),
(673, 24, 83, 0),
(674, 24, 84, 0),
(675, 24, 85, 0),
(676, 24, 86, 0),
(677, 24, 87, 0),
(678, 24, 98, 0),
(679, 24, 99, 0),
(680, 24, 100, 0),
(681, 24, 101, 0),
(682, 24, 102, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_infos`
--

CREATE TABLE `user_infos` (
  `emp_id` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `designation_name` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `age` varchar(100) NOT NULL,
  `nid_no` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `blood_group` varchar(50) DEFAULT NULL,
  `health_card_no` varchar(50) DEFAULT NULL,
  `is_active_home_page` tinyint(1) NOT NULL DEFAULT '0',
  `remarks` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_infos`
--

INSERT INTO `user_infos` (`emp_id`, `full_name`, `designation_name`, `address`, `age`, `nid_no`, `photo`, `contact_no`, `email`, `blood_group`, `health_card_no`, `is_active_home_page`, `remarks`) VALUES
('1000001', 'Momit', 'Software Engineer', '', '', '', 'images/employee/moumit.jpg', '01737151125', 'shofiqueshahin@gmail.com', 'B+', '201800001', 0, 'aaaaaaaaaa'),
('1000002', 'kajol kumar chaki', 'software engineer ', '', '', '23489', 'images/employee/DA90208.jpg', '01757808214', 'kajolchaki@gmail.com', 'o+', NULL, 0, 'none'),
('1000003', 'jahed', 'Chef', '', '', '345678', 'images/employee/558.jpg', '32456', 'sfho@dsaf.dsf', 'A-', NULL, 0, ''),
('1000004', 'biplob', 'Store Keeper', '', '', '2345', '', '21345', 'kumar@mail.com', 'A-', NULL, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `web_actions`
--

CREATE TABLE `web_actions` (
  `id` int(11) NOT NULL,
  `activity_name` varchar(50) NOT NULL,
  `module_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_actions`
--

INSERT INTO `web_actions` (`id`, `activity_name`, `module_id`, `status`) VALUES
(10, 'User enrty', 1, 0),
(11, 'User permission', 1, 0),
(12, 'User update', 1, 0),
(13, 'User delete', 1, 0),
(14, 'control panel', 6, 0),
(15, 'User List', 1, 0),
(16, 'permission grid', 1, 0),
(43, 'activity action access', 1, 0),
(44, 'group permission', 1, 0),
(45, 'website permission', 1, 0),
(50, 'Category Entry', 3, 0),
(51, 'Category Delete', 3, 0),
(52, 'Category Update', 3, 0),
(53, 'Category Grid', 3, 0),
(54, 'Ingredient Entry', 3, 0),
(55, 'Ingredient Delete', 3, 0),
(56, 'Ingredient Update', 3, 0),
(57, 'Ingredient Grid', 3, 0),
(58, 'Size Entry', 3, 0),
(59, 'Size Delete', 3, 0),
(60, 'Size Update', 3, 0),
(61, 'Size Grid', 3, 0),
(62, 'Product Entry', 3, 0),
(63, 'Product Delete', 3, 0),
(64, 'Product Update', 3, 0),
(65, 'Product Grid', 3, 0),
(66, 'Customer Entry', 5, 0),
(67, 'Customer Delete', 5, 0),
(68, 'Customer Update', 5, 0),
(69, 'Customer Grid', 5, 0),
(70, 'Outlet Entry', 6, 1),
(71, 'Outlet Update', 6, 1),
(72, 'Outlet Delete', 6, 1),
(73, 'Outlet Grid', 6, 1),
(74, 'Order Entry', 4, 0),
(75, 'Order Delete', 4, 0),
(76, 'Order Update', 4, 0),
(77, 'Order Grid', 4, 0),
(78, 'cupon entry', 6, 0),
(79, 'cupon delete', 6, 0),
(80, 'cupon update', 6, 0),
(81, 'cupon grid', 6, 0),
(82, 'Customer Report', 2, 0),
(83, 'Order Summary Report', 2, 0),
(84, 'Order Details Report', 2, 0),
(85, 'Product Report', 2, 0),
(86, 'Order VS Payment Report', 2, 0),
(87, 'Product sell report', 2, 0),
(88, 'Custom Order Grid', 4, 1),
(89, 'Custom Order Update', 4, 1),
(90, 'Custom Order Delete', 4, 1),
(91, 'Custom order Greid', 6, 1),
(92, 'Custom order update', 6, 1),
(93, 'Custom order Delete', 6, 1),
(94, 'Delivery Charge Entry', 6, 1),
(95, 'Delivery Charge Delete ', 6, 1),
(96, 'Delivery Charge Update', 6, 1),
(97, 'Delivery Charge Grid', 6, 1),
(98, 'Settings', 6, 0),
(99, 'Expense CRUD', 7, 0),
(100, 'Unit CRUD', 6, 0),
(101, 'Stock adjustment', 3, 0),
(102, 'Stock Grid', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_login`
--

CREATE TABLE `web_login` (
  `emp_id` varchar(10) NOT NULL,
  `is_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:not logged, 1: logged in',
  `chat_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 1:available,2:meeting,3:busy'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `web_menu`
--

CREATE TABLE `web_menu` (
  `id` int(11) NOT NULL,
  `parent_menu_id` int(11) DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  `menu` varchar(50) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_menu`
--

INSERT INTO `web_menu` (`id`, `parent_menu_id`, `title`, `menu`, `description`) VALUES
(16, 16, 'Services', 'services', '<p>Shastho Shikkha ( Ss), &nbsp;&nbsp; <span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">Medical Services&nbsp; ( Ms) , </span>&nbsp;<span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">&nbsp; Law Awarness &amp; Services ( Las)</span> , &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n'),
(28, 28, 'ABOUT US', 'about-us', '<p>We are extremely proud to inform you our new concept, <span style=\"color:#3b2413\"><strong>Cakencookie</strong></span>. Yes it&rsquo;s a new brand of Bakery &amp; Pastry. It&rsquo;s a sophisticated brand of Nafisa Food &amp; Beverage Ltd. The inhabitants of Dhaka City are getting accustomed to Western and European culture , at the same time huge number of expats are travelling to Bangladesh especially Dhaka due to business . Consequently hospitality industry is growing so fast. Restaurant, Cafe, Club, Bar are increasing dramatically to accomplish the need of locals and expats.</p>\r\n\r\n<p>This logical evolutionary change has drawn our attention and the thirst of people towards variety of food items drive us to shape our business concept regarding the brand, <span style=\"color:#3b2413\"><strong>Cakencookie</strong></span>.</p>\r\n'),
(29, 16, 'Helth Awarness', 'Helth Awarness', '<p>We awar people about some dangarous disease like Cancer, Diabetic, Strock, Adolescent Nutrition, Reproductive Health etc.</p>\r\n'),
(30, 16, 'Diagnosis Services', 'Diagnosis Services', '<p>We provide &quot;Diagnosis Card&quot; thus people get discount on diagonisis in several Diagnostic Center For Primary Disease identifying.</p>\r\n'),
(31, 16, 'Doctors Consultancy', 'Doctors Consultancy', '<p>We will provide/suggest Specialist&nbsp; doctor and best treatment process for a specific disease . Services holder will&nbsp; get Specialist Doctors Consultancy From Self Service Center <span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">w</span><span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">ith w</span><span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">eb Camera.</span></p>\r\n'),
(32, 16, 'Medicin Care', 'Medicin Care', '<p>One of the Main target is to provide people medicine for cheap rate and free(Special cases) From Selective Medicin Shop With internet Health Card.</p>\r\n'),
(33, 16, 'Doctors Serial', 'Doctors Serial', '<p>We will arrange doctor&#39;s serial, because it is very difficult to manage a serial for a rural people</p>\r\n'),
(34, 16, 'Law Services', 'Law Services', '<p>Grow awareness &amp; law support against torture, child Marrige,eve-teasing, dowry, terrorism, intoxicating &amp; militancy</p>\r\n'),
(35, 28, 'OUR MISSION', 'mission', '<p>Our competent team members are the main strength point of this sophisticated food brand whose are committed to provide superior quality of bakery, pastries, savories, cakes &amp; ice creams. Our motto is to achieve customers satisfaction through implementing total quality management (TQM) . We are highly committed to collect fresh &amp; purest raw materials, process them in a very systematic and hygienic way for making the fine tuned product by our talented chefs. We do focus on our customer feedback &amp; work on it to provide them wow experience that makes them repeat customers.</p>\r\n'),
(36, 28, 'OUR VISION', 'vision', '<p>Be the leader of the bakery market through ensuring quality, service, innovation &amp; affordable prices to fulfill the needs of our precious customer &amp; consumer.</p>\r\n'),
(37, 28, 'PRODUCTS WE OFFER', 'service', '<p>We believe that the most promising cafes are those which have firm determination to meet guest expectations through their quality of product &amp; Service. This belief has lead us to flourish the brand <span style=\"color:#3b2413\"><strong>Cakencookie </strong></span>that will offer quality of Bakery, Pastry, Hot Savoury, accompanied of varieties coffee and different flavoured Ice-Cream. In short, it&rsquo;s a one stop service offer for the guest convenient only.</p>\r\n'),
(38, 38, 'Contact', 'contact', '<p>Contact address here</p>\r\n'),
(39, 38, 'Address', 'address', '<p>Mohammadpur, Dhaka, Bangladesh 1207,</p><br />\r\n<p>Tongi, Gazipur, Bangladesh 1207,</p>\r\n\r\n'),
(40, 38, 'Mobile', 'mobile', '<p>01613313670</p>\r\n'),
(41, 38, 'Email', 'email', '<p>marketing@cakencookie.net</p>\r\n'),
(42, 38, 'Office Time', ' Office Time', '<p>10:00 AM&nbsp; to 6:00 PM</p>\r\n'),
(43, 43, 'Terms & Conditions', 'Terms & Conditions', '<p>OVERVIEW</p>\r\n\r\n<p>This website is operated by Cakencookies. Throughout the site, the terms &ldquo;we&rdquo;, &ldquo;us&rdquo; and &ldquo;our&rdquo; refer to Cakencookies. Cakencookies offers this website, including all information, tools and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies and notices stated here.</p>\r\n\r\n<p>By visiting our site and/ or purchasing something from us, you engage in our &ldquo;Service&rdquo; and agree to be bound by the following terms and conditions (&ldquo;Terms of Service&rdquo;, &ldquo;Terms&rdquo;), including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/ or contributors of content.</p>\r\n\r\n<p>Please read these Terms of Service carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the website or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.</p>\r\n\r\n<p>Any new features or tools which are added to the current store shall also be subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our website. It is your responsibility to check this page periodically for changes. Your continued use of or access to the website following the posting of any changes constitutes acceptance of those changes.</p>\r\n\r\n<p>Our store is hosted on EyHost Hosting Service and 2Checkout provides us with the online e-commerce platform that allows us to sell our products and services to you.</p>\r\n\r\n<p>SECTION 1 &ndash; ONLINE STORE TERMS</p>\r\n\r\n<p>By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.</p>\r\n\r\n<p>You may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).</p>\r\n\r\n<p>You must not transmit any worms or viruses or any code of a destructive nature.</p>\r\n\r\n<p>A breach or violation of any of the Terms will result in an immediate termination of your Services.</p>\r\n\r\n<p>SECTION 2 &ndash; GENERAL CONDITIONS</p>\r\n\r\n<p>We reserve the right to refuse service to anyone for any reason at any time.</p>\r\n\r\n<p>You understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks.</p>\r\n\r\n<p>You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the website through which the service is provided, without express written permission by us.</p>\r\n\r\n<p>The headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.</p>\r\n\r\n<p>SECTION 3 &ndash; ACCURACY, COMPLETENESS AND TIMELINESS OF INFORMATION</p>\r\n\r\n<p>We are not responsible if information made available on this site is not accurate, complete or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete or more timely sources of information. Any reliance on the material on this site is at your own risk.</p>\r\n\r\n<p>This site may contain certain historical information. Historical information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site.</p>\r\n\r\n<p>SECTION 4 &ndash; MODIFICATIONS TO THE SERVICE AND PRICES</p>\r\n\r\n<p>Prices for our products are subject to change without notice.</p>\r\n\r\n<p>We reserve the right at any time to modify or discontinue the Service (or any part or content thereof) without notice at any time.</p>\r\n\r\n<p>We shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service.</p>\r\n\r\n<p>SECTION 5 &ndash; PRODUCTS OR SERVICES (if applicable)</p>\r\n\r\n<p>Certain products or services may be available exclusively online through the website. These products or services may have limited quantities and are subject to return or exchange only according to our Return Policy.</p>\r\n\r\n<p>We have made every effort to display as accurately as possible the colors and images of our products that appear at the store. We cannot guarantee that your computer monitor&rsquo;s display of any color will be accurate.</p>\r\n\r\n<p>We reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at anytime without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for any product or service made on this site is void where prohibited.</p>\r\n\r\n<p>We do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.</p>\r\n\r\n<p>SECTION 6 &ndash; ACCURACY OF BILLING AND ACCOUNT INFORMATION</p>\r\n\r\n<p>We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.</p>\r\n\r\n<p>You agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.</p>\r\n\r\n<p>For more detail, please review our Returns Policy.</p>\r\n\r\n<p>SECTION 7 &ndash; OPTIONAL TOOLS</p>\r\n\r\n<p>We may provide you with access to third-party tools over which we neither monitor nor have any control nor input.</p>\r\n\r\n<p>You acknowledge and agree that we provide access to such tools &rdquo;as is&rdquo; and &ldquo;as available&rdquo; without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools.</p>\r\n\r\n<p>Any use by you of optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).</p>\r\n\r\n<p>We may also, in the future, offer new services and/or features through the website (including, the release of new tools and resources). Such new features and/or services shall also be subject to these Terms of Service.</p>\r\n\r\n<p>SECTION 8 &ndash; THIRD-PARTY LINKS</p>\r\n\r\n<p>Certain content, products and services available via our Service may include materials from third-parties.</p>\r\n\r\n<p>Third-party links on this site may direct you to third-party websites that are not affiliated with us. We are not responsible for examining or evaluating the content or accuracy and we do not warrant and will not have any liability or responsibility for any third-party materials or websites, or for any other materials, products, or services of third-parties.</p>\r\n\r\n<p>We are not liable for any harm or damages related to the purchase or use of goods, services, resources, content, or any other transactions made in connection with any third-party websites. Please review carefully the third-party&rsquo;s policies and practices and make sure you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding third-party products should be directed to the third-party.</p>\r\n\r\n<p>SECTION 9 &ndash; USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS</p>\r\n\r\n<p>If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, &lsquo;comments&rsquo;), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us. We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for any comments; or (3) to respond to any comments.</p>\r\n\r\n<p>We may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party&rsquo;s intellectual property or these Terms of Service.</p>\r\n\r\n<p>You agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by you or any third-party.</p>\r\n\r\n<p>SECTION 10 &ndash; PERSONAL INFORMATION</p>\r\n\r\n<p>Your submission of personal information through the store is governed by our Privacy Policy. To view our Privacy Policy.</p>\r\n\r\n<p>SECTION 11 &ndash; ERRORS, INACCURACIES AND OMISSIONS</p>\r\n\r\n<p>Occasionally there may be information on our site or in the Service that contains typographical errors, inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, product shipping charges, transit times and availability. We reserve the right to correct any errors, inaccuracies or omissions, and to change or update information or cancel orders if any information in the Service or on any related website is inaccurate at any time without prior notice (including after you have submitted your order).</p>\r\n\r\n<p>We undertake no obligation to update, amend or clarify information in the Service or on any related website, including without limitation, pricing information, except as required by law. No specified update or refresh date applied in the Service or on any related website, should be taken to indicate that all information in the Service or on any related website has been modified or updated.</p>\r\n\r\n<p>SECTION 12 &ndash; PROHIBITED USES</p>\r\n\r\n<p>In addition to other prohibitions as set forth in the Terms of Service, you are prohibited from using the site or its content: (a) for any unlawful purpose; (b) to solicit others to perform or participate in any unlawful acts; (c) to violate any international, federal, provincial or state regulations, rules, laws, or local ordinances; (d) to infringe upon or violate our intellectual property rights or the intellectual property rights of others; (e) to harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, race, age, national origin, or disability; (f) to submit false or misleading information; (g) to upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Service or of any related website, other websites, or the Internet; (h) to collect or track the personal information of others; (i) to spam, phish, pharm, pretext, spider, crawl, or scrape; (j) for any obscene or immoral purpose; or (k) to interfere with or circumvent the security features of the Service or any related website, other websites, or the Internet. We reserve the right to terminate your use of the Service or any related website for violating any of the prohibited uses.</p>\r\n\r\n<p>SECTION 13 &ndash; DISCLAIMER OF WARRANTIES; LIMITATION OF LIABILITY</p>\r\n\r\n<p>We do not guarantee, represent or warrant that your use of our service will be uninterrupted, timely, secure or error-free.</p>\r\n\r\n<p>We do not warrant that the results that may be obtained from the use of the service will be accurate or reliable.</p>\r\n\r\n<p>You agree that from time to time we may remove the service for indefinite periods of time or cancel the service at any time, without notice to you.</p>\r\n\r\n<p>You expressly agree that your use of, or inability to use, the service is at your sole risk. The service and all products and services delivered to you through the service are (except as expressly stated by us) provided &lsquo;as is&rsquo; and &lsquo;as available&rsquo; for your use, without any representation, warranties or conditions of any kind, either express or implied, including all implied warranties or conditions of merchantability, merchantable quality, fitness for a particular purpose, durability, title, and non-infringement.</p>\r\n\r\n<p>In no case shall Cakencookies, our directors, officers, employees, affiliates, agents, contractors, interns, suppliers, service providers or licensors be liable for any injury, loss, claim, or any direct, indirect, incidental, punitive, special, or consequential damages of any kind, including, without limitation lost profits, lost revenue, lost savings, loss of data, replacement costs, or any similar damages, whether based in contract, tort (including negligence), strict liability or otherwise, arising from your use of any of the service or any products procured using the service, or for any other claim related in any way to your use of the service or any product, including, but not limited to, any errors or omissions in any content, or any loss or damage of any kind incurred as a result of the use of the service or any content (or product) posted, transmitted, or otherwise made available via the service, even if advised of their possibility. Because some states or jurisdictions do not allow the exclusion or the limitation of liability for consequential or incidental damages, in such states or jurisdictions, our liability shall be limited to the maximum extent permitted by law.</p>\r\n\r\n<p>SECTION 14 &ndash; INDEMNIFICATION</p>\r\n\r\n<p>You agree to indemnify, defend and hold harmless King&rsquo;s Confectionery (Bangladesh) Pte. Ltd. and our parent, subsidiaries, affiliates, partners, officers, directors, agents, contractors, licensors, service providers, subcontractors, suppliers, interns and employees, harmless from any claim or demand, including reasonable attorneys&rsquo; fees, made by any third-party due to or arising out of your breach of these Terms of Service or the documents they incorporate by reference, or your violation of any law or the rights of a third-party.</p>\r\n\r\n<p>SECTION 15 &ndash; SEVERABILITY</p>\r\n\r\n<p>In the event that any provision of these Terms of Service is determined to be unlawful, void or unenforceable, such provision shall nonetheless be enforceable to the fullest extent permitted by applicable law, and the unenforceable portion shall be deemed to be severed from these Terms of Service, such determination shall not affect the validity and enforceability of any other remaining provisions.</p>\r\n\r\n<p>SECTION 16 &ndash; TERMINATION</p>\r\n\r\n<p>The obligations and liabilities of the parties incurred prior to the termination date shall survive the termination of this agreement for all purposes.</p>\r\n\r\n<p>These Terms of Service are effective unless and until terminated by either you or us. You may terminate these Terms of Service at any time by notifying us that you no longer wish to use our Services, or when you cease using our site.</p>\r\n\r\n<p>If in our sole judgment you fail, or we suspect that you have failed, to comply with any term or provision of these Terms of Service, we also may terminate this agreement at any time without notice and you will remain liable for all amounts due up to and including the date of termination; and/or accordingly may deny you access to our Services (or any part thereof).</p>\r\n\r\n<p>SECTION 17 &ndash; ENTIRE AGREEMENT</p>\r\n\r\n<p>The failure of us to exercise or enforce any right or provision of these Terms of Service shall not constitute a waiver of such right or provision.</p>\r\n\r\n<p>These Terms of Service and any policies or operating rules posted by us on this site or in respect to The Service constitutes the entire agreement and understanding between you and us and govern your use of the Service, superseding any prior or contemporaneous agreements, communications and proposals, whether oral or written, between you and us (including, but not limited to, any prior versions of the Terms of Service).</p>\r\n\r\n<p>Any ambiguities in the interpretation of these Terms of Service shall not be construed against the drafting party.</p>\r\n\r\n<p>SECTION 18 &ndash; JURISDICTION AND RESTRICTION</p>\r\n\r\n<p>Cakencookies controls and maintains this Web Site from Bangladesh. The materials and information contained in this section of this Web Site, relating to Bangladesh, is directed at and restricted to individuals resident in or entities having a place of business in Bangladesh ONLY. The Cakencookies makes no representation that the materials and information contained herein is appropriate or available for use in other locations / jurisdictions.</p>\r\n\r\n<p>These Terms and Conditions are governed by and construed in accordance with the laws of Bangladesh and any dispute relating thereto shall be subject to the non-exclusive jurisdiction of the courts of Bangladesh.</p>\r\n\r\n<p>SECTION 19 &ndash; CHANGES TO TERMS OF SERVICE</p>\r\n\r\n<p>You can review the most current version of the Terms of Service at any time at this page.</p>\r\n\r\n<p>We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Service by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. Your continued use of or access to our website or the Service following the posting of any changes to these Terms of Service constitutes acceptance of those changes.</p>\r\n\r\n<p>SECTION 20 &ndash; CONTACT INFORMATION</p>\r\n'),
(45, NULL, 'Privacy Policy', 'Privacy', '<p>SECTION 1 &ndash; WHAT DO WE DO WITH YOUR INFORMATION?</p>\r\n\r\n<p>When you purchase something from our store, as part of the buying and selling process, we collect the personal information you give us such as your name, address and email address.</p>\r\n\r\n<p>When you browse our store, we also automatically receive your computer&rsquo;s internet protocol (IP) address in order to provide us with information that helps us learn about your browser and operating system.</p>\r\n\r\n<p>Email marketing (if applicable): With your permission, we may send you emails about our store, new products and other updates.</p>\r\n\r\n<p>SECTION 2 &ndash; CONSENT</p>\r\n\r\n<p>How do you get my consent?</p>\r\n\r\n<p>When you provide us with personal information to complete a transaction, verify your credit card, place an order, arrange for a delivery or return a purchase, we imply that you consent to our collecting it and using it for that specific reason only.</p>\r\n\r\n<p>If we ask for your personal information for a secondary reason, like marketing, we will either ask you directly for your expressed consent, or provide you with an opportunity to say no.</p>\r\n\r\n<p>How do I withdraw my consent?</p>\r\n\r\n<p>If after you opt-in, you change your mind, you may withdrawing your consent for us to contact you, for the continued collection, use or disclosure of your information, at anytime, by contacting us at info@kingsbd.com or mailing us at:</p>\r\n\r\n<p>Cakencookies</p>\r\n\r\n<p>House No. 17, Road No. 11, Block G, Banani, Dhaka-1213, Bangladesh</p>\r\n\r\n<p>SECTION 3 &ndash; DISCLOSURE</p>\r\n\r\n<p>We may disclose your personal information if we are required by law to do so or if you violate our Terms of Service.</p>\r\n\r\n<p>SECTION 4 &ndash; EyHOST HOSTING SERVICE &amp; 2CHECKOUT</p>\r\n\r\n<p>Our store is hosted on EyHost Hosting Service and our direct payment gateway is provided by 2Checkout. They provide us with the online e-commerce platform that allows us to sell our products and services to you.</p>\r\n\r\n<p>Your data is stored through EyHost Hosting Service&rsquo;s and 2Checkout&rsquo;s data storage, databases and the general 2Checkout application. They store your data on a secure server behind a firewall.</p>\r\n\r\n<p>Payment:</p>\r\n\r\n<p>If you choose a direct payment gateway to complete your purchase, then 2Checkout stores your credit card data. It is encrypted through the Payment Card Industry Data Security Standard (PCI-DSS). Your purchase transaction data is stored only as long as is necessary to complete your purchase transaction. After that is complete, your purchase transaction information is deleted.</p>\r\n\r\n<p>All direct payment gateways adhere to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, MasterCard, American Express and Discover.</p>\r\n\r\n<p>PCI-DSS requirements help ensure the secure handling of credit card information by our store and its service providers.</p>\r\n\r\n<p>For more insight, you may also want to read 2Checkout&rsquo;s Terms of Service here https://www.2checkout.com/policies/terms-of-use or Privacy Statement here https://www.2checkout.com/policies/privacy-policy.</p>\r\n\r\n<p>SECTION 5 &ndash; THIRD-PARTY SERVICES</p>\r\n\r\n<p>In general, the third-party providers used by us will only collect, use and disclose your information to the extent necessary to allow them to perform the services they provide to us.</p>\r\n\r\n<p>However, certain third-party service providers, such as payment gateways and other payment transaction processors, have their own privacy policies in respect to the information we are required to provide to them for your purchase-related transactions.</p>\r\n\r\n<p>For these providers, we recommend that you read their privacy policies so you can understand the manner in which your personal information will be handled by these providers.</p>\r\n\r\n<p>In particular, remember that certain providers may be located in or have facilities that are located a different jurisdiction than either you or us. So if you elect to proceed with a transaction that involves the services of a third-party service provider, then your information may become subject to the laws of the jurisdiction(s) in which that service provider or its facilities are located.</p>\r\n\r\n<p>Once you leave our store&rsquo;s website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our website&rsquo;s Terms of Service.</p>\r\n\r\n<p>Links</p>\r\n\r\n<p>When you click on links on our store, they may direct you away from our site. We are not responsible for the privacy practices of other sites and encourage you to read their privacy statements.</p>\r\n\r\n<p>Google analytics:</p>\r\n\r\n<p>Our store uses Google Analytics to help us learn about who visits our site and what pages are being looked at.</p>\r\n\r\n<p>SECTION 6 &ndash; SECURITY</p>\r\n\r\n<p>To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered or destroyed.</p>\r\n\r\n<p>If you provide us with your credit card information, the information is encrypted using secure socket layer technology (SSL) and stored with a AES-256 encryption.&nbsp; Although no method of transmission over the Internet or electronic storage is 100% secure, we follow all PCI-DSS requirements and implement additional generally accepted industry standards.</p>\r\n\r\n<p>SECTION 7 &ndash; COOKIES</p>\r\n\r\n<p>In order to improve our Internet service to you, we will occasionally use a &ldquo;cookie&rdquo; and/or other similar files or programs which may place certain information on your computer&rsquo;s hard drive when you visit an Cakencookies&rsquo;s web site. A cookie is a small amount of data that our web server sends to your web browser when you visit certain parts of our site. We may use cookies to:</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp; allow us to recognise the PC you are using when you return to our web site so that we can understand your interest in our web site and tailor its content and advertisements to match your interests (This type of cookie may be stored permanently on your PC but does not contain any information that can identify you personally.);<br />\r\n&nbsp;&nbsp;&nbsp; identify you after you have logged in by storing a temporary reference number in the cookie so that our web server can conduct a dialogue with you while simultaneously dealing with other customers. (Your browser keeps this type of cookie until you log off or close down your browser when these types of cookie are normally deleted. No other information is stored in this type of cookie.);<br />\r\n&nbsp;&nbsp;&nbsp; allow you to carry information across pages of our site and avoid having to re-enter that information;<br />\r\n&nbsp;&nbsp;&nbsp; allow you access to stored information if you register for any of our on-line services;<br />\r\n&nbsp;&nbsp;&nbsp; enable us to produce statistical information (anonymous) which helps us to improve the structure and content of our web site;<br />\r\n&nbsp;&nbsp;&nbsp; enable us to evaluate the effectiveness of our advertising and promotions.</p>\r\n\r\n<p>Cookies do not enable us to gather personal information about you unless you give the information to our server. Most Internet browser software allows the blocking of all cookies or enables you to receive a warning before a cookie is stored. For further information, please refer to your Internet browser software instructions or help screen.</p>\r\n\r\n<p>SECTION 8 &ndash; INTERNET COMMUNICATIONS</p>\r\n\r\n<p>In order to maintain the security of our systems, protect our staff, record transactions, and, in certain circumstances, to prevent and detect crime or unauthorized activities, Cakencookies reserves the right to monitor all internet communications including web and email traffic into and out of its domains.</p>\r\n\r\n<p>SECTION 9 &ndash; AGE OF CONSENT</p>\r\n\r\n<p>By using this site, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.</p>\r\n\r\n<p>SECTION 10 &ndash; CHANGES TO THIS PRIVACY POLICY</p>\r\n\r\n<p>We reserve the right to modify this privacy policy at any time, so please review it frequently. Changes and clarifications will take effect immediately upon their posting on the website. If we make material changes to this policy, we will notify you here that it has been updated, so that you are aware of what information we collect, how we use it, and under what circumstances, if any, we use and/or disclose it.</p>\r\n\r\n<p>If our store is acquired or merged with another company, your information may be transferred to the new owners so that we may continue to sell products to you.</p>\r\n\r\n<p>QUESTIONS AND CONTACT INFORMATION</p>\r\n\r\n<p>If you would like to: access, correct, amend or delete any personal information we have about you, register a complaint, or simply want more information contact our Privacy Compliance Officer at info@kingsbd.com or by mail at</p>\r\n'),
(46, 28, 'REFUND POLICY', 'Refund Policy', '<p>Any changes or cancellations to your order must be placed at least 48 hours in advance of the scheduled delivery or pick up time of your order.&nbsp; If a cancellation is placed at least 48 hours in advance, we are able to issue a 100% refund for your order.&nbsp; Any cancellations or changes made within 48 hours of the scheduled delivery or pick up time of your order are completely non-refundable.</p>\r\n\r\n<p>If you are unsatisfied with your purchase for any reason after delivery of the product has been accepted, please give us a call at</p>\r\n\r\n<p>1. COO : +8801613313688<br />\r\n2. Manager Operation : +8801613313679</p>\r\n\r\n<p>&nbsp;so we can remedy the situation.</p>\r\n'),
(47, 28, 'SPECIALITY', 'Speciality', '<p>The Quality &amp; Quantity of Products, Personalized Service &amp; Prompt Delivery are Our Strength as well as Speciality</p>\r\n'),
(48, 55, 'Special Menu', 'Special Menu', '<p>the menu consist of cakes, pastries, savories &amp; more of freshly baked bakeries which are really prepared with care for our valued customers</p>\r\n'),
(49, NULL, 'Welcome Subtitle', 'Welcome Subtitle', '<h6>Savory/Pastry/Cake/Coffee/Cookies/Bread</h6>\r\n'),
(50, NULL, 'We Are Best', 'We Are Best', '<p>Cake, Pastry, Savory</p>\r\n'),
(51, 55, 'Fresh Products', 'Fresh Products', '<p>Fresh Products</p>\r\n'),
(52, 55, 'Various Items', 'Various Items', '<p>Various Items</p>\r\n'),
(53, 55, 'Personalized  Service', 'Personalized Service', '<p>Well Service</p>\r\n'),
(54, 55, 'Fast Delivery', 'Fast Delivery', '<p>Fast Delivery</p>\r\n'),
(55, NULL, 'Home', 'Home', 'details no need to edit. this is only for development reason'),
(56, NULL, 'Social Network', 'Social Network', 'dont edit this , only for development'),
(57, 56, 'facebook link', 'facebook link', 'https://www.facebook.com/Cakencookiee/'),
(58, 56, 'twitter link', 'twitter link', 'https://www.twitter.com/Cakencookiee/'),
(59, 56, 'instagram link', 'instagram  link', 'https://www.instagram.com/Cakencookiee/'),
(60, 56, 'googleplus  link', 'googleplus  link', 'https://www.googleplus.com/Cakencookiee/'),
(61, NULL, 'bkash mobile no', 'bkash mobile no', '<p>1111111111111</p>'),
(62, NULL, 'Rocket mobile no', 'Rocket mobile no', '<p>1111111111111</p>'),
(63, 32, 'best food', 'pizza_cb', '<p>&nbsp;slkdj f; sklajfd lk;sf klsja dflk;ewrtyu876543223456789765434567</p>\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `web_module`
--

CREATE TABLE `web_module` (
  `id` int(11) NOT NULL,
  `module_name` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_module`
--

INSERT INTO `web_module` (`id`, `module_name`, `status`) VALUES
(1, 'User', 0),
(2, 'Report', 0),
(3, 'Menu Items', 0),
(4, 'Order', 0),
(5, 'Customer', 0),
(6, 'Control Panel', 0),
(7, 'Expense', 0),
(8, 'Settings', 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_notice`
--

CREATE TABLE `web_notice` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `details` text NOT NULL,
  `attachment` varchar(200) DEFAULT NULL,
  `banner_img` varchar(100) DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `posted_by` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:Pending, 2:Approved, 3: Deleted',
  `remarks` varchar(50) DEFAULT NULL,
  `post_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 News, 2: Events',
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Default, 1: Pinned_Post'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_notice`
--

INSERT INTO `web_notice` (`id`, `title`, `details`, `attachment`, `banner_img`, `expire_date`, `posted_by`, `status`, `remarks`, `post_date`, `type`, `is_pinned`) VALUES
(6, 'Notice Event', '<p>Up Coming</p>\r\n', 'Jellyfish.jpg,Penguins.jpg,Lighthouse.jpg', '', '2017-12-06', '1000001', 1, NULL, '2017-11-29 05:52:30', 2, 0),
(7, 'Notice Test', '<p>Up Coming</p>\r\n', '', '', '0000-00-00', '1000001', 1, NULL, '2017-11-29 06:10:54', 1, 0),
(12, 'Diagnosis Services', '<p>Popular Diagnostic Center, Thanthania Bogra.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 'Untitled-1.jpg ', '', '2018-03-23', '1000001', 1, NULL, '2018-03-23 00:36:07', 2, 0),
(13, 'new menu', '<p>sdfsa sdaf</p>\r\n', '', '', '2019-11-24', '1000001', 1, NULL, '2019-11-24 15:11:05', 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appuser`
--
ALTER TABLE `appuser`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `con_user_created_by_fk` (`created_by`),
  ADD KEY `con_user_modified_by_fk` (`modified_by`);

--
-- Indexes for table `banner_image`
--
ALTER TABLE `banner_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cupons`
--
ALTER TABLE `cupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_infos`
--
ALTER TABLE `customer_infos`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `custom_cake`
--
ALTER TABLE `custom_cake`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_charge`
--
ALTER TABLE `delivery_charge`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_categories_expense_categories` (`parent_id`);

--
-- Indexes for table `expense_details`
--
ALTER TABLE `expense_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_details_expenses` (`expense_id`),
  ADD KEY `FK_expense_details_expense_heads` (`expense_head_id`);

--
-- Indexes for table `expense_heads`
--
ALTER TABLE `expense_heads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_heads_expense_categories` (`expense_category_id`);

--
-- Indexes for table `external_contact`
--
ALTER TABLE `external_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallary_images`
--
ALTER TABLE `gallary_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gallary_images_image_group` (`album_id`);

--
-- Indexes for table `image_album`
--
ALTER TABLE `image_album`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_master`
--
ALTER TABLE `order_master`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `outlets`
--
ALTER TABLE `outlets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_ingredient`
--
ALTER TABLE `product_ingredient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_rate`
--
ALTER TABLE `product_rate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_review`
--
ALTER TABLE `product_review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_stock`
--
ALTER TABLE `product_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `id_3` (`id`),
  ADD KEY `id_2` (`id`);

--
-- Indexes for table `size`
--
ALTER TABLE `size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group_member`
--
ALTER TABLE `user_group_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Index 2` (`group_id`,`emp_id`),
  ADD KEY `FK_emp_infos` (`emp_id`);

--
-- Indexes for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Index 2` (`group_id`,`action_id`),
  ADD KEY `FK__activity_actions` (`action_id`);

--
-- Indexes for table `user_infos`
--
ALTER TABLE `user_infos`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `web_actions`
--
ALTER TABLE `web_actions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `web_login`
--
ALTER TABLE `web_login`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `web_menu`
--
ALTER TABLE `web_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_web_menu_web_menu` (`parent_menu_id`);

--
-- Indexes for table `web_module`
--
ALTER TABLE `web_module`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `web_notice`
--
ALTER TABLE `web_notice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1_poosted_by` (`posted_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banner_image`
--
ALTER TABLE `banner_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `cupons`
--
ALTER TABLE `cupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customer_infos`
--
ALTER TABLE `customer_infos`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `custom_cake`
--
ALTER TABLE `custom_cake`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `delivery_charge`
--
ALTER TABLE `delivery_charge`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `expense_details`
--
ALTER TABLE `expense_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `expense_heads`
--
ALTER TABLE `expense_heads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `external_contact`
--
ALTER TABLE `external_contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gallary_images`
--
ALTER TABLE `gallary_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `image_album`
--
ALTER TABLE `image_album`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `order_master`
--
ALTER TABLE `order_master`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `outlets`
--
ALTER TABLE `outlets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_ingredient`
--
ALTER TABLE `product_ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `product_rate`
--
ALTER TABLE `product_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `product_review`
--
ALTER TABLE `product_review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_stock`
--
ALTER TABLE `product_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `size`
--
ALTER TABLE `size`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `user_group_member`
--
ALTER TABLE `user_group_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=683;

--
-- AUTO_INCREMENT for table `web_actions`
--
ALTER TABLE `web_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `web_menu`
--
ALTER TABLE `web_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `web_module`
--
ALTER TABLE `web_module`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `web_notice`
--
ALTER TABLE `web_notice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appuser`
--
ALTER TABLE `appuser`
  ADD CONSTRAINT `con_user_created_by_fk` FOREIGN KEY (`created_by`) REFERENCES `user_infos` (`emp_id`),
  ADD CONSTRAINT `con_user_modified_by_fk` FOREIGN KEY (`modified_by`) REFERENCES `user_infos` (`emp_id`),
  ADD CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user_infos` (`emp_id`);

--
-- Constraints for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `FK_expense_categories_expense_categories` FOREIGN KEY (`parent_id`) REFERENCES `expense_categories` (`id`);

--
-- Constraints for table `expense_details`
--
ALTER TABLE `expense_details`
  ADD CONSTRAINT `FK_expense_details_expense_heads` FOREIGN KEY (`expense_head_id`) REFERENCES `expense_heads` (`id`),
  ADD CONSTRAINT `FK_expense_details_expenses` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`);

--
-- Constraints for table `expense_heads`
--
ALTER TABLE `expense_heads`
  ADD CONSTRAINT `FK_expense_heads_expense_categories` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`);

--
-- Constraints for table `gallary_images`
--
ALTER TABLE `gallary_images`
  ADD CONSTRAINT `FK_gallary_images_image_album` FOREIGN KEY (`album_id`) REFERENCES `image_album` (`id`);

--
-- Constraints for table `user_group_member`
--
ALTER TABLE `user_group_member`
  ADD CONSTRAINT `FK__user_group` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  ADD CONSTRAINT `FK_emp_infos` FOREIGN KEY (`emp_id`) REFERENCES `user_infos` (`emp_id`);

--
-- Constraints for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  ADD CONSTRAINT `FK__activity_actions` FOREIGN KEY (`action_id`) REFERENCES `web_actions` (`id`),
  ADD CONSTRAINT `FK__user_group_id` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`);

--
-- Constraints for table `web_login`
--
ALTER TABLE `web_login`
  ADD CONSTRAINT `emp_id_fk` FOREIGN KEY (`emp_id`) REFERENCES `user_infos` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `web_menu`
--
ALTER TABLE `web_menu`
  ADD CONSTRAINT `FK_web_menu_web_menu` FOREIGN KEY (`parent_menu_id`) REFERENCES `web_menu` (`id`);

--
-- Constraints for table `web_notice`
--
ALTER TABLE `web_notice`
  ADD CONSTRAINT `FK1_poosted_by` FOREIGN KEY (`posted_by`) REFERENCES `user_infos` (`emp_id`);
--
-- Database: `cakencookies`
--
CREATE DATABASE IF NOT EXISTS `cakencookies` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `cakencookies`;

-- --------------------------------------------------------

--
-- Table structure for table `appuser`
--

CREATE TABLE `appuser` (
  `user_id` varchar(12) NOT NULL DEFAULT '',
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `user_password` varchar(40) DEFAULT NULL,
  `user_level` varchar(10) NOT NULL DEFAULT 'General' COMMENT 'Admin,Developer,General',
  `login_status` tinyint(4) DEFAULT '0' COMMENT '1=login; 0=not login;',
  `is_active` int(1) NOT NULL DEFAULT '1' COMMENT '1=Active,0=Blocked',
  `modified_by` varchar(20) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appuser`
--

INSERT INTO `appuser` (`user_id`, `user_name`, `user_password`, `user_level`, `login_status`, `is_active`, `modified_by`, `modified_time`, `created_by`) VALUES
('1000001', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'ROLE_USER', 0, 1, NULL, NULL, '1000001'),
('1000002', 'biplob', '5fb29035061a08613b51fe7756dd7e2e', 'General', 0, 1, NULL, NULL, '1000001');

-- --------------------------------------------------------

--
-- Table structure for table `banner_image`
--

CREATE TABLE `banner_image` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text,
  `photo` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2 in-active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `banner_image`
--

INSERT INTO `banner_image` (`id`, `title`, `text`, `photo`, `status`) VALUES
(21, 'Banner5', 'Savory/Pastry/Cake/Coffee/Cookies/Bread', 'images/banner/5.jpg', 1),
(22, 'Banner6', 'Savory/Pastry/Cake/Coffee/Cookies/Bread', 'images/banner/6.jpg', 1),
(23, 'Banner4', 'Savory/Pastry/Cake/Coffee/Cookies/Bread', 'images/banner/4.jpg', 1),
(27, 'Banner1', 'Savory/Pastry/Cake/Coffee/Cookies/Bread', 'images/banner/1.jpg', 1),
(28, 'Banner2', 'Savory/Pastry/Cake/Coffee/Cookies/Bread', 'images/banner/2.jpg', 1),
(29, 'Banner3', 'Savory/Pastry/Cake/Coffee/Cookies/Bread', 'images/banner/3.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `code`, `name`, `parent_id`, `photo`, `status`) VALUES
(2, '001', 'Breads', NULL, 'images/category/kisspng-bakery-breadbasket-baking-and-bread-basket-5a6b76031de9f7.7922297315169920031225.png', 1),
(9, '102', 'Buns', NULL, 'images/category/kisspng-bakery-breakfast-breadbasket-bread-basket-5a6b7536e1c508.2576371515169917989248.png', 1),
(10, '103', 'Breakfast Pastry', NULL, 'images/category/chocolate muffin.png', 1),
(11, '104', 'Doughnut', NULL, 'images/category/Untitled-1.png', 1),
(12, '105', 'Danish & Croissant', NULL, 'images/category/kisspng-croissant-coffee-danish-pastry-pain-au-chocolat-vi-delicious-croissants-5a7f20f262c2a5.0789929615182809464045.png', 1),
(13, '106', 'Loaf Cake', NULL, 'images/category/fruit cake.png', 1),
(14, '107', 'Savory', NULL, 'images/category/miniBurger.png', 1),
(15, '108', 'Tart', NULL, 'images/category/Lemon tart.png', 1),
(16, '109', 'Cookie', NULL, 'images/category/cats tongue cookie.jpg', 1),
(17, '110', 'Cake', NULL, 'images/category/malted chocolate.png', 1),
(18, '111', 'Pastry', NULL, 'images/category/Red Velvet Pastry.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cupons`
--

CREATE TABLE `cupons` (
  `id` int(11) NOT NULL,
  `cupon_no` varchar(100) NOT NULL,
  `c_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: flat_rate; 2:percentage_rate',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL,
  `amount` float(10,2) DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active; 0:In-Active',
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cupons`
--

INSERT INTO `cupons` (`id`, `cupon_no`, `c_type`, `start_date`, `end_date`, `entry_date`, `amount`, `status`, `customer_id`) VALUES
(1, '1111', 1, '2017-10-02 17:30:20', '2019-10-02 17:30:24', '2018-10-02 17:30:28', 100.00, 1, NULL),
(2, '2222', 2, '2017-10-02 17:30:20', '2019-10-02 17:30:24', '2018-10-02 17:30:28', 10.00, 1, NULL),
(3, '444', 1, '2018-11-08 00:00:00', '2019-02-07 00:00:00', '2019-03-21 00:00:00', 33.00, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer_infos`
--

CREATE TABLE `customer_infos` (
  `customer_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `address` text NOT NULL,
  `age` varchar(100) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `remarks` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  0: inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_infos`
--

INSERT INTO `customer_infos` (`customer_id`, `full_name`, `username`, `password`, `address`, `age`, `photo`, `contact_no`, `email`, `remarks`, `status`) VALUES
(1, 'Moynul Hasan Momit', 'momit', 'e10adc3949ba59abbe56e057f20f883e', 'aaaaaaaaaaa', '200', 'images/customer/momit.jpg', '012100000', 'momit.litu@gmail.com', 'aaaaaaaaaaaa', 1),
(2, 'MUntakim Hasan', 'munif', 'e10adc3949ba59abbe56e057f20f883e', 'aaaaaaaaaaaaaaaa', '20', 'images/customer/1537339731jahed.jpg', '012554455', 'munif.litu@gmail.com', 'aaaaaaaaaaaaaaa', 1),
(5, 'hasan', 'hasan', 'e10adc3949ba59abbe56e057f20f883e', 's sfdf,sdf ,sdfsd,dsf,', '', '', '01980340482', 'momi.df@gmaad.com', NULL, 1),
(6, 'muntakim', 'muntakim', 'e10adc3949ba59abbe56e057f20f883e', 'sgfsf sdfdsfdfdsfs', '', '', '0198034082', 'm.k@gmail.com', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `custom_cake`
--

CREATE TABLE `custom_cake` (
  `id` int(11) NOT NULL,
  `cc_cake_weight` tinyint(1) DEFAULT NULL,
  `cc_cake_tyre` tinyint(1) DEFAULT NULL,
  `cc_delevery_date` datetime DEFAULT NULL,
  `cc_details` text NOT NULL,
  `cc_name` varchar(200) NOT NULL,
  `cc_email` varchar(200) NOT NULL,
  `cc_mobile` varchar(20) NOT NULL,
  `cc_image` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:not seen, 2:seen, 3:varified',
  `varified_by` varchar(20) DEFAULT NULL,
  `varified_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remarks` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `custom_cake`
--

INSERT INTO `custom_cake` (`id`, `cc_cake_weight`, `cc_cake_tyre`, `cc_delevery_date`, `cc_details`, `cc_name`, `cc_email`, `cc_mobile`, `cc_image`, `status`, `varified_by`, `varified_time`, `remarks`) VALUES
(1, 1, 1, '0000-00-00 00:00:00', 'dfgdfg', 'ddfg', 'dfgdfg', '46456', 'momit_singara.jpg', 1, NULL, NULL, NULL),
(2, 0, 0, '0000-00-00 00:00:00', 'sfsdf', 'sdf', 'fggfdsf', '456456', '', 1, NULL, NULL, NULL),
(3, 0, 0, '2018-11-13 12:00:00', 'sdfsdf', 'sdff', 'fsfsdf', '465+', 'cigarat.jpg', 1, NULL, NULL, NULL),
(4, 0, 0, '2018-11-13 12:00:00', 'fgsf', 'sdf', 'dfgdg', '435', '', 1, NULL, NULL, NULL),
(5, 0, 0, '2018-11-13 12:00:00', 'dfghdg', 'ddfgf', 'ffghh', '456', '', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_charge`
--

CREATE TABLE `delivery_charge` (
  `id` int(11) NOT NULL,
  `type` varchar(200) NOT NULL,
  `rate` float(8,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active, 0: inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery_charge`
--

INSERT INTO `delivery_charge` (`id`, `type`, `rate`, `status`) VALUES
(1, 'Inside  Dhaka', 100.00, 1),
(2, 'Outside Dhaka', 250.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `external_contact`
--

CREATE TABLE `external_contact` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `organization` varchar(50) NOT NULL DEFAULT '0',
  `designation` varchar(50) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL DEFAULT '0',
  `mobile_no` varchar(50) NOT NULL DEFAULT '0',
  `created_by` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `external_contact`
--

INSERT INTO `external_contact` (`id`, `name`, `organization`, `designation`, `email`, `mobile_no`, `created_by`) VALUES
(2, 'Rony Talukdar', 'ABC', 'ABC', 'fdsgsdfg', '454235345', '1000001'),
(3, 'ABC', 'ewgvsdagdf', 'btgfewft', 'wrewtgfvdv', '32424', '1000001');

-- --------------------------------------------------------

--
-- Table structure for table `gallary_images`
--

CREATE TABLE `gallary_images` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `album_id` int(11) NOT NULL DEFAULT '0',
  `attachment` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallary_images`
--

INSERT INTO `gallary_images` (`id`, `title`, `album_id`, `attachment`) VALUES
(35, 'title1', 21, '2.JPG'),
(37, 'title4', 21, '4.JPG'),
(38, 'title5', 21, '6.JPG'),
(39, 'title6', 21, '9.JPG'),
(42, 'title1', 21, 'momit_singara.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `image_album`
--

CREATE TABLE `image_album` (
  `id` int(11) NOT NULL,
  `album_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image_album`
--

INSERT INTO `image_album` (`id`, `album_name`) VALUES
(21, 'Food'),
(22, 'Outlet');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

CREATE TABLE `ingredient` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `photo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredient`
--

INSERT INTO `ingredient` (`id`, `code`, `name`, `photo`) VALUES
(4, '10002', 'Eggs', 'images/no_image.png'),
(5, '10003', 'Salt', 'images/no_image.png'),
(6, '10004', 'Sweetener', 'images/no_image.png'),
(7, '10005', 'Milk', 'images/no_image.png'),
(8, '10007', 'Suger', 'images/no_image.png'),
(9, '10006', 'Marzarine', 'images/no_image.png'),
(10, '10008', 'Yeast', 'images/no_image.png'),
(11, '10009', 'Butter', 'images/no_image.png'),
(12, '10010', 'Fondante', 'images/no_image.png'),
(13, '10011', 'Fresh Cream', 'images/no_image.png'),
(14, '10012', 'Flour', 'images/no_image.png'),
(15, '10013', 'Cheese', 'images/no_image.png'),
(16, '10014', 'Chocolate', 'images/no_image.png'),
(17, '10015', 'Dark Chocolate', 'images/no_image.png'),
(18, '10016', 'Suger Syrup', 'images/no_image.png'),
(19, '10017', 'Cherry Pie', 'images/no_image.png'),
(20, '10018', 'Food Colour', 'images/no_image.png'),
(21, '10019', 'Icing Suger', 'images/no_image.png'),
(22, '10020', 'Baking Powder', 'images/no_image.png'),
(23, '10021', 'Strawberry', 'images/no_image.png'),
(24, '10022', 'Chicken', 'images/no_image.png'),
(25, '10023', 'Spice', 'images/no_image.png'),
(26, '10024', 'Vegetable', 'images/no_image.png'),
(27, '10025', 'Sausage', 'images/no_image.png');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size_rate_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_rate` double(12,4) NOT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  2: canceled '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `size_rate_id`, `quantity`, `product_rate`, `status`) VALUES
(1, 1, 55, 121, 3, 1200.0000, 1),
(3, 3, 56, 122, 1, 1600.0000, 1),
(4, 4, 55, 121, 1, 1200.0000, 1),
(5, 5, 56, 122, 1, 1600.0000, 1),
(6, 6, 56, 122, 1, 1600.0000, 1),
(7, 7, 101, 173, 2, 550.0000, 1),
(10, 9, 102, 175, 1, 650.0000, 1),
(11, 10, 66, 161, 2, 55.0000, 1),
(12, 11, 102, 175, 1, 650.0000, 1),
(13, 12, 102, 175, 1, 650.0000, 1),
(14, 13, 102, 175, 1, 650.0000, 1),
(15, 14, 101, 173, 2, 550.0000, 1),
(16, 1, 102, 500, 2, 650.0000, 1),
(17, 9, 101, 500, 1, 550.0000, 1),
(18, 9, 102, 500, 1, 650.0000, 1),
(19, 9, 102, 500, 1, 650.0000, 1),
(20, 9, 102, 500, 1, 650.0000, 1),
(21, 9, 102, 500, 1, 650.0000, 1),
(22, 9, 102, 500, 1, 650.0000, 1),
(23, 9, 85, 182, 1, 50.0000, 1),
(24, 9, 102, 500, 1, 650.0000, 1),
(25, 9, 102, 500, 1, 650.0000, 1),
(26, 9, 85, 0, 1, 50.0000, 1),
(27, 9, 102, 500, 1, 650.0000, 1),
(28, 9, 85, 0, 1, 50.0000, 1),
(29, 9, 102, 500, 1, 650.0000, 1),
(30, 9, 85, 0, 1, 50.0000, 1),
(31, 9, 102, 500, 1, 650.0000, 1),
(32, 9, 85, 0, 1, 50.0000, 1),
(33, 9, 102, 500, 1, 650.0000, 1),
(34, 9, 85, 0, 1, 50.0000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_master`
--

CREATE TABLE `order_master` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` datetime DEFAULT NULL,
  `delivery_type` tinyint(1) DEFAULT '1' COMMENT '1:takeout, 2: delivery',
  `outlet_id` int(11) DEFAULT NULL,
  `delivery_charge_id` int(11) DEFAULT NULL,
  `cupon_id` int(11) DEFAULT NULL,
  `discount_amount` float(12,2) DEFAULT '0.00',
  `delivery_charge` float(12,2) DEFAULT '0.00',
  `total_order_amt` float(12,2) DEFAULT '0.00',
  `total_paid_amount` float(12,2) DEFAULT '0.00',
  `tax_amount` float(12,2) DEFAULT '0.00',
  `address` text NOT NULL,
  `remarks` text,
  `order_status` tinyint(1) DEFAULT '1' COMMENT '1:ordered,  2: ready ,  3: picked',
  `order_noticed` tinyint(1) DEFAULT '1' COMMENT '1:not seen, 2:seen',
  `order_noticed_time` timestamp NULL DEFAULT NULL,
  `payment_time` timestamp NULL DEFAULT NULL,
  `payment_status` tinyint(1) DEFAULT '1' COMMENT '1:not paid,  2: paid ',
  `payment_method` tinyint(1) DEFAULT NULL COMMENT '1:bkash,  2: rocket , 3:Cash on delevery',
  `payment_reference_no` varchar(20) DEFAULT NULL,
  `invoice_no` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_master`
--

INSERT INTO `order_master` (`order_id`, `customer_id`, `order_date`, `delivery_date`, `delivery_type`, `outlet_id`, `delivery_charge_id`, `cupon_id`, `discount_amount`, `delivery_charge`, `total_order_amt`, `total_paid_amount`, `tax_amount`, `address`, `remarks`, `order_status`, `order_noticed`, `order_noticed_time`, `payment_time`, `payment_status`, `payment_method`, `payment_reference_no`, `invoice_no`) VALUES
(1, 1, '2018-10-08 09:42:35', '2018-10-08 12:00:00', 2, NULL, 1, 2222, 360.00, 100.00, 3340.00, 0.00, 0.00, '', 'sdfsdf ', 1, 2, '2018-10-07 19:26:45', NULL, 2, 1, '3340', 'CnC101800001'),
(3, 1, '2018-10-08 09:57:40', '2018-10-04 12:00:00', 1, 1, NULL, 2222, 360.00, 0.00, 1240.00, 0.00, 0.00, '', 'dgd gdfgdfg', 1, 2, '2018-10-13 23:30:21', NULL, 2, 1, '1240', 'CnC101800002'),
(4, 1, '2018-10-08 10:02:20', '2018-11-08 12:00:00', 1, 1, NULL, 2222, 360.00, 0.00, 840.00, 0.00, 0.00, '', 'zdfsd fsf', 1, 1, NULL, NULL, 1, NULL, NULL, 'CnC101800003'),
(5, 1, '2018-10-08 10:03:18', '2018-10-11 12:00:00', 1, 1, NULL, 0, 0.00, 0.00, 1600.00, 0.00, 0.00, '', 'dfgg', 1, 2, '2018-10-13 23:27:43', NULL, 1, NULL, NULL, 'CnC101800004'),
(6, 1, '2018-10-09 09:57:39', '2018-10-09 12:00:00', 2, NULL, 1, 2222, 160.00, 100.00, 1540.00, 0.00, 0.00, '', 'sdfs dfsf', 1, 2, '2018-10-08 18:21:07', NULL, 2, 1, '1540', 'CnC101800005'),
(7, 1, '2018-11-11 11:17:33', '2018-11-12 12:00:00', 1, 1, NULL, NULL, 0.00, 0.00, 1100.00, 1100.00, 0.00, '', '', 1, 2, '2018-11-11 02:08:08', NULL, 2, 1, '1100', 'CnC111800006'),
(9, 1, '2018-11-11 11:33:43', '2018-11-17 12:00:00', 2, 1, 1, NULL, 0.00, 100.00, 700.00, 1200.00, 0.00, '', 'sdf sdfdsfd fdff', 1, 2, '2018-11-11 03:11:56', '2018-11-14 02:18:23', 2, 1, '111', 'CnC111800008'),
(10, 1, '2018-11-13 14:03:26', '2018-11-13 12:00:00', 1, 1, NULL, NULL, 0.00, 0.00, 110.00, 0.00, 0.00, '', 'sff', 1, 2, '2018-11-13 03:03:52', NULL, 1, NULL, NULL, 'CnC111800009'),
(11, 1, '2018-11-13 14:31:29', '2018-11-15 12:00:00', 1, 1, NULL, NULL, 0.00, 0.00, 650.00, 0.00, 0.00, '', '', 1, 2, '2018-11-13 05:35:44', NULL, 1, NULL, NULL, 'CnC111800010'),
(12, 1, '2018-11-13 14:37:30', '2018-11-16 12:00:00', 1, 1, NULL, NULL, 0.00, 0.00, 650.00, 0.00, 0.00, '', '', 1, 1, NULL, NULL, 1, NULL, NULL, 'CnC111800011'),
(13, 1, '2018-11-13 14:39:04', '2018-11-15 12:00:00', 1, 1, NULL, NULL, 0.00, 0.00, 650.00, 0.00, 0.00, '', '', 1, 2, '2018-11-13 05:36:12', NULL, 1, NULL, NULL, 'CnC111800012'),
(14, 1, '2018-11-13 14:40:02', '2018-11-23 12:00:00', 1, 1, NULL, NULL, 0.00, 0.00, 1100.00, 0.00, 0.00, '', '', 2, 2, '2018-11-13 04:47:19', NULL, 1, NULL, NULL, 'CnC111800013');

-- --------------------------------------------------------

--
-- Table structure for table `outlets`
--

CREATE TABLE `outlets` (
  `id` int(11) NOT NULL,
  `address` varchar(500) NOT NULL,
  `outlet_name` varchar(200) DEFAULT NULL,
  `longitud` varchar(50) NOT NULL,
  `incharge_name` varchar(200) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `mobile` int(11) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active; 0:In-Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `outlets`
--

INSERT INTO `outlets` (`id`, `address`, `outlet_name`, `longitud`, `incharge_name`, `image`, `mobile`, `latitude`, `status`) VALUES
(1, '4/1 Salimullah Road, Mohammadpur, Dhaka', 'Mohammodpur ', '90.363841', '', 'images/outlets/outlate1.jpg', 1613313677, '23.759467', 1),
(2, 'Shaplar More, Kamarpara, Uttara, Dhaka', 'Uttara', '', '', 'images/outlets/outlate2.jpg', 1613313676, '', 1),
(3, 'H # 41, R # 04, B # 6, South Banasree, Dhaka', 'Banasree # 1', '', '', 'images/outlets/outlate3.jpg', 0, '', 1),
(4, 'H # 227, R # 16, B # K, South Banasree, Dhaka', 'Banasree # 2', '', '', 'images/outlets/outlate4.jpg', 1, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `code` varchar(200) NOT NULL,
  `tags` varchar(200) NOT NULL,
  `details` text,
  `short_description` text,
  `category_id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `availability` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: available, 0: not avalable',
  `feature_image` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `code`, `tags`, `details`, `short_description`, `category_id`, `brand_id`, `availability`, `feature_image`) VALUES
(65, 'Milk Bread', '101', 'Milk , Bread , Slice ', 'No one wants a crusty loaf every day, and that\'s when these beauties step up to the plate.', NULL, 2, 0, 1, '1.jpg'),
(66, 'Sandwich Bread', '102', 'Bread, Sandwich, Slice', 'No one wants a crusty loaf every day, and that\'s when these beauties step up to the plate.', NULL, 2, 0, 1, '15416720762.jpg'),
(67, 'Regular White Bread', '103', 'White, Bread, Slice', 'No one wants a crusty loaf every day, and that\'s when these beauties step up to the plate.', NULL, 2, 0, 1, ''),
(68, 'Burger Bun', '201', 'Bun', '', NULL, 9, 0, 1, ''),
(69, 'Burger Bun (Medium)', '201.1', 'Bun', '', NULL, 9, 0, 1, ''),
(70, 'Dinner Roll', '202', 'Bun', '', NULL, 9, 0, 1, ''),
(71, 'Hot Dog Bun', '203', 'Bun', '', NULL, 9, 0, 1, ''),
(72, 'Sub Bun', '204', 'Bun', '', NULL, 9, 0, 1, ''),
(73, 'Plain Muffin', '301', 'Pastry', 'a small domed spongy cake made with eggs and baking powder.', NULL, 10, 0, 1, ''),
(74, 'Fruit Muffin', '302', 'Pastry', 'a small domed spongy cake made with eggs and baking powder & fruits inside,', NULL, 10, 0, 1, ''),
(75, 'Chocolate Muffin', '303', 'Pastry', 'a small domed spongy cake made with eggs, chocolate and baking powder', NULL, 10, 0, 1, ''),
(76, 'Chocolate Doughnut', '401', 'Pastry, Chocolate', 'A small fried cake of sweetened dough, typically in the shape of a ring topped with chocolate sauce.', NULL, 11, 0, 1, ''),
(77, 'Strawberry Doughnut', '402', 'Pastry, Strawberry', 'A small fried cake of sweetened dough, typically in the shape of a ring topped with strawberry sauce.', NULL, 11, 0, 1, ''),
(79, 'BlueberryDoughnut', '403', 'Pastry', 'A small fried cake of sweetened dough, typically in the shape of a ring topped with strawberry sauce.', NULL, 11, 0, 1, ''),
(80, 'Plain Croissant', '501', '', 'a French crescent-shaped roll made of sweet flaky yeast dough, eaten for breakfast.', NULL, 12, 0, 1, ''),
(81, 'Chocolate Croissant', '502', 'Pastry', 'a French crescent-shaped roll made of sweet flaky yeast dough filling with, eaten for breakfast.', NULL, 12, 0, 1, ''),
(82, 'Pinwheel Danish', '503', 'Pastry', 'a French crescent-shaped roll made of sweet flaky yeast dough, eaten for breakfast.', NULL, 12, 0, 1, ''),
(83, 'Plain Cake', '601', 'Cake', 'Sponge cake is a cake based on flour (usually wheat flour), sugar, butter and eggs, and is sometimes leavened with baking powder.', NULL, 13, 0, 1, ''),
(84, 'Fruit Cake', '602', 'Cake', 'Sponge cake is a cake based on flour (usually wheat flour), sugar, butter and eggs, fruits and is sometimes leavened with baking powder', NULL, 13, 0, 1, ''),
(85, 'Chicken Sausage Roll (Large)', '701', 'Chicken, Fast food, Sausage, Spicy', '', NULL, 14, 0, 1, ''),
(86, 'Chicken Sausage Roll (Small)', '702', 'Chicken, Fast food, Sausage, Spicy', '', NULL, 14, 0, 1, ''),
(87, 'Pizza Bun', '703', 'Chicken, Fast food, Sausage, Spicy', '', NULL, 14, 0, 1, ''),
(88, 'Chicken Sausage Delight', '705', 'Chicken, Fast food, Sausage, Spicy', 'Sausage Filling Savory with mayo tomato topping.', NULL, 14, 0, 1, ''),
(89, 'Chicken Puff', '708', 'Chicken, Fast food, Sausage, Spicy', 'Puff sheet filling with saute chicken chili onion then baked.', NULL, 14, 0, 1, ''),
(90, 'Chicken Samosa', '709', 'Chicken, Fast food, Sausage, Spicy', '', NULL, 14, 0, 1, ''),
(91, 'Vegetable Singara', '710', 'Vegetable, Fast food, Spicy', 'Black cumin infused singara dough filling with mixed tawa vegetable then deep fry.', NULL, 14, 0, 1, ''),
(93, 'Chicken Cold Sandwich', '711', 'Chicken, Fast food, Sausage, Spicy', '', NULL, 14, 0, 1, ''),
(94, 'Mini Chicken Burger', '712', 'Chicken, Fast food, Spicy', '', NULL, 14, 0, 1, ''),
(96, 'Chicken Spring Roll', '713', 'Chicken, Fast food, Spicy', '', NULL, 14, 0, 1, ''),
(97, 'Vegetable Roll', '714', 'Fast food,Vegetable,Spicy', '', NULL, 14, 0, 1, ''),
(98, 'Lemon Tart', '801', 'Lemon, Pastry', 'A pastry shell with a lemon flavored filling.', NULL, 15, 0, 1, ''),
(99, 'Almond Tart', '802', 'Pastry', 'a pastry shell with a almond flavored filling.', NULL, 15, 0, 1, ''),
(100, 'Test product Momit', '78979', 'momit', 'fhfhg', NULL, 2, 0, 0, '15416732741.jpg'),
(101, 'Vanilla Cake', '1001', '', 'Vanilla sponge layered by butter cream and topping by pure whipped cream.', NULL, 17, 0, 1, '15416734301.jpg'),
(102, 'Black Forest', '1002', 'Chocolate, Cake, Black, ', 'Soft chocolate sponge layered by Cherry pie filling & butter cream and topping by chocolate Ganache or Butter Cream or Chocolate Shavings.', NULL, 17, 0, 1, '15416739802.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `product_image`
--

CREATE TABLE `product_image` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_image` varchar(55) NOT NULL,
  `is_featured` tinyint(1) DEFAULT '0' COMMENT '1:featured, 0 not '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_image`
--

INSERT INTO `product_image` (`id`, `product_id`, `product_image`, `is_featured`) VALUES
(79, 66, '2.jpg', 0),
(80, 67, '3.jpg', 0),
(81, 68, '15416655711.jpg', 0),
(82, 69, '15416656801.jpg', 0),
(83, 70, '15416657302.jpg', 0),
(84, 71, '15416657723.jpg', 0),
(85, 72, '4.jpg', 0),
(86, 73, '15416659791.jpg', 0),
(87, 74, '15416660552.jpg', 0),
(88, 75, '15416661643.jpg', 0),
(89, 76, '15416664311.jpg', 0),
(90, 77, '15416665252.jpg', 0),
(92, 79, '15416693243.jpg', 0),
(93, 80, '15416694381.jpg', 0),
(94, 81, '15416696032.jpg', 0),
(95, 82, '15416697143.jpg', 0),
(96, 83, '15416698441.jpg', 0),
(97, 84, '15416699412.jpg', 0),
(98, 85, '15416703491.jpg', 0),
(99, 86, '15416704341.jpg', 0),
(100, 87, '15416705842.jpg', 0),
(101, 88, '15416706573.jpg', 0),
(102, 89, '15416709114.jpg', 0),
(104, 65, '1.jpg', 0),
(105, 66, '15416720762.jpg', 0),
(106, 90, '5.jpg', 0),
(107, 91, '6.jpg', 0),
(109, 93, '7.jpg', 0),
(110, 94, '8.jpg', 0),
(112, 96, '9.jpg', 0),
(113, 97, '10.jpg', 0),
(114, 98, '15416729791.jpg', 0),
(115, 99, '15416730692.jpg', 0),
(116, 100, 'cigarat.jpg', 0),
(117, 101, '15416734301.jpg', 0),
(118, 102, '15416739802.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_ingredient`
--

CREATE TABLE `product_ingredient` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_ingredient`
--

INSERT INTO `product_ingredient` (`id`, `product_id`, `ingredient_id`) VALUES
(316, 67, 10),
(317, 67, 14),
(318, 68, 5),
(319, 68, 10),
(320, 68, 14),
(321, 69, 5),
(322, 69, 10),
(323, 69, 14),
(324, 70, 5),
(325, 70, 10),
(326, 70, 14),
(327, 71, 5),
(328, 71, 10),
(329, 71, 14),
(330, 72, 5),
(331, 72, 10),
(332, 72, 14),
(333, 73, 8),
(334, 73, 10),
(335, 73, 11),
(336, 73, 14),
(337, 74, 4),
(338, 74, 5),
(339, 74, 7),
(340, 74, 8),
(341, 74, 10),
(342, 74, 14),
(343, 75, 4),
(344, 75, 8),
(345, 75, 11),
(346, 75, 14),
(347, 75, 16),
(348, 76, 5),
(349, 76, 6),
(350, 76, 8),
(351, 76, 11),
(352, 76, 14),
(353, 76, 16),
(354, 77, 4),
(355, 77, 6),
(356, 77, 8),
(357, 77, 14),
(360, 79, 6),
(361, 79, 8),
(362, 79, 10),
(363, 79, 14),
(364, 80, 4),
(365, 80, 6),
(366, 80, 8),
(367, 80, 14),
(368, 81, 8),
(369, 81, 10),
(370, 81, 14),
(371, 81, 16),
(372, 82, 4),
(373, 82, 8),
(374, 82, 10),
(375, 82, 14),
(376, 83, 4),
(377, 83, 5),
(378, 83, 7),
(379, 83, 8),
(380, 83, 14),
(381, 83, 22),
(382, 84, 4),
(383, 84, 8),
(384, 84, 14),
(385, 84, 22),
(394, 86, 4),
(395, 86, 14),
(396, 86, 25),
(397, 86, 27),
(398, 87, 4),
(399, 87, 14),
(400, 87, 24),
(401, 87, 25),
(417, 66, 5),
(418, 66, 10),
(419, 66, 14),
(420, 90, 5),
(421, 90, 14),
(422, 90, 24),
(423, 90, 25),
(432, 93, 4),
(433, 93, 14),
(434, 93, 24),
(435, 94, 5),
(436, 94, 14),
(437, 94, 24),
(438, 94, 25),
(441, 96, 14),
(442, 96, 24),
(443, 97, 5),
(444, 97, 14),
(445, 97, 26),
(446, 98, 6),
(447, 98, 8),
(448, 98, 14),
(449, 99, 8),
(450, 99, 14),
(452, 101, 4),
(453, 101, 6),
(454, 101, 8),
(455, 101, 11),
(456, 101, 13),
(457, 101, 14),
(458, 101, 21),
(459, 101, 22),
(460, 100, 4),
(461, 102, 4),
(462, 102, 6),
(463, 102, 11),
(464, 102, 13),
(465, 102, 14),
(466, 102, 19),
(467, 102, 21),
(468, 102, 22),
(469, 88, 4),
(470, 88, 10),
(471, 88, 14),
(472, 88, 24),
(473, 88, 25),
(474, 88, 27),
(475, 89, 4),
(476, 89, 14),
(477, 89, 24),
(478, 91, 14),
(479, 91, 25),
(480, 91, 26),
(481, 65, 7),
(482, 65, 10),
(483, 65, 14),
(484, 103, 4),
(485, 104, 4),
(486, 104, 12),
(487, 104, 20),
(488, 85, 4),
(489, 85, 14),
(490, 85, 25),
(491, 85, 27);

-- --------------------------------------------------------

--
-- Table structure for table `product_rate`
--

CREATE TABLE `product_rate` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `rate` float(10,2) NOT NULL,
  `discounted_rate` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_rate`
--

INSERT INTO `product_rate` (`id`, `product_id`, `size_id`, `rate`, `discounted_rate`) VALUES
(135, 67, 5, 55.00, 55.00),
(136, 68, 7, 12.00, 12.00),
(137, 69, 8, 9.00, 9.00),
(138, 70, 9, 6.00, 6.00),
(139, 71, 7, 12.00, 12.00),
(140, 72, 10, 22.00, 22.00),
(141, 73, 11, 50.00, 50.00),
(142, 74, 11, 55.00, 55.00),
(143, 75, 11, 55.00, 55.00),
(144, 76, 11, 45.00, 45.00),
(145, 77, 11, 45.00, 45.00),
(147, 79, 11, 45.00, 45.00),
(148, 80, 11, 20.00, 20.00),
(149, 81, 11, 45.00, 45.00),
(150, 82, 11, 60.00, 60.00),
(151, 83, 5, 210.00, 210.00),
(152, 84, 5, 250.00, 250.00),
(155, 86, 1, 30.00, 30.00),
(156, 87, 17, 70.00, 70.00),
(161, 66, 5, 55.00, 55.00),
(162, 90, 6, 25.00, 25.00),
(165, 93, 17, 50.00, 50.00),
(166, 94, 3, 50.00, 50.00),
(168, 96, 6, 30.00, 30.00),
(169, 97, 17, 30.00, 30.00),
(170, 98, 17, 40.00, 40.00),
(171, 99, 17, 40.00, 40.00),
(173, 101, 13, 550.00, 550.00),
(174, 100, 10, 0.00, 120.00),
(175, 102, 13, 650.00, 650.00),
(176, 88, 17, 70.00, 70.00),
(177, 89, 17, 60.00, 60.00),
(178, 91, 6, 15.00, 15.00),
(179, 65, 5, 55.00, 55.00),
(182, 85, 4, 50.00, 50.00);

-- --------------------------------------------------------

--
-- Table structure for table `product_review`
--

CREATE TABLE `product_review` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `review_details` text,
  `review_point` int(1) NOT NULL,
  `review_by_name` varchar(200) NOT NULL,
  `review_by_email` varchar(200) NOT NULL,
  `review_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `size`
--

CREATE TABLE `size` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `size`
--

INSERT INTO `size` (`id`, `code`, `name`) VALUES
(1, '10001', 'Small'),
(3, '10002', 'Mini'),
(4, '10003', 'Large'),
(5, '10004', '400 gm'),
(6, '10005', 'Per Piece'),
(7, '10006', '65 gm'),
(8, '10007', '45 gm'),
(9, '10008', '25 gm'),
(10, '10009', '120 gm'),
(11, '10010', '50 gm'),
(12, '10011', '250 gm'),
(13, '10012', '500 gm'),
(14, '10013', '80 gm'),
(15, '10014', '60 gm'),
(16, '10015', 'Structued'),
(17, '100016', 'Regular');

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) NOT NULL,
  `group_name` varchar(100) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `group_name`, `status`) VALUES
(21, 'Admin', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_member`
--

CREATE TABLE `user_group_member` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT '0',
  `emp_id` varchar(20) NOT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0: no access ; 1:access'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group_member`
--

INSERT INTO `user_group_member` (`id`, `group_id`, `emp_id`, `status`) VALUES
(2, 21, '1000001', 1),
(3, 21, '1000002', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_permission`
--

CREATE TABLE `user_group_permission` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT '0',
  `action_id` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0: Not Permit, 1: Permit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group_permission`
--

INSERT INTO `user_group_permission` (`id`, `group_id`, `action_id`, `status`) VALUES
(251, 21, 11, 1),
(252, 21, 12, 1),
(253, 21, 13, 1),
(254, 21, 14, 1),
(255, 21, 15, 1),
(256, 21, 16, 1),
(257, 21, 43, 1),
(258, 21, 44, 1),
(260, 21, 45, 1),
(583, 21, 10, 1),
(588, 21, 50, 1),
(589, 21, 51, 1),
(590, 21, 52, 1),
(591, 21, 53, 1),
(592, 21, 54, 1),
(593, 21, 55, 1),
(594, 21, 56, 1),
(595, 21, 57, 1),
(596, 21, 58, 1),
(597, 21, 59, 1),
(598, 21, 60, 1),
(599, 21, 61, 1),
(600, 21, 62, 1),
(601, 21, 63, 1),
(602, 21, 64, 1),
(603, 21, 65, 1),
(604, 21, 66, 1),
(605, 21, 67, 1),
(606, 21, 68, 1),
(607, 21, 69, 1),
(608, 21, 70, 1),
(609, 21, 71, 1),
(610, 21, 72, 1),
(611, 21, 73, 1),
(612, 21, 74, 1),
(613, 21, 75, 1),
(614, 21, 76, 1),
(615, 21, 77, 1),
(616, 21, 78, 1),
(617, 21, 79, 1),
(618, 21, 80, 1),
(619, 21, 81, 1),
(620, 21, 82, 1),
(621, 21, 83, 1),
(622, 21, 84, 1),
(623, 21, 85, 1),
(624, 21, 86, 1),
(625, 21, 87, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_infos`
--

CREATE TABLE `user_infos` (
  `emp_id` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `designation_name` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `age` varchar(100) NOT NULL,
  `nid_no` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `blood_group` varchar(50) DEFAULT NULL,
  `health_card_no` varchar(50) DEFAULT NULL,
  `is_active_home_page` tinyint(1) NOT NULL DEFAULT '0',
  `remarks` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_infos`
--

INSERT INTO `user_infos` (`emp_id`, `full_name`, `designation_name`, `address`, `age`, `nid_no`, `photo`, `contact_no`, `email`, `blood_group`, `health_card_no`, `is_active_home_page`, `remarks`) VALUES
('1000001', 'Momit', 'Software Engineer', '', '', '', 'images/employee/momit.jpg', '01737151125', 'shofiqueshahin@gmail.com', 'B+', '201800001', 0, 'aaaaaaaaaa'),
('1000002', 'biplob', 'sells man', '', '', '34567890', '', '12345678', 'dfg@ewart.sfd', '0+', NULL, 1, 'none');

-- --------------------------------------------------------

--
-- Table structure for table `web_actions`
--

CREATE TABLE `web_actions` (
  `id` int(11) NOT NULL,
  `activity_name` varchar(50) NOT NULL,
  `module_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_actions`
--

INSERT INTO `web_actions` (`id`, `activity_name`, `module_id`, `status`) VALUES
(10, 'Employee enrty', 1, 0),
(11, 'employee permission', 1, 0),
(12, 'employee update', 1, 0),
(13, 'employee delete', 1, 0),
(14, 'control panel', 6, 0),
(15, 'employee List', 1, 0),
(16, 'permission grid', 1, 0),
(43, 'activity action access', 1, 0),
(44, 'group permission', 1, 0),
(45, 'website permission', 1, 0),
(50, 'Category Entry', 3, 0),
(51, 'Category Delete', 3, 0),
(52, 'Category Update', 3, 0),
(53, 'Category Grid', 3, 0),
(54, 'Ingredient Entry', 3, 0),
(55, 'Ingredient Delete', 3, 0),
(56, 'Ingredient Update', 3, 0),
(57, 'Ingredient Grid', 3, 0),
(58, 'Size Entry', 3, 0),
(59, 'Size Delete', 3, 0),
(60, 'Size Update', 3, 0),
(61, 'Size Grid', 3, 0),
(62, 'Product Entry', 3, 0),
(63, 'Product Delete', 3, 0),
(64, 'Product Update', 3, 0),
(65, 'Product Grid', 3, 0),
(66, 'Customer Entry', 5, 0),
(67, 'Customer Delete', 5, 0),
(68, 'Customer Update', 5, 0),
(69, 'Customer Grid', 5, 0),
(70, 'Outlet Entry', 6, 0),
(71, 'Outlet Update', 6, 0),
(72, 'Outlet Delete', 6, 0),
(73, 'Outlet Grid', 6, 0),
(74, 'Order Entry', 4, 0),
(75, 'Order Delete', 4, 0),
(76, 'Order Update', 4, 0),
(77, 'Order Grid', 4, 0),
(78, 'cupon entry', 6, 0),
(79, 'cupon delete', 6, 0),
(80, 'cupon update', 6, 0),
(81, 'cupon grid', 6, 0),
(82, 'Customer Report', 2, 0),
(83, 'Order Summary Report', 2, 0),
(84, 'Order Details Report', 2, 0),
(85, 'Product Report', 2, 0),
(86, 'Order VS Payment Report', 2, 0),
(87, 'Product sell report', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_login`
--

CREATE TABLE `web_login` (
  `emp_id` varchar(10) NOT NULL,
  `is_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:not logged, 1: logged in',
  `chat_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 1:available,2:meeting,3:busy'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `web_menu`
--

CREATE TABLE `web_menu` (
  `id` int(11) NOT NULL,
  `parent_menu_id` int(11) DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  `menu` varchar(50) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_menu`
--

INSERT INTO `web_menu` (`id`, `parent_menu_id`, `title`, `menu`, `description`) VALUES
(16, 16, 'Services', 'services', '<p>Shastho Shikkha ( Ss), &nbsp;&nbsp; <span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">Medical Services&nbsp; ( Ms) , </span>&nbsp;<span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">&nbsp; Law Awarness &amp; Services ( Las)</span> , &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n'),
(28, 28, 'ABOUT US', 'about-us', '<p>We are extremely proud to inform you our new concept, <span style=\"color:#3b2413\"><strong>Cakencookie</strong></span>. Yes it&rsquo;s a new brand of Bakery &amp; Pastry. It&rsquo;s a sophisticated brand of Nafisa Food &amp; Beverage Ltd. The inhabitants of Dhaka City are getting accustomed to Western and European culture , at the same time huge number of expats are travelling to Bangladesh especially Dhaka due to business . Consequently hospitality industry is growing so fast. Restaurant, Cafe, Club, Bar are increasing dramatically to accomplish the need of locals and expats.</p>\r\n\r\n<p>This logical evolutionary change has drawn our attention and the thirst of people towards variety of food items drive us to shape our business concept regarding the brand, <span style=\"color:#3b2413\"><strong>Cakencookie</strong></span>.</p>\r\n'),
(29, 16, 'Helth Awarness', 'Helth Awarness', '<p>We awar people about some dangarous disease like Cancer, Diabetic, Strock, Adolescent Nutrition, Reproductive Health etc.</p>\r\n'),
(30, 16, 'Diagnosis Services', 'Diagnosis Services', '<p>We provide &quot;Diagnosis Card&quot; thus people get discount on diagonisis in several Diagnostic Center For Primary Disease identifying.</p>\r\n'),
(31, 16, 'Doctors Consultancy', 'Doctors Consultancy', '<p>We will provide/suggest Specialist&nbsp; doctor and best treatment process for a specific disease . Services holder will&nbsp; get Specialist Doctors Consultancy From Self Service Center <span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">w</span><span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">ith w</span><span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">eb Camera.</span></p>\r\n'),
(32, 16, 'Medicin Care', 'Medicin Care', '<p>One of the Main target is to provide people medicine for cheap rate and free(Special cases) From Selective Medicin Shop With internet Health Card.</p>\r\n'),
(33, 16, 'Doctors Serial', 'Doctors Serial', '<p>We will arrange doctor&#39;s serial, because it is very difficult to manage a serial for a rural people</p>\r\n'),
(34, 16, 'Law Services', 'Law Services', '<p>Grow awarness &amp; law support against tourture, childMarige,evetiging, dowry, terorisom, intoxicating &amp; militancy</p>\r\n'),
(35, 28, 'OUR MISSION', 'mission', '<p>Our competent team members are the main strength point of this sophisticated food brand whose are committed to provide superior quality of bakery, pastries, savories, cakes &amp; ice creams. Our motto is to achieve customers satisfaction through implementing total quality management (TQM) . We are highly committed to collect fresh &amp; purest raw materials, process them in a very systematic and hygienic way for making the fine tuned product by our talented chefs. We do focus on our customer feedback &amp; work on it to provide them wow experience that makes them repeat customers.</p>\r\n'),
(36, 28, 'OUR VISSION', 'vission', 'Be the leader of the bakery market through ensuring quality, service, innovation & affordable prices to fulfill the needs of our precious customer & consumer.'),
(37, 28, 'PRODUCTS WE OFFER', 'service', '<p>We believe that the most promising cafes are those which have firm determination to meet guest expectations through their quality of product &amp; Service. This belief has lead us to flourish the brand <span style=\"color:#3b2413\"><strong>Cakencookie </strong></span>that will offer quality of Bakery, Pastry, Hot Savoury, accompanied of varieties coffee and different flavoured Ice-Cream. In short, it&rsquo;s a one stop service offer for the guest convenient only.</p>\r\n'),
(38, 38, 'Contact', 'contact', '<p>Contact address here</p>\r\n'),
(39, 38, 'Address', 'address', '<p>Mohammadpur, Dhaka, Bangladesh 1207,</p><br />\r\n<p>Tongi, Gazipur, Bangladesh 1207,</p>\r\n\r\n'),
(40, 38, 'Mobile', 'mobile', '<p>01980340482</p>\r\n'),
(41, 38, 'Email', 'email', '<p>support@cakencookie.net</p>\r\n'),
(42, 38, 'Office Time', ' Office Time', '<p>&nbsp;8:45 AM&nbsp; to 5:00 PM</p>\r\n'),
(43, 43, 'Terms & Conditions', 'Terms & Conditions', '<p>OVERVIEW</p>\r\n\r\n<p>This website is operated by Cakencookies. Throughout the site, the terms &ldquo;we&rdquo;, &ldquo;us&rdquo; and &ldquo;our&rdquo; refer to Cakencookies. Cakencookies offers this website, including all information, tools and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies and notices stated here.</p>\r\n\r\n<p>By visiting our site and/ or purchasing something from us, you engage in our &ldquo;Service&rdquo; and agree to be bound by the following terms and conditions (&ldquo;Terms of Service&rdquo;, &ldquo;Terms&rdquo;), including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/ or contributors of content.</p>\r\n\r\n<p>Please read these Terms of Service carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the website or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.</p>\r\n\r\n<p>Any new features or tools which are added to the current store shall also be subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our website. It is your responsibility to check this page periodically for changes. Your continued use of or access to the website following the posting of any changes constitutes acceptance of those changes.</p>\r\n\r\n<p>Our store is hosted on EyHost Hosting Service and 2Checkout provides us with the online e-commerce platform that allows us to sell our products and services to you.</p>\r\n\r\n<p>SECTION 1 &ndash; ONLINE STORE TERMS</p>\r\n\r\n<p>By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.</p>\r\n\r\n<p>You may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).</p>\r\n\r\n<p>You must not transmit any worms or viruses or any code of a destructive nature.</p>\r\n\r\n<p>A breach or violation of any of the Terms will result in an immediate termination of your Services.</p>\r\n\r\n<p>SECTION 2 &ndash; GENERAL CONDITIONS</p>\r\n\r\n<p>We reserve the right to refuse service to anyone for any reason at any time.</p>\r\n\r\n<p>You understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks.</p>\r\n\r\n<p>You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the website through which the service is provided, without express written permission by us.</p>\r\n\r\n<p>The headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.</p>\r\n\r\n<p>SECTION 3 &ndash; ACCURACY, COMPLETENESS AND TIMELINESS OF INFORMATION</p>\r\n\r\n<p>We are not responsible if information made available on this site is not accurate, complete or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete or more timely sources of information. Any reliance on the material on this site is at your own risk.</p>\r\n\r\n<p>This site may contain certain historical information. Historical information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site.</p>\r\n\r\n<p>SECTION 4 &ndash; MODIFICATIONS TO THE SERVICE AND PRICES</p>\r\n\r\n<p>Prices for our products are subject to change without notice.</p>\r\n\r\n<p>We reserve the right at any time to modify or discontinue the Service (or any part or content thereof) without notice at any time.</p>\r\n\r\n<p>We shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service.</p>\r\n\r\n<p>SECTION 5 &ndash; PRODUCTS OR SERVICES (if applicable)</p>\r\n\r\n<p>Certain products or services may be available exclusively online through the website. These products or services may have limited quantities and are subject to return or exchange only according to our Return Policy.</p>\r\n\r\n<p>We have made every effort to display as accurately as possible the colors and images of our products that appear at the store. We cannot guarantee that your computer monitor&rsquo;s display of any color will be accurate.</p>\r\n\r\n<p>We reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at anytime without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for any product or service made on this site is void where prohibited.</p>\r\n\r\n<p>We do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.</p>\r\n\r\n<p>SECTION 6 &ndash; ACCURACY OF BILLING AND ACCOUNT INFORMATION</p>\r\n\r\n<p>We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.</p>\r\n\r\n<p>You agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.</p>\r\n\r\n<p>For more detail, please review our Returns Policy.</p>\r\n\r\n<p>SECTION 7 &ndash; OPTIONAL TOOLS</p>\r\n\r\n<p>We may provide you with access to third-party tools over which we neither monitor nor have any control nor input.</p>\r\n\r\n<p>You acknowledge and agree that we provide access to such tools &rdquo;as is&rdquo; and &ldquo;as available&rdquo; without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools.</p>\r\n\r\n<p>Any use by you of optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).</p>\r\n\r\n<p>We may also, in the future, offer new services and/or features through the website (including, the release of new tools and resources). Such new features and/or services shall also be subject to these Terms of Service.</p>\r\n\r\n<p>SECTION 8 &ndash; THIRD-PARTY LINKS</p>\r\n\r\n<p>Certain content, products and services available via our Service may include materials from third-parties.</p>\r\n\r\n<p>Third-party links on this site may direct you to third-party websites that are not affiliated with us. We are not responsible for examining or evaluating the content or accuracy and we do not warrant and will not have any liability or responsibility for any third-party materials or websites, or for any other materials, products, or services of third-parties.</p>\r\n\r\n<p>We are not liable for any harm or damages related to the purchase or use of goods, services, resources, content, or any other transactions made in connection with any third-party websites. Please review carefully the third-party&rsquo;s policies and practices and make sure you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding third-party products should be directed to the third-party.</p>\r\n\r\n<p>SECTION 9 &ndash; USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS</p>\r\n\r\n<p>If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, &lsquo;comments&rsquo;), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us. We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for any comments; or (3) to respond to any comments.</p>\r\n\r\n<p>We may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party&rsquo;s intellectual property or these Terms of Service.</p>\r\n\r\n<p>You agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by you or any third-party.</p>\r\n\r\n<p>SECTION 10 &ndash; PERSONAL INFORMATION</p>\r\n\r\n<p>Your submission of personal information through the store is governed by our Privacy Policy. To view our Privacy Policy.</p>\r\n\r\n<p>SECTION 11 &ndash; ERRORS, INACCURACIES AND OMISSIONS</p>\r\n\r\n<p>Occasionally there may be information on our site or in the Service that contains typographical errors, inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, product shipping charges, transit times and availability. We reserve the right to correct any errors, inaccuracies or omissions, and to change or update information or cancel orders if any information in the Service or on any related website is inaccurate at any time without prior notice (including after you have submitted your order).</p>\r\n\r\n<p>We undertake no obligation to update, amend or clarify information in the Service or on any related website, including without limitation, pricing information, except as required by law. No specified update or refresh date applied in the Service or on any related website, should be taken to indicate that all information in the Service or on any related website has been modified or updated.</p>\r\n\r\n<p>SECTION 12 &ndash; PROHIBITED USES</p>\r\n\r\n<p>In addition to other prohibitions as set forth in the Terms of Service, you are prohibited from using the site or its content: (a) for any unlawful purpose; (b) to solicit others to perform or participate in any unlawful acts; (c) to violate any international, federal, provincial or state regulations, rules, laws, or local ordinances; (d) to infringe upon or violate our intellectual property rights or the intellectual property rights of others; (e) to harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, race, age, national origin, or disability; (f) to submit false or misleading information; (g) to upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Service or of any related website, other websites, or the Internet; (h) to collect or track the personal information of others; (i) to spam, phish, pharm, pretext, spider, crawl, or scrape; (j) for any obscene or immoral purpose; or (k) to interfere with or circumvent the security features of the Service or any related website, other websites, or the Internet. We reserve the right to terminate your use of the Service or any related website for violating any of the prohibited uses.</p>\r\n\r\n<p>SECTION 13 &ndash; DISCLAIMER OF WARRANTIES; LIMITATION OF LIABILITY</p>\r\n\r\n<p>We do not guarantee, represent or warrant that your use of our service will be uninterrupted, timely, secure or error-free.</p>\r\n\r\n<p>We do not warrant that the results that may be obtained from the use of the service will be accurate or reliable.</p>\r\n\r\n<p>You agree that from time to time we may remove the service for indefinite periods of time or cancel the service at any time, without notice to you.</p>\r\n\r\n<p>You expressly agree that your use of, or inability to use, the service is at your sole risk. The service and all products and services delivered to you through the service are (except as expressly stated by us) provided &lsquo;as is&rsquo; and &lsquo;as available&rsquo; for your use, without any representation, warranties or conditions of any kind, either express or implied, including all implied warranties or conditions of merchantability, merchantable quality, fitness for a particular purpose, durability, title, and non-infringement.</p>\r\n\r\n<p>In no case shall Cakencookies, our directors, officers, employees, affiliates, agents, contractors, interns, suppliers, service providers or licensors be liable for any injury, loss, claim, or any direct, indirect, incidental, punitive, special, or consequential damages of any kind, including, without limitation lost profits, lost revenue, lost savings, loss of data, replacement costs, or any similar damages, whether based in contract, tort (including negligence), strict liability or otherwise, arising from your use of any of the service or any products procured using the service, or for any other claim related in any way to your use of the service or any product, including, but not limited to, any errors or omissions in any content, or any loss or damage of any kind incurred as a result of the use of the service or any content (or product) posted, transmitted, or otherwise made available via the service, even if advised of their possibility. Because some states or jurisdictions do not allow the exclusion or the limitation of liability for consequential or incidental damages, in such states or jurisdictions, our liability shall be limited to the maximum extent permitted by law.</p>\r\n\r\n<p>SECTION 14 &ndash; INDEMNIFICATION</p>\r\n\r\n<p>You agree to indemnify, defend and hold harmless King&rsquo;s Confectionery (Bangladesh) Pte. Ltd. and our parent, subsidiaries, affiliates, partners, officers, directors, agents, contractors, licensors, service providers, subcontractors, suppliers, interns and employees, harmless from any claim or demand, including reasonable attorneys&rsquo; fees, made by any third-party due to or arising out of your breach of these Terms of Service or the documents they incorporate by reference, or your violation of any law or the rights of a third-party.</p>\r\n\r\n<p>SECTION 15 &ndash; SEVERABILITY</p>\r\n\r\n<p>In the event that any provision of these Terms of Service is determined to be unlawful, void or unenforceable, such provision shall nonetheless be enforceable to the fullest extent permitted by applicable law, and the unenforceable portion shall be deemed to be severed from these Terms of Service, such determination shall not affect the validity and enforceability of any other remaining provisions.</p>\r\n\r\n<p>SECTION 16 &ndash; TERMINATION</p>\r\n\r\n<p>The obligations and liabilities of the parties incurred prior to the termination date shall survive the termination of this agreement for all purposes.</p>\r\n\r\n<p>These Terms of Service are effective unless and until terminated by either you or us. You may terminate these Terms of Service at any time by notifying us that you no longer wish to use our Services, or when you cease using our site.</p>\r\n\r\n<p>If in our sole judgment you fail, or we suspect that you have failed, to comply with any term or provision of these Terms of Service, we also may terminate this agreement at any time without notice and you will remain liable for all amounts due up to and including the date of termination; and/or accordingly may deny you access to our Services (or any part thereof).</p>\r\n\r\n<p>SECTION 17 &ndash; ENTIRE AGREEMENT</p>\r\n\r\n<p>The failure of us to exercise or enforce any right or provision of these Terms of Service shall not constitute a waiver of such right or provision.</p>\r\n\r\n<p>These Terms of Service and any policies or operating rules posted by us on this site or in respect to The Service constitutes the entire agreement and understanding between you and us and govern your use of the Service, superseding any prior or contemporaneous agreements, communications and proposals, whether oral or written, between you and us (including, but not limited to, any prior versions of the Terms of Service).</p>\r\n\r\n<p>Any ambiguities in the interpretation of these Terms of Service shall not be construed against the drafting party.</p>\r\n\r\n<p>SECTION 18 &ndash; JURISDICTION AND RESTRICTION</p>\r\n\r\n<p>Cakencookies controls and maintains this Web Site from Bangladesh. The materials and information contained in this section of this Web Site, relating to Bangladesh, is directed at and restricted to individuals resident in or entities having a place of business in Bangladesh ONLY. The Cakencookies makes no representation that the materials and information contained herein is appropriate or available for use in other locations / jurisdictions.</p>\r\n\r\n<p>These Terms and Conditions are governed by and construed in accordance with the laws of Bangladesh and any dispute relating thereto shall be subject to the non-exclusive jurisdiction of the courts of Bangladesh.</p>\r\n\r\n<p>SECTION 19 &ndash; CHANGES TO TERMS OF SERVICE</p>\r\n\r\n<p>You can review the most current version of the Terms of Service at any time at this page.</p>\r\n\r\n<p>We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Service by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. Your continued use of or access to our website or the Service following the posting of any changes to these Terms of Service constitutes acceptance of those changes.</p>\r\n\r\n<p>SECTION 20 &ndash; CONTACT INFORMATION</p>\r\n'),
(45, NULL, 'Privacy Policy', 'Privacy', '<p>SECTION 1 &ndash; WHAT DO WE DO WITH YOUR INFORMATION?</p>\r\n\r\n<p>When you purchase something from our store, as part of the buying and selling process, we collect the personal information you give us such as your name, address and email address.</p>\r\n\r\n<p>When you browse our store, we also automatically receive your computer&rsquo;s internet protocol (IP) address in order to provide us with information that helps us learn about your browser and operating system.</p>\r\n\r\n<p>Email marketing (if applicable): With your permission, we may send you emails about our store, new products and other updates.</p>\r\n\r\n<p>SECTION 2 &ndash; CONSENT</p>\r\n\r\n<p>How do you get my consent?</p>\r\n\r\n<p>When you provide us with personal information to complete a transaction, verify your credit card, place an order, arrange for a delivery or return a purchase, we imply that you consent to our collecting it and using it for that specific reason only.</p>\r\n\r\n<p>If we ask for your personal information for a secondary reason, like marketing, we will either ask you directly for your expressed consent, or provide you with an opportunity to say no.</p>\r\n\r\n<p>How do I withdraw my consent?</p>\r\n\r\n<p>If after you opt-in, you change your mind, you may withdrawing your consent for us to contact you, for the continued collection, use or disclosure of your information, at anytime, by contacting us at info@kingsbd.com or mailing us at:</p>\r\n\r\n<p>Cakencookies</p>\r\n\r\n<p>House No. 17, Road No. 11, Block G, Banani, Dhaka-1213, Bangladesh</p>\r\n\r\n<p>SECTION 3 &ndash; DISCLOSURE</p>\r\n\r\n<p>We may disclose your personal information if we are required by law to do so or if you violate our Terms of Service.</p>\r\n\r\n<p>SECTION 4 &ndash; EyHOST HOSTING SERVICE &amp; 2CHECKOUT</p>\r\n\r\n<p>Our store is hosted on EyHost Hosting Service and our direct payment gateway is provided by 2Checkout. They provide us with the online e-commerce platform that allows us to sell our products and services to you.</p>\r\n\r\n<p>Your data is stored through EyHost Hosting Service&rsquo;s and 2Checkout&rsquo;s data storage, databases and the general 2Checkout application. They store your data on a secure server behind a firewall.</p>\r\n\r\n<p>Payment:</p>\r\n\r\n<p>If you choose a direct payment gateway to complete your purchase, then 2Checkout stores your credit card data. It is encrypted through the Payment Card Industry Data Security Standard (PCI-DSS). Your purchase transaction data is stored only as long as is necessary to complete your purchase transaction. After that is complete, your purchase transaction information is deleted.</p>\r\n\r\n<p>All direct payment gateways adhere to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, MasterCard, American Express and Discover.</p>\r\n\r\n<p>PCI-DSS requirements help ensure the secure handling of credit card information by our store and its service providers.</p>\r\n\r\n<p>For more insight, you may also want to read 2Checkout&rsquo;s Terms of Service here https://www.2checkout.com/policies/terms-of-use or Privacy Statement here https://www.2checkout.com/policies/privacy-policy.</p>\r\n\r\n<p>SECTION 5 &ndash; THIRD-PARTY SERVICES</p>\r\n\r\n<p>In general, the third-party providers used by us will only collect, use and disclose your information to the extent necessary to allow them to perform the services they provide to us.</p>\r\n\r\n<p>However, certain third-party service providers, such as payment gateways and other payment transaction processors, have their own privacy policies in respect to the information we are required to provide to them for your purchase-related transactions.</p>\r\n\r\n<p>For these providers, we recommend that you read their privacy policies so you can understand the manner in which your personal information will be handled by these providers.</p>\r\n\r\n<p>In particular, remember that certain providers may be located in or have facilities that are located a different jurisdiction than either you or us. So if you elect to proceed with a transaction that involves the services of a third-party service provider, then your information may become subject to the laws of the jurisdiction(s) in which that service provider or its facilities are located.</p>\r\n\r\n<p>Once you leave our store&rsquo;s website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our website&rsquo;s Terms of Service.</p>\r\n\r\n<p>Links</p>\r\n\r\n<p>When you click on links on our store, they may direct you away from our site. We are not responsible for the privacy practices of other sites and encourage you to read their privacy statements.</p>\r\n\r\n<p>Google analytics:</p>\r\n\r\n<p>Our store uses Google Analytics to help us learn about who visits our site and what pages are being looked at.</p>\r\n\r\n<p>SECTION 6 &ndash; SECURITY</p>\r\n\r\n<p>To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered or destroyed.</p>\r\n\r\n<p>If you provide us with your credit card information, the information is encrypted using secure socket layer technology (SSL) and stored with a AES-256 encryption.&nbsp; Although no method of transmission over the Internet or electronic storage is 100% secure, we follow all PCI-DSS requirements and implement additional generally accepted industry standards.</p>\r\n\r\n<p>SECTION 7 &ndash; COOKIES</p>\r\n\r\n<p>In order to improve our Internet service to you, we will occasionally use a &ldquo;cookie&rdquo; and/or other similar files or programs which may place certain information on your computer&rsquo;s hard drive when you visit an Cakencookies&rsquo;s web site. A cookie is a small amount of data that our web server sends to your web browser when you visit certain parts of our site. We may use cookies to:</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp; allow us to recognise the PC you are using when you return to our web site so that we can understand your interest in our web site and tailor its content and advertisements to match your interests (This type of cookie may be stored permanently on your PC but does not contain any information that can identify you personally.);<br />\r\n&nbsp;&nbsp;&nbsp; identify you after you have logged in by storing a temporary reference number in the cookie so that our web server can conduct a dialogue with you while simultaneously dealing with other customers. (Your browser keeps this type of cookie until you log off or close down your browser when these types of cookie are normally deleted. No other information is stored in this type of cookie.);<br />\r\n&nbsp;&nbsp;&nbsp; allow you to carry information across pages of our site and avoid having to re-enter that information;<br />\r\n&nbsp;&nbsp;&nbsp; allow you access to stored information if you register for any of our on-line services;<br />\r\n&nbsp;&nbsp;&nbsp; enable us to produce statistical information (anonymous) which helps us to improve the structure and content of our web site;<br />\r\n&nbsp;&nbsp;&nbsp; enable us to evaluate the effectiveness of our advertising and promotions.</p>\r\n\r\n<p>Cookies do not enable us to gather personal information about you unless you give the information to our server. Most Internet browser software allows the blocking of all cookies or enables you to receive a warning before a cookie is stored. For further information, please refer to your Internet browser software instructions or help screen.</p>\r\n\r\n<p>SECTION 8 &ndash; INTERNET COMMUNICATIONS</p>\r\n\r\n<p>In order to maintain the security of our systems, protect our staff, record transactions, and, in certain circumstances, to prevent and detect crime or unauthorized activities, Cakencookies reserves the right to monitor all internet communications including web and email traffic into and out of its domains.</p>\r\n\r\n<p>SECTION 9 &ndash; AGE OF CONSENT</p>\r\n\r\n<p>By using this site, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.</p>\r\n\r\n<p>SECTION 10 &ndash; CHANGES TO THIS PRIVACY POLICY</p>\r\n\r\n<p>We reserve the right to modify this privacy policy at any time, so please review it frequently. Changes and clarifications will take effect immediately upon their posting on the website. If we make material changes to this policy, we will notify you here that it has been updated, so that you are aware of what information we collect, how we use it, and under what circumstances, if any, we use and/or disclose it.</p>\r\n\r\n<p>If our store is acquired or merged with another company, your information may be transferred to the new owners so that we may continue to sell products to you.</p>\r\n\r\n<p>QUESTIONS AND CONTACT INFORMATION</p>\r\n\r\n<p>If you would like to: access, correct, amend or delete any personal information we have about you, register a complaint, or simply want more information contact our Privacy Compliance Officer at info@kingsbd.com or by mail at</p>\r\n'),
(46, NULL, 'Refund Policy', 'Refund Policy', '<p>Any changes or cancellations to your order must be placed at least 48 hours in advance of the scheduled delivery or pick up time of your order.&nbsp; If a cancellation is placed at least 48 hours in advance, we are able to issue a 100% refund for your order.&nbsp; Any cancellations or changes made within 48 hours of the scheduled delivery or pick up time of your order are completely non-refundable.</p>\r\n\r\n<p>If you are unsatisfied with your purchase for any reason after delivery of the product has been accepted, please give us a call at</p>\r\n\r\n<p>1. Manager Operation : +8801755455-666546562932 or<br />\r\n2. Assistant Manager Operation : +88017554545-66+645+652933</p>\r\n\r\n<p>&nbsp;so we can remedy the situation.</p>\r\n'),
(47, 28, 'Speciality', 'Speciality', '<p>A Concern of Nafisa Group<br />\r\nWe believe that the most promising cafes are those which have firm determination to meet guest expectations through their quality of product &amp; Service.</p>\r\n'),
(48, 55, 'Special Menu', 'Special Menu', '<p>The role of a good cook ware in the preparation of a sumptuous meal cannot be over emphasized then one consider white bread</p>\r\n'),
(49, 55, 'Welcome Subtitle', 'Welcome Subtitle', '<h6>Savory/Pastry/Cake/Coffee/Cookies/Bread</h6>\r\n'),
(50, 55, 'We Are Best', 'We Are Best', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>\r\n'),
(51, 55, 'Fresh Dishes', 'Fresh Dishes', 'Fresh Dishes Details'),
(52, 55, 'Verious Items', 'Verious Items', 'Verious Items details'),
(53, 55, 'Well Service', 'Well Service', 'Well Service details'),
(54, 55, 'Fast Delivery', 'Fast Delivery', 'Fast Delivery Details'),
(55, NULL, 'Home', 'Home', 'details no need to edit. this is only for development reason'),
(56, NULL, 'Social Network', 'Social Network', 'dont edit this , only for development'),
(57, 56, 'facebook link', 'facebook link', 'https://www.facebook.com/Cakencookiee/'),
(58, 56, 'twitter link', 'twitter link', 'https://www.twitter.com/Cakencookiee/'),
(59, 56, 'instagram link', 'instagram  link', 'https://www.instagram.com/Cakencookiee/'),
(60, 56, 'googleplus  link', 'googleplus  link', 'https://www.googleplus.com/Cakencookiee/');

-- --------------------------------------------------------

--
-- Table structure for table `web_module`
--

CREATE TABLE `web_module` (
  `id` int(11) NOT NULL,
  `module_name` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_module`
--

INSERT INTO `web_module` (`id`, `module_name`, `status`) VALUES
(1, 'HRM', 0),
(2, 'Report', 0),
(3, 'Product', 0),
(4, 'Order', 0),
(5, 'Customer', 0),
(6, 'Control Panel', 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_notice`
--

CREATE TABLE `web_notice` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `details` text NOT NULL,
  `attachment` varchar(200) DEFAULT NULL,
  `banner_img` varchar(100) DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `posted_by` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:Pending, 2:Approved, 3: Deleted',
  `remarks` varchar(50) DEFAULT NULL,
  `post_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 News, 2: Events',
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Default, 1: Pinned_Post'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_notice`
--

INSERT INTO `web_notice` (`id`, `title`, `details`, `attachment`, `banner_img`, `expire_date`, `posted_by`, `status`, `remarks`, `post_date`, `type`, `is_pinned`) VALUES
(6, 'Notice Event', '<p>Up Coming</p>\r\n', 'Jellyfish.jpg,Penguins.jpg,Lighthouse.jpg', '', '2017-12-06', '1000001', 1, NULL, '2017-11-29 05:52:30', 2, 0),
(7, 'Notice Test', '<p>Up Coming</p>\r\n', '', '', '0000-00-00', '1000001', 1, NULL, '2017-11-29 06:10:54', 1, 0),
(12, 'Diagnosis Services Center', '<p>Popular Diagnostic Center, Thanthania Bogra.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 'Untitled-1.jpg ', '', '2018-03-23', '1000001', 1, NULL, '2018-03-23 00:36:07', 2, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appuser`
--
ALTER TABLE `appuser`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `con_user_created_by_fk` (`created_by`),
  ADD KEY `con_user_modified_by_fk` (`modified_by`);

--
-- Indexes for table `banner_image`
--
ALTER TABLE `banner_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cupons`
--
ALTER TABLE `cupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_infos`
--
ALTER TABLE `customer_infos`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `custom_cake`
--
ALTER TABLE `custom_cake`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_charge`
--
ALTER TABLE `delivery_charge`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_contact`
--
ALTER TABLE `external_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallary_images`
--
ALTER TABLE `gallary_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gallary_images_image_group` (`album_id`);

--
-- Indexes for table `image_album`
--
ALTER TABLE `image_album`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_master`
--
ALTER TABLE `order_master`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `outlets`
--
ALTER TABLE `outlets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_ingredient`
--
ALTER TABLE `product_ingredient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_rate`
--
ALTER TABLE `product_rate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_review`
--
ALTER TABLE `product_review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `size`
--
ALTER TABLE `size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group_member`
--
ALTER TABLE `user_group_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Index 2` (`group_id`,`emp_id`),
  ADD KEY `FK_emp_infos` (`emp_id`);

--
-- Indexes for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Index 2` (`group_id`,`action_id`),
  ADD KEY `FK__activity_actions` (`action_id`);

--
-- Indexes for table `user_infos`
--
ALTER TABLE `user_infos`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `web_actions`
--
ALTER TABLE `web_actions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `web_login`
--
ALTER TABLE `web_login`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `web_menu`
--
ALTER TABLE `web_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_web_menu_web_menu` (`parent_menu_id`);

--
-- Indexes for table `web_module`
--
ALTER TABLE `web_module`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `web_notice`
--
ALTER TABLE `web_notice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1_poosted_by` (`posted_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banner_image`
--
ALTER TABLE `banner_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `cupons`
--
ALTER TABLE `cupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_infos`
--
ALTER TABLE `customer_infos`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `custom_cake`
--
ALTER TABLE `custom_cake`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `delivery_charge`
--
ALTER TABLE `delivery_charge`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `external_contact`
--
ALTER TABLE `external_contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gallary_images`
--
ALTER TABLE `gallary_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `image_album`
--
ALTER TABLE `image_album`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `order_master`
--
ALTER TABLE `order_master`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `outlets`
--
ALTER TABLE `outlets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `product_ingredient`
--
ALTER TABLE `product_ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=492;

--
-- AUTO_INCREMENT for table `product_rate`
--
ALTER TABLE `product_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- AUTO_INCREMENT for table `product_review`
--
ALTER TABLE `product_review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `size`
--
ALTER TABLE `size`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_group_member`
--
ALTER TABLE `user_group_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=626;

--
-- AUTO_INCREMENT for table `web_actions`
--
ALTER TABLE `web_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `web_menu`
--
ALTER TABLE `web_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `web_module`
--
ALTER TABLE `web_module`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `web_notice`
--
ALTER TABLE `web_notice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appuser`
--
ALTER TABLE `appuser`
  ADD CONSTRAINT `con_user_created_by_fk` FOREIGN KEY (`created_by`) REFERENCES `user_infos` (`emp_id`),
  ADD CONSTRAINT `con_user_modified_by_fk` FOREIGN KEY (`modified_by`) REFERENCES `user_infos` (`emp_id`),
  ADD CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user_infos` (`emp_id`);

--
-- Constraints for table `gallary_images`
--
ALTER TABLE `gallary_images`
  ADD CONSTRAINT `FK_gallary_images_image_album` FOREIGN KEY (`album_id`) REFERENCES `image_album` (`id`);

--
-- Constraints for table `user_group_member`
--
ALTER TABLE `user_group_member`
  ADD CONSTRAINT `FK__user_group` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  ADD CONSTRAINT `FK_emp_infos` FOREIGN KEY (`emp_id`) REFERENCES `user_infos` (`emp_id`);

--
-- Constraints for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  ADD CONSTRAINT `FK__activity_actions` FOREIGN KEY (`action_id`) REFERENCES `web_actions` (`id`),
  ADD CONSTRAINT `FK__user_group_id` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`);

--
-- Constraints for table `web_login`
--
ALTER TABLE `web_login`
  ADD CONSTRAINT `emp_id_fk` FOREIGN KEY (`emp_id`) REFERENCES `user_infos` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `web_menu`
--
ALTER TABLE `web_menu`
  ADD CONSTRAINT `FK_web_menu_web_menu` FOREIGN KEY (`parent_menu_id`) REFERENCES `web_menu` (`id`);

--
-- Constraints for table `web_notice`
--
ALTER TABLE `web_notice`
  ADD CONSTRAINT `FK1_poosted_by` FOREIGN KEY (`posted_by`) REFERENCES `user_infos` (`emp_id`);
--
-- Database: `donor`
--
CREATE DATABASE IF NOT EXISTS `donor` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `donor`;

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `division` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `district` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subordinate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`id`, `division`, `district`, `subordinate`, `branch`, `post_code`) VALUES
(1, 'Dhaka', 'Dhaka', 'Demra', 'Demra', 1360),
(2, 'Dhaka', 'Dhaka', 'Demra', 'Sarulia', 1361),
(3, 'Dhaka', 'Dhaka', 'Demra', 'Matuail', 1362),
(4, 'Dhaka', 'Dhaka', 'Dhaka GPO', 'Dhaka GPO', 1000),
(5, 'Dhaka', 'Dhaka', 'Dhaka Main PO', 'Dhaka Main PO', 1100),
(6, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Wari TSO', 1203),
(7, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gendaria TSO', 1204),
(8, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'New Market TSO', 1205),
(9, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhaka CantonmentTSO', 1206),
(10, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mohammadpur Housing', 1207),
(11, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhaka Politechnic', 1208),
(12, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Jigatala TSO', 1209),
(13, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Posta TSO', 1211),
(14, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gulshan Model Town', 1212),
(15, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Banani TSO', 1213),
(16, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Basabo TSO', 1214),
(17, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Tejgaon TSO', 1215),
(18, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Shantinagr TSO', 1217),
(19, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mirpur TSO', 1218),
(20, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilgaonTSO', 1219),
(21, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'BangabhabanTSO', 1222),
(22, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'DilkushaTSO', 1223),
(23, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Sangsad BhabanTSO', 1225),
(24, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilkhetTSO', 1229),
(25, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Uttara Model TwonTSO', 1231),
(26, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhania TSO', 1232),
(27, 'Dhaka', 'Dhaka', 'Dhamrai', 'Dhamrai', 1350),
(28, 'Dhaka', 'Dhaka', 'Dhamrai', 'Kamalpur', 1351),
(29, 'Dhaka', 'Dhaka', 'Joypara', 'Joypara', 1330),
(30, 'Dhaka', 'Dhaka', 'Joypara', 'Palamganj', 1331),
(31, 'Dhaka', 'Dhaka', 'Joypara', 'Narisha', 1332),
(32, 'Dhaka', 'Dhaka', 'Keraniganj', 'Keraniganj', 1310),
(33, 'Dhaka', 'Dhaka', 'Keraniganj', 'Dhaka Jute Mills', 1311),
(34, 'Dhaka', 'Dhaka', 'Keraniganj', 'Ati', 1312),
(35, 'Dhaka', 'Dhaka', 'Keraniganj', 'Kalatia', 1313),
(36, 'Dhaka', 'Dhaka', 'Nawabganj', 'Nawabganj', 1320),
(37, 'Dhaka', 'Dhaka', 'Nawabganj', 'Hasnabad', 1321),
(38, 'Dhaka', 'Dhaka', 'Nawabganj', 'Daudpur', 1322),
(39, 'Dhaka', 'Dhaka', 'Nawabganj', 'Agla', 1323),
(40, 'Dhaka', 'Dhaka', 'Nawabganj', 'Khalpar', 1324),
(41, 'Dhaka', 'Dhaka', 'Nawabganj', 'Churain', 1325),
(42, 'Dhaka', 'Dhaka', 'Savar', 'Savar', 1340),
(43, 'Dhaka', 'Dhaka', 'Savar', 'Dairy Farm', 1341),
(44, 'Dhaka', 'Dhaka', 'Savar', 'Jahangirnagar Univer', 1342),
(45, 'Dhaka', 'Dhaka', 'Savar', 'Saver P.A.T.C', 1343),
(46, 'Dhaka', 'Dhaka', 'Savar', 'Savar Canttonment', 1344),
(47, 'Dhaka', 'Dhaka', 'Savar', 'Shimulia', 1345),
(48, 'Dhaka', 'Dhaka', 'Savar', 'Kashem Cotton Mills', 1346),
(49, 'Dhaka', 'Dhaka', 'Savar', 'Rajphulbaria', 1347),
(50, 'Dhaka', 'Dhaka', 'Savar', 'Amin Bazar', 1348),
(51, 'Dhaka', 'Dhaka', 'Savar', 'EPZ', 1349),
(52, 'Dhaka', 'Mymensingh', 'Bhaluka', 'Bhaluka', 2240),
(53, 'Dhaka', 'Mymensingh', 'Fulbaria', 'Fulbaria', 2216),
(54, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Gaforgaon', 2230),
(55, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Shibganj', 2231),
(56, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Usti', 2232),
(57, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Kandipara', 2233),
(58, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Duttarbazar', 2234),
(59, 'Dhaka', 'Mymensingh', 'Gouripur', 'Gouripur', 2270),
(60, 'Dhaka', 'Mymensingh', 'Gouripur', 'Ramgopalpur', 2271),
(61, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Haluaghat', 2260),
(62, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Dhara', 2261),
(63, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Munshirhat', 2262),
(64, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Isshwargonj', 2280),
(65, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Sohagi', 2281),
(66, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Atharabari', 2282),
(67, 'Dhaka', 'Mymensingh', 'Muktagachha', 'Muktagachha', 2210),
(68, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Mymensingh Sadar', 2200),
(69, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Kawatkhali', 2201),
(70, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Agriculture Universi', 2202),
(71, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Shombhuganj', 2203),
(72, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Biddyaganj', 2204),
(73, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Pearpur', 2205),
(74, 'Dhaka', 'Mymensingh', 'Nandail', 'Nandail', 2290),
(75, 'Dhaka', 'Mymensingh', 'Nandail', 'Gangail', 2291),
(76, 'Dhaka', 'Mymensingh', 'Phulpur', 'Phulpur', 2250),
(77, 'Dhaka', 'Mymensingh', 'Phulpur', 'Beltia', 2251),
(78, 'Dhaka', 'Mymensingh', 'Phulpur', 'Tarakanda', 2252),
(79, 'Dhaka', 'Mymensingh', 'Trishal', 'Trishal', 2220),
(80, 'Dhaka', 'Mymensingh', 'Trishal', 'Ahmadbad', 2221),
(81, 'Dhaka', 'Mymensingh', 'Trishal', 'Ram Amritaganj', 2222),
(82, 'Dhaka', 'Mymensingh', 'Trishal', 'Dhala', 2223),
(83, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Bajitpur', 2336),
(84, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Sararchar', 2337),
(85, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Laksmipur', 2338),
(86, 'Dhaka', 'Kishoreganj', 'Bhairob', 'Bhairab', 2350),
(87, 'Dhaka', 'Kishoreganj', 'Hossenpur', 'Hossenpur', 2320),
(88, 'Dhaka', 'Kishoreganj', 'Itna', 'Itna', 2390),
(89, 'Dhaka', 'Kishoreganj', 'Karimganj', 'Karimganj', 2310),
(90, 'Dhaka', 'Kishoreganj', 'Katiadi', 'Katiadi', 2330),
(91, 'Dhaka', 'Kishoreganj', 'Katiadi', 'Gochhihata', 2331),
(92, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj Sadar', 2300),
(93, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj S.Mills', 2301),
(94, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Maizhati', 2302),
(95, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Nilganj', 2303),
(96, 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Kuliarchar', 2340),
(97, 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Chhoysuti', 2341),
(98, 'Dhaka', 'Kishoreganj', 'Mithamoin', 'MIthamoin', 2370),
(99, 'Dhaka', 'Kishoreganj', 'Mithamoin', 'Abdullahpur', 2371),
(100, 'Dhaka', 'Kishoreganj', 'Nikli', 'Nikli', 2360),
(101, 'Dhaka', 'Kishoreganj', 'Ostagram', 'Ostagram', 2380),
(102, 'Dhaka', 'Kishoreganj', 'Pakundia', 'Pakundia', 2326),
(103, 'Dhaka', 'Kishoreganj', 'Tarial', 'Tarial', 2316),
(104, 'Dhaka', 'Netrakona', 'Susung Durgapur', 'IBH WAs Here', 2420),
(105, 'Dhaka', 'Netrakona', 'Susung Durgapur', 'Susnng Durgapur', 2420),
(106, 'Dhaka', 'Netrakona', 'Atpara', 'Atpara', 2470),
(107, 'Dhaka', 'Netrakona', 'Barhatta', 'Barhatta', 2440),
(108, 'Dhaka', 'Netrakona', 'Dharmapasha', 'Dharampasha', 2450),
(109, 'Dhaka', 'Netrakona', 'Dhobaura', 'Dhobaura', 2416),
(110, 'Dhaka', 'Netrakona', 'Dhobaura', 'Sakoai', 2417),
(111, 'Dhaka', 'Netrakona', 'Kalmakanda', 'Kalmakanda', 2430),
(112, 'Dhaka', 'Netrakona', 'Kendua', 'Kendua', 2480),
(113, 'Dhaka', 'Netrakona', 'Khaliajuri', 'Khaliajhri', 2460),
(114, 'Dhaka', 'Netrakona', 'Khaliajuri', 'Shaldigha', 2462),
(115, 'Dhaka', 'Netrakona', 'Madan', 'Madan', 2490),
(116, 'Dhaka', 'Netrakona', 'Moddhynagar', 'Moddoynagar', 2456),
(117, 'Dhaka', 'Netrakona', 'Mohanganj', 'Mohanganj', 2446),
(118, 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Netrakona Sadar', 2400),
(119, 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Baikherhati', 2401),
(120, 'Dhaka', 'Netrakona', 'Purbadhola', 'Purbadhola', 2410),
(121, 'Dhaka', 'Netrakona', 'Purbadhola', 'Shamgonj', 2411),
(122, 'Dhaka', 'Netrakona', 'Purbadhola', 'Jaria Jhanjhail', 2412),
(123, 'Dhaka', 'Narayanganj', 'Araihazar', 'Araihazar', 1450),
(124, 'Dhaka', 'Narayanganj', 'Araihazar', 'Gopaldi', 1451),
(125, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Baidder Bazar', 1440),
(126, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Bara Nagar', 1441),
(127, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Barodi', 1442),
(128, 'Dhaka', 'Narayanganj', 'Bandar', 'Bandar', 1410),
(129, 'Dhaka', 'Narayanganj', 'Bandar', 'D.C Mills', 1411),
(130, 'Dhaka', 'Narayanganj', 'Bandar', 'Nabiganj', 1412),
(131, 'Dhaka', 'Narayanganj', 'Bandar', 'BIDS', 1413),
(132, 'Dhaka', 'Narayanganj', 'Bandar', 'Madanganj', 1414),
(133, 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatullah', 1420),
(134, 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatulla Bazar', 1421),
(135, 'Dhaka', 'Narayanganj', 'Narayanganj Sadar', 'Narayanganj Sadar', 1400),
(136, 'Dhaka', 'Narayanganj', 'Rupganj', 'Rupganj', 1460),
(137, 'Dhaka', 'Narayanganj', 'Rupganj', 'Kanchan', 1461),
(138, 'Dhaka', 'Narayanganj', 'Rupganj', 'Bhulta', 1462),
(139, 'Dhaka', 'Narayanganj', 'Rupganj', 'Nagri', 1463),
(140, 'Dhaka', 'Narayanganj', 'Rupganj', 'Murapara', 1464),
(141, 'Dhaka', 'Narayanganj', 'Siddirganj', 'Siddirganj', 1430),
(142, 'Dhaka', 'Narayanganj', 'Siddirganj', 'Adamjeenagar', 1431),
(143, 'Dhaka', 'Narayanganj', 'Siddirganj', 'LN Mills', 1432),
(144, 'Dhaka', 'Munshiganj', 'Gajaria', 'Gajaria', 1510),
(145, 'Dhaka', 'Munshiganj', 'Gajaria', 'Hossendi', 1511),
(146, 'Dhaka', 'Munshiganj', 'Gajaria', 'Rasulpur', 1512),
(147, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haridia', 1333),
(148, 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', 1334),
(149, 'Dhaka', 'Munshiganj', 'Lohajong', 'Madini Mandal', 1335),
(150, 'Dhaka', 'Munshiganj', 'Lohajong', 'Lohajang', 1530),
(151, 'Dhaka', 'Munshiganj', 'Lohajong', 'Korhati', 1531),
(152, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haldia SO', 1532),
(153, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haridia DESO', 1533),
(154, 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', 1534),
(155, 'Dhaka', 'Munshiganj', 'Lohajong', 'Medini Mandal EDSO', 1535),
(156, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Munshiganj Sadar', 1500),
(157, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Rikabibazar', 1501),
(158, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Mirkadim', 1502),
(159, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Kathakhali', 1503),
(160, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Sirajdikhan', 1540),
(161, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Kola', 1541),
(162, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Ichapur', 1542),
(163, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Malkha Nagar', 1543),
(164, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Shekher Nagar', 1544),
(165, 'Dhaka', 'Munshiganj', 'Srinagar', 'Srinagar', 1550),
(166, 'Dhaka', 'Munshiganj', 'Srinagar', 'Barikhal', 1551),
(167, 'Dhaka', 'Munshiganj', 'Srinagar', 'Mazpara', 1552),
(168, 'Dhaka', 'Munshiganj', 'Srinagar', 'Hashara', 1553),
(169, 'Dhaka', 'Munshiganj', 'Srinagar', 'Kolapara', 1554),
(170, 'Dhaka', 'Munshiganj', 'Srinagar', 'Kumarbhog', 1555),
(171, 'Dhaka', 'Munshiganj', 'Srinagar', 'Vaggyakul SO', 1556),
(172, 'Dhaka', 'Munshiganj', 'Srinagar', 'Baghra', 1557),
(173, 'Dhaka', 'Munshiganj', 'Srinagar', 'Bhaggyakul', 1558),
(174, 'Dhaka', 'Munshiganj', 'Tangibari', 'Tangibari', 1520),
(175, 'Dhaka', 'Munshiganj', 'Tangibari', 'Betkahat', 1521),
(176, 'Dhaka', 'Munshiganj', 'Tangibari', 'Baligao', 1522),
(177, 'Dhaka', 'Munshiganj', 'Tangibari', 'Bajrajugini', 1523),
(178, 'Dhaka', 'Munshiganj', 'Tangibari', 'Hasail', 1524),
(179, 'Dhaka', 'Munshiganj', 'Tangibari', 'Dighirpar', 1525),
(180, 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura EDSO', 1526),
(181, 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura', 1527),
(182, 'Dhaka', 'Narshingdi', 'Belabo', 'Belabo', 1640),
(183, 'Dhaka', 'Narshingdi', 'Monohordi', 'Monohordi', 1650),
(184, 'Dhaka', 'Narshingdi', 'Monohordi', 'Hatirdia', 1651),
(185, 'Dhaka', 'Narshingdi', 'Monohordi', 'Katabaria', 1652),
(186, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi Sadar', 1600),
(187, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'UMC Jute Mills', 1601),
(188, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi College', 1602),
(189, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Panchdona', 1603),
(190, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Madhabdi', 1604),
(191, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Karimpur', 1605),
(192, 'Dhaka', 'Narshingdi', 'Palash', 'Palash', 1610),
(193, 'Dhaka', 'Narshingdi', 'Palash', 'Ghorashal Urea Facto', 1611),
(194, 'Dhaka', 'Narshingdi', 'Palash', 'Char Sindhur', 1612),
(195, 'Dhaka', 'Narshingdi', 'Palash', 'Ghorashal', 1613),
(196, 'Dhaka', 'Narshingdi', 'Raypura', 'Raypura', 1630),
(197, 'Dhaka', 'Narshingdi', 'Raypura', 'Bazar Hasnabad', 1631),
(198, 'Dhaka', 'Narshingdi', 'Raypura', 'Radhaganj bazar', 1632),
(199, 'Dhaka', 'Narshingdi', 'Shibpur', 'Shibpur', 1620),
(200, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Gazipur Sadar', 1700),
(201, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'B.R.R', 1701),
(202, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Chandna', 1702),
(203, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'B.O.F', 1703),
(204, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'National University', 1704),
(205, 'Dhaka', 'Gazipur', 'Kaliakaar', 'Kaliakaar', 1750),
(206, 'Dhaka', 'Gazipur', 'Kaliakaar', 'Safipur', 1751),
(207, 'Dhaka', 'Gazipur', 'Kaliganj', 'Kaliganj', 1720),
(208, 'Dhaka', 'Gazipur', 'Kaliganj', 'Pubail', 1721),
(209, 'Dhaka', 'Gazipur', 'Kaliganj', 'Santanpara', 1722),
(210, 'Dhaka', 'Gazipur', 'Kaliganj', 'Vaoal Jamalpur', 1723),
(211, 'Dhaka', 'Gazipur', 'Kapashia', 'kapashia', 1730),
(212, 'Dhaka', 'Gazipur', 'Monnunagar', 'Monnunagar', 1710),
(213, 'Dhaka', 'Gazipur', 'Monnunagar', 'Nishat Nagar', 1711),
(214, 'Dhaka', 'Gazipur', 'Monnunagar', 'Ershad Nagar', 1712),
(215, 'Dhaka', 'Gazipur', 'Sreepur', 'Sreepur', 1740),
(216, 'Dhaka', 'Gazipur', 'Sreepur', 'Barmi', 1743),
(217, 'Dhaka', 'Gazipur', 'Sreepur', 'Satkhamair', 1744),
(218, 'Dhaka', 'Gazipur', 'Sreepur', 'Kawraid', 1745),
(219, 'Dhaka', 'Gazipur', 'Sreepur', 'Bashamur', 1747),
(220, 'Dhaka', 'Gazipur', 'Sreepur', 'Boubi', 1748),
(221, 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur', 1741),
(222, 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur Canttome', 1742),
(223, 'Dhaka', 'Rajbari', 'Baliakandi', 'Baliakandi', 7730),
(224, 'Dhaka', 'Rajbari', 'Baliakandi', 'Nalia', 7731),
(225, 'Dhaka', 'Rajbari', 'Pangsha', 'Pangsha', 7720),
(226, 'Dhaka', 'Rajbari', 'Pangsha', 'Ramkol', 7721),
(227, 'Dhaka', 'Rajbari', 'Pangsha', 'Ratandia', 7722),
(228, 'Dhaka', 'Rajbari', 'Pangsha', 'Mrigibazar', 7723),
(229, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Rajbari Sadar', 7700),
(230, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Goalanda', 7710),
(231, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Khankhanapur', 7711),
(232, 'Dhaka', 'Faridpur', 'Alfadanga', 'Alfadanga', 7870),
(233, 'Dhaka', 'Faridpur', 'Bhanga', 'Bhanga', 7830),
(234, 'Dhaka', 'Faridpur', 'Boalmari', 'Boalmari', 7860),
(235, 'Dhaka', 'Faridpur', 'Boalmari', 'Rupatpat', 7861),
(236, 'Dhaka', 'Faridpur', 'Charbhadrasan', 'Charbadrashan', 7810),
(237, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Faridpursadar', 7800),
(238, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Kanaipur', 7801),
(239, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Ambikapur', 7802),
(240, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Baitulaman Politecni', 7803),
(241, 'Dhaka', 'Faridpur', 'Madukhali', 'Madukhali', 7850),
(242, 'Dhaka', 'Faridpur', 'Madukhali', 'Kamarkali', 7851),
(243, 'Dhaka', 'Faridpur', 'Nagarkanda', 'Nagarkanda', 7840),
(244, 'Dhaka', 'Faridpur', 'Nagarkanda', 'Talma', 7841),
(245, 'Dhaka', 'Faridpur', 'Sadarpur', 'Sadarpur', 7820),
(246, 'Dhaka', 'Faridpur', 'Sadarpur', 'Hat Krishapur', 7821),
(247, 'Dhaka', 'Faridpur', 'Sadarpur', 'Bishwa jaker Manjil', 7822),
(248, 'Dhaka', 'Faridpur', 'Shriangan', 'Shriangan', 7804),
(249, 'Dhaka', 'Madaripur', 'Barhamganj', 'Barhamganj', 7930),
(250, 'Dhaka', 'Madaripur', 'Barhamganj', 'Nilaksmibandar', 7931),
(251, 'Dhaka', 'Madaripur', 'Barhamganj', 'Bahadurpur', 7932),
(252, 'Dhaka', 'Madaripur', 'Barhamganj', 'Umedpur', 7933),
(253, 'Dhaka', 'Madaripur', 'kalkini', 'Kalkini', 7920),
(254, 'Dhaka', 'Madaripur', 'kalkini', 'Sahabrampur', 7921),
(255, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Madaripur Sadar', 7900),
(256, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Charmugria', 7901),
(257, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Kulpaddi', 7902),
(258, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Habiganj', 7903),
(259, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Mustafapur', 7904),
(260, 'Dhaka', 'Madaripur', 'Rajoir', 'Rajoir', 7910),
(261, 'Dhaka', 'Madaripur', 'Rajoir', 'Khalia', 7911),
(262, 'Dhaka', 'Shariatpur', 'Bhedorganj', 'Bhedorganj', 8030),
(263, 'Dhaka', 'Shariatpur', 'Damudhya', 'Damudhya', 8040),
(264, 'Dhaka', 'Shariatpur', 'Gosairhat', 'Gosairhat', 8050),
(265, 'Dhaka', 'Shariatpur', 'Jajira', 'Jajira', 8010),
(266, 'Dhaka', 'Shariatpur', 'Naria', 'Naria', 8020),
(267, 'Dhaka', 'Shariatpur', 'Naria', 'Bhozeshwar', 8021),
(268, 'Dhaka', 'Shariatpur', 'Naria', 'Gharisar', 8022),
(269, 'Dhaka', 'Shariatpur', 'Naria', 'Upshi', 8023),
(270, 'Dhaka', 'Shariatpur', 'Naria', 'Kartikpur', 8024),
(271, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Shariatpur Sadar', 8000),
(272, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Angaria', 8001),
(273, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Chikandi', 8002),
(274, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Chandradighalia', 8013),
(275, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Gopalganj Sadar', 8100),
(276, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Ulpur', 8101),
(277, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Barfa', 8102),
(278, 'Dhaka', 'Gopalganj', 'Kashiani', 'Kashiani', 8130),
(279, 'Dhaka', 'Gopalganj', 'Kashiani', 'Ramdia College', 8131),
(280, 'Dhaka', 'Gopalganj', 'Kashiani', 'Ratoil', 8132),
(281, 'Dhaka', 'Gopalganj', 'Kashiani', 'Jonapur', 8133),
(282, 'Dhaka', 'Gopalganj', 'Kotalipara', 'Kotalipara', 8110),
(283, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Maksudpur', 8140),
(284, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Batkiamari', 8141),
(285, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Khandarpara', 8142),
(286, 'Dhaka', 'Gopalganj', 'Tungipara', 'Tungipara', 8120),
(287, 'Dhaka', 'Gopalganj', 'Tungipara', 'Patgati', 8121),
(288, 'Dhaka', 'Manikganj', 'Doulatpur', 'Doulatpur', 1860),
(289, 'Dhaka', 'Manikganj', 'Gheor', 'Gheor', 1840),
(290, 'Dhaka', 'Manikganj', 'Lechhraganj', 'Lechhraganj', 1830),
(291, 'Dhaka', 'Manikganj', 'Lechhraganj', 'Jhitka', 1831),
(292, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Sadar', 1800),
(293, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Bazar', 1801),
(294, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Gorpara', 1802),
(295, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Mahadebpur', 1803),
(296, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Barangail', 1804),
(297, 'Dhaka', 'Manikganj', 'Saturia', 'Saturia', 1810),
(298, 'Dhaka', 'Manikganj', 'Saturia', 'Baliati', 1811),
(299, 'Dhaka', 'Manikganj', 'Shibloya', 'Shibaloy', 1850),
(300, 'Dhaka', 'Manikganj', 'Shibloya', 'Aricha', 1851),
(301, 'Dhaka', 'Manikganj', 'Shibloya', 'Tewta', 1852),
(302, 'Dhaka', 'Manikganj', 'Shibloya', 'Uthli', 1853),
(303, 'Dhaka', 'Manikganj', 'Singari', 'Singair', 1820),
(304, 'Dhaka', 'Manikganj', 'Singari', 'Baira', 1821),
(305, 'Dhaka', 'Manikganj', 'Singari', 'joymantop', 1822),
(306, 'Dhaka', 'Tangail', 'Basail', 'Basail', 1920),
(307, 'Dhaka', 'Tangail', 'Bhuapur', 'Bhuapur', 1960),
(308, 'Dhaka', 'Tangail', 'Delduar', 'Delduar', 1910),
(309, 'Dhaka', 'Tangail', 'Delduar', 'Jangalia', 1911),
(310, 'Dhaka', 'Tangail', 'Delduar', 'Patharail', 1912),
(311, 'Dhaka', 'Tangail', 'Delduar', 'Elasin', 1913),
(312, 'Dhaka', 'Tangail', 'Delduar', 'Hinga Nagar', 1914),
(313, 'Dhaka', 'Tangail', 'Delduar', 'Lowhati', 1915),
(314, 'Dhaka', 'Tangail', 'Ghatail', 'Ghatial', 1980),
(315, 'Dhaka', 'Tangail', 'Ghatail', 'Zahidganj', 1981),
(316, 'Dhaka', 'Tangail', 'Ghatail', 'D. Pakutia', 1982),
(317, 'Dhaka', 'Tangail', 'Ghatail', 'Dhalapara', 1983),
(318, 'Dhaka', 'Tangail', 'Ghatail', 'Lohani', 1984),
(319, 'Dhaka', 'Tangail', 'Gopalpur', 'Gopalpur', 1990),
(320, 'Dhaka', 'Tangail', 'Gopalpur', 'Jhowail', 1991),
(321, 'Dhaka', 'Tangail', 'Gopalpur', 'Hemnagar', 1992),
(322, 'Dhaka', 'Tangail', 'Kalihati', 'Kalihati', 1970),
(323, 'Dhaka', 'Tangail', 'Kalihati', 'Rajafair', 1971),
(324, 'Dhaka', 'Tangail', 'Kalihati', 'Nagbari', 1972),
(325, 'Dhaka', 'Tangail', 'Kalihati', 'Ballabazar', 1973),
(326, 'Dhaka', 'Tangail', 'Kalihati', 'Elinga', 1974),
(327, 'Dhaka', 'Tangail', 'Kalihati', 'Palisha', 1975),
(328, 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari SO', 1976),
(329, 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari', 1977),
(330, 'Dhaka', 'Tangail', 'Kashkaolia', 'Kashkawlia', 1930),
(331, 'Dhaka', 'Tangail', 'Madhupur', 'Madhupur', 1996),
(332, 'Dhaka', 'Tangail', 'Madhupur', 'Dhobari', 1997),
(333, 'Dhaka', 'Tangail', 'Mirzapur', 'Mirzapur', 1940),
(334, 'Dhaka', 'Tangail', 'Mirzapur', 'Gorai', 1941),
(335, 'Dhaka', 'Tangail', 'Mirzapur', 'M.C. College', 1942),
(336, 'Dhaka', 'Tangail', 'Mirzapur', 'Warri paikpara', 1943),
(337, 'Dhaka', 'Tangail', 'Mirzapur', 'Jarmuki', 1944),
(338, 'Dhaka', 'Tangail', 'Mirzapur', 'Mohera', 1945),
(339, 'Dhaka', 'Tangail', 'Nagarpur', 'Nagarpur', 1936),
(340, 'Dhaka', 'Tangail', 'Nagarpur', 'Dhuburia', 1937),
(341, 'Dhaka', 'Tangail', 'Nagarpur', 'Salimabad', 1938),
(342, 'Dhaka', 'Tangail', 'Sakhipur', 'Sakhipur', 1950),
(343, 'Dhaka', 'Tangail', 'Sakhipur', 'Kochua', 1951),
(344, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Tangail Sadar', 1900),
(345, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Kagmari', 1901),
(346, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Santosh', 1902),
(347, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Korotia', 1903),
(348, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Purabari', 1904),
(349, 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj', 2030),
(350, 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj S. Mills', 2031),
(351, 'Dhaka', 'Jamalpur', 'Islampur', 'Islampur', 2020),
(352, 'Dhaka', 'Jamalpur', 'Islampur', 'Durmoot', 2021),
(353, 'Dhaka', 'Jamalpur', 'Islampur', 'Gilabari', 2022),
(354, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Jamalpur', 2000),
(355, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Nandina', 2001),
(356, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Narundi', 2002),
(357, 'Dhaka', 'Jamalpur', 'Malandah', 'Malandah', 2010),
(358, 'Dhaka', 'Jamalpur', 'Malandah', 'Jamalpur', 2011),
(359, 'Dhaka', 'Jamalpur', 'Malandah', 'Malancha', 2012),
(360, 'Dhaka', 'Jamalpur', 'Malandah', 'Mahmoodpur', 2013),
(361, 'Dhaka', 'Jamalpur', 'Mathargonj', 'Mathargonj', 2040),
(362, 'Dhaka', 'Jamalpur', 'Mathargonj', 'Balijhuri', 2041),
(363, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Shorishabari', 2050),
(364, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Gunerbari', 2051),
(365, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Bausee', 2052),
(366, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jagannath Ghat', 2053),
(367, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Pingna', 2054),
(368, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jamuna Sar Karkhana', 2055),
(369, 'Dhaka', 'Sherpur', 'Bakshigonj', 'Bakshigonj', 2140),
(370, 'Dhaka', 'Sherpur', 'Jhinaigati', 'Jhinaigati', 2120),
(371, 'Dhaka', 'Sherpur', 'Nakla', 'Nakla', 2150),
(372, 'Dhaka', 'Sherpur', 'Nakla', 'Gonopaddi', 2151),
(373, 'Dhaka', 'Sherpur', 'Nalitabari', 'Nalitabari', 2110),
(374, 'Dhaka', 'Sherpur', 'Nalitabari', 'Hatibandha', 2111),
(375, 'Dhaka', 'Sherpur', 'Sherpur Shadar', 'Sherpur Shadar', 2100),
(376, 'Dhaka', 'Sherpur', 'Shribardi', 'Shribardi', 2130),
(377, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Akhaura', 3450),
(378, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Azampur', 3451),
(379, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Gangasagar', 3452),
(380, 'Chittagong ', 'Brahmanbaria', 'Banchharampur', 'Banchharampur', 3420),
(381, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Brahamanbaria Sadar', 3400),
(382, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Talshahar', 3401),
(383, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj', 3402),
(384, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj Share', 3403),
(385, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Poun', 3404),
(386, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kasba', 3460),
(387, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kuti', 3461),
(388, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chandidar', 3462),
(389, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chargachh', 3463),
(390, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Gopinathpur', 3464),
(391, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Nabinagar', 3410),
(392, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Laubfatehpur', 3411),
(393, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Rasullabad', 3412),
(394, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shamgram', 3413),
(395, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Ratanpur', 3414),
(396, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shahapur', 3415),
(397, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Kaitala', 3417),
(398, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Salimganj', 3418),
(399, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Jibanganj', 3419),
(400, 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Nasirnagar', 3440),
(401, 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Fandauk', 3441),
(402, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Sarial', 3430),
(403, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Shahbajpur', 3431),
(404, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Chandura', 3432),
(405, 'Chittagong ', 'Comilla', 'Barura', 'Barura', 3560),
(406, 'Chittagong ', 'Comilla', 'Barura', 'Poyalgachha', 3561),
(407, 'Chittagong ', 'Comilla', 'Barura', 'Murdafarganj', 3562),
(408, 'Chittagong ', 'Comilla', 'Brahmanpara', 'Brahmanpara', 3526),
(409, 'Chittagong ', 'Comilla', 'Burichang', 'Burichang', 3520),
(410, 'Chittagong ', 'Comilla', 'Burichang', 'Maynamoti bazar', 3521),
(411, 'Chittagong ', 'Comilla', 'Chandina', 'Chandia', 3510),
(412, 'Chittagong ', 'Comilla', 'Chandina', 'Madhaiabazar', 3511),
(413, 'Chittagong ', 'Comilla', 'Chouddagram', 'Chouddagram', 3550),
(414, 'Chittagong ', 'Comilla', 'Chouddagram', 'Batisa', 3551),
(415, 'Chittagong ', 'Comilla', 'Chouddagram', 'Chiora', 3552),
(416, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Sadar', 3500),
(417, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Contoment', 3501),
(418, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Halimanagar', 3502),
(419, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Courtbari', 3503),
(420, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Suaganj', 3504),
(421, 'Chittagong ', 'Comilla', 'Daudkandi', 'Daudkandi', 3516),
(422, 'Chittagong ', 'Comilla', 'Daudkandi', 'Gouripur', 3517),
(423, 'Chittagong ', 'Comilla', 'Daudkandi', 'Dashpara', 3518),
(424, 'Chittagong ', 'Comilla', 'Daudkandi', 'Eliotganj', 3519),
(425, 'Chittagong ', 'Comilla', 'Davidhar', 'Davidhar', 3530),
(426, 'Chittagong ', 'Comilla', 'Davidhar', 'Gangamandal', 3531),
(427, 'Chittagong ', 'Comilla', 'Davidhar', 'Barashalghar', 3532),
(428, 'Chittagong ', 'Comilla', 'Davidhar', 'Dhamtee', 3533),
(429, 'Chittagong ', 'Comilla', 'Homna', 'Homna', 3546),
(430, 'Chittagong ', 'Comilla', 'Laksam', 'Laksam', 3570),
(431, 'Chittagong ', 'Comilla', 'Laksam', 'Lakshamanpur', 3571),
(432, 'Chittagong ', 'Comilla', 'Laksam', 'Bipulasar', 3572),
(433, 'Chittagong ', 'Comilla', 'Langalkot', 'Langalkot', 3580),
(434, 'Chittagong ', 'Comilla', 'Langalkot', 'Dhalua', 3581),
(435, 'Chittagong ', 'Comilla', 'Langalkot', 'Chhariabazar', 3582),
(436, 'Chittagong ', 'Comilla', 'Langalkot', 'Gunabati', 3583),
(437, 'Chittagong ', 'Comilla', 'Muradnagar', 'Muradnagar', 3540),
(438, 'Chittagong ', 'Comilla', 'Muradnagar', 'Ramchandarpur', 3541),
(439, 'Chittagong ', 'Comilla', 'Muradnagar', 'Companyganj', 3542),
(440, 'Chittagong ', 'Comilla', 'Muradnagar', 'Bangra', 3543),
(441, 'Chittagong ', 'Comilla', 'Muradnagar', 'Sonakanda', 3544),
(442, 'Chittagong ', 'Comilla', 'Muradnagar', 'Pantibazar', 3545),
(443, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Char Alexgander', 3730),
(444, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Hajirghat', 3731),
(445, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Ramgatirhat', 3732),
(446, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Lakshimpur Sadar', 3700),
(447, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Dalal Bazar', 3701),
(448, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Bhabaniganj', 3702),
(449, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Mandari', 3703),
(450, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Keramatganj', 3704),
(451, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Rupchara', 3705),
(452, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Duttapara', 3706),
(453, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Choupalli', 3707),
(454, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Chandraganj', 3708),
(455, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Amani Lakshimpur', 3709),
(456, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Ramganj', 3720),
(457, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Alipur', 3721),
(458, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Panpara', 3722),
(459, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Kanchanpur', 3723),
(460, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Naagmud', 3724),
(461, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Dolta', 3725),
(462, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Raypur', 3710),
(463, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Rakhallia', 3711),
(464, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Nagerdighirpar', 3712),
(465, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Haydarganj', 3713),
(466, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Bhuabari', 3714),
(467, 'Chittagong ', 'Noakhali', 'Basurhat', 'Basur Hat', 3850),
(468, 'Chittagong ', 'Noakhali', 'Basurhat', 'Charhajari', 3851),
(469, 'Chittagong ', 'Noakhali', 'Begumganj', 'Begumganj', 3820),
(470, 'Chittagong ', 'Noakhali', 'Begumganj', 'Choumohani', 3821),
(471, 'Chittagong ', 'Noakhali', 'Begumganj', 'Banglabazar', 3822),
(472, 'Chittagong ', 'Noakhali', 'Begumganj', 'Mir Owarishpur', 3823),
(473, 'Chittagong ', 'Noakhali', 'Begumganj', 'Bazra', 3824),
(474, 'Chittagong ', 'Noakhali', 'Begumganj', 'Jamidar Hat', 3825),
(475, 'Chittagong ', 'Noakhali', 'Begumganj', 'Sonaimuri', 3827),
(476, 'Chittagong ', 'Noakhali', 'Begumganj', 'Gopalpur', 3828),
(477, 'Chittagong ', 'Noakhali', 'Begumganj', 'Joynarayanpur', 3829),
(478, 'Chittagong ', 'Noakhali', 'Begumganj', 'Alaiarpur', 3831),
(479, 'Chittagong ', 'Noakhali', 'Begumganj', 'Tangirpar', 3832),
(480, 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalafat Bazar', 3833),
(481, 'Chittagong ', 'Noakhali', 'Begumganj', 'Rajganj', 3834),
(482, 'Chittagong ', 'Noakhali', 'Begumganj', 'Oachhekpur', 3835),
(483, 'Chittagong ', 'Noakhali', 'Begumganj', 'Bhabani Jibanpur', 3837),
(484, 'Chittagong ', 'Noakhali', 'Begumganj', 'Maheshganj', 3838),
(485, 'Chittagong ', 'Noakhali', 'Begumganj', 'Nadona', 3839),
(486, 'Chittagong ', 'Noakhali', 'Begumganj', 'Nandiapara', 3841),
(487, 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalishpur', 3842),
(488, 'Chittagong ', 'Noakhali', 'Begumganj', 'Dauti', 3843),
(489, 'Chittagong ', 'Noakhali', 'Begumganj', 'Joyag', 3844),
(490, 'Chittagong ', 'Noakhali', 'Begumganj', 'Thanar Hat', 3845),
(491, 'Chittagong ', 'Noakhali', 'Begumganj', 'Amisha Para', 3847),
(492, 'Chittagong ', 'Noakhali', 'Begumganj', 'Durgapur', 3848),
(493, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Chatkhil', 3870),
(494, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Palla', 3871),
(495, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Khilpara', 3872),
(496, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bodalcourt', 3873),
(497, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Rezzakpur', 3874),
(498, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Solla', 3875),
(499, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Karihati', 3877),
(500, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Dosh Gharia', 3878),
(501, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bansa Bazar', 3879),
(502, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sahapur', 3881),
(503, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sampara', 3882),
(504, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Shingbahura', 3883),
(505, 'Chittagong ', 'Noakhali', 'Hatiya', 'Hatiya', 3890),
(506, 'Chittagong ', 'Noakhali', 'Hatiya', 'Afazia', 3891),
(507, 'Chittagong ', 'Noakhali', 'Hatiya', 'Tamoraddi', 3892),
(508, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali Sadar', 3800),
(509, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali College', 3801),
(510, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Sonapur', 3802),
(511, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Din Monir Hat', 3803),
(512, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Pak Kishoreganj', 3804),
(513, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Mriddarhat', 3806),
(514, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Kabirhat', 3807),
(515, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Khalifar Hat', 3808),
(516, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Charam Tua', 3809),
(517, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Chaprashir Hat', 3811),
(518, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Char Jabbar', 3812),
(519, 'Chittagong ', 'Noakhali', 'Senbag', 'Senbag', 3860),
(520, 'Chittagong ', 'Noakhali', 'Senbag', 'Kallyandi', 3861),
(521, 'Chittagong ', 'Noakhali', 'Senbag', 'Beezbag', 3862),
(522, 'Chittagong ', 'Noakhali', 'Senbag', 'Kankirhat', 3863),
(523, 'Chittagong ', 'Noakhali', 'Senbag', 'Chatarpaia', 3864),
(524, 'Chittagong ', 'Noakhali', 'Senbag', 'T.P. Lamua', 3865),
(525, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Chhagalnaia', 3910),
(526, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Maharajganj', 3911),
(527, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Daraga Hat', 3912),
(528, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Puabashimulia', 3913),
(529, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dagondhuia', 3920),
(530, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dudmukha', 3921),
(531, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Chhilonia', 3922),
(532, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Rajapur', 3923),
(533, 'Chittagong ', 'Feni', 'Feni Sadar', 'Feni Sadar', 3900),
(534, 'Chittagong ', 'Feni', 'Feni Sadar', 'Fazilpur', 3901),
(535, 'Chittagong ', 'Feni', 'Feni Sadar', 'Sharshadie', 3902),
(536, 'Chittagong ', 'Feni', 'Feni Sadar', 'Laskarhat', 3903),
(537, 'Chittagong ', 'Feni', 'Pashurampur', 'Pashurampur', 3940),
(538, 'Chittagong ', 'Feni', 'Pashurampur', 'Shuarbazar', 3941),
(539, 'Chittagong ', 'Feni', 'Pashurampur', 'Fulgazi', 3942),
(540, 'Chittagong ', 'Feni', 'Pashurampur', 'Munshirhat', 3943),
(541, 'Chittagong ', 'Feni', 'Sonagazi', 'Sonagazi', 3930),
(542, 'Chittagong ', 'Feni', 'Sonagazi', 'Motiganj', 3931),
(543, 'Chittagong ', 'Feni', 'Sonagazi', 'Ahmadpur', 3932),
(544, 'Chittagong ', 'Feni', 'Sonagazi', 'Kazirhat', 3933),
(545, 'Chittagong ', 'Chittagong', 'Anawara', 'Anowara', 4376),
(546, 'Chittagong ', 'Chittagong', 'Anawara', 'Paroikora', 4377),
(547, 'Chittagong ', 'Chittagong', 'Anawara', 'Battali', 4378),
(548, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kanungopara', 4363),
(549, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Saroatoli', 4364),
(550, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Iqbal Park', 4365),
(551, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Boalkhali', 4366),
(552, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Sakpura', 4367),
(553, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kadurkhal', 4368),
(554, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Charandwip', 4369),
(555, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong GPO', 4000),
(556, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Bandar', 4100),
(557, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Pahartoli', 4202),
(558, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chawkbazar', 4203),
(559, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Patenga', 4204),
(560, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Airport', 4205),
(561, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Jaldia Merine Accade', 4206),
(562, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Firozshah', 4207),
(563, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Mohard', 4208),
(564, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Politechnic In', 4209),
(565, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Bayezid Bostami', 4210),
(566, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Amin Jute Mills', 4211),
(567, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chandgaon', 4212),
(568, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Wazedia', 4213),
(569, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Jalalabad', 4214),
(570, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Anandabazar', 4215),
(571, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishahar', 4216),
(572, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Katuli', 4217),
(573, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Sailers Colon', 4218),
(574, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Customs Acca', 4219),
(575, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Cantonment', 4220),
(576, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Al- Amin Baria Madra', 4221),
(577, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Middle Patenga', 4222),
(578, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Export Processing', 4223),
(579, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Rampura TSO', 4224),
(580, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishshar', 4225),
(581, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Halishahar', 4226),
(582, 'Chittagong ', 'Chittagong', 'East Joara', 'East Joara', 4380),
(583, 'Chittagong ', 'Chittagong', 'East Joara', 'Gachbaria', 4381),
(584, 'Chittagong ', 'Chittagong', 'East Joara', 'Dohazari', 4382),
(585, 'Chittagong ', 'Chittagong', 'East Joara', 'Barma', 4383),
(586, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Fatikchhari', 4350),
(587, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Nanupur', 4351),
(588, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Bhandar Sharif', 4352),
(589, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Najirhat', 4353),
(590, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Harualchhari', 4354),
(591, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Narayanhat', 4355),
(592, 'Chittagong ', 'Chittagong', 'Hathazari', 'Hathazari', 4330),
(593, 'Chittagong ', 'Chittagong', 'Hathazari', 'Chitt.University', 4331),
(594, 'Chittagong ', 'Chittagong', 'Hathazari', 'Gorduara', 4332),
(595, 'Chittagong ', 'Chittagong', 'Hathazari', 'Katirhat', 4333),
(596, 'Chittagong ', 'Chittagong', 'Hathazari', 'Mirzapur', 4334),
(597, 'Chittagong ', 'Chittagong', 'Hathazari', 'Fatahabad', 4335),
(598, 'Chittagong ', 'Chittagong', 'Hathazari', 'Nuralibari', 4337),
(599, 'Chittagong ', 'Chittagong', 'Hathazari', 'Yunus Nagar', 4338),
(600, 'Chittagong ', 'Chittagong', 'Hathazari', 'Madrasa', 4339),
(601, 'Chittagong ', 'Chittagong', 'Jaldi', 'Jaldi', 4390),
(602, 'Chittagong ', 'Chittagong', 'Jaldi', 'Khan Bahadur', 4391),
(603, 'Chittagong ', 'Chittagong', 'Jaldi', 'Gunagari', 4392),
(604, 'Chittagong ', 'Chittagong', 'Jaldi', 'Banigram', 4393),
(605, 'Chittagong ', 'Chittagong', 'Lohagara', 'Lohagara', 4396),
(606, 'Chittagong ', 'Chittagong', 'Lohagara', 'Padua', 4397),
(607, 'Chittagong ', 'Chittagong', 'Lohagara', 'Chunti', 4398),
(608, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mirsharai', 4320),
(609, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Abutorab', 4321),
(610, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Darrogahat', 4322),
(611, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Bharawazhat', 4323),
(612, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Joarganj', 4324),
(613, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Azampur', 4325),
(614, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Korerhat', 4327),
(615, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mohazanhat', 4328),
(616, 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Patia Head Office', 4370),
(617, 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Budhpara', 4371),
(618, 'Chittagong ', 'Chittagong', 'Rangunia', 'Rangunia', 4360),
(619, 'Chittagong ', 'Chittagong', 'Rangunia', 'Dhamair', 4361),
(620, 'Chittagong ', 'Chittagong', 'Rouzan', 'Rouzan', 4340),
(621, 'Chittagong ', 'Chittagong', 'Rouzan', 'Beenajuri', 4341),
(622, 'Chittagong ', 'Chittagong', 'Rouzan', 'Kundeshwari', 4342),
(623, 'Chittagong ', 'Chittagong', 'Rouzan', 'Gahira', 4343),
(624, 'Chittagong ', 'Chittagong', 'Rouzan', 'jagannath Hat', 4344),
(625, 'Chittagong ', 'Chittagong', 'Rouzan', 'Fatepur', 4345),
(626, 'Chittagong ', 'Chittagong', 'Rouzan', 'Guzra Noapara', 4346),
(627, 'Chittagong ', 'Chittagong', 'Rouzan', 'Dewanpur', 4347),
(628, 'Chittagong ', 'Chittagong', 'Rouzan', 'Mohamuni', 4348),
(629, 'Chittagong ', 'Chittagong', 'Rouzan', 'B.I.T Post Office', 4349),
(630, 'Chittagong ', 'Chittagong', 'Sandwip', 'Sandwip', 4300),
(631, 'Chittagong ', 'Chittagong', 'Sandwip', 'Shiberhat', 4301),
(632, 'Chittagong ', 'Chittagong', 'Sandwip', 'Urirchar', 4302),
(633, 'Chittagong ', 'Chittagong', 'Satkania', 'Satkania', 4386),
(634, 'Chittagong ', 'Chittagong', 'Satkania', 'Baitul Ijjat', 4387),
(635, 'Chittagong ', 'Chittagong', 'Satkania', 'Bazalia', 4388),
(636, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Sitakunda', 4310),
(637, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Baroidhala', 4311),
(638, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Barabkunda', 4312),
(639, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Bawashbaria', 4313),
(640, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Kumira', 4314),
(641, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Bhatiari', 4315),
(642, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Fouzdarhat', 4316),
(643, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Jafrabad', 4317),
(644, 'Chittagong ', 'Khagrachari', 'Diginala', 'Diginala', 4420),
(645, 'Chittagong ', 'Khagrachari', 'Khagrachari Sadar', 'Khagrachari Sadar', 4400),
(646, 'Chittagong ', 'Khagrachari', 'Laxmichhari', 'Laxmichhari', 4470),
(647, 'Chittagong ', 'Khagrachari', 'Mahalchhari', 'Mahalchhari', 4430),
(648, 'Chittagong ', 'Khagrachari', 'Manikchhari', 'Manikchhari', 4460),
(649, 'Chittagong ', 'Khagrachari', 'Matiranga', 'Matiranga', 4450),
(650, 'Chittagong ', 'Khagrachari', 'Panchhari', 'Panchhari', 4410),
(651, 'Chittagong ', 'Khagrachari', 'Ramghar Head Office', 'Ramghar Head Office', 4440),
(652, 'Chittagong ', 'Rangamati', 'Barakal', 'Barakal', 4570),
(653, 'Chittagong ', 'Rangamati', 'Bilaichhari', 'Bilaichhari', 4550),
(654, 'Chittagong ', 'Rangamati', 'Jarachhari', 'Jarachhari', 4560),
(655, 'Chittagong ', 'Rangamati', 'Kalampati', 'Kalampati', 4510),
(656, 'Chittagong ', 'Rangamati', 'Kalampati', 'Betbunia', 4511),
(657, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai', 4530),
(658, 'Chittagong ', 'Rangamati', 'kaptai', 'Chandraghona', 4531),
(659, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Project', 4532),
(660, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Nuton Bazar', 4533),
(661, 'Chittagong ', 'Rangamati', 'Longachh', 'Longachh', 4580),
(662, 'Chittagong ', 'Rangamati', 'Marishya', 'Marishya', 4590),
(663, 'Chittagong ', 'Rangamati', 'Naniachhar', 'Nanichhar', 4520),
(664, 'Chittagong ', 'Rangamati', 'Rajsthali', 'Rajsthali', 4540),
(665, 'Chittagong ', 'Rangamati', 'Rangamati Sadar', 'Rangamati Sadar', 4500),
(666, 'Chittagong ', 'Bandarban', 'Alikadam', 'Alikadam', 4650),
(667, 'Chittagong ', 'Bandarban', 'Bandarban Sadar', 'Bandarban Sadar', 4600),
(668, 'Chittagong ', 'Bandarban', 'Naikhong', 'Naikhong', 4660),
(669, 'Chittagong ', 'Bandarban', 'Roanchhari', 'Roanchhari', 4610),
(670, 'Chittagong ', 'Bandarban', 'Ruma', 'Ruma', 4620),
(671, 'Chittagong ', 'Bandarban', 'Thanchi', 'Thanchi', 4630),
(672, 'Chittagong ', 'Bandarban', 'Thanchi', 'Lama', 4641),
(673, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga', 4740),
(674, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga S.O', 4741),
(675, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Badarkali', 4742),
(676, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Malumghat', 4743),
(677, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Coxs Bazar Sadar', 4700),
(678, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Zhilanja', 4701),
(679, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Eidga', 4702),
(680, 'Chittagong ', 'Coxs Bazar', 'Gorakghat', 'Gorakghat', 4710),
(681, 'Chittagong ', 'Coxs Bazar', 'Kutubdia', 'Kutubdia', 4720),
(682, 'Chittagong ', 'Coxs Bazar', 'Ramu', 'Ramu', 4730),
(683, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Teknaf', 4760),
(684, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Hnila', 4761),
(685, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'St.Martin', 4762),
(686, 'Chittagong ', 'Coxs Bazar', 'Ukhia', 'Ukhia', 4750),
(687, 'Khulna ', 'Kustia', 'Bheramara', 'Bheramara', 7040),
(688, 'Khulna ', 'Kustia', 'Bheramara', 'Ganges Bheramara', 7041),
(689, 'Khulna ', 'Kustia', 'Bheramara', 'Allardarga', 7042),
(690, 'Khulna ', 'Kustia', 'Janipur', 'Janipur', 7020),
(691, 'Khulna ', 'Kustia', 'Janipur', 'Khoksa', 7021),
(692, 'Khulna ', 'Kustia', 'Kumarkhali', 'Kumarkhali', 7010),
(693, 'Khulna ', 'Kustia', 'Kumarkhali', 'Panti', 7011),
(694, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kustia Sadar', 7000),
(695, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kushtia Mohini', 7001),
(696, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Jagati', 7002),
(697, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Islami University', 7003),
(698, 'Khulna ', 'Kustia', 'Mirpur', 'Mirpur', 7030),
(699, 'Khulna ', 'Kustia', 'Mirpur', 'Poradaha', 7031),
(700, 'Khulna ', 'Kustia', 'Mirpur', 'Amla Sadarpur', 7032),
(701, 'Khulna ', 'Kustia', 'Rafayetpur', 'Rafayetpur', 7050),
(702, 'Khulna ', 'Kustia', 'Rafayetpur', 'Taragunia', 7051),
(703, 'Khulna ', 'Kustia', 'Rafayetpur', 'Khasmathurapur', 7052),
(704, 'Khulna ', 'Meherpur', 'Gangni', 'Gangni', 7110),
(705, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Meherpur Sadar', 7100),
(706, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', 7101),
(707, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Mujib Nagar Complex', 7102),
(708, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', 7152),
(709, 'Khulna ', 'Chuadanga', 'Alamdanga', 'Alamdanga', 7210),
(710, 'Khulna ', 'Chuadanga', 'Alamdanga', 'Hardi', 7211),
(711, 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Chuadanga Sadar', 7200),
(712, 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Munshiganj', 7201),
(713, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Damurhuda', 7220),
(714, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Darshana', 7221),
(715, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Andulbaria', 7222),
(716, 'Khulna ', 'Chuadanga', 'Doulatganj', 'Doulatganj', 7230),
(717, 'Khulna ', 'Jinaidaha', 'Harinakundu', 'Harinakundu', 7310),
(718, 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Sadar', 7300),
(719, 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Cadet College', 7301),
(720, 'Khulna ', 'Jinaidaha', 'Kotchandpur', 'Kotchandpur', 7330),
(721, 'Khulna ', 'Jinaidaha', 'Maheshpur', 'Maheshpur', 7340),
(722, 'Khulna ', 'Jinaidaha', 'Naldanga', 'Naldanga', 7350),
(723, 'Khulna ', 'Jinaidaha', 'Naldanga', 'Hatbar Bazar', 7351),
(724, 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Shailakupa', 7320),
(725, 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Kumiradaha', 7321),
(726, 'Khulna ', 'Jessore', 'Bagharpara', 'Bagharpara', 7470),
(727, 'Khulna ', 'Jessore', 'Bagharpara', 'Gouranagar', 7471),
(728, 'Khulna ', 'Jessore', 'Chaugachha', 'Chougachha', 7410),
(729, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Sadar', 7400),
(730, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Upa-Shahar', 7401),
(731, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Chanchra', 7402),
(732, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore canttonment', 7403),
(733, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Airbach', 7404),
(734, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Rupdia', 7405),
(735, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Basundia', 7406),
(736, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Churamankathi', 7407),
(737, 'Khulna ', 'Jessore', 'Jhikargachha', 'Jhikargachha', 7420),
(738, 'Khulna ', 'Jessore', 'Keshabpur', 'Keshobpur', 7450),
(739, 'Khulna ', 'Jessore', 'Monirampur', 'Monirampur', 7440),
(740, 'Khulna ', 'Jessore', 'Noapara', 'Noapara', 7460),
(741, 'Khulna ', 'Jessore', 'Noapara', 'Rajghat', 7461),
(742, 'Khulna ', 'Jessore', 'Noapara', 'Bhugilhat', 7462),
(743, 'Khulna ', 'Jessore', 'Sarsa', 'Sarsa', 7430),
(744, 'Khulna ', 'Jessore', 'Sarsa', 'Benapole', 7431),
(745, 'Khulna ', 'Jessore', 'Sarsa', 'Jadabpur', 7432),
(746, 'Khulna ', 'Jessore', 'Sarsa', 'Bag Achra', 7433),
(747, 'Khulna ', 'Narail', 'Kalia', 'Kalia', 7520),
(748, 'Khulna ', 'Narail', 'Laxmipasha', 'Laxmipasha', 7510),
(749, 'Khulna ', 'Narail', 'Laxmipasha', 'Lohagora', 7511),
(750, 'Khulna ', 'Narail', 'Laxmipasha', 'Itna', 7512),
(751, 'Khulna ', 'Narail', 'Laxmipasha', 'Naldi', 7513),
(752, 'Khulna ', 'Narail', 'Laxmipasha', 'Baradia', 7514),
(753, 'Khulna ', 'Narail', 'Mohajan', 'Mohajan', 7521),
(754, 'Khulna ', 'Narail', 'Narail Sadar', 'Narail Sadar', 7500),
(755, 'Khulna ', 'Narail', 'Narail Sadar', 'Ratanganj', 7501),
(756, 'Khulna ', 'Magura', 'Arpara', 'Arpara', 7620),
(757, 'Khulna ', 'Magura', 'Magura Sadar', 'Magura Sadar', 7600),
(758, 'Khulna ', 'Magura', 'Mohammadpur', 'Mohammadpur', 7630),
(759, 'Khulna ', 'Magura', 'Mohammadpur', 'Binodpur', 7631),
(760, 'Khulna ', 'Magura', 'Mohammadpur', 'Nahata', 7632),
(761, 'Khulna ', 'Magura', 'Shripur', 'Shripur', 7610),
(762, 'Khulna ', 'Magura', 'Shripur', 'Langalbadh', 7611),
(763, 'Khulna ', 'Magura', 'Shripur', 'Nachol', 7612),
(764, 'Khulna ', 'Khulna', 'Alaipur', 'Alaipur', 9240),
(765, 'Khulna ', 'Khulna', 'Alaipur', 'Rupsha', 9241),
(766, 'Khulna ', 'Khulna', 'Alaipur', 'Belphulia', 9242),
(767, 'Khulna ', 'Khulna', 'Batiaghat', 'Batiaghat', 9260),
(768, 'Khulna ', 'Khulna', 'Batiaghat', 'Surkalee', 9261),
(769, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Chalna Bazar', 9270),
(770, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Dakup', 9271),
(771, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Bajua', 9272),
(772, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Nalian', 9273),
(773, 'Khulna ', 'Khulna', 'Digalia', 'Digalia', 9220),
(774, 'Khulna ', 'Khulna', 'Digalia', 'Chandni Mahal', 9221),
(775, 'Khulna ', 'Khulna', 'Digalia', 'Senhati', 9222),
(776, 'Khulna ', 'Khulna', 'Digalia', 'Ghoshghati', 9223),
(777, 'Khulna ', 'Khulna', 'Digalia', 'Gazirhat', 9224),
(778, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna G.P.O', 9000),
(779, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khula Sadar', 9100),
(780, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna Shipyard', 9201),
(781, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Doulatpur', 9202),
(782, 'Khulna ', 'Khulna', 'Khulna Sadar', 'BIT Khulna', 9203),
(783, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Siramani', 9204),
(784, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Jahanabad Canttonmen', 9205),
(785, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Sonali Jute Mills', 9206),
(786, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Atra Shilpa Area', 9207),
(787, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna University', 9208),
(788, 'Khulna ', 'Khulna', 'Madinabad', 'Madinabad', 9290),
(789, 'Khulna ', 'Khulna', 'Madinabad', 'Amadee', 9291),
(790, 'Khulna ', 'Khulna', 'Paikgachha', 'Paikgachha', 9280),
(791, 'Khulna ', 'Khulna', 'Paikgachha', 'Godaipur', 9281),
(792, 'Khulna ', 'Khulna', 'Paikgachha', 'Kapilmoni', 9282),
(793, 'Khulna ', 'Khulna', 'Paikgachha', 'Katipara', 9283),
(794, 'Khulna ', 'Khulna', 'Paikgachha', 'Chandkhali', 9284),
(795, 'Khulna ', 'Khulna', 'Paikgachha', 'Garaikhali', 9285),
(796, 'Khulna ', 'Khulna', 'Phultala', 'Phultala', 9210),
(797, 'Khulna ', 'Khulna', 'Sajiara', 'Sajiara', 9250),
(798, 'Khulna ', 'Khulna', 'Sajiara', 'Ghonabanda', 9251),
(799, 'Khulna ', 'Khulna', 'Sajiara', 'Chuknagar', 9252),
(800, 'Khulna ', 'Khulna', 'Sajiara', 'Shahapur', 9253),
(801, 'Khulna ', 'Khulna', 'Terakhada', 'Terakhada', 9230),
(802, 'Khulna ', 'Khulna', 'Terakhada', 'Pak Barasat', 9231),
(803, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'Bagerhat Sadar', 9300);
INSERT INTO `areas` (`id`, `division`, `district`, `subordinate`, `branch`, `post_code`) VALUES
(804, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'P.C College', 9301),
(805, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'Rangdia', 9302),
(806, 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Chalna Ankorage', 9350),
(807, 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Mongla Port', 9351),
(808, 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Chitalmari', 9360),
(809, 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Barabaria', 9361),
(810, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Fakirhat', 9370),
(811, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Mansa', 9371),
(812, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Bhanganpar Bazar', 9372),
(813, 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Kachua', 9310),
(814, 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Sonarkola', 9311),
(815, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Mollahat', 9380),
(816, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Kahalpur', 9381),
(817, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Dariala', 9382),
(818, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Charkulia', 9383),
(819, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Nagarkandi', 9384),
(820, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Pak Gangni', 9385),
(821, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Morelganj', 9320),
(822, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Sannasi Bazar', 9321),
(823, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Telisatee', 9322),
(824, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Rampal', 9340),
(825, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Foylahat', 9341),
(826, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Sonatunia', 9342),
(827, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Gourambha', 9343),
(828, 'Khulna ', 'IBH WAs Here', 'Rayenda', 'Rayenda', 9330),
(829, 'Khulna ', 'Satkhira', 'Ashashuni', 'Ashashuni', 9460),
(830, 'Khulna ', 'Satkhira', 'Ashashuni', 'Baradal', 9461),
(831, 'Khulna ', 'Satkhira', 'Debbhata', 'Debbhata', 9430),
(832, 'Khulna ', 'Satkhira', 'Debbhata', 'Gurugram', 9431),
(833, 'Khulna ', 'Satkhira', 'kalaroa', 'kalaroa', 9410),
(834, 'Khulna ', 'Satkhira', 'kalaroa', 'Murarikati', 9411),
(835, 'Khulna ', 'Satkhira', 'kalaroa', 'Jhaudanga', 9412),
(836, 'Khulna ', 'Satkhira', 'kalaroa', 'Hamidpur', 9413),
(837, 'Khulna ', 'Satkhira', 'kalaroa', 'Khordo', 9414),
(838, 'Khulna ', 'Satkhira', 'kalaroa', 'Chandanpur', 9415),
(839, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Kaliganj UPO', 9440),
(840, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Nalta Mubaroknagar', 9441),
(841, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Ratanpur', 9442),
(842, 'Khulna ', 'Satkhira', 'Nakipur', 'Nakipur', 9450),
(843, 'Khulna ', 'Satkhira', 'Nakipur', 'Noornagar', 9451),
(844, 'Khulna ', 'Satkhira', 'Nakipur', 'Naobeki', 9452),
(845, 'Khulna ', 'Satkhira', 'Nakipur', 'Buri Goalini', 9453),
(846, 'Khulna ', 'Satkhira', 'Nakipur', 'Gabura', 9454),
(847, 'Khulna ', 'Satkhira', 'Nakipur', 'Habinagar', 9455),
(848, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Sadar', 9400),
(849, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Islamia Acc', 9401),
(850, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Gunakar kati', 9402),
(851, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Budhhat', 9403),
(852, 'Khulna ', 'Satkhira', 'Taala', 'Taala', 9420),
(853, 'Khulna ', 'Satkhira', 'Taala', 'Patkelghata', 9421),
(854, 'Sylhet ', 'Sunamganj', 'Bishamsarpur', 'Bishamsapur', 3010),
(855, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak', 3080),
(856, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Cement Facto', 3081),
(857, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Paper Mills', 3082),
(858, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj', 3083),
(859, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj Natun Ba', 3084),
(860, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Khurma', 3085),
(861, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Moinpur', 3086),
(862, 'Sylhet ', 'Sunamganj', 'Chhatak', 'jahidpur', 3087),
(863, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Islamabad', 3088),
(864, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chourangi Bazar', 3893),
(865, 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Dhirai Chandpur', 3040),
(866, 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Jagdal', 3041),
(867, 'Sylhet ', 'Sunamganj', 'Duara bazar', 'Duara bazar', 3070),
(868, 'Sylhet ', 'Sunamganj', 'Ghungiar', 'Ghungiar', 3050),
(869, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Jagnnathpur', 3060),
(870, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Syedpur', 3061),
(871, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Atuajan', 3062),
(872, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Hasan Fatemapur', 3063),
(873, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Rasulganj', 3064),
(874, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Shiramsi', 3065),
(875, 'Sylhet ', 'Sunamganj', 'Sachna', 'Sachna', 3020),
(876, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Sunamganj Sadar', 3000),
(877, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Pagla', 3001),
(878, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Patharia', 3002),
(879, 'Sylhet ', 'Sunamganj', 'Tahirpur', 'Tahirpur', 3030),
(880, 'Sylhet ', 'Sylhet', 'Balaganj', 'Balaganj', 3120),
(881, 'Sylhet ', 'Sylhet', 'Balaganj', 'Karua', 3121),
(882, 'Sylhet ', 'Sylhet', 'Balaganj', 'Brahman Shashon', 3122),
(883, 'Sylhet ', 'Sylhet', 'Balaganj', 'Tajpur', 3123),
(884, 'Sylhet ', 'Sylhet', 'Balaganj', 'Goala Bazar', 3124),
(885, 'Sylhet ', 'Sylhet', 'Balaganj', 'Begumpur', 3125),
(886, 'Sylhet ', 'Sylhet', 'Balaganj', 'Omarpur', 3126),
(887, 'Sylhet ', 'Sylhet', 'Balaganj', 'Kathal Khair', 3127),
(888, 'Sylhet ', 'Sylhet', 'Balaganj', 'Gaharpur', 3128),
(889, 'Sylhet ', 'Sylhet', 'Balaganj', 'Natun Bazar', 3129),
(890, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Bianibazar', 3170),
(891, 'Sylhet ', 'Sylhet', 'Bianibazar', 'jaldup', 3171),
(892, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Mathiura', 3172),
(893, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Kurar bazar', 3173),
(894, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Salia bazar', 3174),
(895, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Churkai', 3175),
(896, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Bishwanath', 3130),
(897, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Dashghar', 3131),
(898, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Doulathpur', 3132),
(899, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Deokalas', 3133),
(900, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Singer kanch', 3134),
(901, 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj', 3116),
(902, 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj SareKarkh', 3117),
(903, 'Sylhet ', 'Sylhet', 'Goainhat', 'Goainhat', 3150),
(904, 'Sylhet ', 'Sylhet', 'Goainhat', 'Jaflong', 3151),
(905, 'Sylhet ', 'Sylhet', 'Goainhat', 'Chiknagul', 3152),
(906, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Gopalgannj', 3160),
(907, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dhaka Dakkhin', 3161),
(908, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dakkhin Bhadashore', 3162),
(909, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Ranaping', 3163),
(910, 'Sylhet ', 'Sylhet', 'Gopalganj', 'banigram', 3164),
(911, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Chandanpur', 3165),
(912, 'Sylhet ', 'Sylhet', 'Jaintapur', 'Jainthapur', 3156),
(913, 'Sylhet ', 'Sylhet', 'Jakiganj', 'Jakiganj', 3190),
(914, 'Sylhet ', 'Sylhet', 'Jakiganj', 'Ichhamati', 3191),
(915, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Kanaighat', 3180),
(916, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Chatulbazar', 3181),
(917, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Manikganj', 3182),
(918, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Gachbari', 3183),
(919, 'Sylhet ', 'Sylhet', 'Kompanyganj', 'Kompanyganj', 3140),
(920, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhe Sadar', 3100),
(921, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Cadet Col', 3101),
(922, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Biman Bondar', 3102),
(923, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Khadimnagar', 3103),
(924, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad Cantoment', 3104),
(925, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Silam', 3105),
(926, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Birahimpur', 3106),
(927, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad', 3107),
(928, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Mogla', 3108),
(929, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Ranga Hajiganj', 3109),
(930, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kadamtali', 3111),
(931, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kamalbazer', 3112),
(932, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Lalbazar', 3113),
(933, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Shahajalal Science &', 3114),
(934, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Baralekha', 3250),
(935, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Juri', 3251),
(936, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Dhakkhinbag', 3252),
(937, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Purbashahabajpur', 3253),
(938, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Kamalganj', 3220),
(939, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Keramatnaga', 3221),
(940, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Patrakhola', 3222),
(941, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Shamsher Nagar', 3223),
(942, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Munshibazar', 3224),
(943, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Kulaura', 3230),
(944, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Tillagaon', 3231),
(945, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Langla', 3232),
(946, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Prithimpasha', 3233),
(947, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Kajaldhara', 3234),
(948, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Karimpur', 3235),
(949, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Baramchal', 3237),
(950, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Moulvibazar Sadar', 3200),
(951, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Barakapan', 3201),
(952, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Monumukh', 3202),
(953, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Afrozganj', 3203),
(954, 'Sylhet ', 'Moulvibazar', 'Rajnagar', 'Rajnagar', 3240),
(955, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Srimangal', 3210),
(956, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Narain Chora', 3211),
(957, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Kalighat', 3212),
(958, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Khejurichhara', 3213),
(959, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Satgaon', 3214),
(960, 'Sylhet ', 'Hobiganj', 'Azmireeganj', 'Azmireeganj', 3360),
(961, 'Sylhet ', 'Hobiganj', 'Bahubal', 'Bahubal', 3310),
(962, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Baniachang', 3350),
(963, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Jatrapasha', 3351),
(964, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Kadirganj', 3352),
(965, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chunarughat', 3320),
(966, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chandpurbagan', 3321),
(967, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Narapati', 3322),
(968, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Hobiganj Sadar', 3300),
(969, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Shaestaganj', 3301),
(970, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Gopaya', 3302),
(971, 'Sylhet ', 'Hobiganj', 'Kalauk', 'Kalauk', 3340),
(972, 'Sylhet ', 'Hobiganj', 'Kalauk', 'Lakhai', 3341),
(973, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Madhabpur', 3330),
(974, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Itakhola', 3331),
(975, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Shahajibazar', 3332),
(976, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Saihamnagar', 3333),
(977, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Nabiganj', 3370),
(978, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Goplarbazar', 3371),
(979, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Golduba', 3372),
(980, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Digalbak', 3373),
(981, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Inathganj', 3374),
(982, 'Barisal ', 'Barishal', 'Agailzhara', 'Agailzhara', 8240),
(983, 'Barisal ', 'Barishal', 'Agailzhara', 'Gaila', 8241),
(984, 'Barisal ', 'Barishal', 'Agailzhara', 'Paisarhat', 8242),
(985, 'Barisal ', 'Barishal', 'Babuganj', 'Babuganj', 8210),
(986, 'Barisal ', 'Barishal', 'Babuganj', 'Rahamatpur', 8211),
(987, 'Barisal ', 'Barishal', 'Babuganj', 'Chandpasha', 8212),
(988, 'Barisal ', 'Barishal', 'Babuganj', 'Madhabpasha', 8213),
(989, 'Barisal ', 'Barishal', 'Babuganj', 'Thakur Mallik', 8214),
(990, 'Barisal ', 'Barishal', 'Babuganj', 'Nizamuddin College', 8215),
(991, 'Barisal ', 'Barishal', 'Babuganj', 'Barishal Cadet', 8216),
(992, 'Barisal ', 'Barishal', 'Barajalia', 'Barajalia', 8260),
(993, 'Barisal ', 'Barishal', 'Barajalia', 'Osman Manjil', 8261),
(994, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Barishal Sadar', 8200),
(995, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Bukhainagar', 8201),
(996, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Saheberhat', 8202),
(997, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Sugandia', 8203),
(998, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Patang', 8204),
(999, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Kashipur', 8205),
(1000, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Jaguarhat', 8206),
(1001, 'Barisal ', 'Barishal', 'Gouranadi', 'Gouranadi', 8230),
(1002, 'Barisal ', 'Barishal', 'Gouranadi', 'Tarki Bandar', 8231),
(1003, 'Barisal ', 'Barishal', 'Gouranadi', 'Kashemabad', 8232),
(1004, 'Barisal ', 'Barishal', 'Gouranadi', 'Batajor', 8233),
(1005, 'Barisal ', 'Barishal', 'Mahendiganj', 'Mahendiganj', 8270),
(1006, 'Barisal ', 'Barishal', 'Mahendiganj', 'Laskarpur', 8271),
(1007, 'Barisal ', 'Barishal', 'Mahendiganj', 'Ulania', 8272),
(1008, 'Barisal ', 'Barishal', 'Mahendiganj', 'Nalgora', 8273),
(1009, 'Barisal ', 'Barishal', 'Mahendiganj', 'Langutia', 8274),
(1010, 'Barisal ', 'Barishal', 'Muladi', 'Muladi', 8250),
(1011, 'Barisal ', 'Barishal', 'Muladi', 'Kazirchar', 8251),
(1012, 'Barisal ', 'Barishal', 'Muladi', 'Charkalekhan', 8252),
(1013, 'Barisal ', 'Barishal', 'Sahebganj', 'Sahebganj', 8280),
(1014, 'Barisal ', 'Barishal', 'Sahebganj', 'Charamandi', 8281),
(1015, 'Barisal ', 'Barishal', 'Sahebganj', 'Padri Shibpur', 8282),
(1016, 'Barisal ', 'Barishal', 'Sahebganj', 'Shialguni', 8283),
(1017, 'Barisal ', 'Barishal', 'Sahebganj', 'kalaskati', 8284),
(1018, 'Barisal ', 'Barishal', 'Uzirpur', 'Uzirpur', 8220),
(1019, 'Barisal ', 'Barishal', 'Uzirpur', 'Dhamura', 8221),
(1020, 'Barisal ', 'Barishal', 'Uzirpur', 'Jugirkanda', 8222),
(1021, 'Barisal ', 'Barishal', 'Uzirpur', 'Dakuarhat', 8223),
(1022, 'Barisal ', 'Barishal', 'Uzirpur', 'Shikarpur', 8224),
(1023, 'Barisal ', 'Bhola', 'Bhola Sadar', 'Bhola Sadar', 8300),
(1024, 'Barisal ', 'Bhola', 'Bhola Sadar', 'Joynagar', 8301),
(1025, 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Borhanuddin UPO', 8320),
(1026, 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Mirzakalu', 8321),
(1027, 'Barisal ', 'Bhola', 'Charfashion', 'Charfashion', 8340),
(1028, 'Barisal ', 'Bhola', 'Charfashion', 'Dularhat', 8341),
(1029, 'Barisal ', 'Bhola', 'Charfashion', 'Keramatganj', 8342),
(1030, 'Barisal ', 'Bhola', 'Doulatkhan', 'Doulatkhan', 8310),
(1031, 'Barisal ', 'Bhola', 'Doulatkhan', 'Hajipur', 8311),
(1032, 'Barisal ', 'Bhola', 'Hajirhat', 'Hajirhat', 8360),
(1033, 'Barisal ', 'Bhola', 'Hatshoshiganj', 'Hatshoshiganj', 8350),
(1034, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Lalmohan UPO', 8330),
(1035, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Daurihat', 8331),
(1036, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Gazaria', 8332),
(1037, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Jhalokathi Sadar', 8400),
(1038, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Nabagram', 8401),
(1039, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Baukathi', 8402),
(1040, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Gabha', 8403),
(1041, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Shekherhat', 8404),
(1042, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Kathalia', 8430),
(1043, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Amua', 8431),
(1044, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Niamatee', 8432),
(1045, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Shoulajalia', 8433),
(1046, 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Nalchhiti', 8420),
(1047, 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Beerkathi', 8421),
(1048, 'Barisal ', 'Jhalokathi', 'Rajapur', 'Rajapur', 8410),
(1049, 'Barisal ', 'Pirojpur', 'Banaripara', 'Banaripara', 8530),
(1050, 'Barisal ', 'Pirojpur', 'Banaripara', 'Chakhar', 8531),
(1051, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Bhandaria', 8550),
(1052, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Kanudashkathi', 8551),
(1053, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Dhaoa', 8552),
(1054, 'Barisal ', 'Pirojpur', 'kaukhali', 'Kaukhali', 8510),
(1055, 'Barisal ', 'Pirojpur', 'kaukhali', 'Keundia', 8511),
(1056, 'Barisal ', 'Pirojpur', 'kaukhali', 'Joykul', 8512),
(1057, 'Barisal ', 'Pirojpur', 'kaukhali', 'Jolagati', 8513),
(1058, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Mathbaria', 8560),
(1059, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tushkhali', 8561),
(1060, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Halta', 8562),
(1061, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Gulishakhali', 8563),
(1062, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tiarkhali', 8564),
(1063, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Betmor Natun Hat', 8565),
(1064, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Shilarganj', 8566),
(1065, 'Barisal ', 'Pirojpur', 'Nazirpur', 'Nazirpur', 8540),
(1066, 'Barisal ', 'Pirojpur', 'Nazirpur', 'Sriramkathi', 8541),
(1067, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Pirojpur Sadar', 8500),
(1068, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Hularhat', 8501),
(1069, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Parerhat', 8502),
(1070, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Swarupkathi', 8520),
(1071, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Darus Sunnat', 8521),
(1072, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Kaurikhara', 8522),
(1073, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Jalabari', 8523),
(1074, 'Barisal ', 'Patuakhali', 'Bauphal', 'Bauphal', 8620),
(1075, 'Barisal ', 'Patuakhali', 'Bauphal', 'Bagabandar', 8621),
(1076, 'Barisal ', 'Patuakhali', 'Bauphal', 'Birpasha', 8622),
(1077, 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalishari', 8623),
(1078, 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalaia', 8624),
(1079, 'Barisal ', 'Patuakhali', 'Dashmina', 'Dashmina', 8630),
(1080, 'Barisal ', 'Patuakhali', 'Galachipa', 'Galachipa', 8640),
(1081, 'Barisal ', 'Patuakhali', 'Galachipa', 'Gazipur Bandar', 8641),
(1082, 'Barisal ', 'Patuakhali', 'Khepupara', 'Khepupara', 8650),
(1083, 'Barisal ', 'Patuakhali', 'Khepupara', 'Mahipur', 8651),
(1084, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Patuakhali Sadar', 8600),
(1085, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Moukaran', 8601),
(1086, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Dumkee', 8602),
(1087, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Rahimabad', 8603),
(1088, 'Barisal ', 'Patuakhali', 'Subidkhali', 'Subidkhali', 8610),
(1089, 'Barisal ', 'Barguna', 'Amtali', 'Amtali', 8710),
(1090, 'Barisal ', 'Barguna', 'Bamna', 'Bamna', 8730),
(1091, 'Barisal ', 'Barguna', 'Barguna Sadar', 'Barguna Sadar', 8700),
(1092, 'Barisal ', 'Barguna', 'Barguna Sadar', 'Nali Bandar', 8701),
(1093, 'Barisal ', 'Barguna', 'Betagi', 'Betagi', 8740),
(1094, 'Barisal ', 'Barguna', 'Betagi', 'Darul Ulam', 8741),
(1095, 'Barisal ', 'Barguna', 'Patharghata', 'Patharghata', 8720),
(1096, 'Barisal ', 'Barguna', 'Patharghata', 'Kakchira', 8721),
(1097, 'Rajshahi ', 'Panchagarh', 'Boda', 'Boda', 5010),
(1098, 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Chotto Dab', 5040),
(1099, 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Mirjapur', 5041),
(1100, 'Rajshahi ', 'Panchagarh', 'Dabiganj', 'Dabiganj', 5020),
(1101, 'Rajshahi ', 'Panchagarh', 'Panchagra Sadar', 'Panchagar Sadar', 5000),
(1102, 'Rajshahi ', 'Panchagarh', 'Tetulia', 'Tetulia', 5030),
(1103, 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Baliadangi', 5140),
(1104, 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Lahiri', 5141),
(1105, 'Rajshahi ', 'Thakurgaon', 'Jibanpur', 'Jibanpur', 5130),
(1106, 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', 5110),
(1107, 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', 5470),
(1108, 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Rani Sankail', 5120),
(1109, 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Nekmarad', 5121),
(1110, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Sadar', 5100),
(1111, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Road', 5101),
(1112, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Shibganj', 5102),
(1113, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Ruhia', 5103),
(1114, 'Rajshahi ', 'Dinajpur', 'Bangla Hili', 'Bangla Hili', 5270),
(1115, 'Rajshahi ', 'Dinajpur', 'Biral', 'Biral', 5210),
(1116, 'Rajshahi ', 'Dinajpur', 'Birampur', 'Birampur', 5266),
(1117, 'Rajshahi ', 'Dinajpur', 'Birganj', 'Birganj', 5220),
(1118, 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Chrirbandar', 5240),
(1119, 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Ranirbandar', 5241),
(1120, 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Sadar', 5200),
(1121, 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Rajbari', 5201),
(1122, 'Rajshahi ', 'Dinajpur', 'Khansama', 'Khansama', 5230),
(1123, 'Rajshahi ', 'Dinajpur', 'Khansama', 'Pakarhat', 5231),
(1124, 'Rajshahi ', 'Dinajpur', 'Maharajganj', 'Maharajganj', 5226),
(1125, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Nababganj', 5280),
(1126, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Daudpur', 5281),
(1127, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Gopalpur', 5282),
(1128, 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Osmanpur', 5290),
(1129, 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Ghoraghat', 5291),
(1130, 'Rajshahi ', 'Dinajpur', 'Parbatipur', 'Parbatipur', 5250),
(1131, 'Rajshahi ', 'Dinajpur', 'Phulbari', 'Phulbari', 5260),
(1132, 'Rajshahi ', 'Dinajpur', 'Setabganj', 'Setabganj', 5216),
(1133, 'Rajshahi ', 'Nilphamari', 'Dimla', 'Dimla', 5350),
(1134, 'Rajshahi ', 'Nilphamari', 'Dimla', 'Ghaga Kharibari', 5351),
(1135, 'Rajshahi ', 'Nilphamari', 'Domar', 'Domar', 5340),
(1136, 'Rajshahi ', 'Nilphamari', 'Domar', 'Chilahati', 5341),
(1137, 'Rajshahi ', 'Nilphamari', 'Jaldhaka', 'Jaldhaka', 5330),
(1138, 'Rajshahi ', 'Nilphamari', 'Kishoriganj', 'Kishoriganj', 5320),
(1139, 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sadar', 5300),
(1140, 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sugar Mil', 5301),
(1141, 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur', 5310),
(1142, 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur Upashahar', 5311),
(1143, 'Rajshahi ', 'Rangpur', 'Badarganj', 'Badarganj', 5430),
(1144, 'Rajshahi ', 'Rangpur', 'Badarganj', 'Shyampur', 5431),
(1145, 'Rajshahi ', 'Rangpur', 'Gangachara', 'Gangachara', 5410),
(1146, 'Rajshahi ', 'Rangpur', 'Kaunia', 'Kaunia', 5440),
(1147, 'Rajshahi ', 'Rangpur', 'Kaunia', 'Haragachh', 5441),
(1148, 'Rajshahi ', 'Rangpur', 'Mithapukur', 'Mithapukur', 5460),
(1149, 'Rajshahi ', 'Rangpur', 'Pirgachha', 'Pirgachha', 5450),
(1150, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Sadar', 5400),
(1151, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Upa-Shahar', 5401),
(1152, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Alamnagar', 5402),
(1153, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Mahiganj', 5403),
(1154, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Cadet Colleg', 5404),
(1155, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Carmiecal Col', 5405),
(1156, 'Rajshahi ', 'Rangpur', 'Taraganj', 'Taraganj', 5420),
(1157, 'Rajshahi ', 'Lalmonirhat', 'Aditmari', 'Aditmari', 5510),
(1158, 'Rajshahi ', 'Lalmonirhat', 'Hatibandha', 'Hatibandha', 5530),
(1159, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Lalmonirhat Sadar', 5500),
(1160, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Moghalhat', 5501),
(1161, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Kulaghat SO', 5502),
(1162, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Patgram', 5540),
(1163, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Baura', 5541),
(1164, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Burimari', 5542),
(1165, 'Rajshahi ', 'Lalmonirhat', 'Tushbhandar', 'Tushbhandar', 5520),
(1166, 'Rajshahi ', 'Kurigram', 'Bhurungamari', 'Bhurungamari', 5670),
(1167, 'Rajshahi ', 'Kurigram', 'Chilmari', 'Chilmari', 5630),
(1168, 'Rajshahi ', 'Kurigram', 'Chilmari', 'Jorgachh', 5631),
(1169, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Kurigram Sadar', 5600),
(1170, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Pandul', 5601),
(1171, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Phulbari', 5680),
(1172, 'Rajshahi ', 'Kurigram', 'Nageshwar', 'Nageshwar', 5660),
(1173, 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Rajarhat', 5610),
(1174, 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Nazimkhan', 5611),
(1175, 'Rajshahi ', 'Kurigram', 'Rajibpur', 'Rajibpur', 5650),
(1176, 'Rajshahi ', 'Kurigram', 'Roumari', 'Roumari', 5640),
(1177, 'Rajshahi ', 'Kurigram', 'Ulipur', 'Ulipur', 5620),
(1178, 'Rajshahi ', 'Kurigram', 'Ulipur', 'Bazarhat', 5621),
(1179, 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'Bonarpara', 5750),
(1180, 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'saghata', 5751),
(1181, 'Rajshahi ', 'Gaibandha', 'Gaibandha Sadar', 'Gaibandha Sadar', 5700),
(1182, 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Gobindhaganj', 5740),
(1183, 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Mahimaganj', 5741),
(1184, 'Rajshahi ', 'Gaibandha', 'Palashbari', 'Palashbari', 5730),
(1185, 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Phulchhari', 5760),
(1186, 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Bharatkhali', 5761),
(1187, 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Saadullapur', 5710),
(1188, 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Naldanga', 5711),
(1189, 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Sundarganj', 5720),
(1190, 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Bamandanga', 5721),
(1191, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Adamdighi', 5890),
(1192, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Santahar', 5891),
(1193, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Nasharatpur', 5892),
(1194, 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Sadar', 5800),
(1195, 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Canttonment', 5801),
(1196, 'Rajshahi ', 'Bogra', 'Dhunat', 'Dhunat', 5850),
(1197, 'Rajshahi ', 'Bogra', 'Dhunat', 'Gosaibari', 5851),
(1198, 'Rajshahi ', 'Bogra', 'Dupchachia', 'Dupchachia', 5880),
(1199, 'Rajshahi ', 'Bogra', 'Dupchachia', 'Talora', 5881),
(1200, 'Rajshahi ', 'Bogra', 'Gabtoli', 'Gabtoli', 5820),
(1201, 'Rajshahi ', 'Bogra', 'Gabtoli', 'Sukhanpukur', 5821),
(1202, 'Rajshahi ', 'Bogra', 'Kahalu', 'Kahalu', 5870),
(1203, 'Rajshahi ', 'Bogra', 'Nandigram', 'Nandigram', 5860),
(1204, 'Rajshahi ', 'Bogra', 'Sariakandi', 'Sariakandi', 5830),
(1205, 'Rajshahi ', 'Bogra', 'Sariakandi', 'Chandan Baisha', 5831),
(1206, 'Rajshahi ', 'Bogra', 'Sherpur', 'Sherpur', 5840),
(1207, 'Rajshahi ', 'Bogra', 'Sherpur', 'Chandaikona', 5841),
(1208, 'Rajshahi ', 'Bogra', 'Sherpur', 'Palli Unnyan Accadem', 5842),
(1209, 'Rajshahi ', 'Bogra', 'Shibganj', 'Shibganj', 5810),
(1210, 'Rajshahi ', 'Bogra', 'Sonatola', 'Sonatola', 5826),
(1211, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'Akklepur', 5940),
(1212, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'jamalganj', 5941),
(1213, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'Tilakpur', 5942),
(1214, 'Rajshahi ', 'Joypurhat', 'Joypurhat Sadar', 'Joypurhat Sadar', 5900),
(1215, 'Rajshahi ', 'Joypurhat', 'kalai', 'kalai', 5930),
(1216, 'Rajshahi ', 'Joypurhat', 'Khetlal', 'Khetlal', 5920),
(1217, 'Rajshahi ', 'Joypurhat', 'panchbibi', 'Panchbibi', 5910),
(1218, 'Rajshahi ', 'Rajshahi', 'Bagha', 'Bagha', 6280),
(1219, 'Rajshahi ', 'Rajshahi', 'Bagha', 'Arani', 6281),
(1220, 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Bhabaniganj', 6250),
(1221, 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Taharpur', 6251),
(1222, 'Rajshahi ', 'Rajshahi', 'Charghat', 'Charghat', 6270),
(1223, 'Rajshahi ', 'Rajshahi', 'Charghat', 'Sarda', 6271),
(1224, 'Rajshahi ', 'Rajshahi', 'Durgapur', 'Durgapur', 6240),
(1225, 'Rajshahi ', 'Rajshahi', 'Godagari', 'Godagari', 6290),
(1226, 'Rajshahi ', 'Rajshahi', 'Godagari', 'Premtoli', 6291),
(1227, 'Rajshahi ', 'Rajshahi', 'Khod Mohanpur', 'Khodmohanpur', 6220),
(1228, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Lalitganj', 6210),
(1229, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Rajshahi Sugar Mills', 6211),
(1230, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Shyampur', 6212),
(1231, 'Rajshahi ', 'Rajshahi', 'Putia', 'Putia', 6260),
(1232, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Sadar', 6000),
(1233, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Ghuramara', 6100),
(1234, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Court', 6201),
(1235, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Canttonment', 6202),
(1236, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Sapura', 6203),
(1237, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Kazla', 6204),
(1238, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi University', 6205),
(1239, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Binodpur Bazar', 6206),
(1240, 'Rajshahi ', 'Rajshahi', 'Tanor', 'Tanor', 6230),
(1241, 'Rajshahi ', 'Chapinawabganj', 'Bholahat', 'Bholahat', 6330),
(1242, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Chapinawbganj Sadar', 6300),
(1243, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Rajarampur', 6301),
(1244, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Ramchandrapur', 6302),
(1245, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Amnura', 6303),
(1246, 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Nachol', 6310),
(1247, 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Mandumala', 6311),
(1248, 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Rohanpur', 6320),
(1249, 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Gomashtapur', 6321),
(1250, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Shibganj U.P.O', 6340),
(1251, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Kansart', 6341),
(1252, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Manaksha', 6342),
(1253, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Gopalpur U.P.O', 6420),
(1254, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Lalpur S.O', 6421),
(1255, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Abdulpur', 6422),
(1256, 'Rajshahi ', 'Natore', 'Harua', 'Harua', 6430),
(1257, 'Rajshahi ', 'Natore', 'Harua', 'Dayarampur', 6431),
(1258, 'Rajshahi ', 'Natore', 'Harua', 'Baraigram', 6432),
(1259, 'Rajshahi ', 'Natore', 'Hatgurudaspur', 'Hatgurudaspur', 6440),
(1260, 'Rajshahi ', 'Natore', 'Laxman', 'Laxman', 6410),
(1261, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Natore Sadar', 6400),
(1262, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Digapatia', 6401),
(1263, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Baiddyabal Gharia', 6402),
(1264, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Madhnagar', 6403),
(1265, 'Rajshahi ', 'Natore', 'Singra', 'Singra', 6450),
(1266, 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Ahsanganj', 6596),
(1267, 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Bandai', 6597),
(1268, 'Rajshahi ', 'Naogaon', 'Badalgachhi', 'Badalgachhi', 6570),
(1269, 'Rajshahi ', 'Naogaon', 'Dhamuirhat', 'Dhamuirhat', 6580),
(1270, 'Rajshahi ', 'Naogaon', 'Mahadebpur', 'Mahadebpur', 6530),
(1271, 'Rajshahi ', 'Naogaon', 'Naogaon Sadar', 'Naogaon Sadar', 6500),
(1272, 'Rajshahi ', 'Naogaon', 'Niamatpur', 'Niamatpur', 6520),
(1273, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Nitpur', 6550),
(1274, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Porsa', 6551),
(1275, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Panguria', 6552),
(1276, 'Rajshahi ', 'Naogaon', 'Patnitala', 'Patnitala', 6540),
(1277, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Prasadpur', 6510),
(1278, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Manda', 6511),
(1279, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Balihar', 6512),
(1280, 'Rajshahi ', 'Naogaon', 'Raninagar', 'Raninagar', 6590),
(1281, 'Rajshahi ', 'Naogaon', 'Raninagar', 'Kashimpur', 6591),
(1282, 'Rajshahi ', 'Naogaon', 'Sapahar', 'Sapahar', 6560),
(1283, 'Rajshahi ', 'Naogaon', 'Sapahar', 'Moduhil', 6561),
(1284, 'Rajshahi ', 'Pabna', 'Banwarinagar', 'Banwarinagar', 6650),
(1285, 'Rajshahi ', 'Pabna', 'Bera', 'Bera', 6680),
(1286, 'Rajshahi ', 'Pabna', 'Bera', 'Nakalia', 6681),
(1287, 'Rajshahi ', 'Pabna', 'Bera', 'Kashinathpur', 6682),
(1288, 'Rajshahi ', 'Pabna', 'Bera', 'Puran Bharenga', 6683),
(1289, 'Rajshahi ', 'Pabna', 'Bhangura', 'Bhangura', 6640),
(1290, 'Rajshahi ', 'Pabna', 'Chatmohar', 'Chatmohar', 6630),
(1291, 'Rajshahi ', 'Pabna', 'Debottar', 'Debottar', 6610),
(1292, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Ishwardi', 6620),
(1293, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Dhapari', 6621),
(1294, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Pakshi', 6622),
(1295, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Rajapur', 6623),
(1296, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Pabna Sadar', 6600),
(1297, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Kaliko Cotton Mills', 6601),
(1298, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Hamayetpur', 6602),
(1299, 'Rajshahi ', 'Pabna', 'Sathia', 'Sathia', 6670),
(1300, 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sujanagar', 6660),
(1301, 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sagarkandi', 6661),
(1302, 'Rajshahi ', 'Sirajganj', 'Baiddya Jam Toil', 'Baiddya Jam Toil', 6730),
(1303, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Belkuchi', 6740),
(1304, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sohagpur', 6741),
(1305, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Rajapur', 6742),
(1306, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Enayetpur', 6751),
(1307, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sthal', 6752),
(1308, 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Dhangora', 6720),
(1309, 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Malonga', 6721),
(1310, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Kazipur', 6710),
(1311, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Shuvgachha', 6711),
(1312, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Gandail', 6712),
(1313, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Shahjadpur', 6770),
(1314, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Porjana', 6771),
(1315, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Jamirta', 6772),
(1316, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Kaijuri', 6773),
(1317, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Sirajganj Sadar', 6700),
(1318, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Raipur', 6701),
(1319, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Rashidabad', 6702),
(1320, 'Rajshahi ', 'Sirajganj', 'Tarash', 'Tarash', 6780),
(1321, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara', 6760),
(1322, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara R.S', 6761),
(1323, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Lahiri Mohanpur', 6762),
(1324, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Salap', 6763);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `sub_category`) VALUES
(1, 'Education', 'Science'),
(2, 'Education', 'Commerce'),
(3, 'Education', 'Arts'),
(4, 'Education', 'IELTS,TOFEL'),
(5, 'Education', 'GRE,GMAT'),
(6, 'Education', 'Admission'),
(7, 'Education', 'Govt. Job'),
(8, 'Education', 'Others Job'),
(9, 'Education', 'Literature'),
(10, 'Education', 'Self Development'),
(11, 'Education', 'Skill and Training'),
(12, 'Education', 'Scientific Instrument '),
(13, 'Education', 'Painting and Drawing'),
(14, 'Education', 'Medical Instruments'),
(15, 'Education', 'Engineering Instruments'),
(16, 'Education', 'Others'),
(17, 'Sports', 'Indoor'),
(18, 'Sports', 'Outdoor'),
(19, 'Home Appliances', 'Electronics '),
(20, 'Home Appliances', 'Furnitures'),
(21, 'Home Appliances', 'Others'),
(22, 'Food', 'Dry Food'),
(23, 'Clothes', 'Winter'),
(24, 'Others', 'Others'),
(25, 'Hobby', 'Pets'),
(26, 'Hobby', 'Others');

-- --------------------------------------------------------

--
-- Table structure for table `map_locations`
--

CREATE TABLE `map_locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `latitude` decimal(8,2) NOT NULL,
  `longitude` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_09_16_191456_create_photos_table', 1),
(9, '2019_10_02_163040_create_user_infos_table', 1),
(10, '2019_10_02_163124_create_areas_table', 1),
(11, '2019_10_02_163149_create_map_locations_table', 1),
(12, '2019_10_02_163209_create_roles_table', 1),
(13, '2019_10_02_163221_create_role_users_table', 1),
(14, '2019_10_02_163235_create_posts_table', 1),
(15, '2019_10_02_163250_create_post_photos_table', 1),
(16, '2019_10_02_163310_create_post_reviews_table', 1),
(17, '2019_10_26_183002_create_categories_table', 2),
(18, '2019_11_07_095738_create_user_activities_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0367b99ef4597af702b48bc41ae3dfdb4bfa8205d5d0b4b8717e33daec028a71dfa14df954a0c365', 8, 3, 'MyApp', '[]', 0, '2019-10-24 01:11:27', '2019-10-24 01:11:27', '2020-10-24 07:11:27'),
('0538d60ff088607a7ee9eabff171d149fcbd7633a20bbca7af2d8e078b934232f94a27b145129372', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:42:18', '2019-10-22 05:42:18', '2020-10-22 11:42:18'),
('08b7abf0fa9d275a4bc8ef2335560edb45282352ffdb5f804b25682e723232e900ec93244bfacd09', 8, 3, 'MyApp', '[]', 0, '2019-10-23 11:09:32', '2019-10-23 11:09:32', '2020-10-23 17:09:32'),
('090b256502a09c7172d994cf76dd5a718935b51fd9aa5524a595dd75fbd5be778d653fb22cbc2d81', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:54:12', '2019-10-22 06:54:12', '2020-10-22 12:54:12'),
('0aa01291a76c03957b7f353cb1942a3eb9b90016ba2ec1cba4fb012c00bd2e6db750c6a686b1a2b3', 8, 3, 'MyApp', '[]', 0, '2019-10-23 10:54:52', '2019-10-23 10:54:52', '2020-10-23 16:54:52'),
('10e316a2d4283f757199ed05c6aeb22feedc53b48351bc83391095616e19243c951d6167caf2b542', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:20:28', '2019-10-22 07:20:28', '2020-10-22 13:20:28'),
('11f9dcedddb7da0cf58bfbafc224eaaba838b51b9fd9fe487fb29a3d68cc333fdef82bc245356707', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:27:10', '2019-10-29 10:27:10', '2020-10-29 16:27:10'),
('143d66c3090c43464b2620f9d96e3d751c25e27d3abe510a7b2780332d1b830ee2f1b5b5fc012a50', 7, 3, 'MyApp', '[]', 0, '2019-10-09 13:33:50', '2019-10-09 13:33:50', '2020-10-09 19:33:50'),
('16670f8619a147c02fffd7eab4332da69b51fd5dcccab4a3c97177001f66b84cb959689ac312c467', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:42:52', '2019-10-29 10:42:52', '2020-10-29 16:42:52'),
('16fd0cd170ee6d65dbbe61417e5f94c8619797a631bf4d1b5d42969e41a43e5bfbe2c27c4c9554bb', 2, 1, 'MyApp', '[]', 0, '2019-10-08 07:54:13', '2019-10-08 07:54:13', '2020-10-08 13:54:13'),
('196960fabc8cd81114b1d54236b9bd1fa158d16161f6f6a03f13f4711374c68b5b252480b75f60a7', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:41:05', '2019-10-22 06:41:05', '2020-10-22 12:41:05'),
('1a2fb0396fc0d14c10f9f40081a4f94b2614ad863415ee5b704624f9ff7bab4aadd8ce3dcae74dd5', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:43:06', '2019-10-22 06:43:06', '2020-10-22 12:43:06'),
('1d4dd51296f3e5eb0cceeb5bba8e8a2a714a4fc449a22f907b37eb74883aafaa8a6dafef50e97f79', 8, 3, 'MyApp', '[]', 0, '2019-10-21 12:34:48', '2019-10-21 12:34:48', '2020-10-21 18:34:48'),
('2055df0e2dad05c6d64100e53a594178f95e484ea582706b196e0dbf0208040826da11781c35ff84', 5, 3, 'MyApp', '[]', 0, '2019-10-08 13:58:08', '2019-10-08 13:58:08', '2020-10-08 19:58:08'),
('219eb707ac99d7a39dcf4a81d79074eff3ae4ee7c06a7d2733a962c54bd351a98b44149ea714e74f', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:24:53', '2019-10-29 10:24:53', '2020-10-29 16:24:53'),
('266e62737c7cdeab26f822ced66e3c736fb3e064c80abd3a9fe4d9451938afe7934af5542839e462', 8, 3, 'MyApp', '[]', 1, '2019-10-29 21:27:15', '2019-10-29 21:27:15', '2020-10-30 03:27:15'),
('26aa9f897ac2f10d12dc174eac8fe10c7e5eb5d5367b713249ac22b97221868842e1182ef429c798', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:47:30', '2019-10-22 07:47:30', '2020-10-22 13:47:30'),
('2c9881c634258c3da0b527de2fc1ac9c11040d569de8631a0d33c0c31f90001d61fbf1d5d446e27e', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:20:59', '2019-10-22 06:20:59', '2020-10-22 12:20:59'),
('2d1b1d634b6d9c79523c775fe4ddd9725ac08a71e34fb091c4adfd90984c8adaadb66777e9165e1c', 7, 3, 'MyApp', '[]', 0, '2019-10-09 11:14:46', '2019-10-09 11:14:46', '2020-10-09 17:14:46'),
('3267967041658890f4aafe3f23d0c82e6e6dd6d8bd3e856ba7502cc6424b553d0298fce1f47d10df', 7, 3, 'MyApp', '[]', 0, '2019-10-24 00:28:25', '2019-10-24 00:28:25', '2020-10-24 06:28:25'),
('3286500c92d207becbfa915f222fc7745ab7c4839a0ffe373189b6e704ba452ad3c2d9da78757e90', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:12:52', '2019-10-22 06:12:52', '2020-10-22 12:12:52'),
('33d28f112d1d19eff7ac2d539655263f9ddf4a2d9015f3dcc5f74a736029c872a76e8df60176257c', 7, 3, 'MyApp', '[]', 0, '2019-10-20 00:03:13', '2019-10-20 00:03:13', '2020-10-20 06:03:13'),
('346945987b93b78c19fe0e7519bfd014865f29d85b12157f8572d1af4de42369a2dfa5214c17683b', 7, 3, 'MyApp', '[]', 0, '2019-11-05 03:17:39', '2019-11-05 03:17:39', '2020-11-05 09:17:39'),
('358daafbd07eb6bf89b9bd1b76b49deb5b34a4c498e96d92fda8064a4efeda474c8c1dc7c1e6f229', 7, 3, 'MyApp', '[]', 0, '2019-10-19 23:14:39', '2019-10-19 23:14:39', '2020-10-20 05:14:39'),
('3604bf19f6e3fb136b0c9db2527c224e7632c4999327684a89feac5bd5d8290e69fcd9f238b3e882', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:19:20', '2019-10-22 06:19:20', '2020-10-22 12:19:20'),
('378b95eb7a52cec66dea2aadd91cfaf2eb83d45264fbd61a5f81f4f401f13ffd8530d2264f9f680c', 8, 3, 'MyApp', '[]', 0, '2019-10-23 11:03:45', '2019-10-23 11:03:45', '2020-10-23 17:03:45'),
('3e75bda43f12e2116a9e6b3b5bf54cf334e0506e8a00cec09c04c526502137ab41d9d9a62700e860', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:16:07', '2019-10-22 01:16:07', '2020-10-22 07:16:07'),
('45ac8200936a4eb073ce86a8348243ac97b8b24b733efe9d217a279d68a0452ed33c23cd5e527c66', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:58:08', '2019-10-22 05:58:08', '2020-10-22 11:58:08'),
('45c88bf8c552fe52da8377115c4f3eded97c7078253625aa947599f8a64006bb03f7228d7ffae672', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:14:42', '2019-10-22 06:14:42', '2020-10-22 12:14:42'),
('47072ce6e5ed06b2afab885539364bee779b98c0648b1f7ab667adaed94e2a13df0c210446067035', 7, 3, 'MyApp', '[]', 0, '2019-11-06 22:37:22', '2019-11-06 22:37:22', '2020-11-07 04:37:22'),
('48832a6f4ba125036897849e5b3712e13b9b32b4f71f0ac0cb7df01dd3ff41b1df0d407eb8b60f83', 8, 3, 'MyApp', '[]', 0, '2019-10-21 12:35:00', '2019-10-21 12:35:00', '2020-10-21 18:35:00'),
('4a491def5dd0ac5ed8e2d58b184f575f451ff69810fa0cd5192d9f5ecda5149240f3f32d6cb8f732', 7, 3, 'MyApp', '[]', 1, '2019-11-05 22:35:02', '2019-11-05 22:35:02', '2020-11-06 04:35:02'),
('4df53c77d0663d969e955e73c9e45d4e4edf453914defd5226f5d3c2120650620eca3e2860e1594d', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:07:22', '2019-10-22 01:07:22', '2020-10-22 07:07:22'),
('4e982acd704575e0ad16d3fe1db3fb19a0417457bfa0f33558b7dccce6b0d8dfc96f75f9be09c6a6', 8, 3, 'MyApp', '[]', 1, '2019-10-29 13:52:43', '2019-10-29 13:52:43', '2020-10-29 19:52:43'),
('4f42bad92b1e9929eb80c89a3a9b6425a7fe3e94e2febb0adc8ca9d3706469c5d9f1d1e8d8c3d97b', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:36:32', '2019-10-29 10:36:32', '2020-10-29 16:36:32'),
('514c145e0db2122856837f008f7c662743b09ac4dcc80172165249f43c694a565139d42514ece74a', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:36:23', '2019-10-22 07:36:23', '2020-10-22 13:36:23'),
('518519b8499afc53dd3984a999885c9d12ebd58600004001c62bc02ed70e2ba0506964f3f975269c', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:07:53', '2019-10-22 01:07:53', '2020-10-22 07:07:53'),
('5328423d6686644a1a04361fe6cb168c820b370b45a5e13e0a70b8840bb65b619a80961ecf7b92e6', 8, 3, 'MyApp', '[]', 0, '2019-10-23 11:10:51', '2019-10-23 11:10:51', '2020-10-23 17:10:51'),
('5408acd55708ffbbda1044121637f5ca7a3778c02bc674bfc1bf553dc4817668c050651a3bf48128', 7, 3, 'MyApp', '[]', 1, '2019-11-06 13:19:50', '2019-11-06 13:19:50', '2020-11-06 19:19:50'),
('591f0a7ba8316ae3b00cef47a22840de9ff91177aa639190db00fbd067ac1edd2ecdb5a9d34dd65d', 8, 3, 'MyApp', '[]', 1, '2019-10-29 22:01:29', '2019-10-29 22:01:29', '2020-10-30 04:01:29'),
('5b8eaf256fe0a6fb21d0cbf7271d696ad5362d1ac6eadaa7f73b415a4fb4f1d14a77b43cdf6d6396', 8, 3, 'MyApp', '[]', 0, '2019-10-21 12:33:40', '2019-10-21 12:33:40', '2020-10-21 18:33:40'),
('5e01f4004684c8ae85926e5f68953af8ce6c530e2b43d8226d8daf951e294a8a8bcea7dc54c64980', 7, 3, 'MyApp', '[]', 0, '2019-10-20 00:00:51', '2019-10-20 00:00:51', '2020-10-20 06:00:51'),
('5f591d4ae031194be1182ca129136d4fa17bc429f6354ea5cdeccebf5c9fec98bd8267dc9b6968cd', 9, 3, 'MyApp', '[]', 0, '2019-10-29 13:52:15', '2019-10-29 13:52:15', '2020-10-29 19:52:15'),
('60ba3f3db5eef94e9ddb563442a0b5cba5af04c0fd5ee1354493e813b2231a575aa8288a6da8e9b0', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:18:05', '2019-10-22 06:18:05', '2020-10-22 12:18:05'),
('62ba7dc2dbfc30c5a9041134e6ddcfe1868fa5c93e1eb54ab4293ad6b7a3c75d031dd41025f998a1', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:08:52', '2019-10-22 07:08:52', '2020-10-22 13:08:52'),
('63f268e71035232215a6eb8182031ac973bc0cc830164a54a4882be7d32dc400ef3eda48f7fea317', 5, 3, 'MyApp', '[]', 0, '2019-10-08 13:59:03', '2019-10-08 13:59:03', '2020-10-08 19:59:03'),
('65e189ff977ab8ab87c9545ec25eecbd54544cc6181f424eb75af8f433f22443f1a6ebfa317c7d51', 8, 3, 'MyApp', '[]', 0, '2019-10-29 10:12:33', '2019-10-29 10:12:33', '2020-10-29 16:12:33'),
('662811f57abacb0cc8059ffcbd582ea3b1be18ed0413d3fb16a9655a6f062eca29ad2ac46112c387', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:45:41', '2019-10-29 10:45:41', '2020-10-29 16:45:41'),
('6b141c73faba8100854afeb573ec84dc921d1c5fb071d2031f4192e79efd1dfc1d0c75004505b9f0', 8, 3, 'MyApp', '[]', 1, '2019-10-29 09:54:11', '2019-10-29 09:54:11', '2020-10-29 15:54:11'),
('6c789d1bed19fb4554b13fbcace97c332ce0f34f3fc4b3c42c87da39d92f1690df2de70d1ffc1855', 7, 3, 'MyApp', '[]', 0, '2019-10-19 02:43:28', '2019-10-19 02:43:28', '2020-10-19 08:43:28'),
('6d65dad7465625fd0b17816f9c80b333792e0f87d637f5d144329d5acb96996456b8cbfefd882871', 5, 3, 'MyApp', '[]', 1, '2019-10-27 22:10:46', '2019-10-27 22:10:46', '2020-10-28 04:10:46'),
('6e67955f664b0759981e4e9da1ce4073b617897e2ce032a3f201e344f38faf7881d2c75f165bab7e', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:05:16', '2019-10-22 07:05:16', '2020-10-22 13:05:16'),
('6fcb9c46ec26ccbcf27e4e0b6b4d18e68045cb4920c688c3cf4f78d5192655ded27f1196409d8f80', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:40:21', '2019-10-22 06:40:21', '2020-10-22 12:40:21'),
('73fccac5bd44611850166a139462b3e18e4a182d92b43d1d5df8145f86ca952aa8b63d1426da3104', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:00:31', '2019-10-22 06:00:31', '2020-10-22 12:00:31'),
('741370d7478c7bcfd396ef0ab655d592a7f8c95e1941028ff5c66dcadf644e92b03dd0cecfc260b8', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:18:50', '2019-10-22 01:18:50', '2020-10-22 07:18:50'),
('7568d194fba43a449469ebff06c58882db10f569d457207634d8023c4fa01b6939ae3d5cabf58e20', 8, 3, 'MyApp', '[]', 0, '2019-10-29 22:00:26', '2019-10-29 22:00:26', '2020-10-30 04:00:26'),
('765678b917de4e29edfb9497d5cbe67eee7d96c8f897d681036ed311357416d5f816c7d761795ae0', 2, 1, 'MyApp', '[]', 0, '2019-10-08 07:55:29', '2019-10-08 07:55:29', '2020-10-08 13:55:29'),
('769548b5703c090c87a2c6a456f610067fd5de073e66e3b11e90e16774928b90dc9a074e0851546e', 8, 3, 'MyApp', '[]', 0, '2019-10-23 11:04:02', '2019-10-23 11:04:02', '2020-10-23 17:04:02'),
('76b0f8b87d3ccc535f7e156b52b2289d2a37cb7c89ed1c0685f8fdb975087f0d24ae779dc71eb742', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:25:43', '2019-10-22 05:25:43', '2020-10-22 11:25:43'),
('78e271bd8ed5b4e98baa7b63264193c0c79ad135e6e557de8d189efad5f509bb06e834df6eef8268', 8, 3, 'MyApp', '[]', 0, '2019-10-23 11:03:16', '2019-10-23 11:03:16', '2020-10-23 17:03:16'),
('7cd46d7125646c5ee80481ffff2c1becf392c3a501bc16365c964ca89f9f783a3d14abc0dd82eb6c', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:27:26', '2019-10-22 01:27:26', '2020-10-22 07:27:26'),
('7ce90d2a8ee517404690227d184fc93bb68c3d448fd284a3cda8de7f241df9679a2041d129390a5d', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:48:09', '2019-10-29 10:48:09', '2020-10-29 16:48:09'),
('7fd8432d74a3cf0d64aac01e202e76b284bdbd9a2ce690e1acf45837758655adf4754f15d4b6f5d8', 8, 3, 'MyApp', '[]', 0, '2019-10-23 11:08:26', '2019-10-23 11:08:26', '2020-10-23 17:08:26'),
('815da69e845bdd45d882a89b06ca3fd3f65b7779cc21290da13b60f73a1327878def5a603b21700d', 9, 3, 'MyApp', '[]', 1, '2019-10-29 10:28:51', '2019-10-29 10:28:51', '2020-10-29 16:28:51'),
('8268b526fc29c1ea4319c56042e1b31ebed75b9fc978aaa44a2a1a2d03928ab4454c41bc43e1c98f', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:26:48', '2019-10-22 06:26:48', '2020-10-22 12:26:48'),
('8286ca6f0d8c654c04fc001be06ef578c59ebe9e45bb60a60343b00ecdfba5c9990d475daec93764', 8, 3, 'MyApp', '[]', 1, '2019-10-24 04:05:30', '2019-10-24 04:05:30', '2020-10-24 10:05:30'),
('85742d0769b40e8dde523ce6aaca49a82fa33e9c4f7f8fb269d575494591e3e90b5c5b721f9307a8', 7, 3, 'MyApp', '[]', 0, '2019-10-19 02:44:13', '2019-10-19 02:44:13', '2020-10-19 08:44:13'),
('87f6ebdb91dc0b67c162d82bf6b7dd045e9395676b94794f98a617b92365ee9073b5838394337f99', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:40:09', '2019-10-29 10:40:09', '2020-10-29 16:40:09'),
('8860690e96e0e2f459230b8fe2b7f0176024ff87f46a2be168b01c101b011675de346f237002f814', 7, 3, 'MyApp', '[]', 0, '2019-10-19 02:53:11', '2019-10-19 02:53:11', '2020-10-19 08:53:11'),
('8c6727459dd219dddb9575ea1365156238370cc626d2de6428f7ff3587cdf184784dd233327c1e46', 7, 3, 'MyApp', '[]', 0, '2019-10-24 00:14:16', '2019-10-24 00:14:16', '2020-10-24 06:14:16'),
('8d1f32111301d5c8967e3ee930801b5d466716898ce50c91dfd4ede932f16e4230f06f43ed22a060', 2, 3, 'MyApp', '[]', 0, '2019-10-19 23:11:46', '2019-10-19 23:11:46', '2020-10-20 05:11:46'),
('8d3cbd9f0e70fdaec709fc1958f3367b37c780d896b88d2bf41bde7c452fbbba280b1a31e1d87af5', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:15:23', '2019-10-22 01:15:23', '2020-10-22 07:15:23'),
('8ef228b242f80d89564c3e3e4291fa06e38fb9652f8afd9b0bd7e697a3cc1e9bed578c918cab2522', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:42:28', '2019-10-29 10:42:28', '2020-10-29 16:42:28'),
('918a5b4625013c574c2e519f810ceca01fbd3c74430c0454dcd30aca15ee2879203a29d583279396', 4, 3, 'MyApp', '[]', 0, '2019-10-08 13:56:07', '2019-10-08 13:56:07', '2020-10-08 19:56:07'),
('95651df87e05513b2fb553c2f6e49783bc2fe292b86dd314fc79bfc882f71c56b755bc6bfb497ea4', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:26:27', '2019-10-22 01:26:27', '2020-10-22 07:26:27'),
('980fdb4916e567e9f23deebc803786fa7d8309d6bc1385877d9358400f19a04b83a140d8034d5fc8', 7, 3, 'MyApp', '[]', 0, '2019-10-19 02:44:48', '2019-10-19 02:44:48', '2020-10-19 08:44:48'),
('98674290dec45a82fec7beb1f33fed8d6b002ed979efeca22be17e165bd08aa19a478fd595052116', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:09:18', '2019-10-22 01:09:18', '2020-10-22 07:09:18'),
('98f958c947f7d9fcf87ba261e747ce35981c6290682f67e4f9b0c45e5c437d9b049ba0de5589f020', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:28:48', '2019-10-22 06:28:48', '2020-10-22 12:28:48'),
('9b21c0f1b79eae6717f82daa2537f823dc0c5d5688c3dab71a7471970a74e38656000ac60a8f5f0d', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:34:16', '2019-10-29 10:34:16', '2020-10-29 16:34:16'),
('9bcfda4f0fbf2e8b4b98a85cefead0d83f3bac7f79b998265ca068a9034af2ff19e2e000d0183f46', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:14:33', '2019-10-22 07:14:33', '2020-10-22 13:14:33'),
('a050c120ea9cc686373f84bb2ca1645430c9e1f41343bc16053ebafec7ea065ae162d7143643d000', 7, 3, 'MyApp', '[]', 0, '2019-11-06 00:48:04', '2019-11-06 00:48:04', '2020-11-06 06:48:04'),
('a13892ad3f5eadbe6c8028e4692383590ac8b9cdc3fd834bb35568538c954051671cfff1198b5377', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:45:42', '2019-10-22 07:45:42', '2020-10-22 13:45:42'),
('a183dd5fa5da353ceff13c2c4fb68a8e2e31373acf7a2bb71a51fa0d4af26707b23494a8960110a5', 8, 3, 'MyApp', '[]', 0, '2019-10-24 01:10:45', '2019-10-24 01:10:45', '2020-10-24 07:10:45'),
('a32d08dd724d1c64c9ad9fcbf6c1df46d43584e3d54c3ec1d1843e0e418f850d5283a7f04a9391cc', 8, 3, 'MyApp', '[]', 0, '2019-11-07 05:26:42', '2019-11-07 05:26:42', '2020-11-07 11:26:42'),
('a3ea342a9defbd031ce1999e4d483ce3f83aa5bbe2fc72b3bde6081ddb4cc65b8e36aec4fc2e036b', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:12:14', '2019-10-22 01:12:14', '2020-10-22 07:12:14'),
('a6d71f1b95a5117c51848c14018736986f20a29f963a3dc1021fb70f7b064ca1c57e8fa9b153eaa6', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:11:46', '2019-10-29 10:11:46', '2020-10-29 16:11:46'),
('a7b1fb5296756477dd1082b4541a0b451b783021f08aea1a402e092242b7f3c352e0715038d25dab', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:35:01', '2019-10-29 10:35:01', '2020-10-29 16:35:01'),
('a84a8b702dc757ffabbaaf8bbfcf66a9a862d52c7f5b34612ad5e077c2f684b51105a189d1f59ac1', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:19:22', '2019-10-22 05:19:22', '2020-10-22 11:19:22'),
('a9684edde991daf1c30ac1e30769c94f664f31d6a480581b7b838b741ba9b6817f8a94618e0813eb', 2, 1, 'MyApp', '[]', 0, '2019-10-08 07:53:26', '2019-10-08 07:53:26', '2020-10-08 13:53:26'),
('a9718beb863c07a04d0bdfdb556e149d93031637b864dd342c8144a2b119b844963f7d2405c440bd', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:25:50', '2019-10-22 06:25:50', '2020-10-22 12:25:50'),
('aa22bd48bf8804086ee507890d79522065e302b61a53bbb23e6079cf6f67dd0090a1da30e93765e2', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:44:45', '2019-10-29 10:44:45', '2020-10-29 16:44:45'),
('ac2d2f5f7ac3672f02b5aadfa159fac76b4ff02ee15263638755b30ff054c453897baf6c78b116af', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:27:11', '2019-10-22 06:27:11', '2020-10-22 12:27:11'),
('ac5d5ef38d6b27540b98511ee11e540029de442f8c7b949f44b2e2ef9eb6410a3773c4205fd43a60', 7, 3, 'MyApp', '[]', 0, '2019-10-18 16:00:21', '2019-10-18 16:00:21', '2020-10-18 22:00:21'),
('aca76663e049e7c02f7abf4bc7119c1ada8bd64c260aeca21591f5c3093d8316fd7cd464369fb673', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:31:48', '2019-10-22 06:31:48', '2020-10-22 12:31:48'),
('b19531dc9adda4934a615d8c31b4e9d5d16600ed625a00b0fa89d509f45531b9466b0bb3a05d6214', 4, 3, 'MyApp', '[]', 0, '2019-10-08 14:25:03', '2019-10-08 14:25:03', '2020-10-08 20:25:03'),
('b1c300561ea8d04cbd456c934d656f95b438c45a94392fd23159605664411bc8ee3dd887168b9fa2', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:27:27', '2019-10-22 05:27:27', '2020-10-22 11:27:27'),
('b29a6dd28dc50e50f33001b95047b13be2fb227b6fecd359c4dbaf8101720705c099c01bd0b28a22', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:39:45', '2019-10-22 05:39:45', '2020-10-22 11:39:45'),
('b3a2aec0a94b1d8a7c60ba3ac188e71de77d3b58f43c6d4f5403bc588881ce2720e5d1b059d411ae', 6, 3, 'MyApp', '[]', 0, '2019-10-14 04:40:55', '2019-10-14 04:40:55', '2020-10-14 10:40:55'),
('b5690f9102c47abcad33bd84fbb3c34202e49437314554e99b09f39a2d0944084dbd18a7011e538e', 8, 3, 'MyApp', '[]', 1, '2019-10-29 22:18:11', '2019-10-29 22:18:11', '2020-10-30 04:18:11'),
('b5f6ee93eef9e05f8f9b9d6b8358f54a636b269ad0f85f13decb10341f11acbed5ec829691837700', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:14:07', '2019-10-22 06:14:07', '2020-10-22 12:14:07'),
('b81cf9b7aa89ff7d42c04dac076da859560b238e5e5a6fd09d0e9c83f6339cade28fd73f4f9cbc0e', 7, 3, 'MyApp', '[]', 0, '2019-11-05 13:01:06', '2019-11-05 13:01:06', '2020-11-05 19:01:06'),
('b86d8184b8dd5ee22a73f89f45a2b507de01aa52f077299e6511009cb4cb0e539acf38dc8370b210', 2, 1, 'MyApp', '[]', 0, '2019-10-08 07:46:27', '2019-10-08 07:46:27', '2020-10-08 13:46:27'),
('b9452c9ec0bc753d359ba86efee4973c51249b01fc5783e6c7894326d7b583b4c778b00a2d3693e7', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:59:59', '2019-10-22 05:59:59', '2020-10-22 11:59:59'),
('b9c6f81c90c9f05425ef78df6b11752434e01db9abe7b09fdd02a4106c1b895d954c9fb4f07544c1', 8, 3, 'MyApp', '[]', 1, '2019-10-29 22:27:52', '2019-10-29 22:27:52', '2020-10-30 04:27:52'),
('bd5879276e6e6979b2a65f14d966905afad24c593a4364451282e3227394f00e039a95a013a52290', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:39:01', '2019-10-22 05:39:01', '2020-10-22 11:39:01'),
('bf67b5a929724957ef55d1500e39bbc5930dcc3375a573e92bb71a8d531feb39d6b1424a59ad5882', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:40:52', '2019-10-22 05:40:52', '2020-10-22 11:40:52'),
('bfd8bcb4fbd99bd9cb13dd2cbdb0e6ab3bb2704cc67f6eca6dd3ad83734caef82c54c3b9a73027e5', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:12:40', '2019-10-22 01:12:40', '2020-10-22 07:12:40'),
('c16534348dc54e6a5c8a9ed6bf70f6d2be6af8f8d7406529a8aca4e5838d3ec9b2656eb19ec8fe98', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:42:55', '2019-10-22 07:42:55', '2020-10-22 13:42:55'),
('c17e93c4d3a0552190034e6ae5bb21d6830327243e5435178bae6afeb613231a1d7cc5973ae8fee7', 8, 3, 'MyApp', '[]', 0, '2019-10-24 01:11:15', '2019-10-24 01:11:15', '2020-10-24 07:11:15'),
('c327377c28a9f6b7c2eebfd24079ca14899c0940584177e341f9d3529b826cdd741a29240fd008d0', 8, 3, 'MyApp', '[]', 1, '2019-11-05 11:32:24', '2019-11-05 11:32:24', '2020-11-05 17:32:24'),
('c39a84bb8f2fd75003af5cc10787710a6f6afef694f8cd1eaf72e27422dbab3600603fbe6b7198fd', 7, 3, 'MyApp', '[]', 0, '2019-10-19 23:27:46', '2019-10-19 23:27:46', '2020-10-20 05:27:46'),
('c8bfb11cb511116bc81f728f32c718039379e038d421dc63815a5248cef2a2a8bbefe5136545f52e', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:18:48', '2019-10-22 05:18:48', '2020-10-22 11:18:48'),
('c947c2c2bd6ec5ec2118d065389a0324bfcca02f54ac9eebd68138baf1201d756607b5e8c80760d3', 3, 3, 'MyApp', '[]', 0, '2019-10-08 14:46:33', '2019-10-08 14:46:33', '2020-10-08 20:46:33'),
('ce80d274560bf3c9b5d354242abf00c631a66c04a966d5520e3ba3d29b72de39377b0cb2af529bfc', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:56:52', '2019-10-22 05:56:52', '2020-10-22 11:56:52'),
('cf0ce790efc7dd85218bc891152cefe0b539eb0ec92676a5f24eda7bdf8d181a9037365790e09573', 3, 3, 'MyApp', '[]', 0, '2019-10-08 13:48:51', '2019-10-08 13:48:51', '2020-10-08 19:48:51'),
('d2270850e578555cf7f83b3180b13b11bf3409189d6c4f5cc53919b6b98d9a5b0ed73ce492bba90b', 8, 3, 'MyApp', '[]', 0, '2019-10-30 03:12:51', '2019-10-30 03:12:51', '2020-10-30 09:12:51'),
('decaa7cf954af7f7e3f75914642dbeb51f42efc24cab0a68de1d6bcc8f8f24cd3495098a4d2bb22b', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:43:26', '2019-10-22 05:43:26', '2020-10-22 11:43:26'),
('e08a23538f51c9443fdfa31521de7f8c42d02edb8278c1a6119ded46139c4f7bd80453cbc28d69d9', 5, 3, 'MyApp', '[]', 0, '2019-10-08 13:59:13', '2019-10-08 13:59:13', '2020-10-08 19:59:13'),
('e41a96a494b601d332e0d320fb128f5b871859d401f4b731c141a47dcc7f73a1dc8a2aa741b34b80', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:15:37', '2019-10-22 06:15:37', '2020-10-22 12:15:37'),
('e5804239e72b93d7f975ee8547f9a1f3a23ed5836b28d257c6f0667c1d99dbe982d3a530083f5cdb', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:33:36', '2019-10-29 10:33:36', '2020-10-29 16:33:36'),
('e7da545d7d2ac392035e321e299bc8ab897d5d64ddf5c20d88be27fd378f01b3508efff3f7dc5dd3', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:34:35', '2019-10-22 05:34:35', '2020-10-22 11:34:35'),
('e913082144ed8a28ec93b6fec46ee1ef0c74abaed334f45646ff02a37b187a8bd8fc645c43cf48dd', 8, 3, 'MyApp', '[]', 0, '2019-10-22 07:18:57', '2019-10-22 07:18:57', '2020-10-22 13:18:57'),
('e9a9035463e2dd850ff57aa19051f9eb80640cc66dae9edf18fae8c13af19a001d84a4435c79bdea', 8, 3, 'MyApp', '[]', 1, '2019-10-29 10:33:16', '2019-10-29 10:33:16', '2020-10-29 16:33:16'),
('eba8780ca2de6a214cabab15e6ab379b431928cc3b24830e3effa598f9ed4a1ee66f76b77bd6868f', 8, 3, 'MyApp', '[]', 0, '2019-10-22 05:18:16', '2019-10-22 05:18:16', '2020-10-22 11:18:16'),
('ec3461eb508abee251c999ae89b0891196a2521b7d66160092463022c7fe63ff4c273756cd55a4ea', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:17:19', '2019-10-22 01:17:19', '2020-10-22 07:17:19'),
('ed8b4dd28052130d10075f00ccc0528929fb125954d38f46e13a5b746f7a8d0392608bd06d089834', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:15:00', '2019-10-22 01:15:00', '2020-10-22 07:15:00'),
('f3c6d0e335d66bd8d1e1caf57af7356869b0f326128f796f31bd9ffc0b58ce9baf87d5191f65fa4d', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:19:55', '2019-10-22 01:19:55', '2020-10-22 07:19:55'),
('f4334cebfdb1d5365a6b7290963d73d2db5c64beb6b60cf4128de10d241c0b9effa7290d31dc2a22', 2, 1, 'MyApp', '[]', 0, '2019-10-08 07:44:20', '2019-10-08 07:44:20', '2020-10-08 13:44:20'),
('f5814fc549965d2f0f1976c9dd48948a228909c68ec404bb64ed942b70499a2ba8f777eca3a1946a', 8, 3, 'MyApp', '[]', 1, '2019-10-29 13:53:45', '2019-10-29 13:53:45', '2020-10-29 19:53:45'),
('f6279a97fe685b7ff71b646c8bf771d4ce664a0ecb247e07a6b13893a85538f2ba37fabcecfd6d81', 8, 3, 'MyApp', '[]', 0, '2019-10-23 13:48:17', '2019-10-23 13:48:17', '2020-10-23 19:48:17'),
('f6308a9e411d26a6a35567e43c53d7a9058f9393f2f0b4a51c0fe74278ff55227a9fcb73a04b00d9', 8, 3, 'MyApp', '[]', 1, '2019-10-29 22:27:12', '2019-10-29 22:27:12', '2020-10-30 04:27:12'),
('f6bafc4f6b0844dd8d5d2a0732f6eb230f67afcdbd61b84ed11aa302668a930bc98111bdbb9511ac', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:17:39', '2019-10-22 01:17:39', '2020-10-22 07:17:39'),
('f75237b0f6a9dc856d4536f036749a6e3848661c236f6406242b9a7c3affd8e41eb6bdd1d90fc0b2', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:20:17', '2019-10-22 06:20:17', '2020-10-22 12:20:17'),
('fab72d7fbabd3a1887021b1fdec21812703855b9c2d3deb8f1e0f97136aa523b7461cc4cd3789881', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:39:26', '2019-10-22 06:39:26', '2020-10-22 12:39:26'),
('fcaf130f956e7e5d28189eca0cf283271ded198cd16d058fe9ec00a8010cfb8d9919bd505555b37f', 8, 3, 'MyApp', '[]', 0, '2019-10-22 01:13:06', '2019-10-22 01:13:06', '2020-10-22 07:13:06'),
('ff803174f5006b2a1ffd18f5ceb5cf39e1f66eec497dae653edfce0eaebb1d206d5fd99562cf86d0', 8, 3, 'MyApp', '[]', 0, '2019-10-22 06:32:15', '2019-10-22 06:32:15', '2020-10-22 12:32:15');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'PzIvs26AULDlMjnwWm26H8xn6YF5q4udHBfvWQC7', 'http://localhost', 1, 0, 0, '2019-10-08 07:43:21', '2019-10-08 07:43:21'),
(2, NULL, 'Laravel Password Grant Client', 'FJ3yWbp0FST7giIeYtucfTVDO2v3KfdrtO29DM9E', 'http://localhost', 0, 1, 0, '2019-10-08 07:43:21', '2019-10-08 07:43:21'),
(3, NULL, 'Laravel Personal Access Client', 'tgzkNysAGVQSJetYbDDkgg9t8vagsV1z9fFvxTDb', 'http://localhost', 1, 0, 0, '2019-10-08 08:00:25', '2019-10-08 08:00:25'),
(4, NULL, 'Laravel Password Grant Client', 'CVG9nDkfgdeBOzRwogE1VJYVcqqeBdjQZYGy1EaG', 'http://localhost', 0, 1, 0, '2019-10-08 08:00:25', '2019-10-08 08:00:25');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-10-08 07:43:21', '2019-10-08 07:43:21'),
(2, 3, '2019-10-08 08:00:25', '2019-10-08 08:00:25');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('kajolchaki@gmail.com', '$2y$10$XUFaM7kBpPE6tuPeZzS7LOZv0M0ifJoW6KF5jBjdTsv/GYFmEQDEO', '2019-10-20 01:26:19');

-- --------------------------------------------------------

--
-- Table structure for table `photos`
--

CREATE TABLE `photos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imageable_id` int(10) UNSIGNED NOT NULL,
  `imageable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `photos`
--

INSERT INTO `photos` (`id`, `path`, `imageable_id`, `imageable_type`, `created_at`, `updated_at`) VALUES
(1, '1570642651558.jpg', 1, 'App/User', '2019-10-09 11:37:31', '2019-10-09 11:37:31'),
(2, '1570647268DA90208.jpg', 3, 'App/User', '2019-10-09 12:54:28', '2019-10-09 12:54:28'),
(3, '1570647296DA90208.jpg', 3, 'App/User', '2019-10-09 12:54:56', '2019-10-09 12:54:56'),
(4, '1570649672DA90208.jpg', 7, 'App/User', '2019-10-09 13:34:32', '2019-10-09 13:34:32'),
(5, '1570649688DA90208.jpg', 7, 'App/User', '2019-10-09 13:34:48', '2019-10-09 13:34:48'),
(6, '1570650651558.jpg', 2, 'App/Post', '2019-10-09 13:50:51', '2019-10-09 13:50:51'),
(7, '1571916702pic_tania.jpg', 8, 'App/User', '2019-10-24 05:31:42', '2019-10-24 05:31:42'),
(8, '1571917961pic_tania.jpg', 8, 'App/User', '2019-10-24 05:52:41', '2019-10-24 05:52:41'),
(9, '1571919071pic_tania.jpg', 8, 'App/User', '2019-10-24 06:11:11', '2019-10-24 06:11:11'),
(10, '1571919394pic_tania.jpg', 8, 'App/User', '2019-10-24 06:16:34', '2019-10-24 06:16:34'),
(11, '1571920411pic_tania.jpg', 8, 'App/User', '2019-10-24 06:33:31', '2019-10-24 06:33:31'),
(12, '1571941734DA90208.jpg', 8, 'App/User', '2019-10-24 12:28:54', '2019-10-24 12:28:54'),
(13, '1572078826DA90208.jpg', 8, 'App/User', '2019-10-26 02:33:46', '2019-10-26 02:33:46'),
(14, '1572079856IMG_5544.JPG', 8, 'App/User', '2019-10-26 02:50:56', '2019-10-26 02:50:56'),
(15, '1572080189IMG_5544.JPG', 8, 'App/User', '2019-10-26 02:56:29', '2019-10-26 02:56:29'),
(16, '157208025128168192_1644936082262400_7252799108334151554_n.jpg', 8, 'App/User', '2019-10-26 02:57:31', '2019-10-26 02:57:31'),
(17, '1572080658DA90208.jpg', 8, 'App/User', '2019-10-26 03:04:18', '2019-10-26 03:04:18'),
(18, '157208067134859485_1755832061172801_599560009839280128_n.jpg', 8, 'App/User', '2019-10-26 03:04:31', '2019-10-26 03:04:31');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_id` int(11) NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `map_location_id` int(11) NOT NULL,
  `quality` int(11) NOT NULL DEFAULT '1',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Donate',
  `post_condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Used',
  `financial_value` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `sub_title`, `description`, `area_id`, `address`, `category_id`, `map_location_id`, `quality`, `mobile`, `post_status`, `post_type`, `post_condition`, `financial_value`, `created_at`, `updated_at`) VALUES
(1, 7, 'It was popularised in the 1960s', 'sheets containing Lorem Ipsum passages,', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 1, 'mirpur', 10, 1, 5, '01111111118', 'available', 'Want to Donate', 'Used', 1000, '2019-10-09 13:49:57', '2019-10-09 13:49:57'),
(2, 7, 'desktop publishing software updated', 'It has survived not only five centuries', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 12, 'mirpur, abcd', 10, 1, 8, '01111111118', 'Occupied', 'Asking For Donation', 'New', 1000, '2019-10-09 13:50:51', '2019-11-06 10:01:32'),
(4, 5, 'survived not only five centuries', 'It has survived not only five centuries', 'this table is good\r\nIt has survived not only five centuries\r\nIt has survived not only five centuriesIt has survived not only five centuriesIt has survived not only five centuriesIt has survived not only five centuriesIt has survived not only five centuriesIt has survived not only five centuriesIt has survived not only five centuries', 1, 'mirpur', 3, 1, 5, '01111111118', 'Available', 'Want to Donate', 'Used', 1000, '2019-10-27 01:38:01', '2019-10-27 01:38:01'),
(5, 7, 'survived not only five centuries', ' only five centuries', 'this table is good, survived not only five centuries survived not only five centuries survived not only five centuries vsurvived not only five centuriessurvived not only five centuriessurvived not only five centuriessurvived not only five centuriessurvived not only five centuriessurvived not only five centuriessurvived not only five centuries', 14, 'mirpur', 3, 1, 5, '01111111118', 'Reserved', 'Want to donate', 'Used', 1000, '2019-10-27 01:39:02', '2019-10-27 01:39:02'),
(6, 2, 'including versions of Lorem Ipsum.', 'good', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 4, 1, 5, '01222222222', 'Available', 'Asking For Donation', 'Used', 500, '2019-10-27 03:29:16', '2019-10-27 03:29:16'),
(7, 5, 'including versions of Lorem Ipsum.', 'ert', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 12, 1, 5, '01222222222', 'Available', 'Asking For Donation', 'Used', 33, '2019-10-27 03:37:59', '2019-10-27 03:37:59'),
(8, 8, 'Lorem Ipsum is simply dummy including versions', 's', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 13, 1, 5, '01222222222', 'Available', 'Asking For Donation', 'Used', 2, '2019-10-27 03:42:14', '2019-10-27 03:42:14'),
(9, 8, 'publishing software like Aldus PageMaker ', 'ds', '00s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 22, 'fdhgjfklyu;', 13, 1, 5, '01222222222', 'Reserved', 'Want to Donate', 'Used', 3, '2019-10-27 03:54:27', '2019-10-27 03:54:27'),
(10, 2, ' remaining essentially unchanged.', 'dsfg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 11, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 3, '2019-10-27 03:57:23', '2019-10-27 03:57:23'),
(11, 4, 'including versions of Lorem Ipsum.', 'sdf', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 222, '622, West shawrapara, mirpur', 11, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 3, '2019-10-27 04:02:05', '2019-10-27 04:02:05'),
(12, 8, 'It has survived not only five', 'sdfaswe', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 42, '622, West shawrapara, mirpur', 12, 1, 5, '01222222222', 'Available', 'Asking For Donation', 'Used', 3, '2019-10-27 04:03:54', '2019-10-27 04:03:54'),
(13, 8, ' including versions of Lorem Ipsum.', 'sdf', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 279, '622, West shawrapara, mirpur', 12, 1, 5, '01222222222', 'Occupied', 'Want to Donate', 'Used', 3, '2019-10-27 04:05:45', '2019-10-27 04:05:45'),
(14, 4, ' remaining essentially unchanged', 'dg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 17, 1, 5, '01222222222', 'Available', 'Asking For Donation', 'Used', 33, '2019-10-27 04:08:09', '2019-10-27 04:08:09'),
(15, 4, ' including versions of Lorem Ipsum.', 'sdf', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 23, '622, West shawrapara, mirpur', 11, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 3, '2019-10-27 04:10:48', '2019-10-27 04:10:48'),
(16, 8, 'Ipsum has been the industry', 'dfg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 223, '622, West shawrapara, mirpur', 14, 1, 5, '01222222222', 'occupied', 'Want to Donate', 'Used', 4, '2019-10-27 04:11:46', '2019-10-27 04:11:46'),
(17, 6, 'Lorem Ipsum has been the industry', 'ert', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 12, '622, West shawrapara, mirpur', 17, 1, 5, '01222222222', 'Available', 'Asking For Donation', 'Used', 4, '2019-10-27 04:13:58', '2019-10-27 04:13:58'),
(18, 8, ' including versions of Lorem Ipsum.', 'dfg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 46, '622, West shawrapara, mirpur', 14, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 4, '2019-10-27 04:15:34', '2019-10-27 04:15:34'),
(19, 6, 'The versions of Lorem Ipsum.', 'sfd', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 742, '622, West shawrapara, mirpur', 13, 1, 5, '01222222222', 'Reserved', 'Want to Donate', 'Used', 4, '2019-10-27 04:18:40', '2019-10-27 04:18:40'),
(20, 8, 'meaning in the Cambridge English Dictionary', 'dfg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 278, '622, West shawrapara, mirpur', 13, 1, 5, '01222222222', 'Reserved', 'Want to Donate', 'Used', 5, '2019-10-27 04:22:09', '2019-10-27 04:22:09'),
(21, 8, 'Aldus PageMaker including versions', 'hkgg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 41, '622, West shawrapara, mirpur', 12, 1, 5, '01222222222', 'Occupied', 'Want to Donate', 'Used', 5, '2019-10-27 04:33:32', '2019-10-27 04:33:32'),
(22, 5, ' including versions of Lorem Ipsum.', 'sdf', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 13, 1, 5, '01222222222', 'Reserved ', 'Asking For Donation', 'Used', 3421, '2019-10-27 04:35:00', '2019-10-27 04:35:00'),
(23, 2, 'the Cambridge English Dictionary', 'd', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 412, '622, West shawrapara, mirpur', 11, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 3433, '2019-10-27 04:36:07', '2019-10-27 04:36:07'),
(24, 8, ' including versions of Lorem Ipsum.', 'sdf', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 17, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 333, '2019-10-27 04:37:05', '2019-10-27 04:37:05'),
(25, 7, 'dummy text ever since the 1500', 'sdfaswe', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 1000, '622, West shawrapara, mirpur', 17, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 3, '2019-10-27 04:37:39', '2019-10-27 04:37:39'),
(26, 8, ' including versions of Lorem Ipsum.', 'sdfas', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 14, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 3, '2019-10-27 04:39:04', '2019-10-27 04:39:04'),
(27, 8, ' including versions of Lorem Ipsum.', 'This is a donation post', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 4, '622, West shawrapara, mirpur', 20, 1, 5, '01222222222', 'Available', 'Want to Donate', 'Used', 88, '2019-10-27 04:39:44', '2019-10-27 04:39:44'),
(28, 7, 'This is a donation post', 'This is a donation post', 'This is a donation post', 2, '622, West Shawrapara', 23, 1, 5, '01777777788', 'Available', 'Want to Donate', 'New', 333, '2019-11-06 05:34:33', '2019-11-06 05:34:33'),
(29, 7, 'Eloquent model', 'create a model instance', 'To get started, let\'s create an Eloquent model. Models typically live in the app directory, but you are free to place them anywhere that can be auto-loaded according to your composer.json file. All Eloquent models extend Illuminate\\Database\\Eloquent\\Model class.\n\nThe easiest way to create a model instance is using the make:model Artisan command:', 732, '622, West Shawrapara', 11, 1, 9, '01777777788', 'Available', 'Want to Donate', 'New', 200, '2019-11-07 04:19:44', '2019-11-07 04:19:44');

-- --------------------------------------------------------

--
-- Table structure for table `post_photos`
--

CREATE TABLE `post_photos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_photos`
--

INSERT INTO `post_photos` (`id`, `post_id`, `photo_id`) VALUES
(1, 1, 17),
(2, 2, 16),
(3, 3, 17),
(4, 4, 16),
(5, 5, 18),
(6, 6, 10),
(7, 7, 11),
(8, 8, 1),
(9, 9, 12),
(10, 8, 11),
(11, 10, 13),
(12, 11, 1),
(13, 12, 12),
(14, 13, 18),
(15, 14, 13),
(16, 16, 14),
(17, 17, 5),
(18, 16, 4),
(19, 17, 15),
(20, 18, 14),
(21, 19, 5),
(22, 20, 7),
(23, 20, 9),
(24, 21, 14),
(25, 22, 15),
(26, 23, 14),
(27, 24, 5),
(28, 25, 7),
(29, 26, 15),
(30, 27, 4),
(31, 2, 6);

-- --------------------------------------------------------

--
-- Table structure for table `post_reviews`
--

CREATE TABLE `post_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `financial_value` int(11) NOT NULL,
  `quality` int(11) NOT NULL,
  `comment_post` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_user` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_reviews`
--

INSERT INTO `post_reviews` (`id`, `post_id`, `user_id`, `financial_value`, `quality`, `comment_post`, `comment_user`, `created_at`, `updated_at`) VALUES
(1, 2, 7, 23, 8, 'desktop publishing software updated desktop publishing software updateddesktop publishing software updateddesktop publishing software updateddesktop publishing software updated', 'desktop publishing software updateddesktop publishing software updateddesktop publishing software updated', '2019-11-07 00:56:52', '2019-11-07 00:56:52');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_users`
--

CREATE TABLE `role_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `active_status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Mobile_verified_at` timestamp NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `mobile`, `email`, `Mobile_verified_at`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'kajol chaki', '01888888888', 'kajolchaki@gmail.com', NULL, NULL, '$2y$10$QgSz.aWufE7c9p2DeBwZuOssy/jlR7bVz7H42qcw.nnsW8hbvh9Z.', NULL, '2019-10-08 04:45:10', '2019-10-08 04:45:10'),
(2, 'prosanta Chaki', '01111111128', 'kajol.bd@mail.com', NULL, NULL, '$2y$10$0ZUglD3NhNT7CxiNMb5SRea8GXo5Wqk0nUgqoSWYZkVKb7AMRMgTS', NULL, '2019-10-08 07:41:01', '2019-10-08 07:41:01'),
(3, 'Probhas Ranjon', '01111111111', 'sdfhlk@dsf.d', NULL, NULL, '$2y$10$qWfmrB0WQpmfq06DJBgfMuLh1X4Hoq6Ag6UCsA1xdnrBDKPALJLm2', NULL, '2019-10-08 13:48:51', '2019-10-09 12:54:56'),
(4, 'Nazmul Khan', '01777777777', 'sdfhlk@dsf.dsf', NULL, NULL, '$2y$10$TeGJhkO4YuwJYg2CivxUQOAKVlMQwWVld/Sra8dDDvDYYUKlue48C', NULL, '2019-10-08 13:56:07', '2019-10-08 14:42:32'),
(5, 'Azizul Islam Saju', '01777777778', 'adasd@sdf.dfg', NULL, NULL, '$2y$10$VZEOheIqDuI3jhbBSFcfve0X.Etr5.Lf66TemmPiQcaXuDQ.usP5K', NULL, '2019-10-08 13:58:08', '2019-10-08 13:58:08'),
(6, 'Samir chaki', '01233444444', 'kajolchaki@gmail.c', NULL, NULL, '$2y$10$7QcLjUrIEhNUvZGDZPe7Yu1sda7mcsxeupmgnrM1djqSrShQx5Hb2', NULL, '2019-10-09 05:04:35', '2019-10-09 05:04:35'),
(7, 'Borhan Rubbany', '01777777788', 'adasssadd@sdf.dfg', NULL, NULL, '$2y$10$BiFdG5P9nrZyVcjyhNO1sO8kyk.HqAVKzfgon7rIEa2raS4bB1iTa', NULL, '2019-10-09 11:14:46', '2019-10-09 11:14:46'),
(8, 'Pronob Kumar', '01222222222', 'kumar@mail.coms', NULL, NULL, '$2y$10$jeeFb4jCarIOd55rQhN7GOaR8aCAN9UVDBs5fWsC4r/OQ4jZRzbbe', NULL, '2019-10-21 12:33:40', '2019-10-25 22:47:20'),
(9, 'Biplob Biswas', '01234567891', 'biplob@gmail.com', NULL, NULL, '$2y$10$KrUfCm.ySxB8c72Ye2GORurtPtewvngZ7yho.IPtiPr2TGYi8QDSS', NULL, '2019-10-29 10:28:51', '2019-10-29 10:28:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_activities`
--

CREATE TABLE `user_activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `created` tinyint(1) NOT NULL DEFAULT '0',
  `interested` tinyint(1) NOT NULL DEFAULT '0',
  `received` tinyint(1) NOT NULL DEFAULT '0',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_activities`
--

INSERT INTO `user_activities` (`id`, `user_id`, `post_id`, `created`, `interested`, `received`, `verified`, `created_at`, `updated_at`) VALUES
(1, 7, 29, 1, 0, 0, 0, '2019-11-07 04:19:44', '2019-11-07 04:19:44'),
(2, 7, 2, 0, 1, 0, 0, '2019-11-07 04:45:45', '2019-11-07 04:45:45'),
(4, 8, 2, 0, 1, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(5, 7, 1, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(6, 7, 2, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(7, 7, 5, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(8, 7, 25, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(9, 7, 28, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(10, 7, 29, 1, 0, 0, 0, '2019-10-27 04:13:58', '2019-11-07 05:26:45'),
(11, 5, 4, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(12, 2, 7, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(13, 8, 8, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(14, 8, 9, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(15, 4, 11, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(16, 4, 14, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(17, 8, 16, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(18, 6, 17, 1, 0, 0, 0, '2019-11-07 05:26:45', '2019-11-07 05:26:45'),
(19, 5, 22, 1, 0, 0, 0, '2019-11-05 18:00:00', '2019-11-06 18:00:00'),
(20, 2, 23, 1, 0, 0, 0, '2019-11-04 18:00:00', '2019-11-05 18:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_infos`
--

CREATE TABLE `user_infos` (
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `map_location_id` int(11) NOT NULL,
  `blood_group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ' ',
  `photo_id` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `active_status` tinyint(1) NOT NULL DEFAULT '1',
  `marital_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Single',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_infos`
--

INSERT INTO `user_infos` (`user_id`, `area_id`, `address`, `map_location_id`, `blood_group`, `birthday`, `gender`, `occupation`, `organization`, `description`, `photo_id`, `weight`, `active_status`, `marital_status`, `created_at`, `updated_at`) VALUES
(3, 2, '622, West Shawrapara', 1, 'O-', '1993-04-22', 'male', 'Student', 'Daffodil International University', 'none', 3, 33, 1, '1', NULL, NULL),
(4, 2, '622, West Shawrapara', 1, 'O-', '1993-04-22', 'male', 'Student', 'Dhaka University', 'none', 1, 33, 1, '1', NULL, NULL),
(7, 2, '622, West Shawrapara', 1, 'O-', '1993-04-22', 'male', 'Student', NULL, 'graduation completed', 5, 33, 1, '1', NULL, NULL),
(8, 4, '622, West shawrapara, mirpur', 1, 'O+', '1992-04-21', 'Male', 'Banker', 'Dhaka College', 'I am a regular student of Dhaka College.', 18, 34, 1, 'Married', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `map_locations`
--
ALTER TABLE `map_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `photos`
--
ALTER TABLE `photos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_photos`
--
ALTER TABLE `post_photos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_reviews`
--
ALTER TABLE `post_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_users`
--
ALTER TABLE `role_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_activities`
--
ALTER TABLE `user_activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_infos`
--
ALTER TABLE `user_infos`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1325;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `map_locations`
--
ALTER TABLE `map_locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `photos`
--
ALTER TABLE `photos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `post_photos`
--
ALTER TABLE `post_photos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `post_reviews`
--
ALTER TABLE `post_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role_users`
--
ALTER TABLE `role_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user_activities`
--
ALTER TABLE `user_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- Database: `fastfood_db`
--
CREATE DATABASE IF NOT EXISTS `fastfood_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `fastfood_db`;

-- --------------------------------------------------------

--
-- Table structure for table `appuser`
--

CREATE TABLE `appuser` (
  `user_id` varchar(12) NOT NULL DEFAULT '',
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `user_password` varchar(40) DEFAULT NULL,
  `user_level` varchar(10) NOT NULL DEFAULT 'General' COMMENT 'Admin,Developer,General',
  `login_status` tinyint(4) DEFAULT '0' COMMENT '1=login; 0=not login;',
  `is_active` int(1) NOT NULL DEFAULT '1' COMMENT '1=Active,0=Blocked',
  `modified_by` varchar(20) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appuser`
--

INSERT INTO `appuser` (`user_id`, `user_name`, `user_password`, `user_level`, `login_status`, `is_active`, `modified_by`, `modified_time`, `created_by`) VALUES
('1000001', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'ROLE_USER', 0, 1, NULL, NULL, '1000001');

-- --------------------------------------------------------

--
-- Table structure for table `banner_image`
--

CREATE TABLE `banner_image` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text,
  `photo` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2 in-active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `banner_image`
--

INSERT INTO `banner_image` (`id`, `title`, `text`, `photo`, `status`) VALUES
(29, 'Banner3', 'Savory/Pastry/Cake/Coffee/Cookies/Bread', 'images/banner/3.jpg', 1),
(36, 'banner4', 'Brownie', 'images/banner/8.jpg', 1),
(37, 'Banner2', 'Makeup kit', 'images/banner/Mac Structured Cake.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `code`, `name`, `parent_id`, `photo`, `status`) VALUES
(25, '0001', 'Bakary', NULL, 'images/no_image.png', 1),
(26, '0002', 'Burger', NULL, 'images/no_image.png', 1),
(27, '0003', 'Pizza', NULL, 'images/no_image.png', 1),
(28, '0004', 'Noodlse', NULL, 'images/no_image.png', 1),
(29, '0005', 'Pasta', NULL, 'images/no_image.png', 1),
(30, '0006', 'Fry Item', NULL, 'images/no_image.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cupons`
--

CREATE TABLE `cupons` (
  `id` int(11) NOT NULL,
  `cupon_no` varchar(100) NOT NULL,
  `c_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: flat_rate; 2:percentage_rate',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL,
  `amount` float(10,2) DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active; 0:In-Active',
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cupons`
--

INSERT INTO `cupons` (`id`, `cupon_no`, `c_type`, `start_date`, `end_date`, `entry_date`, `amount`, `status`, `customer_id`) VALUES
(1, '1111', 1, '2017-10-02 17:30:20', '2019-10-02 17:30:24', '2018-10-02 17:30:28', 100.00, 1, NULL),
(2, '2222', 2, '2017-10-02 17:30:20', '2019-10-02 17:30:24', '2018-10-02 17:30:28', 10.00, 1, NULL),
(3, '444', 1, '2018-11-08 00:00:00', '2019-02-07 00:00:00', '2019-03-21 00:00:00', 33.00, 1, 1),
(4, '123321', 2, '2018-08-27 00:00:00', '2019-02-14 00:00:00', '2018-11-20 00:00:00', 10.00, 1, 0),
(5, '55555', 1, '2018-06-03 00:00:00', '2019-04-26 00:00:00', '0000-00-00 00:00:00', 55.00, 1, 8),
(6, '2018', 1, '2018-11-22 00:00:00', '2018-11-22 00:00:00', '2018-11-22 00:00:00', 100.00, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_infos`
--

CREATE TABLE `customer_infos` (
  `customer_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `address` text NOT NULL,
  `age` date NOT NULL,
  `photo` varchar(100) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `remarks` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  0: inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_infos`
--

INSERT INTO `customer_infos` (`customer_id`, `full_name`, `username`, `password`, `address`, `age`, `photo`, `contact_no`, `email`, `remarks`, `status`) VALUES
(1, 'Moynul Hasan Momit', 'momit', 'e10adc3949ba59abbe56e057f20f883e', 'aaaaaaaaaaa', '0000-00-00', 'images/customer/momit.jpg', '012100000', 'momit.litu@gmail.com', 'aaaaaaaaaaaa', 1),
(2, 'MUntakim Hasan', 'munif', 'e10adc3949ba59abbe56e057f20f883e', 'aaaaaaaaaaaaaaaa', '0000-00-00', 'images/customer/1537339731jahed.jpg', '012554455', 'munif.litu@gmail.com', 'aaaaaaaaaaaaaaa', 1),
(5, 'hasan', 'hasan', 'e10adc3949ba59abbe56e057f20f883e', 's sfdf,sdf ,sdfsd,dsf,', '0000-00-00', '', '01980340482', 'momi.df@gmaad.com', NULL, 1),
(6, 'muntakim', 'muntakim', 'e10adc3949ba59abbe56e057f20f883e', 'sgfsf sdfdsfdfdsfs', '0000-00-00', '', '0198034082', 'm.k@gmail.com', NULL, 1),
(7, 'Mir Abu Sayef', 'M.A Sayef', 'e10adc3949ba59abbe56e057f20f883e', 'Mohammadpur, Chanmia Housing, 41/10, Road # 1, 5-A. Dhaka - 1207', '0000-00-00', '', '01630325935', 'mirabu.sayef@yahoo.com', NULL, 1),
(8, 'Shabir Alkama', 'Shabir', 'e10adc3949ba59abbe56e057f20f883e', 'Mohammadpur, Chanmia Housing, 41/10, Road # 1, 5-A. Dhaka - 1207', '0000-00-00', '', '01133', 'Shabiralkama@gmail.com', NULL, 1),
(9, 'Anika Thasin', 'Anika', '827ccb0eea8a706c4c34a16891f84e7b', 'House-463, Road-31, Mohakhali Dohs', '0000-00-00', '', '01779574169', 'anikathasin.tonni@gmail.com', NULL, 1),
(10, 'shabir', 'Alkama', 'addcec5c2816e7b9277a56b3b1f12a96', 'H# 1/B, R# 11, Nikunja-2, Khilkhet, Dhaka 1229', '0000-00-00', '', '01712341127', 'shabiralkama_5700@yahoo.com', NULL, 1),
(11, 'Nazmul', 'Nazmul Ahsan', '25f9e794323b453885f5181f1b624d0b', 'Dhaka', '0000-00-00', '', '01613313666', 'it@nafisagroup.com', NULL, 1),
(12, 'mmmmomit', 'mmmmomit', 'e10adc3949ba59abbe56e057f20f883e', '', '0000-00-00', '', '0198034045', 'm.k@gmail.com', NULL, 1),
(13, 'Walk In Customer', NULL, NULL, 'no address', '0000-00-00', 'images/no_image.png', '456456464', '', '', 1),
(14, 'POS Customer', NULL, NULL, 'dfgdgdfg', '0000-00-00', 'images/no_image.png', '45645646', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `custom_cake`
--

CREATE TABLE `custom_cake` (
  `id` int(11) NOT NULL,
  `cc_cake_weight` varchar(50) DEFAULT NULL,
  `cc_cake_tyre` tinyint(1) DEFAULT NULL,
  `cc_delevery_date` datetime DEFAULT NULL,
  `cc_details` text NOT NULL,
  `cc_name` varchar(200) NOT NULL,
  `cc_email` varchar(200) NOT NULL,
  `cc_mobile` varchar(20) NOT NULL,
  `cc_image` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:not seen, 2:seen, 3:varified',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active, 0: Deleted',
  `varified_by` varchar(20) DEFAULT NULL,
  `varified_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remarks` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `custom_cake`
--

INSERT INTO `custom_cake` (`id`, `cc_cake_weight`, `cc_cake_tyre`, `cc_delevery_date`, `cc_details`, `cc_name`, `cc_email`, `cc_mobile`, `cc_image`, `status`, `active`, `varified_by`, `varified_time`, `remarks`) VALUES
(1, '0', 0, '2018-11-13 12:00:00', 'sdf sdf', 'sdf ', 'sdfs', '45435', 'images/custom/momit_singara.jpg', 2, 1, NULL, '2018-11-15 10:51:19', NULL),
(2, '0', 0, '2018-11-25 12:00:00', 'hhhhhhhh', 'Mir Abu Sayef', 'mirabu.sayef@yahoo.com', '01630325935', 'images/custom/kit.jpg', 2, 1, NULL, '2018-11-25 17:01:12', NULL),
(3, '3', 0, '2018-11-25 12:00:00', 'rectangular', 'shabir', 'shabiralkama@gmail.com', '01712341127', 'images/custom/8.jpg', 3, 1, '1000001', '2018-11-25 17:57:53', ''),
(4, '', 1, '2018-11-29 03:30:00', 'Write up : happy birthday', 'shabir', 'shabiralkama@gmail.com', '01712341127', 'images/custom/5.jpg', 1, 1, NULL, NULL, NULL),
(5, '5', 3, '2018-11-29 12:00:00', 'from momit', 'momit', 'momit.litu@gmails.com', '654541', 'images/no_image.png', 1, 1, NULL, NULL, NULL),
(6, '', 0, '2018-12-03 12:00:00', 'square', 'happy birthday to sumaiya', 'shabiralkama@gmail.com', 'shabir', 'images/custom/15438304268.jpg', 1, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_charge`
--

CREATE TABLE `delivery_charge` (
  `id` int(11) NOT NULL,
  `type` varchar(200) NOT NULL,
  `rate` float(8,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active, 0: inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery_charge`
--

INSERT INTO `delivery_charge` (`id`, `type`, `rate`, `status`) VALUES
(1, 'Inside  Dhaka', 100.00, 1),
(2, 'Outside Dhaka', 250.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `expense_reference_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `expense_date` date DEFAULT NULL,
  `expense_amount` double(12,4) NOT NULL,
  `expense_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:cash, 2:credit',
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `paid_amount` double(12,4) NOT NULL DEFAULT '0.0000',
  `balance` double(12,4) NOT NULL DEFAULT '0.0000',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,0: Deleted',
  `payment_status` tinyint(1) DEFAULT '1' COMMENT '1:due, 2:partialy paid,3:paid',
  `attachment` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `modified_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `expense_reference_no`, `expense_date`, `expense_amount`, `expense_type`, `description`, `paid_amount`, `balance`, `status`, `payment_status`, `attachment`, `created_by`, `modified_by`, `updated_at`, `created_at`) VALUES
(1, 'EXP2019/10/000001', '2019-10-24', 300.0000, 1, 'Electric bill of November', 0.0000, 300.0000, 1, NULL, '', '1000001', '1000001', '2019-11-02 18:13:45', '2019-10-24 14:56:24');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(11) NOT NULL,
  `expense_cat_name` varchar(200) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:active,0:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `expense_cat_name`, `parent_id`, `status`) VALUES
(1, 'Bills', NULL, 1),
(2, 'Electric  Bills', 1, 1),
(3, 'Gas Bills', 1, 1),
(4, 'Palli Electric Bills', 2, 1),
(5, 'PDB Electric Bills', 2, 1),
(6, 'gg', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `expense_details`
--

CREATE TABLE `expense_details` (
  `id` int(11) NOT NULL,
  `expense_id` int(11) NOT NULL,
  `expense_head_id` int(11) NOT NULL,
  `amount` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `expense_details`
--

INSERT INTO `expense_details` (`id`, `expense_id`, `expense_head_id`, `amount`, `description`) VALUES
(10, 1, 1, '200.00', ''),
(11, 1, 2, '100.00', '');

-- --------------------------------------------------------

--
-- Table structure for table `expense_heads`
--

CREATE TABLE `expense_heads` (
  `id` int(11) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `expense_head_name` varchar(200) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expense_heads`
--

INSERT INTO `expense_heads` (`id`, `expense_category_id`, `expense_head_name`, `note`, `status`) VALUES
(1, 5, 'Mollabrick PDB electric billl', 'sdfg sfsfsd fsdfsdfdzfdsa fdasfasd', 1),
(2, 4, 'Mollabrick Palli  electric billl', 'sdfg sfsfsd fsdfsdfdzfdsa fdasfasd', 1);

-- --------------------------------------------------------

--
-- Table structure for table `external_contact`
--

CREATE TABLE `external_contact` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `organization` varchar(50) NOT NULL DEFAULT '0',
  `designation` varchar(50) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL DEFAULT '0',
  `mobile_no` varchar(50) NOT NULL DEFAULT '0',
  `created_by` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `external_contact`
--

INSERT INTO `external_contact` (`id`, `name`, `organization`, `designation`, `email`, `mobile_no`, `created_by`) VALUES
(2, 'Rony Talukdar', 'ABC', 'ABC', 'fdsgsdfg', '454235345', '1000001'),
(3, 'ABC', 'ewgvsdagdf', 'btgfewft', 'wrewtgfvdv', '32424', '1000001');

-- --------------------------------------------------------

--
-- Table structure for table `gallary_images`
--

CREATE TABLE `gallary_images` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `album_id` int(11) NOT NULL DEFAULT '0',
  `attachment` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallary_images`
--

INSERT INTO `gallary_images` (`id`, `title`, `album_id`, `attachment`) VALUES
(52, 'cake', 23, '36.jpg'),
(53, 'cake', 23, '32.jpg'),
(54, 'Pizza Bun', 21, '2.jpg'),
(55, 'Mini Chicken Burger', 21, '8.jpg'),
(56, 'Sausage Delight', 21, '3.jpg'),
(58, 'cake', 23, '38.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `image_album`
--

CREATE TABLE `image_album` (
  `id` int(11) NOT NULL,
  `album_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image_album`
--

INSERT INTO `image_album` (`id`, `album_name`) VALUES
(21, 'Food'),
(22, 'Outlet'),
(23, 'Decorated Cake');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

CREATE TABLE `ingredient` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `photo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredient`
--

INSERT INTO `ingredient` (`id`, `code`, `name`, `photo`) VALUES
(4, '10002', 'Eggs', 'images/no_image.png'),
(7, '10005', 'Milk', 'images/no_image.png'),
(8, '10007', 'Suger', 'images/no_image.png'),
(11, '10009', 'Butter', 'images/no_image.png'),
(15, '10013', 'Cheese', 'images/no_image.png'),
(16, '10014', 'Chocolate', 'images/no_image.png'),
(17, '10015', 'Dark Chocolate', 'images/no_image.png'),
(24, '10022', 'Chicken', 'images/no_image.png'),
(26, '10024', 'Vegetable', 'images/no_image.png'),
(29, '10001', 'Beef', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_rate` float(8,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  2: canceled '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `size_id`, `unit_id`, `quantity`, `product_rate`, `status`) VALUES
(66, 30, 1, 7, 3, 1, 1720.00, 1),
(67, 30, 2, 1, 3, 12, 150.00, 1),
(68, 30, 1, 500, 3, 1, 1720.00, 1),
(69, 30, 2, 0, 3, 12, 150.00, 1),
(70, 30, 1, 7, 3, 3, 1720.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_master`
--

CREATE TABLE `order_master` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` datetime DEFAULT NULL,
  `delivery_type` tinyint(1) DEFAULT '1' COMMENT '1:takeout, 2: delivery, 3:dine in',
  `outlet_id` int(11) DEFAULT NULL,
  `delivery_charge_id` int(11) DEFAULT NULL,
  `cupon_id` int(11) DEFAULT NULL,
  `discount_amount` float(12,2) DEFAULT '0.00',
  `delivery_charge` float(12,2) DEFAULT '0.00',
  `total_order_amt` float(12,2) DEFAULT '0.00',
  `total_paid_amount` float(12,2) DEFAULT '0.00',
  `tax_amount` float(12,2) DEFAULT '0.00',
  `address` text NOT NULL,
  `remarks` text,
  `order_status` tinyint(1) DEFAULT '1' COMMENT '1:ordered,  2: ready ,  3: delivered',
  `order_noticed` tinyint(1) DEFAULT '1' COMMENT '1:not seen, 2:seen',
  `order_noticed_time` timestamp NULL DEFAULT NULL,
  `payment_time` timestamp NULL DEFAULT NULL,
  `payment_status` tinyint(1) DEFAULT '1' COMMENT '1:not paid,  2: paid ',
  `payment_method` tinyint(1) DEFAULT NULL COMMENT '1:bkash,  2: rocket ',
  `payment_reference_no` varchar(20) DEFAULT NULL,
  `invoice_no` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_master`
--

INSERT INTO `order_master` (`order_id`, `customer_id`, `order_date`, `delivery_date`, `delivery_type`, `outlet_id`, `delivery_charge_id`, `cupon_id`, `discount_amount`, `delivery_charge`, `total_order_amt`, `total_paid_amount`, `tax_amount`, `address`, `remarks`, `order_status`, `order_noticed`, `order_noticed_time`, `payment_time`, `payment_status`, `payment_method`, `payment_reference_no`, `invoice_no`) VALUES
(30, 14, '2019-11-10 19:21:09', '2019-11-10 12:00:00', 3, NULL, 3, NULL, 50.00, 0.00, 8680.00, 3470.00, 0.00, '', 'dfgdfg', 2, 2, '2019-11-10 08:28:14', '2019-11-10 12:59:24', 2, 3, '4544545', 'INV111900001');

-- --------------------------------------------------------

--
-- Table structure for table `outlets`
--

CREATE TABLE `outlets` (
  `id` int(11) NOT NULL,
  `address` varchar(500) NOT NULL,
  `outlet_name` varchar(200) DEFAULT NULL,
  `longitud` varchar(50) NOT NULL,
  `incharge_name` varchar(200) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `mobile` varchar(11) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active; 0:In-Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `outlets`
--

INSERT INTO `outlets` (`id`, `address`, `outlet_name`, `longitud`, `incharge_name`, `image`, `mobile`, `latitude`, `status`) VALUES
(1, '4/1 Salimullah Road, Mohammadpur, Dhaka', 'Mohammodpur ', '90.363841', '', 'images/outlets/outlate1.jpg', '01613313677', '23.759467', 1),
(2, 'Shaplar More, Kamarpara, Uttara, Dhaka', 'Uttara', '', '', 'images/outlets/outlate2.jpg', '01613313676', '', 1),
(3, 'H # 41, R # 04, B # 6, South Banasree, Dhaka', 'Banasree # 1', '', '', 'images/outlets/outlate3.jpg', '', '', 1),
(4, 'H # 227, R # 16, B # K, South Banasree, Dhaka', 'Banasree # 2', '', '', 'images/outlets/outlate4.jpg', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `code` varchar(200) NOT NULL,
  `tags` varchar(200) NOT NULL,
  `details` text,
  `short_description` text,
  `category_id` int(11) NOT NULL,
  `brand_name` varchar(50) DEFAULT NULL,
  `availability` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: available, 0: not avalable',
  `sell_from_stock` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Yes, 0: No',
  `feature_image` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `code`, `tags`, `details`, `short_description`, `category_id`, `brand_name`, `availability`, `sell_from_stock`, `feature_image`) VALUES
(1, 'Pestry', '00001', '', '', NULL, 25, NULL, 1, 1, ''),
(2, 'Plain Cake', '0002', '', '', NULL, 25, NULL, 1, 1, ''),
(3, 'Product A', '101', '', 'hjhj khjkhjh', NULL, 26, NULL, 1, 0, ''),
(4, 'AAAA', '2100', '', '', NULL, 25, NULL, 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `product_image`
--

CREATE TABLE `product_image` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_image` varchar(55) NOT NULL,
  `is_featured` tinyint(1) DEFAULT '0' COMMENT '1:featured, 0 not '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_image`
--

INSERT INTO `product_image` (`id`, `product_id`, `product_image`, `is_featured`) VALUES
(1, 1, '15723716584.jpg', 0),
(2, 2, '15733204197.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_ingredient`
--

CREATE TABLE `product_ingredient` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_ingredient`
--

INSERT INTO `product_ingredient` (`id`, `product_id`, `ingredient_id`) VALUES
(13, 1, 4),
(14, 1, 8),
(15, 1, 11),
(16, 1, 17),
(17, 2, 4),
(18, 2, 7),
(19, 2, 8),
(20, 2, 11),
(21, 2, 15),
(22, 2, 16),
(23, 2, 17),
(24, 2, 24),
(25, 2, 26),
(26, 2, 29),
(30, 3, 4),
(31, 3, 15),
(32, 3, 16),
(37, 4, 16),
(38, 4, 29);

-- --------------------------------------------------------

--
-- Table structure for table `product_rate`
--

CREATE TABLE `product_rate` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT '0',
  `production_rate` float(10,2) NOT NULL,
  `rate` float(10,2) NOT NULL,
  `discount_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: flat_rate; 2:percentage_rate',
  `discount_amount` float(10,2) NOT NULL,
  `discounted_rate` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_rate`
--

INSERT INTO `product_rate` (`id`, `product_id`, `size_id`, `unit_id`, `stock_quantity`, `production_rate`, `rate`, `discount_type`, `discount_amount`, `discounted_rate`) VALUES
(7, 1, 7, 3, 40, 1510.00, 1720.00, 1, 0.00, 1720.00),
(8, 1, 5, 3, 223, 510.00, 620.00, 1, 0.00, 620.00),
(9, 2, 1, 3, 32, 120.00, 150.00, 1, 0.00, 150.00),
(12, 3, 1, 3, 20, 0.00, 100.00, 1, 0.00, 100.00),
(13, 3, 14, 3, 20, 0.00, 80.00, 1, 0.00, 80.00),
(16, 4, 1, 3, 104, 875.00, 950.00, 1, 5.00, 875.00),
(17, 4, 0, 0, 0, 0.00, 0.00, 1, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `product_review`
--

CREATE TABLE `product_review` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `review_details` text,
  `review_point` int(1) NOT NULL,
  `review_by_name` varchar(200) NOT NULL,
  `review_by_email` varchar(200) NOT NULL,
  `review_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_stock`
--

CREATE TABLE `product_stock` (
  `id` int(11) NOT NULL,
  `product_rate_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `note` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product_stock`
--

INSERT INTO `product_stock` (`id`, `product_rate_id`, `date`, `quantity`, `note`) VALUES
(1, 8, '2019-11-20', 5, 'product added'),
(2, 7, '2019-11-21', 33, 'product added'),
(3, 8, '2019-11-13', 6, 'product added'),
(4, 7, '2019-11-20', 33, 'product added'),
(5, 8, '2019-11-13', 6, 'product added'),
(6, 7, '2019-11-20', 33, 'product added'),
(7, 8, '2019-11-13', -6, 'product damaged'),
(8, 7, '2019-11-20', 33, 'product added'),
(9, 9, '2019-11-13', 3, 'product added'),
(10, 9, '2019-11-12', 22, 'product added'),
(25, 8, '2019-11-14', 33, 'sdf'),
(26, 7, '2019-11-22', 2, 'update'),
(27, 9, '2019-11-21', 10, 'Product receive from shopno'),
(28, 12, '2019-11-21', 12, 'Product receive from shopno'),
(29, 16, '2019-11-21', 2, 'add product'),
(30, 13, '2019-11-21', 2, 'add product'),
(31, 12, '2019-11-21', 3, 'add product'),
(32, 7, '2019-11-22', 5, 'none'),
(33, 7, '2019-11-21', 10, 'none');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `company_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `stock_alert_quantity` int(11) NOT NULL,
  `tax` float NOT NULL,
  `logo` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `company_name`, `site_title`, `site_url`, `stock_alert_quantity`, `tax`, `logo`) VALUES
(1, 'Fastfood', 'Fastfood POS', 'http://localhost/fastfood/admin/', 64, 52, 'images/banner/1574357893no_image.png');

-- --------------------------------------------------------

--
-- Table structure for table `size`
--

CREATE TABLE `size` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `size`
--

INSERT INTO `size` (`id`, `code`, `name`) VALUES
(1, '10001', 'Small'),
(3, '10002', 'Mini'),
(4, '10003', 'Large'),
(5, '10004', '200 gm'),
(6, '10005', 'Per Piece'),
(7, '10006', '500 gm'),
(8, '10007', '100ml'),
(9, '10008', '250ml'),
(10, '10009', '500 ml'),
(11, '10010', '1ltr'),
(12, '10011', '250 gm'),
(14, '10013', 'Family'),
(17, '10016', 'Regular'),
(19, '10018', '1 kg'),
(20, '10019', '2 kg'),
(21, '10020', '3 kg'),
(22, '10021', '4 kg');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `unit_name` varchar(100) DEFAULT NULL,
  `short_name` varchar(10) DEFAULT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(3) DEFAULT NULL COMMENT 'add, sub, mul, div',
  `conversion_rate` double(12,2) DEFAULT NULL,
  `note` text,
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active, 2:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_name`, `short_name`, `base_unit`, `operator`, `conversion_rate`, `note`, `status`) VALUES
(1, 'Kilogram', 'KG', NULL, NULL, 0.00, NULL, 1),
(2, 'Gram', 'gm', 1, 'sub', 1000.00, NULL, 1),
(3, 'Pices', 'Pcs', NULL, NULL, 0.00, NULL, 1),
(4, 'Dozen', 'Dzn', 3, 'mul', 12.00, NULL, 1),
(5, 'Liter', 'Ltr', NULL, 'mul', 0.00, NULL, 1),
(6, 'Mililiter', 'ml', 5, 'div', 1000.00, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) NOT NULL,
  `group_name` varchar(100) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `group_name`, `status`) VALUES
(21, 'Admin', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_member`
--

CREATE TABLE `user_group_member` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT '0',
  `emp_id` varchar(20) NOT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '0: no access ; 1:access'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group_member`
--

INSERT INTO `user_group_member` (`id`, `group_id`, `emp_id`, `status`) VALUES
(2, 21, '1000001', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_permission`
--

CREATE TABLE `user_group_permission` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT '0',
  `action_id` int(11) DEFAULT '0',
  `status` tinyint(1) NOT NULL COMMENT '0: Not Permit, 1: Permit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group_permission`
--

INSERT INTO `user_group_permission` (`id`, `group_id`, `action_id`, `status`) VALUES
(251, 21, 11, 1),
(252, 21, 12, 1),
(253, 21, 13, 1),
(254, 21, 14, 1),
(255, 21, 15, 1),
(256, 21, 16, 1),
(257, 21, 43, 1),
(258, 21, 44, 1),
(260, 21, 45, 1),
(583, 21, 10, 1),
(588, 21, 50, 1),
(589, 21, 51, 1),
(590, 21, 52, 1),
(591, 21, 53, 1),
(592, 21, 54, 1),
(593, 21, 55, 1),
(594, 21, 56, 1),
(595, 21, 57, 1),
(596, 21, 58, 1),
(597, 21, 59, 1),
(598, 21, 60, 1),
(599, 21, 61, 1),
(600, 21, 62, 1),
(601, 21, 63, 1),
(602, 21, 64, 1),
(603, 21, 65, 1),
(604, 21, 66, 1),
(605, 21, 67, 1),
(606, 21, 68, 1),
(607, 21, 69, 1),
(608, 21, 70, 0),
(609, 21, 71, 0),
(610, 21, 72, 0),
(611, 21, 73, 0),
(612, 21, 74, 1),
(613, 21, 75, 1),
(614, 21, 76, 1),
(615, 21, 77, 1),
(616, 21, 78, 0),
(617, 21, 79, 0),
(618, 21, 80, 0),
(619, 21, 81, 0),
(620, 21, 82, 1),
(621, 21, 83, 1),
(622, 21, 84, 1),
(623, 21, 85, 1),
(624, 21, 86, 1),
(625, 21, 87, 1),
(626, 21, 88, 0),
(627, 21, 89, 0),
(628, 21, 90, 0),
(629, 21, 94, 0),
(630, 21, 95, 0),
(631, 21, 96, 0),
(632, 21, 97, 0),
(633, 21, 98, 1),
(634, 21, 99, 1),
(635, 21, 100, 1),
(636, 21, 101, 1),
(637, 21, 102, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_infos`
--

CREATE TABLE `user_infos` (
  `emp_id` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `designation_name` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `age` varchar(100) NOT NULL,
  `nid_no` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `blood_group` varchar(50) DEFAULT NULL,
  `health_card_no` varchar(50) DEFAULT NULL,
  `is_active_home_page` tinyint(1) NOT NULL DEFAULT '0',
  `remarks` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_infos`
--

INSERT INTO `user_infos` (`emp_id`, `full_name`, `designation_name`, `address`, `age`, `nid_no`, `photo`, `contact_no`, `email`, `blood_group`, `health_card_no`, `is_active_home_page`, `remarks`) VALUES
('1000001', 'Momit', 'Software Engineer', '', '', '', 'images/employee/momit.jpg', '01737151125', 'shofiqueshahin@gmail.com', 'B+', '201800001', 0, 'aaaaaaaaaa');

-- --------------------------------------------------------

--
-- Table structure for table `web_actions`
--

CREATE TABLE `web_actions` (
  `id` int(11) NOT NULL,
  `activity_name` varchar(50) NOT NULL,
  `module_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_actions`
--

INSERT INTO `web_actions` (`id`, `activity_name`, `module_id`, `status`) VALUES
(10, 'Employee enrty', 1, 0),
(11, 'employee permission', 1, 0),
(12, 'employee update', 1, 0),
(13, 'employee delete', 1, 0),
(14, 'control panel', 6, 0),
(15, 'employee List', 1, 0),
(16, 'permission grid', 1, 0),
(43, 'activity action access', 1, 0),
(44, 'group permission', 1, 0),
(45, 'website permission', 1, 0),
(50, 'Category Entry', 3, 0),
(51, 'Category Delete', 3, 0),
(52, 'Category Update', 3, 0),
(53, 'Category Grid', 3, 0),
(54, 'Ingredient Entry', 3, 0),
(55, 'Ingredient Delete', 3, 0),
(56, 'Ingredient Update', 3, 0),
(57, 'Ingredient Grid', 3, 0),
(58, 'Size Entry', 3, 0),
(59, 'Size Delete', 3, 0),
(60, 'Size Update', 3, 0),
(61, 'Size Grid', 3, 0),
(62, 'Product Entry', 3, 0),
(63, 'Product Delete', 3, 0),
(64, 'Product Update', 3, 0),
(65, 'Product Grid', 3, 0),
(66, 'Customer Entry', 5, 0),
(67, 'Customer Delete', 5, 0),
(68, 'Customer Update', 5, 0),
(69, 'Customer Grid', 5, 0),
(70, 'Outlet Entry', 6, 1),
(71, 'Outlet Update', 6, 1),
(72, 'Outlet Delete', 6, 1),
(73, 'Outlet Grid', 6, 1),
(74, 'Order Entry', 4, 0),
(75, 'Order Delete', 4, 0),
(76, 'Order Update', 4, 0),
(77, 'Order Grid', 4, 0),
(78, 'cupon entry', 6, 1),
(79, 'cupon delete', 6, 1),
(80, 'cupon update', 6, 1),
(81, 'cupon grid', 6, 1),
(82, 'Customer Report', 2, 0),
(83, 'Order Summary Report', 2, 0),
(84, 'Order Details Report', 2, 0),
(85, 'Product Report', 2, 0),
(86, 'Order VS Payment Report', 2, 0),
(87, 'Product sell report', 2, 0),
(88, 'Custom Order Grid', 4, 1),
(89, 'Custom Order Update', 4, 1),
(90, 'Custom Order Delete', 4, 1),
(91, 'Custom order Greid', 6, 1),
(92, 'Custom order update', 6, 1),
(93, 'Custom order Delete', 6, 1),
(94, 'Delivery Charge Entry', 6, 1),
(95, 'Delivery Charge Delete ', 6, 1),
(96, 'Delivery Charge Update', 6, 1),
(97, 'Delivery Charge Grid', 6, 1),
(98, 'Settings', 6, 0),
(99, 'Expense CRUD', 7, 0),
(100, 'Unit CRUD', 6, 0),
(101, 'Stock adjustment', 3, 0),
(102, 'Stock Grid', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_login`
--

CREATE TABLE `web_login` (
  `emp_id` varchar(10) NOT NULL,
  `is_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:not logged, 1: logged in',
  `chat_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 1:available,2:meeting,3:busy'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `web_menu`
--

CREATE TABLE `web_menu` (
  `id` int(11) NOT NULL,
  `parent_menu_id` int(11) DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  `menu` varchar(50) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_menu`
--

INSERT INTO `web_menu` (`id`, `parent_menu_id`, `title`, `menu`, `description`) VALUES
(16, 16, 'Services', 'services', '<p>Shastho Shikkha ( Ss), &nbsp;&nbsp; <span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">Medical Services&nbsp; ( Ms) , </span>&nbsp;<span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">&nbsp; Law Awarness &amp; Services ( Las)</span> , &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n'),
(28, 28, 'ABOUT US', 'about-us', '<p>We are extremely proud to inform you our new concept, <span style=\"color:#3b2413\"><strong>Cakencookie</strong></span>. Yes it&rsquo;s a new brand of Bakery &amp; Pastry. It&rsquo;s a sophisticated brand of Nafisa Food &amp; Beverage Ltd. The inhabitants of Dhaka City are getting accustomed to Western and European culture , at the same time huge number of expats are travelling to Bangladesh especially Dhaka due to business . Consequently hospitality industry is growing so fast. Restaurant, Cafe, Club, Bar are increasing dramatically to accomplish the need of locals and expats.</p>\r\n\r\n<p>This logical evolutionary change has drawn our attention and the thirst of people towards variety of food items drive us to shape our business concept regarding the brand, <span style=\"color:#3b2413\"><strong>Cakencookie</strong></span>.</p>\r\n'),
(29, 16, 'Helth Awarness', 'Helth Awarness', '<p>We awar people about some dangarous disease like Cancer, Diabetic, Strock, Adolescent Nutrition, Reproductive Health etc.</p>\r\n'),
(30, 16, 'Diagnosis Services', 'Diagnosis Services', '<p>We provide &quot;Diagnosis Card&quot; thus people get discount on diagonisis in several Diagnostic Center For Primary Disease identifying.</p>\r\n'),
(31, 16, 'Doctors Consultancy', 'Doctors Consultancy', '<p>We will provide/suggest Specialist&nbsp; doctor and best treatment process for a specific disease . Services holder will&nbsp; get Specialist Doctors Consultancy From Self Service Center <span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">w</span><span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">ith w</span><span style=\"background-color:transparent; color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px\">eb Camera.</span></p>\r\n'),
(32, 16, 'Medicin Care', 'Medicin Care', '<p>One of the Main target is to provide people medicine for cheap rate and free(Special cases) From Selective Medicin Shop With internet Health Card.</p>\r\n'),
(33, 16, 'Doctors Serial', 'Doctors Serial', '<p>We will arrange doctor&#39;s serial, because it is very difficult to manage a serial for a rural people</p>\r\n'),
(34, 16, 'Law Services', 'Law Services', '<p>Grow awareness &amp; law support against torture, child Marrige,eve-teasing, dowry, terrorism, intoxicating &amp; militancy</p>\r\n'),
(35, 28, 'OUR MISSION', 'mission', '<p>Our competent team members are the main strength point of this sophisticated food brand whose are committed to provide superior quality of bakery, pastries, savories, cakes &amp; ice creams. Our motto is to achieve customers satisfaction through implementing total quality management (TQM) . We are highly committed to collect fresh &amp; purest raw materials, process them in a very systematic and hygienic way for making the fine tuned product by our talented chefs. We do focus on our customer feedback &amp; work on it to provide them wow experience that makes them repeat customers.</p>\r\n'),
(36, 28, 'OUR VISION', 'vision', '<p>Be the leader of the bakery market through ensuring quality, service, innovation &amp; affordable prices to fulfill the needs of our precious customer &amp; consumer.</p>\r\n'),
(37, 28, 'PRODUCTS WE OFFER', 'service', '<p>We believe that the most promising cafes are those which have firm determination to meet guest expectations through their quality of product &amp; Service. This belief has lead us to flourish the brand <span style=\"color:#3b2413\"><strong>Cakencookie </strong></span>that will offer quality of Bakery, Pastry, Hot Savoury, accompanied of varieties coffee and different flavoured Ice-Cream. In short, it&rsquo;s a one stop service offer for the guest convenient only.</p>\r\n'),
(38, 38, 'Contact', 'contact', '<p>Contact address here</p>\r\n'),
(39, 38, 'Address', 'address', '<p>Mohammadpur, Dhaka, Bangladesh 1207,</p><br />\r\n<p>Tongi, Gazipur, Bangladesh 1207,</p>\r\n\r\n'),
(40, 38, 'Mobile', 'mobile', '<p>01613313670</p>\r\n'),
(41, 38, 'Email', 'email', '<p>marketing@cakencookie.net</p>\r\n'),
(42, 38, 'Office Time', ' Office Time', '<p>10:00 AM&nbsp; to 6:00 PM</p>\r\n'),
(43, 43, 'Terms & Conditions', 'Terms & Conditions', '<p>OVERVIEW</p>\r\n\r\n<p>This website is operated by Cakencookies. Throughout the site, the terms &ldquo;we&rdquo;, &ldquo;us&rdquo; and &ldquo;our&rdquo; refer to Cakencookies. Cakencookies offers this website, including all information, tools and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies and notices stated here.</p>\r\n\r\n<p>By visiting our site and/ or purchasing something from us, you engage in our &ldquo;Service&rdquo; and agree to be bound by the following terms and conditions (&ldquo;Terms of Service&rdquo;, &ldquo;Terms&rdquo;), including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/ or contributors of content.</p>\r\n\r\n<p>Please read these Terms of Service carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the website or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.</p>\r\n\r\n<p>Any new features or tools which are added to the current store shall also be subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our website. It is your responsibility to check this page periodically for changes. Your continued use of or access to the website following the posting of any changes constitutes acceptance of those changes.</p>\r\n\r\n<p>Our store is hosted on EyHost Hosting Service and 2Checkout provides us with the online e-commerce platform that allows us to sell our products and services to you.</p>\r\n\r\n<p>SECTION 1 &ndash; ONLINE STORE TERMS</p>\r\n\r\n<p>By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.</p>\r\n\r\n<p>You may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).</p>\r\n\r\n<p>You must not transmit any worms or viruses or any code of a destructive nature.</p>\r\n\r\n<p>A breach or violation of any of the Terms will result in an immediate termination of your Services.</p>\r\n\r\n<p>SECTION 2 &ndash; GENERAL CONDITIONS</p>\r\n\r\n<p>We reserve the right to refuse service to anyone for any reason at any time.</p>\r\n\r\n<p>You understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks.</p>\r\n\r\n<p>You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the website through which the service is provided, without express written permission by us.</p>\r\n\r\n<p>The headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.</p>\r\n\r\n<p>SECTION 3 &ndash; ACCURACY, COMPLETENESS AND TIMELINESS OF INFORMATION</p>\r\n\r\n<p>We are not responsible if information made available on this site is not accurate, complete or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete or more timely sources of information. Any reliance on the material on this site is at your own risk.</p>\r\n\r\n<p>This site may contain certain historical information. Historical information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site.</p>\r\n\r\n<p>SECTION 4 &ndash; MODIFICATIONS TO THE SERVICE AND PRICES</p>\r\n\r\n<p>Prices for our products are subject to change without notice.</p>\r\n\r\n<p>We reserve the right at any time to modify or discontinue the Service (or any part or content thereof) without notice at any time.</p>\r\n\r\n<p>We shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service.</p>\r\n\r\n<p>SECTION 5 &ndash; PRODUCTS OR SERVICES (if applicable)</p>\r\n\r\n<p>Certain products or services may be available exclusively online through the website. These products or services may have limited quantities and are subject to return or exchange only according to our Return Policy.</p>\r\n\r\n<p>We have made every effort to display as accurately as possible the colors and images of our products that appear at the store. We cannot guarantee that your computer monitor&rsquo;s display of any color will be accurate.</p>\r\n\r\n<p>We reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at anytime without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for any product or service made on this site is void where prohibited.</p>\r\n\r\n<p>We do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.</p>\r\n\r\n<p>SECTION 6 &ndash; ACCURACY OF BILLING AND ACCOUNT INFORMATION</p>\r\n\r\n<p>We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.</p>\r\n\r\n<p>You agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.</p>\r\n\r\n<p>For more detail, please review our Returns Policy.</p>\r\n\r\n<p>SECTION 7 &ndash; OPTIONAL TOOLS</p>\r\n\r\n<p>We may provide you with access to third-party tools over which we neither monitor nor have any control nor input.</p>\r\n\r\n<p>You acknowledge and agree that we provide access to such tools &rdquo;as is&rdquo; and &ldquo;as available&rdquo; without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools.</p>\r\n\r\n<p>Any use by you of optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).</p>\r\n\r\n<p>We may also, in the future, offer new services and/or features through the website (including, the release of new tools and resources). Such new features and/or services shall also be subject to these Terms of Service.</p>\r\n\r\n<p>SECTION 8 &ndash; THIRD-PARTY LINKS</p>\r\n\r\n<p>Certain content, products and services available via our Service may include materials from third-parties.</p>\r\n\r\n<p>Third-party links on this site may direct you to third-party websites that are not affiliated with us. We are not responsible for examining or evaluating the content or accuracy and we do not warrant and will not have any liability or responsibility for any third-party materials or websites, or for any other materials, products, or services of third-parties.</p>\r\n\r\n<p>We are not liable for any harm or damages related to the purchase or use of goods, services, resources, content, or any other transactions made in connection with any third-party websites. Please review carefully the third-party&rsquo;s policies and practices and make sure you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding third-party products should be directed to the third-party.</p>\r\n\r\n<p>SECTION 9 &ndash; USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS</p>\r\n\r\n<p>If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, &lsquo;comments&rsquo;), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us. We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for any comments; or (3) to respond to any comments.</p>\r\n\r\n<p>We may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party&rsquo;s intellectual property or these Terms of Service.</p>\r\n\r\n<p>You agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by you or any third-party.</p>\r\n\r\n<p>SECTION 10 &ndash; PERSONAL INFORMATION</p>\r\n\r\n<p>Your submission of personal information through the store is governed by our Privacy Policy. To view our Privacy Policy.</p>\r\n\r\n<p>SECTION 11 &ndash; ERRORS, INACCURACIES AND OMISSIONS</p>\r\n\r\n<p>Occasionally there may be information on our site or in the Service that contains typographical errors, inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, product shipping charges, transit times and availability. We reserve the right to correct any errors, inaccuracies or omissions, and to change or update information or cancel orders if any information in the Service or on any related website is inaccurate at any time without prior notice (including after you have submitted your order).</p>\r\n\r\n<p>We undertake no obligation to update, amend or clarify information in the Service or on any related website, including without limitation, pricing information, except as required by law. No specified update or refresh date applied in the Service or on any related website, should be taken to indicate that all information in the Service or on any related website has been modified or updated.</p>\r\n\r\n<p>SECTION 12 &ndash; PROHIBITED USES</p>\r\n\r\n<p>In addition to other prohibitions as set forth in the Terms of Service, you are prohibited from using the site or its content: (a) for any unlawful purpose; (b) to solicit others to perform or participate in any unlawful acts; (c) to violate any international, federal, provincial or state regulations, rules, laws, or local ordinances; (d) to infringe upon or violate our intellectual property rights or the intellectual property rights of others; (e) to harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, race, age, national origin, or disability; (f) to submit false or misleading information; (g) to upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Service or of any related website, other websites, or the Internet; (h) to collect or track the personal information of others; (i) to spam, phish, pharm, pretext, spider, crawl, or scrape; (j) for any obscene or immoral purpose; or (k) to interfere with or circumvent the security features of the Service or any related website, other websites, or the Internet. We reserve the right to terminate your use of the Service or any related website for violating any of the prohibited uses.</p>\r\n\r\n<p>SECTION 13 &ndash; DISCLAIMER OF WARRANTIES; LIMITATION OF LIABILITY</p>\r\n\r\n<p>We do not guarantee, represent or warrant that your use of our service will be uninterrupted, timely, secure or error-free.</p>\r\n\r\n<p>We do not warrant that the results that may be obtained from the use of the service will be accurate or reliable.</p>\r\n\r\n<p>You agree that from time to time we may remove the service for indefinite periods of time or cancel the service at any time, without notice to you.</p>\r\n\r\n<p>You expressly agree that your use of, or inability to use, the service is at your sole risk. The service and all products and services delivered to you through the service are (except as expressly stated by us) provided &lsquo;as is&rsquo; and &lsquo;as available&rsquo; for your use, without any representation, warranties or conditions of any kind, either express or implied, including all implied warranties or conditions of merchantability, merchantable quality, fitness for a particular purpose, durability, title, and non-infringement.</p>\r\n\r\n<p>In no case shall Cakencookies, our directors, officers, employees, affiliates, agents, contractors, interns, suppliers, service providers or licensors be liable for any injury, loss, claim, or any direct, indirect, incidental, punitive, special, or consequential damages of any kind, including, without limitation lost profits, lost revenue, lost savings, loss of data, replacement costs, or any similar damages, whether based in contract, tort (including negligence), strict liability or otherwise, arising from your use of any of the service or any products procured using the service, or for any other claim related in any way to your use of the service or any product, including, but not limited to, any errors or omissions in any content, or any loss or damage of any kind incurred as a result of the use of the service or any content (or product) posted, transmitted, or otherwise made available via the service, even if advised of their possibility. Because some states or jurisdictions do not allow the exclusion or the limitation of liability for consequential or incidental damages, in such states or jurisdictions, our liability shall be limited to the maximum extent permitted by law.</p>\r\n\r\n<p>SECTION 14 &ndash; INDEMNIFICATION</p>\r\n\r\n<p>You agree to indemnify, defend and hold harmless King&rsquo;s Confectionery (Bangladesh) Pte. Ltd. and our parent, subsidiaries, affiliates, partners, officers, directors, agents, contractors, licensors, service providers, subcontractors, suppliers, interns and employees, harmless from any claim or demand, including reasonable attorneys&rsquo; fees, made by any third-party due to or arising out of your breach of these Terms of Service or the documents they incorporate by reference, or your violation of any law or the rights of a third-party.</p>\r\n\r\n<p>SECTION 15 &ndash; SEVERABILITY</p>\r\n\r\n<p>In the event that any provision of these Terms of Service is determined to be unlawful, void or unenforceable, such provision shall nonetheless be enforceable to the fullest extent permitted by applicable law, and the unenforceable portion shall be deemed to be severed from these Terms of Service, such determination shall not affect the validity and enforceability of any other remaining provisions.</p>\r\n\r\n<p>SECTION 16 &ndash; TERMINATION</p>\r\n\r\n<p>The obligations and liabilities of the parties incurred prior to the termination date shall survive the termination of this agreement for all purposes.</p>\r\n\r\n<p>These Terms of Service are effective unless and until terminated by either you or us. You may terminate these Terms of Service at any time by notifying us that you no longer wish to use our Services, or when you cease using our site.</p>\r\n\r\n<p>If in our sole judgment you fail, or we suspect that you have failed, to comply with any term or provision of these Terms of Service, we also may terminate this agreement at any time without notice and you will remain liable for all amounts due up to and including the date of termination; and/or accordingly may deny you access to our Services (or any part thereof).</p>\r\n\r\n<p>SECTION 17 &ndash; ENTIRE AGREEMENT</p>\r\n\r\n<p>The failure of us to exercise or enforce any right or provision of these Terms of Service shall not constitute a waiver of such right or provision.</p>\r\n\r\n<p>These Terms of Service and any policies or operating rules posted by us on this site or in respect to The Service constitutes the entire agreement and understanding between you and us and govern your use of the Service, superseding any prior or contemporaneous agreements, communications and proposals, whether oral or written, between you and us (including, but not limited to, any prior versions of the Terms of Service).</p>\r\n\r\n<p>Any ambiguities in the interpretation of these Terms of Service shall not be construed against the drafting party.</p>\r\n\r\n<p>SECTION 18 &ndash; JURISDICTION AND RESTRICTION</p>\r\n\r\n<p>Cakencookies controls and maintains this Web Site from Bangladesh. The materials and information contained in this section of this Web Site, relating to Bangladesh, is directed at and restricted to individuals resident in or entities having a place of business in Bangladesh ONLY. The Cakencookies makes no representation that the materials and information contained herein is appropriate or available for use in other locations / jurisdictions.</p>\r\n\r\n<p>These Terms and Conditions are governed by and construed in accordance with the laws of Bangladesh and any dispute relating thereto shall be subject to the non-exclusive jurisdiction of the courts of Bangladesh.</p>\r\n\r\n<p>SECTION 19 &ndash; CHANGES TO TERMS OF SERVICE</p>\r\n\r\n<p>You can review the most current version of the Terms of Service at any time at this page.</p>\r\n\r\n<p>We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Service by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. Your continued use of or access to our website or the Service following the posting of any changes to these Terms of Service constitutes acceptance of those changes.</p>\r\n\r\n<p>SECTION 20 &ndash; CONTACT INFORMATION</p>\r\n'),
(45, NULL, 'Privacy Policy', 'Privacy', '<p>SECTION 1 &ndash; WHAT DO WE DO WITH YOUR INFORMATION?</p>\r\n\r\n<p>When you purchase something from our store, as part of the buying and selling process, we collect the personal information you give us such as your name, address and email address.</p>\r\n\r\n<p>When you browse our store, we also automatically receive your computer&rsquo;s internet protocol (IP) address in order to provide us with information that helps us learn about your browser and operating system.</p>\r\n\r\n<p>Email marketing (if applicable): With your permission, we may send you emails about our store, new products and other updates.</p>\r\n\r\n<p>SECTION 2 &ndash; CONSENT</p>\r\n\r\n<p>How do you get my consent?</p>\r\n\r\n<p>When you provide us with personal information to complete a transaction, verify your credit card, place an order, arrange for a delivery or return a purchase, we imply that you consent to our collecting it and using it for that specific reason only.</p>\r\n\r\n<p>If we ask for your personal information for a secondary reason, like marketing, we will either ask you directly for your expressed consent, or provide you with an opportunity to say no.</p>\r\n\r\n<p>How do I withdraw my consent?</p>\r\n\r\n<p>If after you opt-in, you change your mind, you may withdrawing your consent for us to contact you, for the continued collection, use or disclosure of your information, at anytime, by contacting us at info@kingsbd.com or mailing us at:</p>\r\n\r\n<p>Cakencookies</p>\r\n\r\n<p>House No. 17, Road No. 11, Block G, Banani, Dhaka-1213, Bangladesh</p>\r\n\r\n<p>SECTION 3 &ndash; DISCLOSURE</p>\r\n\r\n<p>We may disclose your personal information if we are required by law to do so or if you violate our Terms of Service.</p>\r\n\r\n<p>SECTION 4 &ndash; EyHOST HOSTING SERVICE &amp; 2CHECKOUT</p>\r\n\r\n<p>Our store is hosted on EyHost Hosting Service and our direct payment gateway is provided by 2Checkout. They provide us with the online e-commerce platform that allows us to sell our products and services to you.</p>\r\n\r\n<p>Your data is stored through EyHost Hosting Service&rsquo;s and 2Checkout&rsquo;s data storage, databases and the general 2Checkout application. They store your data on a secure server behind a firewall.</p>\r\n\r\n<p>Payment:</p>\r\n\r\n<p>If you choose a direct payment gateway to complete your purchase, then 2Checkout stores your credit card data. It is encrypted through the Payment Card Industry Data Security Standard (PCI-DSS). Your purchase transaction data is stored only as long as is necessary to complete your purchase transaction. After that is complete, your purchase transaction information is deleted.</p>\r\n\r\n<p>All direct payment gateways adhere to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, MasterCard, American Express and Discover.</p>\r\n\r\n<p>PCI-DSS requirements help ensure the secure handling of credit card information by our store and its service providers.</p>\r\n\r\n<p>For more insight, you may also want to read 2Checkout&rsquo;s Terms of Service here https://www.2checkout.com/policies/terms-of-use or Privacy Statement here https://www.2checkout.com/policies/privacy-policy.</p>\r\n\r\n<p>SECTION 5 &ndash; THIRD-PARTY SERVICES</p>\r\n\r\n<p>In general, the third-party providers used by us will only collect, use and disclose your information to the extent necessary to allow them to perform the services they provide to us.</p>\r\n\r\n<p>However, certain third-party service providers, such as payment gateways and other payment transaction processors, have their own privacy policies in respect to the information we are required to provide to them for your purchase-related transactions.</p>\r\n\r\n<p>For these providers, we recommend that you read their privacy policies so you can understand the manner in which your personal information will be handled by these providers.</p>\r\n\r\n<p>In particular, remember that certain providers may be located in or have facilities that are located a different jurisdiction than either you or us. So if you elect to proceed with a transaction that involves the services of a third-party service provider, then your information may become subject to the laws of the jurisdiction(s) in which that service provider or its facilities are located.</p>\r\n\r\n<p>Once you leave our store&rsquo;s website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our website&rsquo;s Terms of Service.</p>\r\n\r\n<p>Links</p>\r\n\r\n<p>When you click on links on our store, they may direct you away from our site. We are not responsible for the privacy practices of other sites and encourage you to read their privacy statements.</p>\r\n\r\n<p>Google analytics:</p>\r\n\r\n<p>Our store uses Google Analytics to help us learn about who visits our site and what pages are being looked at.</p>\r\n\r\n<p>SECTION 6 &ndash; SECURITY</p>\r\n\r\n<p>To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered or destroyed.</p>\r\n\r\n<p>If you provide us with your credit card information, the information is encrypted using secure socket layer technology (SSL) and stored with a AES-256 encryption.&nbsp; Although no method of transmission over the Internet or electronic storage is 100% secure, we follow all PCI-DSS requirements and implement additional generally accepted industry standards.</p>\r\n\r\n<p>SECTION 7 &ndash; COOKIES</p>\r\n\r\n<p>In order to improve our Internet service to you, we will occasionally use a &ldquo;cookie&rdquo; and/or other similar files or programs which may place certain information on your computer&rsquo;s hard drive when you visit an Cakencookies&rsquo;s web site. A cookie is a small amount of data that our web server sends to your web browser when you visit certain parts of our site. We may use cookies to:</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp; allow us to recognise the PC you are using when you return to our web site so that we can understand your interest in our web site and tailor its content and advertisements to match your interests (This type of cookie may be stored permanently on your PC but does not contain any information that can identify you personally.);<br />\r\n&nbsp;&nbsp;&nbsp; identify you after you have logged in by storing a temporary reference number in the cookie so that our web server can conduct a dialogue with you while simultaneously dealing with other customers. (Your browser keeps this type of cookie until you log off or close down your browser when these types of cookie are normally deleted. No other information is stored in this type of cookie.);<br />\r\n&nbsp;&nbsp;&nbsp; allow you to carry information across pages of our site and avoid having to re-enter that information;<br />\r\n&nbsp;&nbsp;&nbsp; allow you access to stored information if you register for any of our on-line services;<br />\r\n&nbsp;&nbsp;&nbsp; enable us to produce statistical information (anonymous) which helps us to improve the structure and content of our web site;<br />\r\n&nbsp;&nbsp;&nbsp; enable us to evaluate the effectiveness of our advertising and promotions.</p>\r\n\r\n<p>Cookies do not enable us to gather personal information about you unless you give the information to our server. Most Internet browser software allows the blocking of all cookies or enables you to receive a warning before a cookie is stored. For further information, please refer to your Internet browser software instructions or help screen.</p>\r\n\r\n<p>SECTION 8 &ndash; INTERNET COMMUNICATIONS</p>\r\n\r\n<p>In order to maintain the security of our systems, protect our staff, record transactions, and, in certain circumstances, to prevent and detect crime or unauthorized activities, Cakencookies reserves the right to monitor all internet communications including web and email traffic into and out of its domains.</p>\r\n\r\n<p>SECTION 9 &ndash; AGE OF CONSENT</p>\r\n\r\n<p>By using this site, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.</p>\r\n\r\n<p>SECTION 10 &ndash; CHANGES TO THIS PRIVACY POLICY</p>\r\n\r\n<p>We reserve the right to modify this privacy policy at any time, so please review it frequently. Changes and clarifications will take effect immediately upon their posting on the website. If we make material changes to this policy, we will notify you here that it has been updated, so that you are aware of what information we collect, how we use it, and under what circumstances, if any, we use and/or disclose it.</p>\r\n\r\n<p>If our store is acquired or merged with another company, your information may be transferred to the new owners so that we may continue to sell products to you.</p>\r\n\r\n<p>QUESTIONS AND CONTACT INFORMATION</p>\r\n\r\n<p>If you would like to: access, correct, amend or delete any personal information we have about you, register a complaint, or simply want more information contact our Privacy Compliance Officer at info@kingsbd.com or by mail at</p>\r\n'),
(46, 28, 'REFUND POLICY', 'Refund Policy', '<p>Any changes or cancellations to your order must be placed at least 48 hours in advance of the scheduled delivery or pick up time of your order.&nbsp; If a cancellation is placed at least 48 hours in advance, we are able to issue a 100% refund for your order.&nbsp; Any cancellations or changes made within 48 hours of the scheduled delivery or pick up time of your order are completely non-refundable.</p>\r\n\r\n<p>If you are unsatisfied with your purchase for any reason after delivery of the product has been accepted, please give us a call at</p>\r\n\r\n<p>1. COO : +8801613313688<br />\r\n2. Manager Operation : +8801613313679</p>\r\n\r\n<p>&nbsp;so we can remedy the situation.</p>\r\n'),
(47, 28, 'SPECIALITY', 'Speciality', '<p>The Quality &amp; Quantity of Products, Personalized Service &amp; Prompt Delivery are Our Strength as well as Speciality</p>\r\n'),
(48, 55, 'Special Menu', 'Special Menu', '<p>the menu consist of cakes, pastries, savories &amp; more of freshly baked bakeries which are really prepared with care for our valued customers</p>\r\n'),
(49, NULL, 'Welcome Subtitle', 'Welcome Subtitle', '<h6>Savory/Pastry/Cake/Coffee/Cookies/Bread</h6>\r\n'),
(50, NULL, 'We Are Best', 'We Are Best', '<p>Cake, Pastry, Savory</p>\r\n'),
(51, 55, 'Fresh Products', 'Fresh Products', '<p>Fresh Products</p>\r\n'),
(52, 55, 'Various Items', 'Various Items', '<p>Various Items</p>\r\n'),
(53, 55, 'Personalized  Service', 'Personalized Service', '<p>Well Service</p>\r\n'),
(54, 55, 'Fast Delivery', 'Fast Delivery', '<p>Fast Delivery</p>\r\n'),
(55, NULL, 'Home', 'Home', 'details no need to edit. this is only for development reason'),
(56, NULL, 'Social Network', 'Social Network', 'dont edit this , only for development'),
(57, 56, 'facebook link', 'facebook link', 'https://www.facebook.com/Cakencookiee/'),
(58, 56, 'twitter link', 'twitter link', 'https://www.twitter.com/Cakencookiee/'),
(59, 56, 'instagram link', 'instagram  link', 'https://www.instagram.com/Cakencookiee/'),
(60, 56, 'googleplus  link', 'googleplus  link', 'https://www.googleplus.com/Cakencookiee/'),
(61, NULL, 'bkash mobile no', 'bkash mobile no', '<p>1111111111111</p>'),
(62, NULL, 'Rocket mobile no', 'Rocket mobile no', '<p>1111111111111</p>');

-- --------------------------------------------------------

--
-- Table structure for table `web_module`
--

CREATE TABLE `web_module` (
  `id` int(11) NOT NULL,
  `module_name` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:active, 1:inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_module`
--

INSERT INTO `web_module` (`id`, `module_name`, `status`) VALUES
(1, 'HRM', 0),
(2, 'Report', 0),
(3, 'Product', 0),
(4, 'Order', 0),
(5, 'Customer', 0),
(6, 'Control Panel', 0),
(7, 'Expense', 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_notice`
--

CREATE TABLE `web_notice` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `details` text NOT NULL,
  `attachment` varchar(200) DEFAULT NULL,
  `banner_img` varchar(100) DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `posted_by` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:Pending, 2:Approved, 3: Deleted',
  `remarks` varchar(50) DEFAULT NULL,
  `post_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 News, 2: Events',
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Default, 1: Pinned_Post'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `web_notice`
--

INSERT INTO `web_notice` (`id`, `title`, `details`, `attachment`, `banner_img`, `expire_date`, `posted_by`, `status`, `remarks`, `post_date`, `type`, `is_pinned`) VALUES
(6, 'Notice Event', '<p>Up Coming</p>\r\n', 'Jellyfish.jpg,Penguins.jpg,Lighthouse.jpg', '', '2017-12-06', '1000001', 1, NULL, '2017-11-29 05:52:30', 2, 0),
(7, 'Notice Test', '<p>Up Coming</p>\r\n', '', '', '0000-00-00', '1000001', 1, NULL, '2017-11-29 06:10:54', 1, 0),
(12, 'Diagnosis Services Center', '<p>Popular Diagnostic Center, Thanthania Bogra.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 'Untitled-1.jpg ', '', '2018-03-23', '1000001', 1, NULL, '2018-03-23 00:36:07', 2, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appuser`
--
ALTER TABLE `appuser`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `con_user_created_by_fk` (`created_by`),
  ADD KEY `con_user_modified_by_fk` (`modified_by`);

--
-- Indexes for table `banner_image`
--
ALTER TABLE `banner_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cupons`
--
ALTER TABLE `cupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_infos`
--
ALTER TABLE `customer_infos`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `custom_cake`
--
ALTER TABLE `custom_cake`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_charge`
--
ALTER TABLE `delivery_charge`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_categories_expense_categories` (`parent_id`);

--
-- Indexes for table `expense_details`
--
ALTER TABLE `expense_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_details_expenses` (`expense_id`),
  ADD KEY `FK_expense_details_expense_heads` (`expense_head_id`);

--
-- Indexes for table `expense_heads`
--
ALTER TABLE `expense_heads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_expense_heads_expense_categories` (`expense_category_id`);

--
-- Indexes for table `external_contact`
--
ALTER TABLE `external_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallary_images`
--
ALTER TABLE `gallary_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gallary_images_image_group` (`album_id`);

--
-- Indexes for table `image_album`
--
ALTER TABLE `image_album`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_master`
--
ALTER TABLE `order_master`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `outlets`
--
ALTER TABLE `outlets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_ingredient`
--
ALTER TABLE `product_ingredient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_rate`
--
ALTER TABLE `product_rate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_review`
--
ALTER TABLE `product_review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_stock`
--
ALTER TABLE `product_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `id_3` (`id`),
  ADD KEY `id_2` (`id`);

--
-- Indexes for table `size`
--
ALTER TABLE `size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group_member`
--
ALTER TABLE `user_group_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Index 2` (`group_id`,`emp_id`),
  ADD KEY `FK_emp_infos` (`emp_id`);

--
-- Indexes for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Index 2` (`group_id`,`action_id`),
  ADD KEY `FK__activity_actions` (`action_id`);

--
-- Indexes for table `user_infos`
--
ALTER TABLE `user_infos`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `web_actions`
--
ALTER TABLE `web_actions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `web_login`
--
ALTER TABLE `web_login`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `web_menu`
--
ALTER TABLE `web_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_web_menu_web_menu` (`parent_menu_id`);

--
-- Indexes for table `web_module`
--
ALTER TABLE `web_module`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `web_notice`
--
ALTER TABLE `web_notice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1_poosted_by` (`posted_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banner_image`
--
ALTER TABLE `banner_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `cupons`
--
ALTER TABLE `cupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customer_infos`
--
ALTER TABLE `customer_infos`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `custom_cake`
--
ALTER TABLE `custom_cake`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `delivery_charge`
--
ALTER TABLE `delivery_charge`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `expense_details`
--
ALTER TABLE `expense_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `expense_heads`
--
ALTER TABLE `expense_heads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `external_contact`
--
ALTER TABLE `external_contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `gallary_images`
--
ALTER TABLE `gallary_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `image_album`
--
ALTER TABLE `image_album`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `order_master`
--
ALTER TABLE `order_master`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `outlets`
--
ALTER TABLE `outlets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_ingredient`
--
ALTER TABLE `product_ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `product_rate`
--
ALTER TABLE `product_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `product_review`
--
ALTER TABLE `product_review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_stock`
--
ALTER TABLE `product_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `size`
--
ALTER TABLE `size`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_group_member`
--
ALTER TABLE `user_group_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=638;

--
-- AUTO_INCREMENT for table `web_actions`
--
ALTER TABLE `web_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `web_menu`
--
ALTER TABLE `web_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `web_module`
--
ALTER TABLE `web_module`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `web_notice`
--
ALTER TABLE `web_notice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appuser`
--
ALTER TABLE `appuser`
  ADD CONSTRAINT `con_user_created_by_fk` FOREIGN KEY (`created_by`) REFERENCES `user_infos` (`emp_id`),
  ADD CONSTRAINT `con_user_modified_by_fk` FOREIGN KEY (`modified_by`) REFERENCES `user_infos` (`emp_id`),
  ADD CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user_infos` (`emp_id`);

--
-- Constraints for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `FK_expense_categories_expense_categories` FOREIGN KEY (`parent_id`) REFERENCES `expense_categories` (`id`);

--
-- Constraints for table `expense_details`
--
ALTER TABLE `expense_details`
  ADD CONSTRAINT `FK_expense_details_expense_heads` FOREIGN KEY (`expense_head_id`) REFERENCES `expense_heads` (`id`),
  ADD CONSTRAINT `FK_expense_details_expenses` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`);

--
-- Constraints for table `expense_heads`
--
ALTER TABLE `expense_heads`
  ADD CONSTRAINT `FK_expense_heads_expense_categories` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`);

--
-- Constraints for table `gallary_images`
--
ALTER TABLE `gallary_images`
  ADD CONSTRAINT `FK_gallary_images_image_album` FOREIGN KEY (`album_id`) REFERENCES `image_album` (`id`);

--
-- Constraints for table `user_group_member`
--
ALTER TABLE `user_group_member`
  ADD CONSTRAINT `FK__user_group` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  ADD CONSTRAINT `FK_emp_infos` FOREIGN KEY (`emp_id`) REFERENCES `user_infos` (`emp_id`);

--
-- Constraints for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  ADD CONSTRAINT `FK__activity_actions` FOREIGN KEY (`action_id`) REFERENCES `web_actions` (`id`),
  ADD CONSTRAINT `FK__user_group_id` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`);

--
-- Constraints for table `web_login`
--
ALTER TABLE `web_login`
  ADD CONSTRAINT `emp_id_fk` FOREIGN KEY (`emp_id`) REFERENCES `user_infos` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `web_menu`
--
ALTER TABLE `web_menu`
  ADD CONSTRAINT `FK_web_menu_web_menu` FOREIGN KEY (`parent_menu_id`) REFERENCES `web_menu` (`id`);

--
-- Constraints for table `web_notice`
--
ALTER TABLE `web_notice`
  ADD CONSTRAINT `FK1_poosted_by` FOREIGN KEY (`posted_by`) REFERENCES `user_infos` (`emp_id`);
--
-- Database: `laravel_cms`
--
CREATE DATABASE IF NOT EXISTS `laravel_cms` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `laravel_cms`;

-- --------------------------------------------------------

--
-- Table structure for table `aSD`
--

CREATE TABLE `aSD` (
  `id` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  `sub_category` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `aSD`
--

INSERT INTO `aSD` (`id`, `category`, `sub_category`) VALUES
(1, 'Education', 'Science;'),
(2, 'Education', 'Commerce'),
(3, 'Education', 'Arts'),
(4, 'Education', 'IELTS/TOFEL'),
(5, 'Education', 'GRE/GMAT'),
(6, 'Education', 'Admission'),
(7, 'Education', 'Govt. Job'),
(8, 'Education', 'Others Job'),
(9, 'Education', 'Literature'),
(10, 'Education', 'Self Development'),
(11, 'Education', 'Skill and Training'),
(12, 'Education', 'Scientific Instrument '),
(13, 'Education', 'Painting and Drawing'),
(14, 'Education', 'Medical Instruments'),
(15, 'Education', 'Engineering Instruments'),
(16, 'Education', 'Others'),
(17, 'Sports', 'Indoor'),
(18, 'Sports', 'Outdoor'),
(19, 'Home Appliances', 'Electronics '),
(20, 'Home Appliances', 'Furnitures'),
(21, 'Home Appliances', 'Others'),
(22, 'Food', ''),
(23, 'Clothes', ''),
(24, 'Others', '');

-- --------------------------------------------------------

--
-- Table structure for table `data`
--

CREATE TABLE `data` (
  `id` int(10) UNSIGNED NOT NULL,
  `devision` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `subordinate` varchar(255) NOT NULL,
  `branch` varchar(255) NOT NULL,
  `post_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `data`
--

INSERT INTO `data` (`id`, `devision`, `district`, `subordinate`, `branch`, `post_code`) VALUES
(1, 'Dhaka', 'Dhaka', 'Demra', 'Demra', 1360),
(2, 'Dhaka', 'Dhaka', 'Demra', 'Sarulia', 1361),
(3, 'Dhaka', 'Dhaka', 'Demra', 'Matuail', 1362),
(4, 'Dhaka', 'Dhaka', 'Dhaka GPO', 'Dhaka GPO', 1000),
(5, 'Dhaka', 'Dhaka', 'Dhaka Main PO', 'Dhaka Main PO', 1100),
(6, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Wari TSO', 1203),
(7, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gendaria TSO', 1204),
(8, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'New Market TSO', 1205),
(9, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhaka CantonmentTSO', 1206),
(10, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mohammadpur Housing', 1207),
(11, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhaka Politechnic', 1208),
(12, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Jigatala TSO', 1209),
(13, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Posta TSO', 1211),
(14, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gulshan Model Town', 1212),
(15, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Banani TSO', 1213),
(16, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Basabo TSO', 1214),
(17, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Tejgaon TSO', 1215),
(18, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Shantinagr TSO', 1217),
(19, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mirpur TSO', 1218),
(20, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilgaonTSO', 1219),
(21, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'BangabhabanTSO', 1222),
(22, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'DilkushaTSO', 1223),
(23, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Sangsad BhabanTSO', 1225),
(24, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilkhetTSO', 1229),
(25, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Uttara Model TwonTSO', 1231),
(26, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhania TSO', 1232),
(27, 'Dhaka', 'Dhaka', 'Dhamrai', 'Dhamrai', 1350),
(28, 'Dhaka', 'Dhaka', 'Dhamrai', 'Kamalpur', 1351),
(29, 'Dhaka', 'Dhaka', 'Joypara', 'Joypara', 1330),
(30, 'Dhaka', 'Dhaka', 'Joypara', 'Palamganj', 1331),
(31, 'Dhaka', 'Dhaka', 'Joypara', 'Narisha', 1332),
(32, 'Dhaka', 'Dhaka', 'Keraniganj', 'Keraniganj', 1310),
(33, 'Dhaka', 'Dhaka', 'Keraniganj', 'Dhaka Jute Mills', 1311),
(34, 'Dhaka', 'Dhaka', 'Keraniganj', 'Ati', 1312),
(35, 'Dhaka', 'Dhaka', 'Keraniganj', 'Kalatia', 1313),
(36, 'Dhaka', 'Dhaka', 'Nawabganj', 'Nawabganj', 1320),
(37, 'Dhaka', 'Dhaka', 'Nawabganj', 'Hasnabad', 1321),
(38, 'Dhaka', 'Dhaka', 'Nawabganj', 'Daudpur', 1322),
(39, 'Dhaka', 'Dhaka', 'Nawabganj', 'Agla', 1323),
(40, 'Dhaka', 'Dhaka', 'Nawabganj', 'Khalpar', 1324),
(41, 'Dhaka', 'Dhaka', 'Nawabganj', 'Churain', 1325),
(42, 'Dhaka', 'Dhaka', 'Savar', 'Savar', 1340),
(43, 'Dhaka', 'Dhaka', 'Savar', 'Dairy Farm', 1341),
(44, 'Dhaka', 'Dhaka', 'Savar', 'Jahangirnagar Univer', 1342),
(45, 'Dhaka', 'Dhaka', 'Savar', 'Saver P.A.T.C', 1343),
(46, 'Dhaka', 'Dhaka', 'Savar', 'Savar Canttonment', 1344),
(47, 'Dhaka', 'Dhaka', 'Savar', 'Shimulia', 1345),
(48, 'Dhaka', 'Dhaka', 'Savar', 'Kashem Cotton Mills', 1346),
(49, 'Dhaka', 'Dhaka', 'Savar', 'Rajphulbaria', 1347),
(50, 'Dhaka', 'Dhaka', 'Savar', 'Amin Bazar', 1348),
(51, 'Dhaka', 'Dhaka', 'Savar', 'EPZ', 1349),
(52, 'Dhaka', 'Mymensingh', 'Bhaluka', 'Bhaluka', 2240),
(53, 'Dhaka', 'Mymensingh', 'Fulbaria', 'Fulbaria', 2216),
(54, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Gaforgaon', 2230),
(55, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Shibganj', 2231),
(56, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Usti', 2232),
(57, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Kandipara', 2233),
(58, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Duttarbazar', 2234),
(59, 'Dhaka', 'Mymensingh', 'Gouripur', 'Gouripur', 2270),
(60, 'Dhaka', 'Mymensingh', 'Gouripur', 'Ramgopalpur', 2271),
(61, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Haluaghat', 2260),
(62, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Dhara', 2261),
(63, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Munshirhat', 2262),
(64, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Isshwargonj', 2280),
(65, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Sohagi', 2281),
(66, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Atharabari', 2282),
(67, 'Dhaka', 'Mymensingh', 'Muktagachha', 'Muktagachha', 2210),
(68, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Mymensingh Sadar', 2200),
(69, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Kawatkhali', 2201),
(70, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Agriculture Universi', 2202),
(71, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Shombhuganj', 2203),
(72, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Biddyaganj', 2204),
(73, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Pearpur', 2205),
(74, 'Dhaka', 'Mymensingh', 'Nandail', 'Nandail', 2290),
(75, 'Dhaka', 'Mymensingh', 'Nandail', 'Gangail', 2291),
(76, 'Dhaka', 'Mymensingh', 'Phulpur', 'Phulpur', 2250),
(77, 'Dhaka', 'Mymensingh', 'Phulpur', 'Beltia', 2251),
(78, 'Dhaka', 'Mymensingh', 'Phulpur', 'Tarakanda', 2252),
(79, 'Dhaka', 'Mymensingh', 'Trishal', 'Trishal', 2220),
(80, 'Dhaka', 'Mymensingh', 'Trishal', 'Ahmadbad', 2221),
(81, 'Dhaka', 'Mymensingh', 'Trishal', 'Ram Amritaganj', 2222),
(82, 'Dhaka', 'Mymensingh', 'Trishal', 'Dhala', 2223),
(83, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Bajitpur', 2336),
(84, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Sararchar', 2337),
(85, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Laksmipur', 2338),
(86, 'Dhaka', 'Kishoreganj', 'Bhairob', 'Bhairab', 2350),
(87, 'Dhaka', 'Kishoreganj', 'Hossenpur', 'Hossenpur', 2320),
(88, 'Dhaka', 'Kishoreganj', 'Itna', 'Itna', 2390),
(89, 'Dhaka', 'Kishoreganj', 'Karimganj', 'Karimganj', 2310),
(90, 'Dhaka', 'Kishoreganj', 'Katiadi', 'Katiadi', 2330),
(91, 'Dhaka', 'Kishoreganj', 'Katiadi', 'Gochhihata', 2331),
(92, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj Sadar', 2300),
(93, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj S.Mills', 2301),
(94, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Maizhati', 2302),
(95, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Nilganj', 2303),
(96, 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Kuliarchar', 2340),
(97, 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Chhoysuti', 2341),
(98, 'Dhaka', 'Kishoreganj', 'Mithamoin', 'MIthamoin', 2370),
(99, 'Dhaka', 'Kishoreganj', 'Mithamoin', 'Abdullahpur', 2371),
(100, 'Dhaka', 'Kishoreganj', 'Nikli', 'Nikli', 2360),
(101, 'Dhaka', 'Kishoreganj', 'Ostagram', 'Ostagram', 2380),
(102, 'Dhaka', 'Kishoreganj', 'Pakundia', 'Pakundia', 2326),
(103, 'Dhaka', 'Kishoreganj', 'Tarial', 'Tarial', 2316),
(104, 'Dhaka', 'Netrakona', 'Susung Durgapur', 'IBH WAs Here', 0),
(105, 'Dhaka', 'Netrakona', 'Susung Durgapur', 'Susnng Durgapur', 2420),
(106, 'Dhaka', 'Netrakona', 'Atpara', 'Atpara', 2470),
(107, 'Dhaka', 'Netrakona', 'Barhatta', 'Barhatta', 2440),
(108, 'Dhaka', 'Netrakona', 'Dharmapasha', 'Dharampasha', 2450),
(109, 'Dhaka', 'Netrakona', 'Dhobaura', 'Dhobaura', 2416),
(110, 'Dhaka', 'Netrakona', 'Dhobaura', 'Sakoai', 2417),
(111, 'Dhaka', 'Netrakona', 'Kalmakanda', 'Kalmakanda', 2430),
(112, 'Dhaka', 'Netrakona', 'Kendua', 'Kendua', 2480),
(113, 'Dhaka', 'Netrakona', 'Khaliajuri', 'Khaliajhri', 2460),
(114, 'Dhaka', 'Netrakona', 'Khaliajuri', 'Shaldigha', 2462),
(115, 'Dhaka', 'Netrakona', 'Madan', 'Madan', 2490),
(116, 'Dhaka', 'Netrakona', 'Moddhynagar', 'Moddoynagar', 2456),
(117, 'Dhaka', 'Netrakona', 'Mohanganj', 'Mohanganj', 2446),
(118, 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Netrakona Sadar', 2400),
(119, 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Baikherhati', 2401),
(120, 'Dhaka', 'Netrakona', 'Purbadhola', 'Purbadhola', 2410),
(121, 'Dhaka', 'Netrakona', 'Purbadhola', 'Shamgonj', 2411),
(122, 'Dhaka', 'Netrakona', 'Purbadhola', 'Jaria Jhanjhail', 2412),
(123, 'Dhaka', 'Narayanganj', 'Araihazar', 'Araihazar', 1450),
(124, 'Dhaka', 'Narayanganj', 'Araihazar', 'Gopaldi', 1451),
(125, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Baidder Bazar', 1440),
(126, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Bara Nagar', 1441),
(127, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Barodi', 1442),
(128, 'Dhaka', 'Narayanganj', 'Bandar', 'Bandar', 1410),
(129, 'Dhaka', 'Narayanganj', 'Bandar', 'D.C Mills', 1411),
(130, 'Dhaka', 'Narayanganj', 'Bandar', 'Nabiganj', 1412),
(131, 'Dhaka', 'Narayanganj', 'Bandar', 'BIDS', 1413),
(132, 'Dhaka', 'Narayanganj', 'Bandar', 'Madanganj', 1414),
(133, 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatullah', 1420),
(134, 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatulla Bazar', 1421),
(135, 'Dhaka', 'Narayanganj', 'Narayanganj Sadar', 'Narayanganj Sadar', 1400),
(136, 'Dhaka', 'Narayanganj', 'Rupganj', 'Rupganj', 1460),
(137, 'Dhaka', 'Narayanganj', 'Rupganj', 'Kanchan', 1461),
(138, 'Dhaka', 'Narayanganj', 'Rupganj', 'Bhulta', 1462),
(139, 'Dhaka', 'Narayanganj', 'Rupganj', 'Nagri', 1463),
(140, 'Dhaka', 'Narayanganj', 'Rupganj', 'Murapara', 1464),
(141, 'Dhaka', 'Narayanganj', 'Siddirganj', 'Siddirganj', 1430),
(142, 'Dhaka', 'Narayanganj', 'Siddirganj', 'Adamjeenagar', 1431),
(143, 'Dhaka', 'Narayanganj', 'Siddirganj', 'LN Mills', 1432),
(144, 'Dhaka', 'Munshiganj', 'Gajaria', 'Gajaria', 1510),
(145, 'Dhaka', 'Munshiganj', 'Gajaria', 'Hossendi', 1511),
(146, 'Dhaka', 'Munshiganj', 'Gajaria', 'Rasulpur', 1512),
(147, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haridia', 1333),
(148, 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', 1334),
(149, 'Dhaka', 'Munshiganj', 'Lohajong', 'Madini Mandal', 1335),
(150, 'Dhaka', 'Munshiganj', 'Lohajong', 'Lohajang', 1530),
(151, 'Dhaka', 'Munshiganj', 'Lohajong', 'Korhati', 1531),
(152, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haldia SO', 1532),
(153, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haridia DESO', 1533),
(154, 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', 1534),
(155, 'Dhaka', 'Munshiganj', 'Lohajong', 'Medini Mandal EDSO', 1535),
(156, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Munshiganj Sadar', 1500),
(157, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Rikabibazar', 1501),
(158, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Mirkadim', 1502),
(159, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Kathakhali', 1503),
(160, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Sirajdikhan', 1540),
(161, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Kola', 1541),
(162, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Ichapur', 1542),
(163, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Malkha Nagar', 1543),
(164, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Shekher Nagar', 1544),
(165, 'Dhaka', 'Munshiganj', 'Srinagar', 'Srinagar', 1550),
(166, 'Dhaka', 'Munshiganj', 'Srinagar', 'Barikhal', 1551),
(167, 'Dhaka', 'Munshiganj', 'Srinagar', 'Mazpara', 1552),
(168, 'Dhaka', 'Munshiganj', 'Srinagar', 'Hashara', 1553),
(169, 'Dhaka', 'Munshiganj', 'Srinagar', 'Kolapara', 1554),
(170, 'Dhaka', 'Munshiganj', 'Srinagar', 'Kumarbhog', 1555),
(171, 'Dhaka', 'Munshiganj', 'Srinagar', 'Vaggyakul SO', 1556),
(172, 'Dhaka', 'Munshiganj', 'Srinagar', 'Baghra', 1557),
(173, 'Dhaka', 'Munshiganj', 'Srinagar', 'Bhaggyakul', 1558),
(174, 'Dhaka', 'Munshiganj', 'Tangibari', 'Tangibari', 1520),
(175, 'Dhaka', 'Munshiganj', 'Tangibari', 'Betkahat', 1521),
(176, 'Dhaka', 'Munshiganj', 'Tangibari', 'Baligao', 1522),
(177, 'Dhaka', 'Munshiganj', 'Tangibari', 'Bajrajugini', 1523),
(178, 'Dhaka', 'Munshiganj', 'Tangibari', 'Hasail', 1524),
(179, 'Dhaka', 'Munshiganj', 'Tangibari', 'Dighirpar', 1525),
(180, 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura EDSO', 1526),
(181, 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura', 1527),
(182, 'Dhaka', 'Narshingdi', 'Belabo', 'Belabo', 1640),
(183, 'Dhaka', 'Narshingdi', 'Monohordi', 'Monohordi', 1650),
(184, 'Dhaka', 'Narshingdi', 'Monohordi', 'Hatirdia', 1651),
(185, 'Dhaka', 'Narshingdi', 'Monohordi', 'Katabaria', 1652),
(186, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi Sadar', 1600),
(187, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'UMC Jute Mills', 1601),
(188, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi College', 1602),
(189, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Panchdona', 1603),
(190, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Madhabdi', 1604),
(191, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Karimpur', 1605),
(192, 'Dhaka', 'Narshingdi', 'Palash', 'Palash', 1610),
(193, 'Dhaka', 'Narshingdi', 'Palash', 'Ghorashal Urea Facto', 1611),
(194, 'Dhaka', 'Narshingdi', 'Palash', 'Char Sindhur', 1612),
(195, 'Dhaka', 'Narshingdi', 'Palash', 'Ghorashal', 1613),
(196, 'Dhaka', 'Narshingdi', 'Raypura', 'Raypura', 1630),
(197, 'Dhaka', 'Narshingdi', 'Raypura', 'Bazar Hasnabad', 1631),
(198, 'Dhaka', 'Narshingdi', 'Raypura', 'Radhaganj bazar', 1632),
(199, 'Dhaka', 'Narshingdi', 'Shibpur', 'Shibpur', 1620),
(200, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Gazipur Sadar', 1700),
(201, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'B.R.R', 1701),
(202, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Chandna', 1702),
(203, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'B.O.F', 1703),
(204, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'National University', 1704),
(205, 'Dhaka', 'Gazipur', 'Kaliakaar', 'Kaliakaar', 1750),
(206, 'Dhaka', 'Gazipur', 'Kaliakaar', 'Safipur', 1751),
(207, 'Dhaka', 'Gazipur', 'Kaliganj', 'Kaliganj', 1720),
(208, 'Dhaka', 'Gazipur', 'Kaliganj', 'Pubail', 1721),
(209, 'Dhaka', 'Gazipur', 'Kaliganj', 'Santanpara', 1722),
(210, 'Dhaka', 'Gazipur', 'Kaliganj', 'Vaoal Jamalpur', 1723),
(211, 'Dhaka', 'Gazipur', 'Kapashia', 'kapashia', 1730),
(212, 'Dhaka', 'Gazipur', 'Monnunagar', 'Monnunagar', 1710),
(213, 'Dhaka', 'Gazipur', 'Monnunagar', 'Nishat Nagar', 1711),
(214, 'Dhaka', 'Gazipur', 'Monnunagar', 'Ershad Nagar', 1712),
(215, 'Dhaka', 'Gazipur', 'Sreepur', 'Sreepur', 1740),
(216, 'Dhaka', 'Gazipur', 'Sreepur', 'Barmi', 1743),
(217, 'Dhaka', 'Gazipur', 'Sreepur', 'Satkhamair', 1744),
(218, 'Dhaka', 'Gazipur', 'Sreepur', 'Kawraid', 1745),
(219, 'Dhaka', 'Gazipur', 'Sreepur', 'Bashamur', 1747),
(220, 'Dhaka', 'Gazipur', 'Sreepur', 'Boubi', 1748),
(221, 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur', 1741),
(222, 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur Canttome', 1742),
(223, 'Dhaka', 'Rajbari', 'Baliakandi', 'Baliakandi', 7730),
(224, 'Dhaka', 'Rajbari', 'Baliakandi', 'Nalia', 7731),
(225, 'Dhaka', 'Rajbari', 'Pangsha', 'Pangsha', 7720),
(226, 'Dhaka', 'Rajbari', 'Pangsha', 'Ramkol', 7721),
(227, 'Dhaka', 'Rajbari', 'Pangsha', 'Ratandia', 7722),
(228, 'Dhaka', 'Rajbari', 'Pangsha', 'Mrigibazar', 7723),
(229, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Rajbari Sadar', 7700),
(230, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Goalanda', 7710),
(231, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Khankhanapur', 7711),
(232, 'Dhaka', 'Faridpur', 'Alfadanga', 'Alfadanga', 7870),
(233, 'Dhaka', 'Faridpur', 'Bhanga', 'Bhanga', 7830),
(234, 'Dhaka', 'Faridpur', 'Boalmari', 'Boalmari', 7860),
(235, 'Dhaka', 'Faridpur', 'Boalmari', 'Rupatpat', 7861),
(236, 'Dhaka', 'Faridpur', 'Charbhadrasan', 'Charbadrashan', 7810),
(237, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Faridpursadar', 7800),
(238, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Kanaipur', 7801),
(239, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Ambikapur', 7802),
(240, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Baitulaman Politecni', 7803),
(241, 'Dhaka', 'Faridpur', 'Madukhali', 'Madukhali', 7850),
(242, 'Dhaka', 'Faridpur', 'Madukhali', 'Kamarkali', 7851),
(243, 'Dhaka', 'Faridpur', 'Nagarkanda', 'Nagarkanda', 7840),
(244, 'Dhaka', 'Faridpur', 'Nagarkanda', 'Talma', 7841),
(245, 'Dhaka', 'Faridpur', 'Sadarpur', 'Sadarpur', 7820),
(246, 'Dhaka', 'Faridpur', 'Sadarpur', 'Hat Krishapur', 7821),
(247, 'Dhaka', 'Faridpur', 'Sadarpur', 'Bishwa jaker Manjil', 7822),
(248, 'Dhaka', 'Faridpur', 'Shriangan', 'Shriangan', 7804),
(249, 'Dhaka', 'Madaripur', 'Barhamganj', 'Barhamganj', 7930),
(250, 'Dhaka', 'Madaripur', 'Barhamganj', 'Nilaksmibandar', 7931),
(251, 'Dhaka', 'Madaripur', 'Barhamganj', 'Bahadurpur', 7932),
(252, 'Dhaka', 'Madaripur', 'Barhamganj', 'Umedpur', 7933),
(253, 'Dhaka', 'Madaripur', 'kalkini', 'Kalkini', 7920),
(254, 'Dhaka', 'Madaripur', 'kalkini', 'Sahabrampur', 7921),
(255, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Madaripur Sadar', 7900),
(256, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Charmugria', 7901),
(257, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Kulpaddi', 7902),
(258, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Habiganj', 7903),
(259, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Mustafapur', 7904),
(260, 'Dhaka', 'Madaripur', 'Rajoir', 'Rajoir', 7910),
(261, 'Dhaka', 'Madaripur', 'Rajoir', 'Khalia', 7911),
(262, 'Dhaka', 'Shariatpur', 'Bhedorganj', 'Bhedorganj', 8030),
(263, 'Dhaka', 'Shariatpur', 'Damudhya', 'Damudhya', 8040),
(264, 'Dhaka', 'Shariatpur', 'Gosairhat', 'Gosairhat', 8050),
(265, 'Dhaka', 'Shariatpur', 'Jajira', 'Jajira', 8010),
(266, 'Dhaka', 'Shariatpur', 'Naria', 'Naria', 8020),
(267, 'Dhaka', 'Shariatpur', 'Naria', 'Bhozeshwar', 8021),
(268, 'Dhaka', 'Shariatpur', 'Naria', 'Gharisar', 8022),
(269, 'Dhaka', 'Shariatpur', 'Naria', 'Upshi', 8023),
(270, 'Dhaka', 'Shariatpur', 'Naria', 'Kartikpur', 8024),
(271, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Shariatpur Sadar', 8000),
(272, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Angaria', 8001),
(273, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Chikandi', 8002),
(274, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Chandradighalia', 8013),
(275, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Gopalganj Sadar', 8100),
(276, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Ulpur', 8101),
(277, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Barfa', 8102),
(278, 'Dhaka', 'Gopalganj', 'Kashiani', 'Kashiani', 8130),
(279, 'Dhaka', 'Gopalganj', 'Kashiani', 'Ramdia College', 8131),
(280, 'Dhaka', 'Gopalganj', 'Kashiani', 'Ratoil', 8132),
(281, 'Dhaka', 'Gopalganj', 'Kashiani', 'Jonapur', 8133),
(282, 'Dhaka', 'Gopalganj', 'Kotalipara', 'Kotalipara', 8110),
(283, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Maksudpur', 8140),
(284, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Batkiamari', 8141),
(285, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Khandarpara', 8142),
(286, 'Dhaka', 'Gopalganj', 'Tungipara', 'Tungipara', 8120),
(287, 'Dhaka', 'Gopalganj', 'Tungipara', 'Patgati', 8121),
(288, 'Dhaka', 'Manikganj', 'Doulatpur', 'Doulatpur', 1860),
(289, 'Dhaka', 'Manikganj', 'Gheor', 'Gheor', 1840),
(290, 'Dhaka', 'Manikganj', 'Lechhraganj', 'Lechhraganj', 1830),
(291, 'Dhaka', 'Manikganj', 'Lechhraganj', 'Jhitka', 1831),
(292, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Sadar', 1800),
(293, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Bazar', 1801),
(294, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Gorpara', 1802),
(295, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Mahadebpur', 1803),
(296, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Barangail', 1804),
(297, 'Dhaka', 'Manikganj', 'Saturia', 'Saturia', 1810),
(298, 'Dhaka', 'Manikganj', 'Saturia', 'Baliati', 1811),
(299, 'Dhaka', 'Manikganj', 'Shibloya', 'Shibaloy', 1850),
(300, 'Dhaka', 'Manikganj', 'Shibloya', 'Aricha', 1851),
(301, 'Dhaka', 'Manikganj', 'Shibloya', 'Tewta', 1852),
(302, 'Dhaka', 'Manikganj', 'Shibloya', 'Uthli', 1853),
(303, 'Dhaka', 'Manikganj', 'Singari', 'Singair', 1820),
(304, 'Dhaka', 'Manikganj', 'Singari', 'Baira', 1821),
(305, 'Dhaka', 'Manikganj', 'Singari', 'joymantop', 1822),
(306, 'Dhaka', 'Tangail', 'Basail', 'Basail', 1920),
(307, 'Dhaka', 'Tangail', 'Bhuapur', 'Bhuapur', 1960),
(308, 'Dhaka', 'Tangail', 'Delduar', 'Delduar', 1910),
(309, 'Dhaka', 'Tangail', 'Delduar', 'Jangalia', 1911),
(310, 'Dhaka', 'Tangail', 'Delduar', 'Patharail', 1912),
(311, 'Dhaka', 'Tangail', 'Delduar', 'Elasin', 1913),
(312, 'Dhaka', 'Tangail', 'Delduar', 'Hinga Nagar', 1914),
(313, 'Dhaka', 'Tangail', 'Delduar', 'Lowhati', 1915),
(314, 'Dhaka', 'Tangail', 'Ghatail', 'Ghatial', 1980),
(315, 'Dhaka', 'Tangail', 'Ghatail', 'Zahidganj', 1981),
(316, 'Dhaka', 'Tangail', 'Ghatail', 'D. Pakutia', 1982),
(317, 'Dhaka', 'Tangail', 'Ghatail', 'Dhalapara', 1983),
(318, 'Dhaka', 'Tangail', 'Ghatail', 'Lohani', 1984),
(319, 'Dhaka', 'Tangail', 'Gopalpur', 'Gopalpur', 1990),
(320, 'Dhaka', 'Tangail', 'Gopalpur', 'Jhowail', 1991),
(321, 'Dhaka', 'Tangail', 'Gopalpur', 'Hemnagar', 1992),
(322, 'Dhaka', 'Tangail', 'Kalihati', 'Kalihati', 1970),
(323, 'Dhaka', 'Tangail', 'Kalihati', 'Rajafair', 1971),
(324, 'Dhaka', 'Tangail', 'Kalihati', 'Nagbari', 1972),
(325, 'Dhaka', 'Tangail', 'Kalihati', 'Ballabazar', 1973),
(326, 'Dhaka', 'Tangail', 'Kalihati', 'Elinga', 1974),
(327, 'Dhaka', 'Tangail', 'Kalihati', 'Palisha', 1975),
(328, 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari SO', 1976),
(329, 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari', 1977),
(330, 'Dhaka', 'Tangail', 'Kashkaolia', 'Kashkawlia', 1930),
(331, 'Dhaka', 'Tangail', 'Madhupur', 'Madhupur', 1996),
(332, 'Dhaka', 'Tangail', 'Madhupur', 'Dhobari', 1997),
(333, 'Dhaka', 'Tangail', 'Mirzapur', 'Mirzapur', 1940),
(334, 'Dhaka', 'Tangail', 'Mirzapur', 'Gorai', 1941),
(335, 'Dhaka', 'Tangail', 'Mirzapur', 'M.C. College', 1942),
(336, 'Dhaka', 'Tangail', 'Mirzapur', 'Warri paikpara', 1943),
(337, 'Dhaka', 'Tangail', 'Mirzapur', 'Jarmuki', 1944),
(338, 'Dhaka', 'Tangail', 'Mirzapur', 'Mohera', 1945),
(339, 'Dhaka', 'Tangail', 'Nagarpur', 'Nagarpur', 1936),
(340, 'Dhaka', 'Tangail', 'Nagarpur', 'Dhuburia', 1937),
(341, 'Dhaka', 'Tangail', 'Nagarpur', 'Salimabad', 1938),
(342, 'Dhaka', 'Tangail', 'Sakhipur', 'Sakhipur', 1950),
(343, 'Dhaka', 'Tangail', 'Sakhipur', 'Kochua', 1951),
(344, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Tangail Sadar', 1900),
(345, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Kagmari', 1901),
(346, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Santosh', 1902),
(347, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Korotia', 1903),
(348, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Purabari', 1904),
(349, 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj', 2030),
(350, 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj S. Mills', 2031),
(351, 'Dhaka', 'Jamalpur', 'Islampur', 'Islampur', 2020),
(352, 'Dhaka', 'Jamalpur', 'Islampur', 'Durmoot', 2021),
(353, 'Dhaka', 'Jamalpur', 'Islampur', 'Gilabari', 2022),
(354, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Jamalpur', 2000),
(355, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Nandina', 2001),
(356, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Narundi', 2002),
(357, 'Dhaka', 'Jamalpur', 'Malandah', 'Malandah', 2010),
(358, 'Dhaka', 'Jamalpur', 'Malandah', 'Jamalpur', 2011),
(359, 'Dhaka', 'Jamalpur', 'Malandah', 'Malancha', 2012),
(360, 'Dhaka', 'Jamalpur', 'Malandah', 'Mahmoodpur', 2013),
(361, 'Dhaka', 'Jamalpur', 'Mathargonj', 'Mathargonj', 2040),
(362, 'Dhaka', 'Jamalpur', 'Mathargonj', 'Balijhuri', 2041),
(363, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Shorishabari', 2050),
(364, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Gunerbari', 2051),
(365, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Bausee', 2052),
(366, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jagannath Ghat', 2053),
(367, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Pingna', 2054),
(368, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jamuna Sar Karkhana', 2055),
(369, 'Dhaka', 'Sherpur', 'Bakshigonj', 'Bakshigonj', 2140),
(370, 'Dhaka', 'Sherpur', 'Jhinaigati', 'Jhinaigati', 2120),
(371, 'Dhaka', 'Sherpur', 'Nakla', 'Nakla', 2150),
(372, 'Dhaka', 'Sherpur', 'Nakla', 'Gonopaddi', 2151),
(373, 'Dhaka', 'Sherpur', 'Nalitabari', 'Nalitabari', 2110),
(374, 'Dhaka', 'Sherpur', 'Nalitabari', 'Hatibandha', 2111),
(375, 'Dhaka', 'Sherpur', 'Sherpur Shadar', 'Sherpur Shadar', 2100),
(376, 'Dhaka', 'Sherpur', 'Shribardi', 'Shribardi', 2130),
(377, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Akhaura', 3450),
(378, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Azampur', 3451),
(379, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Gangasagar', 3452),
(380, 'Chittagong ', 'Brahmanbaria', 'Banchharampur', 'Banchharampur', 3420),
(381, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Brahamanbaria Sadar', 3400),
(382, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Talshahar', 3401),
(383, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj', 3402),
(384, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj Share', 3403),
(385, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Poun', 3404),
(386, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kasba', 3460),
(387, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kuti', 3461),
(388, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chandidar', 3462),
(389, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chargachh', 3463),
(390, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Gopinathpur', 3464),
(391, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Nabinagar', 3410),
(392, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Laubfatehpur', 3411),
(393, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Rasullabad', 3412),
(394, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shamgram', 3413),
(395, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Ratanpur', 3414),
(396, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shahapur', 3415),
(397, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Kaitala', 3417),
(398, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Salimganj', 3418),
(399, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Jibanganj', 3419),
(400, 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Nasirnagar', 3440),
(401, 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Fandauk', 3441),
(402, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Sarial', 3430),
(403, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Shahbajpur', 3431),
(404, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Chandura', 3432),
(405, 'Chittagong ', 'Comilla', 'Barura', 'Barura', 3560),
(406, 'Chittagong ', 'Comilla', 'Barura', 'Poyalgachha', 3561),
(407, 'Chittagong ', 'Comilla', 'Barura', 'Murdafarganj', 3562),
(408, 'Chittagong ', 'Comilla', 'Brahmanpara', 'Brahmanpara', 3526),
(409, 'Chittagong ', 'Comilla', 'Burichang', 'Burichang', 3520),
(410, 'Chittagong ', 'Comilla', 'Burichang', 'Maynamoti bazar', 3521),
(411, 'Chittagong ', 'Comilla', 'Chandina', 'Chandia', 3510),
(412, 'Chittagong ', 'Comilla', 'Chandina', 'Madhaiabazar', 3511),
(413, 'Chittagong ', 'Comilla', 'Chouddagram', 'Chouddagram', 3550),
(414, 'Chittagong ', 'Comilla', 'Chouddagram', 'Batisa', 3551),
(415, 'Chittagong ', 'Comilla', 'Chouddagram', 'Chiora', 3552),
(416, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Sadar', 3500),
(417, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Contoment', 3501),
(418, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Halimanagar', 3502),
(419, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Courtbari', 3503),
(420, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Suaganj', 3504),
(421, 'Chittagong ', 'Comilla', 'Daudkandi', 'Daudkandi', 3516),
(422, 'Chittagong ', 'Comilla', 'Daudkandi', 'Gouripur', 3517),
(423, 'Chittagong ', 'Comilla', 'Daudkandi', 'Dashpara', 3518),
(424, 'Chittagong ', 'Comilla', 'Daudkandi', 'Eliotganj', 3519),
(425, 'Chittagong ', 'Comilla', 'Davidhar', 'Davidhar', 3530),
(426, 'Chittagong ', 'Comilla', 'Davidhar', 'Gangamandal', 3531),
(427, 'Chittagong ', 'Comilla', 'Davidhar', 'Barashalghar', 3532),
(428, 'Chittagong ', 'Comilla', 'Davidhar', 'Dhamtee', 3533),
(429, 'Chittagong ', 'Comilla', 'Homna', 'Homna', 3546),
(430, 'Chittagong ', 'Comilla', 'Laksam', 'Laksam', 3570),
(431, 'Chittagong ', 'Comilla', 'Laksam', 'Lakshamanpur', 3571),
(432, 'Chittagong ', 'Comilla', 'Laksam', 'Bipulasar', 3572),
(433, 'Chittagong ', 'Comilla', 'Langalkot', 'Langalkot', 3580),
(434, 'Chittagong ', 'Comilla', 'Langalkot', 'Dhalua', 3581),
(435, 'Chittagong ', 'Comilla', 'Langalkot', 'Chhariabazar', 3582),
(436, 'Chittagong ', 'Comilla', 'Langalkot', 'Gunabati', 3583),
(437, 'Chittagong ', 'Comilla', 'Muradnagar', 'Muradnagar', 3540),
(438, 'Chittagong ', 'Comilla', 'Muradnagar', 'Ramchandarpur', 3541),
(439, 'Chittagong ', 'Comilla', 'Muradnagar', 'Companyganj', 3542),
(440, 'Chittagong ', 'Comilla', 'Muradnagar', 'Bangra', 3543),
(441, 'Chittagong ', 'Comilla', 'Muradnagar', 'Sonakanda', 3544),
(442, 'Chittagong ', 'Comilla', 'Muradnagar', 'Pantibazar', 3545),
(443, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Char Alexgander', 3730),
(444, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Hajirghat', 3731),
(445, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Ramgatirhat', 3732),
(446, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Lakshimpur Sadar', 3700),
(447, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Dalal Bazar', 3701),
(448, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Bhabaniganj', 3702),
(449, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Mandari', 3703),
(450, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Keramatganj', 3704),
(451, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Rupchara', 3705),
(452, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Duttapara', 3706),
(453, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Choupalli', 3707),
(454, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Chandraganj', 3708),
(455, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Amani Lakshimpur', 3709),
(456, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Ramganj', 3720),
(457, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Alipur', 3721),
(458, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Panpara', 3722),
(459, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Kanchanpur', 3723),
(460, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Naagmud', 3724),
(461, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Dolta', 3725),
(462, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Raypur', 3710),
(463, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Rakhallia', 3711),
(464, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Nagerdighirpar', 3712),
(465, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Haydarganj', 3713),
(466, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Bhuabari', 3714),
(467, 'Chittagong ', 'Noakhali', 'Basurhat', 'Basur Hat', 3850),
(468, 'Chittagong ', 'Noakhali', 'Basurhat', 'Charhajari', 3851),
(469, 'Chittagong ', 'Noakhali', 'Begumganj', 'Begumganj', 3820),
(470, 'Chittagong ', 'Noakhali', 'Begumganj', 'Choumohani', 3821),
(471, 'Chittagong ', 'Noakhali', 'Begumganj', 'Banglabazar', 3822),
(472, 'Chittagong ', 'Noakhali', 'Begumganj', 'Mir Owarishpur', 3823),
(473, 'Chittagong ', 'Noakhali', 'Begumganj', 'Bazra', 3824),
(474, 'Chittagong ', 'Noakhali', 'Begumganj', 'Jamidar Hat', 3825),
(475, 'Chittagong ', 'Noakhali', 'Begumganj', 'Sonaimuri', 3827),
(476, 'Chittagong ', 'Noakhali', 'Begumganj', 'Gopalpur', 3828),
(477, 'Chittagong ', 'Noakhali', 'Begumganj', 'Joynarayanpur', 3829),
(478, 'Chittagong ', 'Noakhali', 'Begumganj', 'Alaiarpur', 3831),
(479, 'Chittagong ', 'Noakhali', 'Begumganj', 'Tangirpar', 3832),
(480, 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalafat Bazar', 3833),
(481, 'Chittagong ', 'Noakhali', 'Begumganj', 'Rajganj', 3834),
(482, 'Chittagong ', 'Noakhali', 'Begumganj', 'Oachhekpur', 3835),
(483, 'Chittagong ', 'Noakhali', 'Begumganj', 'Bhabani Jibanpur', 3837),
(484, 'Chittagong ', 'Noakhali', 'Begumganj', 'Maheshganj', 3838),
(485, 'Chittagong ', 'Noakhali', 'Begumganj', 'Nadona', 3839),
(486, 'Chittagong ', 'Noakhali', 'Begumganj', 'Nandiapara', 3841),
(487, 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalishpur', 3842),
(488, 'Chittagong ', 'Noakhali', 'Begumganj', 'Dauti', 3843),
(489, 'Chittagong ', 'Noakhali', 'Begumganj', 'Joyag', 3844),
(490, 'Chittagong ', 'Noakhali', 'Begumganj', 'Thanar Hat', 3845),
(491, 'Chittagong ', 'Noakhali', 'Begumganj', 'Amisha Para', 3847),
(492, 'Chittagong ', 'Noakhali', 'Begumganj', 'Durgapur', 3848),
(493, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Chatkhil', 3870),
(494, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Palla', 3871),
(495, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Khilpara', 3872),
(496, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bodalcourt', 3873),
(497, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Rezzakpur', 3874),
(498, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Solla', 3875),
(499, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Karihati', 3877),
(500, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Dosh Gharia', 3878),
(501, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bansa Bazar', 3879),
(502, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sahapur', 3881),
(503, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sampara', 3882),
(504, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Shingbahura', 3883),
(505, 'Chittagong ', 'Noakhali', 'Hatiya', 'Hatiya', 3890),
(506, 'Chittagong ', 'Noakhali', 'Hatiya', 'Afazia', 3891),
(507, 'Chittagong ', 'Noakhali', 'Hatiya', 'Tamoraddi', 3892),
(508, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali Sadar', 3800),
(509, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali College', 3801),
(510, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Sonapur', 3802),
(511, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Din Monir Hat', 3803),
(512, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Pak Kishoreganj', 3804),
(513, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Mriddarhat', 3806),
(514, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Kabirhat', 3807),
(515, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Khalifar Hat', 3808),
(516, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Charam Tua', 3809),
(517, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Chaprashir Hat', 3811),
(518, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Char Jabbar', 3812),
(519, 'Chittagong ', 'Noakhali', 'Senbag', 'Senbag', 3860),
(520, 'Chittagong ', 'Noakhali', 'Senbag', 'Kallyandi', 3861),
(521, 'Chittagong ', 'Noakhali', 'Senbag', 'Beezbag', 3862),
(522, 'Chittagong ', 'Noakhali', 'Senbag', 'Kankirhat', 3863),
(523, 'Chittagong ', 'Noakhali', 'Senbag', 'Chatarpaia', 3864),
(524, 'Chittagong ', 'Noakhali', 'Senbag', 'T.P. Lamua', 3865),
(525, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Chhagalnaia', 3910),
(526, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Maharajganj', 3911),
(527, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Daraga Hat', 3912),
(528, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Puabashimulia', 3913),
(529, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dagondhuia', 3920),
(530, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dudmukha', 3921),
(531, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Chhilonia', 3922),
(532, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Rajapur', 3923),
(533, 'Chittagong ', 'Feni', 'Feni Sadar', 'Feni Sadar', 3900),
(534, 'Chittagong ', 'Feni', 'Feni Sadar', 'Fazilpur', 3901),
(535, 'Chittagong ', 'Feni', 'Feni Sadar', 'Sharshadie', 3902),
(536, 'Chittagong ', 'Feni', 'Feni Sadar', 'Laskarhat', 3903),
(537, 'Chittagong ', 'Feni', 'Pashurampur', 'Pashurampur', 3940),
(538, 'Chittagong ', 'Feni', 'Pashurampur', 'Shuarbazar', 3941),
(539, 'Chittagong ', 'Feni', 'Pashurampur', 'Fulgazi', 3942),
(540, 'Chittagong ', 'Feni', 'Pashurampur', 'Munshirhat', 3943),
(541, 'Chittagong ', 'Feni', 'Sonagazi', 'Sonagazi', 3930),
(542, 'Chittagong ', 'Feni', 'Sonagazi', 'Motiganj', 3931),
(543, 'Chittagong ', 'Feni', 'Sonagazi', 'Ahmadpur', 3932),
(544, 'Chittagong ', 'Feni', 'Sonagazi', 'Kazirhat', 3933),
(545, 'Chittagong ', 'Chittagong', 'Anawara', 'Anowara', 4376),
(546, 'Chittagong ', 'Chittagong', 'Anawara', 'Paroikora', 4377),
(547, 'Chittagong ', 'Chittagong', 'Anawara', 'Battali', 4378),
(548, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kanungopara', 4363),
(549, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Saroatoli', 4364),
(550, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Iqbal Park', 4365),
(551, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Boalkhali', 4366),
(552, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Sakpura', 4367),
(553, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kadurkhal', 4368),
(554, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Charandwip', 4369),
(555, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong GPO', 4000),
(556, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Bandar', 4100),
(557, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Pahartoli', 4202),
(558, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chawkbazar', 4203),
(559, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Patenga', 4204),
(560, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Airport', 4205),
(561, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Jaldia Merine Accade', 4206),
(562, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Firozshah', 4207),
(563, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Mohard', 4208),
(564, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Politechnic In', 4209),
(565, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Bayezid Bostami', 4210),
(566, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Amin Jute Mills', 4211),
(567, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chandgaon', 4212),
(568, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Wazedia', 4213),
(569, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Jalalabad', 4214),
(570, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Anandabazar', 4215),
(571, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishahar', 4216),
(572, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Katuli', 4217),
(573, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Sailers Colon', 4218),
(574, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Customs Acca', 4219),
(575, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Cantonment', 4220),
(576, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Al- Amin Baria Madra', 4221),
(577, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Middle Patenga', 4222),
(578, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Export Processing', 4223),
(579, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Rampura TSO', 4224),
(580, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishshar', 4225),
(581, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Halishahar', 4226),
(582, 'Chittagong ', 'Chittagong', 'East Joara', 'East Joara', 4380),
(583, 'Chittagong ', 'Chittagong', 'East Joara', 'Gachbaria', 4381),
(584, 'Chittagong ', 'Chittagong', 'East Joara', 'Dohazari', 4382),
(585, 'Chittagong ', 'Chittagong', 'East Joara', 'Barma', 4383),
(586, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Fatikchhari', 4350),
(587, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Nanupur', 4351),
(588, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Bhandar Sharif', 4352),
(589, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Najirhat', 4353),
(590, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Harualchhari', 4354),
(591, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Narayanhat', 4355),
(592, 'Chittagong ', 'Chittagong', 'Hathazari', 'Hathazari', 4330),
(593, 'Chittagong ', 'Chittagong', 'Hathazari', 'Chitt.University', 4331),
(594, 'Chittagong ', 'Chittagong', 'Hathazari', 'Gorduara', 4332),
(595, 'Chittagong ', 'Chittagong', 'Hathazari', 'Katirhat', 4333),
(596, 'Chittagong ', 'Chittagong', 'Hathazari', 'Mirzapur', 4334),
(597, 'Chittagong ', 'Chittagong', 'Hathazari', 'Fatahabad', 4335),
(598, 'Chittagong ', 'Chittagong', 'Hathazari', 'Nuralibari', 4337),
(599, 'Chittagong ', 'Chittagong', 'Hathazari', 'Yunus Nagar', 4338),
(600, 'Chittagong ', 'Chittagong', 'Hathazari', 'Madrasa', 4339),
(601, 'Chittagong ', 'Chittagong', 'Jaldi', 'Jaldi', 4390),
(602, 'Chittagong ', 'Chittagong', 'Jaldi', 'Khan Bahadur', 4391),
(603, 'Chittagong ', 'Chittagong', 'Jaldi', 'Gunagari', 4392),
(604, 'Chittagong ', 'Chittagong', 'Jaldi', 'Banigram', 4393),
(605, 'Chittagong ', 'Chittagong', 'Lohagara', 'Lohagara', 4396),
(606, 'Chittagong ', 'Chittagong', 'Lohagara', 'Padua', 4397),
(607, 'Chittagong ', 'Chittagong', 'Lohagara', 'Chunti', 4398),
(608, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mirsharai', 4320),
(609, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Abutorab', 4321),
(610, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Darrogahat', 4322),
(611, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Bharawazhat', 4323),
(612, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Joarganj', 4324),
(613, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Azampur', 4325),
(614, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Korerhat', 4327),
(615, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mohazanhat', 4328),
(616, 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Patia Head Office', 4370),
(617, 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Budhpara', 4371),
(618, 'Chittagong ', 'Chittagong', 'Rangunia', 'Rangunia', 4360),
(619, 'Chittagong ', 'Chittagong', 'Rangunia', 'Dhamair', 4361),
(620, 'Chittagong ', 'Chittagong', 'Rouzan', 'Rouzan', 4340),
(621, 'Chittagong ', 'Chittagong', 'Rouzan', 'Beenajuri', 4341),
(622, 'Chittagong ', 'Chittagong', 'Rouzan', 'Kundeshwari', 4342),
(623, 'Chittagong ', 'Chittagong', 'Rouzan', 'Gahira', 4343),
(624, 'Chittagong ', 'Chittagong', 'Rouzan', 'jagannath Hat', 4344),
(625, 'Chittagong ', 'Chittagong', 'Rouzan', 'Fatepur', 4345),
(626, 'Chittagong ', 'Chittagong', 'Rouzan', 'Guzra Noapara', 4346),
(627, 'Chittagong ', 'Chittagong', 'Rouzan', 'Dewanpur', 4347),
(628, 'Chittagong ', 'Chittagong', 'Rouzan', 'Mohamuni', 4348),
(629, 'Chittagong ', 'Chittagong', 'Rouzan', 'B.I.T Post Office', 4349),
(630, 'Chittagong ', 'Chittagong', 'Sandwip', 'Sandwip', 4300),
(631, 'Chittagong ', 'Chittagong', 'Sandwip', 'Shiberhat', 4301),
(632, 'Chittagong ', 'Chittagong', 'Sandwip', 'Urirchar', 4302),
(633, 'Chittagong ', 'Chittagong', 'Satkania', 'Satkania', 4386),
(634, 'Chittagong ', 'Chittagong', 'Satkania', 'Baitul Ijjat', 4387),
(635, 'Chittagong ', 'Chittagong', 'Satkania', 'Bazalia', 4388),
(636, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Sitakunda', 4310),
(637, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Baroidhala', 4311),
(638, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Barabkunda', 4312),
(639, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Bawashbaria', 4313),
(640, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Kumira', 4314),
(641, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Bhatiari', 4315),
(642, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Fouzdarhat', 4316),
(643, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Jafrabad', 4317),
(644, 'Chittagong ', 'Khagrachari', 'Diginala', 'Diginala', 4420),
(645, 'Chittagong ', 'Khagrachari', 'Khagrachari Sadar', 'Khagrachari Sadar', 4400),
(646, 'Chittagong ', 'Khagrachari', 'Laxmichhari', 'Laxmichhari', 4470),
(647, 'Chittagong ', 'Khagrachari', 'Mahalchhari', 'Mahalchhari', 4430),
(648, 'Chittagong ', 'Khagrachari', 'Manikchhari', 'Manikchhari', 4460),
(649, 'Chittagong ', 'Khagrachari', 'Matiranga', 'Matiranga', 4450),
(650, 'Chittagong ', 'Khagrachari', 'Panchhari', 'Panchhari', 4410),
(651, 'Chittagong ', 'Khagrachari', 'Ramghar Head Office', 'Ramghar Head Office', 4440),
(652, 'Chittagong ', 'Rangamati', 'Barakal', 'Barakal', 4570),
(653, 'Chittagong ', 'Rangamati', 'Bilaichhari', 'Bilaichhari', 4550),
(654, 'Chittagong ', 'Rangamati', 'Jarachhari', 'Jarachhari', 4560),
(655, 'Chittagong ', 'Rangamati', 'Kalampati', 'Kalampati', 4510),
(656, 'Chittagong ', 'Rangamati', 'Kalampati', 'Betbunia', 4511),
(657, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai', 4530),
(658, 'Chittagong ', 'Rangamati', 'kaptai', 'Chandraghona', 4531),
(659, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Project', 4532),
(660, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Nuton Bazar', 4533),
(661, 'Chittagong ', 'Rangamati', 'Longachh', 'Longachh', 4580),
(662, 'Chittagong ', 'Rangamati', 'Marishya', 'Marishya', 4590),
(663, 'Chittagong ', 'Rangamati', 'Naniachhar', 'Nanichhar', 4520),
(664, 'Chittagong ', 'Rangamati', 'Rajsthali', 'Rajsthali', 4540),
(665, 'Chittagong ', 'Rangamati', 'Rangamati Sadar', 'Rangamati Sadar', 4500),
(666, 'Chittagong ', 'Bandarban', 'Alikadam', 'Alikadam', 4650),
(667, 'Chittagong ', 'Bandarban', 'Bandarban Sadar', 'Bandarban Sadar', 4600),
(668, 'Chittagong ', 'Bandarban', 'Naikhong', 'Naikhong', 4660),
(669, 'Chittagong ', 'Bandarban', 'Roanchhari', 'Roanchhari', 4610),
(670, 'Chittagong ', 'Bandarban', 'Ruma', 'Ruma', 4620),
(671, 'Chittagong ', 'Bandarban', 'Thanchi', 'Thanchi', 4630),
(672, 'Chittagong ', 'Bandarban', 'Thanchi', 'Lama', 4641),
(673, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga', 4740),
(674, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga S.O', 4741),
(675, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Badarkali', 4742),
(676, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Malumghat', 4743),
(677, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Coxs Bazar Sadar', 4700),
(678, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Zhilanja', 4701),
(679, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Eidga', 4702),
(680, 'Chittagong ', 'Coxs Bazar', 'Gorakghat', 'Gorakghat', 4710),
(681, 'Chittagong ', 'Coxs Bazar', 'Kutubdia', 'Kutubdia', 4720),
(682, 'Chittagong ', 'Coxs Bazar', 'Ramu', 'Ramu', 4730),
(683, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Teknaf', 4760),
(684, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Hnila', 4761),
(685, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'St.Martin', 4762),
(686, 'Chittagong ', 'Coxs Bazar', 'Ukhia', 'Ukhia', 4750),
(687, 'Khulna ', 'Kustia', 'Bheramara', 'Bheramara', 7040),
(688, 'Khulna ', 'Kustia', 'Bheramara', 'Ganges Bheramara', 7041),
(689, 'Khulna ', 'Kustia', 'Bheramara', 'Allardarga', 7042),
(690, 'Khulna ', 'Kustia', 'Janipur', 'Janipur', 7020),
(691, 'Khulna ', 'Kustia', 'Janipur', 'Khoksa', 7021),
(692, 'Khulna ', 'Kustia', 'Kumarkhali', 'Kumarkhali', 7010),
(693, 'Khulna ', 'Kustia', 'Kumarkhali', 'Panti', 7011),
(694, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kustia Sadar', 7000),
(695, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kushtia Mohini', 7001),
(696, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Jagati', 7002),
(697, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Islami University', 7003),
(698, 'Khulna ', 'Kustia', 'Mirpur', 'Mirpur', 7030),
(699, 'Khulna ', 'Kustia', 'Mirpur', 'Poradaha', 7031),
(700, 'Khulna ', 'Kustia', 'Mirpur', 'Amla Sadarpur', 7032),
(701, 'Khulna ', 'Kustia', 'Rafayetpur', 'Rafayetpur', 7050),
(702, 'Khulna ', 'Kustia', 'Rafayetpur', 'Taragunia', 7051),
(703, 'Khulna ', 'Kustia', 'Rafayetpur', 'Khasmathurapur', 7052),
(704, 'Khulna ', 'Meherpur', 'Gangni', 'Gangni', 7110),
(705, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Meherpur Sadar', 7100),
(706, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', 7101),
(707, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Mujib Nagar Complex', 7102),
(708, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', 7152),
(709, 'Khulna ', 'Chuadanga', 'Alamdanga', 'Alamdanga', 7210),
(710, 'Khulna ', 'Chuadanga', 'Alamdanga', 'Hardi', 7211),
(711, 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Chuadanga Sadar', 7200),
(712, 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Munshiganj', 7201),
(713, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Damurhuda', 7220),
(714, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Darshana', 7221),
(715, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Andulbaria', 7222),
(716, 'Khulna ', 'Chuadanga', 'Doulatganj', 'Doulatganj', 7230),
(717, 'Khulna ', 'Jinaidaha', 'Harinakundu', 'Harinakundu', 7310),
(718, 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Sadar', 7300),
(719, 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Cadet College', 7301),
(720, 'Khulna ', 'Jinaidaha', 'Kotchandpur', 'Kotchandpur', 7330),
(721, 'Khulna ', 'Jinaidaha', 'Maheshpur', 'Maheshpur', 7340),
(722, 'Khulna ', 'Jinaidaha', 'Naldanga', 'Naldanga', 7350),
(723, 'Khulna ', 'Jinaidaha', 'Naldanga', 'Hatbar Bazar', 7351),
(724, 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Shailakupa', 7320),
(725, 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Kumiradaha', 7321),
(726, 'Khulna ', 'Jessore', 'Bagharpara', 'Bagharpara', 7470),
(727, 'Khulna ', 'Jessore', 'Bagharpara', 'Gouranagar', 7471),
(728, 'Khulna ', 'Jessore', 'Chaugachha', 'Chougachha', 7410),
(729, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Sadar', 7400),
(730, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Upa-Shahar', 7401),
(731, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Chanchra', 7402),
(732, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore canttonment', 7403),
(733, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Airbach', 7404),
(734, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Rupdia', 7405),
(735, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Basundia', 7406),
(736, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Churamankathi', 7407),
(737, 'Khulna ', 'Jessore', 'Jhikargachha', 'Jhikargachha', 7420),
(738, 'Khulna ', 'Jessore', 'Keshabpur', 'Keshobpur', 7450),
(739, 'Khulna ', 'Jessore', 'Monirampur', 'Monirampur', 7440),
(740, 'Khulna ', 'Jessore', 'Noapara', 'Noapara', 7460),
(741, 'Khulna ', 'Jessore', 'Noapara', 'Rajghat', 7461),
(742, 'Khulna ', 'Jessore', 'Noapara', 'Bhugilhat', 7462),
(743, 'Khulna ', 'Jessore', 'Sarsa', 'Sarsa', 7430),
(744, 'Khulna ', 'Jessore', 'Sarsa', 'Benapole', 7431),
(745, 'Khulna ', 'Jessore', 'Sarsa', 'Jadabpur', 7432),
(746, 'Khulna ', 'Jessore', 'Sarsa', 'Bag Achra', 7433),
(747, 'Khulna ', 'Narail', 'Kalia', 'Kalia', 7520),
(748, 'Khulna ', 'Narail', 'Laxmipasha', 'Laxmipasha', 7510),
(749, 'Khulna ', 'Narail', 'Laxmipasha', 'Lohagora', 7511),
(750, 'Khulna ', 'Narail', 'Laxmipasha', 'Itna', 7512),
(751, 'Khulna ', 'Narail', 'Laxmipasha', 'Naldi', 7513),
(752, 'Khulna ', 'Narail', 'Laxmipasha', 'Baradia', 7514),
(753, 'Khulna ', 'Narail', 'Mohajan', 'Mohajan', 7521),
(754, 'Khulna ', 'Narail', 'Narail Sadar', 'Narail Sadar', 7500),
(755, 'Khulna ', 'Narail', 'Narail Sadar', 'Ratanganj', 7501),
(756, 'Khulna ', 'Magura', 'Arpara', 'Arpara', 7620),
(757, 'Khulna ', 'Magura', 'Magura Sadar', 'Magura Sadar', 7600),
(758, 'Khulna ', 'Magura', 'Mohammadpur', 'Mohammadpur', 7630),
(759, 'Khulna ', 'Magura', 'Mohammadpur', 'Binodpur', 7631),
(760, 'Khulna ', 'Magura', 'Mohammadpur', 'Nahata', 7632),
(761, 'Khulna ', 'Magura', 'Shripur', 'Shripur', 7610),
(762, 'Khulna ', 'Magura', 'Shripur', 'Langalbadh', 7611),
(763, 'Khulna ', 'Magura', 'Shripur', 'Nachol', 7612),
(764, 'Khulna ', 'Khulna', 'Alaipur', 'Alaipur', 9240),
(765, 'Khulna ', 'Khulna', 'Alaipur', 'Rupsha', 9241),
(766, 'Khulna ', 'Khulna', 'Alaipur', 'Belphulia', 9242),
(767, 'Khulna ', 'Khulna', 'Batiaghat', 'Batiaghat', 9260),
(768, 'Khulna ', 'Khulna', 'Batiaghat', 'Surkalee', 9261),
(769, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Chalna Bazar', 9270),
(770, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Dakup', 9271),
(771, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Bajua', 9272),
(772, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Nalian', 9273),
(773, 'Khulna ', 'Khulna', 'Digalia', 'Digalia', 9220),
(774, 'Khulna ', 'Khulna', 'Digalia', 'Chandni Mahal', 9221),
(775, 'Khulna ', 'Khulna', 'Digalia', 'Senhati', 9222),
(776, 'Khulna ', 'Khulna', 'Digalia', 'Ghoshghati', 9223),
(777, 'Khulna ', 'Khulna', 'Digalia', 'Gazirhat', 9224),
(778, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna G.P.O', 9000),
(779, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khula Sadar', 9100),
(780, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna Shipyard', 9201),
(781, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Doulatpur', 9202),
(782, 'Khulna ', 'Khulna', 'Khulna Sadar', 'BIT Khulna', 9203),
(783, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Siramani', 9204),
(784, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Jahanabad Canttonmen', 9205),
(785, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Sonali Jute Mills', 9206),
(786, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Atra Shilpa Area', 9207),
(787, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna University', 9208),
(788, 'Khulna ', 'Khulna', 'Madinabad', 'Madinabad', 9290),
(789, 'Khulna ', 'Khulna', 'Madinabad', 'Amadee', 9291),
(790, 'Khulna ', 'Khulna', 'Paikgachha', 'Paikgachha', 9280),
(791, 'Khulna ', 'Khulna', 'Paikgachha', 'Godaipur', 9281),
(792, 'Khulna ', 'Khulna', 'Paikgachha', 'Kapilmoni', 9282),
(793, 'Khulna ', 'Khulna', 'Paikgachha', 'Katipara', 9283),
(794, 'Khulna ', 'Khulna', 'Paikgachha', 'Chandkhali', 9284),
(795, 'Khulna ', 'Khulna', 'Paikgachha', 'Garaikhali', 9285),
(796, 'Khulna ', 'Khulna', 'Phultala', 'Phultala', 9210),
(797, 'Khulna ', 'Khulna', 'Sajiara', 'Sajiara', 9250),
(798, 'Khulna ', 'Khulna', 'Sajiara', 'Ghonabanda', 9251),
(799, 'Khulna ', 'Khulna', 'Sajiara', 'Chuknagar', 9252),
(800, 'Khulna ', 'Khulna', 'Sajiara', 'Shahapur', 9253),
(801, 'Khulna ', 'Khulna', 'Terakhada', 'Terakhada', 9230),
(802, 'Khulna ', 'Khulna', 'Terakhada', 'Pak Barasat', 9231),
(803, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'Bagerhat Sadar', 9300);
INSERT INTO `data` (`id`, `devision`, `district`, `subordinate`, `branch`, `post_code`) VALUES
(804, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'P.C College', 9301),
(805, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'Rangdia', 9302),
(806, 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Chalna Ankorage', 9350),
(807, 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Mongla Port', 9351),
(808, 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Chitalmari', 9360),
(809, 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Barabaria', 9361),
(810, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Fakirhat', 9370),
(811, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Mansa', 9371),
(812, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Bhanganpar Bazar', 9372),
(813, 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Kachua', 9310),
(814, 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Sonarkola', 9311),
(815, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Mollahat', 9380),
(816, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Kahalpur', 9381),
(817, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Dariala', 9382),
(818, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Charkulia', 9383),
(819, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Nagarkandi', 9384),
(820, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Pak Gangni', 9385),
(821, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Morelganj', 9320),
(822, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Sannasi Bazar', 9321),
(823, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Telisatee', 9322),
(824, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Rampal', 9340),
(825, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Foylahat', 9341),
(826, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Sonatunia', 9342),
(827, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Gourambha', 9343),
(828, 'Khulna ', 'IBH WAs Here', 'Rayenda', 'Rayenda', 9330),
(829, 'Khulna ', 'Satkhira', 'Ashashuni', 'Ashashuni', 9460),
(830, 'Khulna ', 'Satkhira', 'Ashashuni', 'Baradal', 9461),
(831, 'Khulna ', 'Satkhira', 'Debbhata', 'Debbhata', 9430),
(832, 'Khulna ', 'Satkhira', 'Debbhata', 'Gurugram', 9431),
(833, 'Khulna ', 'Satkhira', 'kalaroa', 'kalaroa', 9410),
(834, 'Khulna ', 'Satkhira', 'kalaroa', 'Murarikati', 9411),
(835, 'Khulna ', 'Satkhira', 'kalaroa', 'Jhaudanga', 9412),
(836, 'Khulna ', 'Satkhira', 'kalaroa', 'Hamidpur', 9413),
(837, 'Khulna ', 'Satkhira', 'kalaroa', 'Khordo', 9414),
(838, 'Khulna ', 'Satkhira', 'kalaroa', 'Chandanpur', 9415),
(839, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Kaliganj UPO', 9440),
(840, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Nalta Mubaroknagar', 9441),
(841, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Ratanpur', 9442),
(842, 'Khulna ', 'Satkhira', 'Nakipur', 'Nakipur', 9450),
(843, 'Khulna ', 'Satkhira', 'Nakipur', 'Noornagar', 9451),
(844, 'Khulna ', 'Satkhira', 'Nakipur', 'Naobeki', 9452),
(845, 'Khulna ', 'Satkhira', 'Nakipur', 'Buri Goalini', 9453),
(846, 'Khulna ', 'Satkhira', 'Nakipur', 'Gabura', 9454),
(847, 'Khulna ', 'Satkhira', 'Nakipur', 'Habinagar', 9455),
(848, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Sadar', 9400),
(849, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Islamia Acc', 9401),
(850, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Gunakar kati', 9402),
(851, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Budhhat', 9403),
(852, 'Khulna ', 'Satkhira', 'Taala', 'Taala', 9420),
(853, 'Khulna ', 'Satkhira', 'Taala', 'Patkelghata', 9421),
(854, 'Sylhet ', 'Sunamganj', 'Bishamsarpur', 'Bishamsapur', 3010),
(855, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak', 3080),
(856, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Cement Facto', 3081),
(857, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Paper Mills', 3082),
(858, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj', 3083),
(859, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj Natun Ba', 3084),
(860, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Khurma', 3085),
(861, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Moinpur', 3086),
(862, 'Sylhet ', 'Sunamganj', 'Chhatak', 'jahidpur', 3087),
(863, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Islamabad', 3088),
(864, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chourangi Bazar', 3893),
(865, 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Dhirai Chandpur', 3040),
(866, 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Jagdal', 3041),
(867, 'Sylhet ', 'Sunamganj', 'Duara bazar', 'Duara bazar', 3070),
(868, 'Sylhet ', 'Sunamganj', 'Ghungiar', 'Ghungiar', 3050),
(869, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Jagnnathpur', 3060),
(870, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Syedpur', 3061),
(871, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Atuajan', 3062),
(872, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Hasan Fatemapur', 3063),
(873, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Rasulganj', 3064),
(874, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Shiramsi', 3065),
(875, 'Sylhet ', 'Sunamganj', 'Sachna', 'Sachna', 3020),
(876, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Sunamganj Sadar', 3000),
(877, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Pagla', 3001),
(878, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Patharia', 3002),
(879, 'Sylhet ', 'Sunamganj', 'Tahirpur', 'Tahirpur', 3030),
(880, 'Sylhet ', 'Sylhet', 'Balaganj', 'Balaganj', 3120),
(881, 'Sylhet ', 'Sylhet', 'Balaganj', 'Karua', 3121),
(882, 'Sylhet ', 'Sylhet', 'Balaganj', 'Brahman Shashon', 3122),
(883, 'Sylhet ', 'Sylhet', 'Balaganj', 'Tajpur', 3123),
(884, 'Sylhet ', 'Sylhet', 'Balaganj', 'Goala Bazar', 3124),
(885, 'Sylhet ', 'Sylhet', 'Balaganj', 'Begumpur', 3125),
(886, 'Sylhet ', 'Sylhet', 'Balaganj', 'Omarpur', 3126),
(887, 'Sylhet ', 'Sylhet', 'Balaganj', 'Kathal Khair', 3127),
(888, 'Sylhet ', 'Sylhet', 'Balaganj', 'Gaharpur', 3128),
(889, 'Sylhet ', 'Sylhet', 'Balaganj', 'Natun Bazar', 3129),
(890, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Bianibazar', 3170),
(891, 'Sylhet ', 'Sylhet', 'Bianibazar', 'jaldup', 3171),
(892, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Mathiura', 3172),
(893, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Kurar bazar', 3173),
(894, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Salia bazar', 3174),
(895, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Churkai', 3175),
(896, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Bishwanath', 3130),
(897, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Dashghar', 3131),
(898, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Doulathpur', 3132),
(899, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Deokalas', 3133),
(900, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Singer kanch', 3134),
(901, 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj', 3116),
(902, 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj SareKarkh', 3117),
(903, 'Sylhet ', 'Sylhet', 'Goainhat', 'Goainhat', 3150),
(904, 'Sylhet ', 'Sylhet', 'Goainhat', 'Jaflong', 3151),
(905, 'Sylhet ', 'Sylhet', 'Goainhat', 'Chiknagul', 3152),
(906, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Gopalgannj', 3160),
(907, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dhaka Dakkhin', 3161),
(908, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dakkhin Bhadashore', 3162),
(909, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Ranaping', 3163),
(910, 'Sylhet ', 'Sylhet', 'Gopalganj', 'banigram', 3164),
(911, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Chandanpur', 3165),
(912, 'Sylhet ', 'Sylhet', 'Jaintapur', 'Jainthapur', 3156),
(913, 'Sylhet ', 'Sylhet', 'Jakiganj', 'Jakiganj', 3190),
(914, 'Sylhet ', 'Sylhet', 'Jakiganj', 'Ichhamati', 3191),
(915, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Kanaighat', 3180),
(916, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Chatulbazar', 3181),
(917, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Manikganj', 3182),
(918, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Gachbari', 3183),
(919, 'Sylhet ', 'Sylhet', 'Kompanyganj', 'Kompanyganj', 3140),
(920, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhe Sadar', 3100),
(921, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Cadet Col', 3101),
(922, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Biman Bondar', 3102),
(923, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Khadimnagar', 3103),
(924, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad Cantoment', 3104),
(925, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Silam', 3105),
(926, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Birahimpur', 3106),
(927, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad', 3107),
(928, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Mogla', 3108),
(929, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Ranga Hajiganj', 3109),
(930, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kadamtali', 3111),
(931, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kamalbazer', 3112),
(932, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Lalbazar', 3113),
(933, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Shahajalal Science &', 3114),
(934, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Baralekha', 3250),
(935, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Juri', 3251),
(936, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Dhakkhinbag', 3252),
(937, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Purbashahabajpur', 3253),
(938, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Kamalganj', 3220),
(939, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Keramatnaga', 3221),
(940, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Patrakhola', 3222),
(941, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Shamsher Nagar', 3223),
(942, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Munshibazar', 3224),
(943, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Kulaura', 3230),
(944, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Tillagaon', 3231),
(945, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Langla', 3232),
(946, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Prithimpasha', 3233),
(947, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Kajaldhara', 3234),
(948, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Karimpur', 3235),
(949, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Baramchal', 3237),
(950, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Moulvibazar Sadar', 3200),
(951, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Barakapan', 3201),
(952, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Monumukh', 3202),
(953, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Afrozganj', 3203),
(954, 'Sylhet ', 'Moulvibazar', 'Rajnagar', 'Rajnagar', 3240),
(955, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Srimangal', 3210),
(956, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Narain Chora', 3211),
(957, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Kalighat', 3212),
(958, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Khejurichhara', 3213),
(959, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Satgaon', 3214),
(960, 'Sylhet ', 'Hobiganj', 'Azmireeganj', 'Azmireeganj', 3360),
(961, 'Sylhet ', 'Hobiganj', 'Bahubal', 'Bahubal', 3310),
(962, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Baniachang', 3350),
(963, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Jatrapasha', 3351),
(964, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Kadirganj', 3352),
(965, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chunarughat', 3320),
(966, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chandpurbagan', 3321),
(967, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Narapati', 3322),
(968, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Hobiganj Sadar', 3300),
(969, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Shaestaganj', 3301),
(970, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Gopaya', 3302),
(971, 'Sylhet ', 'Hobiganj', 'Kalauk', 'Kalauk', 3340),
(972, 'Sylhet ', 'Hobiganj', 'Kalauk', 'Lakhai', 3341),
(973, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Madhabpur', 3330),
(974, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Itakhola', 3331),
(975, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Shahajibazar', 3332),
(976, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Saihamnagar', 3333),
(977, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Nabiganj', 3370),
(978, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Goplarbazar', 3371),
(979, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Golduba', 3372),
(980, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Digalbak', 3373),
(981, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Inathganj', 3374),
(982, 'Barisal ', 'Barishal', 'Agailzhara', 'Agailzhara', 8240),
(983, 'Barisal ', 'Barishal', 'Agailzhara', 'Gaila', 8241),
(984, 'Barisal ', 'Barishal', 'Agailzhara', 'Paisarhat', 8242),
(985, 'Barisal ', 'Barishal', 'Babuganj', 'Babuganj', 8210),
(986, 'Barisal ', 'Barishal', 'Babuganj', 'Rahamatpur', 8211),
(987, 'Barisal ', 'Barishal', 'Babuganj', 'Chandpasha', 8212),
(988, 'Barisal ', 'Barishal', 'Babuganj', 'Madhabpasha', 8213),
(989, 'Barisal ', 'Barishal', 'Babuganj', 'Thakur Mallik', 8214),
(990, 'Barisal ', 'Barishal', 'Babuganj', 'Nizamuddin College', 8215),
(991, 'Barisal ', 'Barishal', 'Babuganj', 'Barishal Cadet', 8216),
(992, 'Barisal ', 'Barishal', 'Barajalia', 'Barajalia', 8260),
(993, 'Barisal ', 'Barishal', 'Barajalia', 'Osman Manjil', 8261),
(994, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Barishal Sadar', 8200),
(995, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Bukhainagar', 8201),
(996, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Saheberhat', 8202),
(997, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Sugandia', 8203),
(998, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Patang', 8204),
(999, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Kashipur', 8205),
(1000, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Jaguarhat', 8206),
(1001, 'Barisal ', 'Barishal', 'Gouranadi', 'Gouranadi', 8230),
(1002, 'Barisal ', 'Barishal', 'Gouranadi', 'Tarki Bandar', 8231),
(1003, 'Barisal ', 'Barishal', 'Gouranadi', 'Kashemabad', 8232),
(1004, 'Barisal ', 'Barishal', 'Gouranadi', 'Batajor', 8233),
(1005, 'Barisal ', 'Barishal', 'Mahendiganj', 'Mahendiganj', 8270),
(1006, 'Barisal ', 'Barishal', 'Mahendiganj', 'Laskarpur', 8271),
(1007, 'Barisal ', 'Barishal', 'Mahendiganj', 'Ulania', 8272),
(1008, 'Barisal ', 'Barishal', 'Mahendiganj', 'Nalgora', 8273),
(1009, 'Barisal ', 'Barishal', 'Mahendiganj', 'Langutia', 8274),
(1010, 'Barisal ', 'Barishal', 'Muladi', 'Muladi', 8250),
(1011, 'Barisal ', 'Barishal', 'Muladi', 'Kazirchar', 8251),
(1012, 'Barisal ', 'Barishal', 'Muladi', 'Charkalekhan', 8252),
(1013, 'Barisal ', 'Barishal', 'Sahebganj', 'Sahebganj', 8280),
(1014, 'Barisal ', 'Barishal', 'Sahebganj', 'Charamandi', 8281),
(1015, 'Barisal ', 'Barishal', 'Sahebganj', 'Padri Shibpur', 8282),
(1016, 'Barisal ', 'Barishal', 'Sahebganj', 'Shialguni', 8283),
(1017, 'Barisal ', 'Barishal', 'Sahebganj', 'kalaskati', 8284),
(1018, 'Barisal ', 'Barishal', 'Uzirpur', 'Uzirpur', 8220),
(1019, 'Barisal ', 'Barishal', 'Uzirpur', 'Dhamura', 8221),
(1020, 'Barisal ', 'Barishal', 'Uzirpur', 'Jugirkanda', 8222),
(1021, 'Barisal ', 'Barishal', 'Uzirpur', 'Dakuarhat', 8223),
(1022, 'Barisal ', 'Barishal', 'Uzirpur', 'Shikarpur', 8224),
(1023, 'Barisal ', 'Bhola', 'Bhola Sadar', 'Bhola Sadar', 8300),
(1024, 'Barisal ', 'Bhola', 'Bhola Sadar', 'Joynagar', 8301),
(1025, 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Borhanuddin UPO', 8320),
(1026, 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Mirzakalu', 8321),
(1027, 'Barisal ', 'Bhola', 'Charfashion', 'Charfashion', 8340),
(1028, 'Barisal ', 'Bhola', 'Charfashion', 'Dularhat', 8341),
(1029, 'Barisal ', 'Bhola', 'Charfashion', 'Keramatganj', 8342),
(1030, 'Barisal ', 'Bhola', 'Doulatkhan', 'Doulatkhan', 8310),
(1031, 'Barisal ', 'Bhola', 'Doulatkhan', 'Hajipur', 8311),
(1032, 'Barisal ', 'Bhola', 'Hajirhat', 'Hajirhat', 8360),
(1033, 'Barisal ', 'Bhola', 'Hatshoshiganj', 'Hatshoshiganj', 8350),
(1034, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Lalmohan UPO', 8330),
(1035, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Daurihat', 8331),
(1036, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Gazaria', 8332),
(1037, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Jhalokathi Sadar', 8400),
(1038, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Nabagram', 8401),
(1039, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Baukathi', 8402),
(1040, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Gabha', 8403),
(1041, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Shekherhat', 8404),
(1042, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Kathalia', 8430),
(1043, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Amua', 8431),
(1044, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Niamatee', 8432),
(1045, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Shoulajalia', 8433),
(1046, 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Nalchhiti', 8420),
(1047, 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Beerkathi', 8421),
(1048, 'Barisal ', 'Jhalokathi', 'Rajapur', 'Rajapur', 8410),
(1049, 'Barisal ', 'Pirojpur', 'Banaripara', 'Banaripara', 8530),
(1050, 'Barisal ', 'Pirojpur', 'Banaripara', 'Chakhar', 8531),
(1051, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Bhandaria', 8550),
(1052, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Kanudashkathi', 8551),
(1053, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Dhaoa', 8552),
(1054, 'Barisal ', 'Pirojpur', 'kaukhali', 'Kaukhali', 8510),
(1055, 'Barisal ', 'Pirojpur', 'kaukhali', 'Keundia', 8511),
(1056, 'Barisal ', 'Pirojpur', 'kaukhali', 'Joykul', 8512),
(1057, 'Barisal ', 'Pirojpur', 'kaukhali', 'Jolagati', 8513),
(1058, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Mathbaria', 8560),
(1059, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tushkhali', 8561),
(1060, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Halta', 8562),
(1061, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Gulishakhali', 8563),
(1062, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tiarkhali', 8564),
(1063, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Betmor Natun Hat', 8565),
(1064, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Shilarganj', 8566),
(1065, 'Barisal ', 'Pirojpur', 'Nazirpur', 'Nazirpur', 8540),
(1066, 'Barisal ', 'Pirojpur', 'Nazirpur', 'Sriramkathi', 8541),
(1067, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Pirojpur Sadar', 8500),
(1068, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Hularhat', 8501),
(1069, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Parerhat', 8502),
(1070, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Swarupkathi', 8520),
(1071, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Darus Sunnat', 8521),
(1072, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Kaurikhara', 8522),
(1073, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Jalabari', 8523),
(1074, 'Barisal ', 'Patuakhali', 'Bauphal', 'Bauphal', 8620),
(1075, 'Barisal ', 'Patuakhali', 'Bauphal', 'Bagabandar', 8621),
(1076, 'Barisal ', 'Patuakhali', 'Bauphal', 'Birpasha', 8622),
(1077, 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalishari', 8623),
(1078, 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalaia', 8624),
(1079, 'Barisal ', 'Patuakhali', 'Dashmina', 'Dashmina', 8630),
(1080, 'Barisal ', 'Patuakhali', 'Galachipa', 'Galachipa', 8640),
(1081, 'Barisal ', 'Patuakhali', 'Galachipa', 'Gazipur Bandar', 8641),
(1082, 'Barisal ', 'Patuakhali', 'Khepupara', 'Khepupara', 8650),
(1083, 'Barisal ', 'Patuakhali', 'Khepupara', 'Mahipur', 8651),
(1084, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Patuakhali Sadar', 8600),
(1085, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Moukaran', 8601),
(1086, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Dumkee', 8602),
(1087, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Rahimabad', 8603),
(1088, 'Barisal ', 'Patuakhali', 'Subidkhali', 'Subidkhali', 8610),
(1089, 'Barisal ', 'Barguna', 'Amtali', 'Amtali', 8710),
(1090, 'Barisal ', 'Barguna', 'Bamna', 'Bamna', 8730),
(1091, 'Barisal ', 'Barguna', 'Barguna Sadar', 'Barguna Sadar', 8700),
(1092, 'Barisal ', 'Barguna', 'Barguna Sadar', 'Nali Bandar', 8701),
(1093, 'Barisal ', 'Barguna', 'Betagi', 'Betagi', 8740),
(1094, 'Barisal ', 'Barguna', 'Betagi', 'Darul Ulam', 8741),
(1095, 'Barisal ', 'Barguna', 'Patharghata', 'Patharghata', 8720),
(1096, 'Barisal ', 'Barguna', 'Patharghata', 'Kakchira', 8721),
(1097, 'Rajshahi ', 'Panchagarh', 'Boda', 'Boda', 5010),
(1098, 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Chotto Dab', 5040),
(1099, 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Mirjapur', 5041),
(1100, 'Rajshahi ', 'Panchagarh', 'Dabiganj', 'Dabiganj', 5020),
(1101, 'Rajshahi ', 'Panchagarh', 'Panchagra Sadar', 'Panchagar Sadar', 5000),
(1102, 'Rajshahi ', 'Panchagarh', 'Tetulia', 'Tetulia', 5030),
(1103, 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Baliadangi', 5140),
(1104, 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Lahiri', 5141),
(1105, 'Rajshahi ', 'Thakurgaon', 'Jibanpur', 'Jibanpur', 5130),
(1106, 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', 5110),
(1107, 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', 5470),
(1108, 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Rani Sankail', 5120),
(1109, 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Nekmarad', 5121),
(1110, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Sadar', 5100),
(1111, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Road', 5101),
(1112, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Shibganj', 5102),
(1113, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Ruhia', 5103),
(1114, 'Rajshahi ', 'Dinajpur', 'Bangla Hili', 'Bangla Hili', 5270),
(1115, 'Rajshahi ', 'Dinajpur', 'Biral', 'Biral', 5210),
(1116, 'Rajshahi ', 'Dinajpur', 'Birampur', 'Birampur', 5266),
(1117, 'Rajshahi ', 'Dinajpur', 'Birganj', 'Birganj', 5220),
(1118, 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Chrirbandar', 5240),
(1119, 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Ranirbandar', 5241),
(1120, 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Sadar', 5200),
(1121, 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Rajbari', 5201),
(1122, 'Rajshahi ', 'Dinajpur', 'Khansama', 'Khansama', 5230),
(1123, 'Rajshahi ', 'Dinajpur', 'Khansama', 'Pakarhat', 5231),
(1124, 'Rajshahi ', 'Dinajpur', 'Maharajganj', 'Maharajganj', 5226),
(1125, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Nababganj', 5280),
(1126, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Daudpur', 5281),
(1127, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Gopalpur', 5282),
(1128, 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Osmanpur', 5290),
(1129, 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Ghoraghat', 5291),
(1130, 'Rajshahi ', 'Dinajpur', 'Parbatipur', 'Parbatipur', 5250),
(1131, 'Rajshahi ', 'Dinajpur', 'Phulbari', 'Phulbari', 5260),
(1132, 'Rajshahi ', 'Dinajpur', 'Setabganj', 'Setabganj', 5216),
(1133, 'Rajshahi ', 'Nilphamari', 'Dimla', 'Dimla', 5350),
(1134, 'Rajshahi ', 'Nilphamari', 'Dimla', 'Ghaga Kharibari', 5351),
(1135, 'Rajshahi ', 'Nilphamari', 'Domar', 'Domar', 5340),
(1136, 'Rajshahi ', 'Nilphamari', 'Domar', 'Chilahati', 5341),
(1137, 'Rajshahi ', 'Nilphamari', 'Jaldhaka', 'Jaldhaka', 5330),
(1138, 'Rajshahi ', 'Nilphamari', 'Kishoriganj', 'Kishoriganj', 5320),
(1139, 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sadar', 5300),
(1140, 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sugar Mil', 5301),
(1141, 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur', 5310),
(1142, 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur Upashahar', 5311),
(1143, 'Rajshahi ', 'Rangpur', 'Badarganj', 'Badarganj', 5430),
(1144, 'Rajshahi ', 'Rangpur', 'Badarganj', 'Shyampur', 5431),
(1145, 'Rajshahi ', 'Rangpur', 'Gangachara', 'Gangachara', 5410),
(1146, 'Rajshahi ', 'Rangpur', 'Kaunia', 'Kaunia', 5440),
(1147, 'Rajshahi ', 'Rangpur', 'Kaunia', 'Haragachh', 5441),
(1148, 'Rajshahi ', 'Rangpur', 'Mithapukur', 'Mithapukur', 5460),
(1149, 'Rajshahi ', 'Rangpur', 'Pirgachha', 'Pirgachha', 5450),
(1150, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Sadar', 5400),
(1151, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Upa-Shahar', 5401),
(1152, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Alamnagar', 5402),
(1153, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Mahiganj', 5403),
(1154, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Cadet Colleg', 5404),
(1155, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Carmiecal Col', 5405),
(1156, 'Rajshahi ', 'Rangpur', 'Taraganj', 'Taraganj', 5420),
(1157, 'Rajshahi ', 'Lalmonirhat', 'Aditmari', 'Aditmari', 5510),
(1158, 'Rajshahi ', 'Lalmonirhat', 'Hatibandha', 'Hatibandha', 5530),
(1159, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Lalmonirhat Sadar', 5500),
(1160, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Moghalhat', 5501),
(1161, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Kulaghat SO', 5502),
(1162, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Patgram', 5540),
(1163, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Baura', 5541),
(1164, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Burimari', 5542),
(1165, 'Rajshahi ', 'Lalmonirhat', 'Tushbhandar', 'Tushbhandar', 5520),
(1166, 'Rajshahi ', 'Kurigram', 'Bhurungamari', 'Bhurungamari', 5670),
(1167, 'Rajshahi ', 'Kurigram', 'Chilmari', 'Chilmari', 5630),
(1168, 'Rajshahi ', 'Kurigram', 'Chilmari', 'Jorgachh', 5631),
(1169, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Kurigram Sadar', 5600),
(1170, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Pandul', 5601),
(1171, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Phulbari', 5680),
(1172, 'Rajshahi ', 'Kurigram', 'Nageshwar', 'Nageshwar', 5660),
(1173, 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Rajarhat', 5610),
(1174, 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Nazimkhan', 5611),
(1175, 'Rajshahi ', 'Kurigram', 'Rajibpur', 'Rajibpur', 5650),
(1176, 'Rajshahi ', 'Kurigram', 'Roumari', 'Roumari', 5640),
(1177, 'Rajshahi ', 'Kurigram', 'Ulipur', 'Ulipur', 5620),
(1178, 'Rajshahi ', 'Kurigram', 'Ulipur', 'Bazarhat', 5621),
(1179, 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'Bonarpara', 5750),
(1180, 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'saghata', 5751),
(1181, 'Rajshahi ', 'Gaibandha', 'Gaibandha Sadar', 'Gaibandha Sadar', 5700),
(1182, 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Gobindhaganj', 5740),
(1183, 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Mahimaganj', 5741),
(1184, 'Rajshahi ', 'Gaibandha', 'Palashbari', 'Palashbari', 5730),
(1185, 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Phulchhari', 5760),
(1186, 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Bharatkhali', 5761),
(1187, 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Saadullapur', 5710),
(1188, 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Naldanga', 5711),
(1189, 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Sundarganj', 5720),
(1190, 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Bamandanga', 5721),
(1191, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Adamdighi', 5890),
(1192, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Santahar', 5891),
(1193, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Nasharatpur', 5892),
(1194, 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Sadar', 5800),
(1195, 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Canttonment', 5801),
(1196, 'Rajshahi ', 'Bogra', 'Dhunat', 'Dhunat', 5850),
(1197, 'Rajshahi ', 'Bogra', 'Dhunat', 'Gosaibari', 5851),
(1198, 'Rajshahi ', 'Bogra', 'Dupchachia', 'Dupchachia', 5880),
(1199, 'Rajshahi ', 'Bogra', 'Dupchachia', 'Talora', 5881),
(1200, 'Rajshahi ', 'Bogra', 'Gabtoli', 'Gabtoli', 5820),
(1201, 'Rajshahi ', 'Bogra', 'Gabtoli', 'Sukhanpukur', 5821),
(1202, 'Rajshahi ', 'Bogra', 'Kahalu', 'Kahalu', 5870),
(1203, 'Rajshahi ', 'Bogra', 'Nandigram', 'Nandigram', 5860),
(1204, 'Rajshahi ', 'Bogra', 'Sariakandi', 'Sariakandi', 5830),
(1205, 'Rajshahi ', 'Bogra', 'Sariakandi', 'Chandan Baisha', 5831),
(1206, 'Rajshahi ', 'Bogra', 'Sherpur', 'Sherpur', 5840),
(1207, 'Rajshahi ', 'Bogra', 'Sherpur', 'Chandaikona', 5841),
(1208, 'Rajshahi ', 'Bogra', 'Sherpur', 'Palli Unnyan Accadem', 5842),
(1209, 'Rajshahi ', 'Bogra', 'Shibganj', 'Shibganj', 5810),
(1210, 'Rajshahi ', 'Bogra', 'Sonatola', 'Sonatola', 5826),
(1211, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'Akklepur', 5940),
(1212, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'jamalganj', 5941),
(1213, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'Tilakpur', 5942),
(1214, 'Rajshahi ', 'Joypurhat', 'Joypurhat Sadar', 'Joypurhat Sadar', 5900),
(1215, 'Rajshahi ', 'Joypurhat', 'kalai', 'kalai', 5930),
(1216, 'Rajshahi ', 'Joypurhat', 'Khetlal', 'Khetlal', 5920),
(1217, 'Rajshahi ', 'Joypurhat', 'panchbibi', 'Panchbibi', 5910),
(1218, 'Rajshahi ', 'Rajshahi', 'Bagha', 'Bagha', 6280),
(1219, 'Rajshahi ', 'Rajshahi', 'Bagha', 'Arani', 6281),
(1220, 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Bhabaniganj', 6250),
(1221, 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Taharpur', 6251),
(1222, 'Rajshahi ', 'Rajshahi', 'Charghat', 'Charghat', 6270),
(1223, 'Rajshahi ', 'Rajshahi', 'Charghat', 'Sarda', 6271),
(1224, 'Rajshahi ', 'Rajshahi', 'Durgapur', 'Durgapur', 6240),
(1225, 'Rajshahi ', 'Rajshahi', 'Godagari', 'Godagari', 6290),
(1226, 'Rajshahi ', 'Rajshahi', 'Godagari', 'Premtoli', 6291),
(1227, 'Rajshahi ', 'Rajshahi', 'Khod Mohanpur', 'Khodmohanpur', 6220),
(1228, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Lalitganj', 6210),
(1229, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Rajshahi Sugar Mills', 6211),
(1230, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Shyampur', 6212),
(1231, 'Rajshahi ', 'Rajshahi', 'Putia', 'Putia', 6260),
(1232, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Sadar', 6000),
(1233, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Ghuramara', 6100),
(1234, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Court', 6201),
(1235, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Canttonment', 6202),
(1236, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Sapura', 6203),
(1237, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Kazla', 6204),
(1238, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi University', 6205),
(1239, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Binodpur Bazar', 6206),
(1240, 'Rajshahi ', 'Rajshahi', 'Tanor', 'Tanor', 6230),
(1241, 'Rajshahi ', 'Chapinawabganj', 'Bholahat', 'Bholahat', 6330),
(1242, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Chapinawbganj Sadar', 6300),
(1243, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Rajarampur', 6301),
(1244, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Ramchandrapur', 6302),
(1245, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Amnura', 6303),
(1246, 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Nachol', 6310),
(1247, 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Mandumala', 6311),
(1248, 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Rohanpur', 6320),
(1249, 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Gomashtapur', 6321),
(1250, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Shibganj U.P.O', 6340),
(1251, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Kansart', 6341),
(1252, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Manaksha', 6342),
(1253, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Gopalpur U.P.O', 6420),
(1254, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Lalpur S.O', 6421),
(1255, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Abdulpur', 6422),
(1256, 'Rajshahi ', 'Natore', 'Harua', 'Harua', 6430),
(1257, 'Rajshahi ', 'Natore', 'Harua', 'Dayarampur', 6431),
(1258, 'Rajshahi ', 'Natore', 'Harua', 'Baraigram', 6432),
(1259, 'Rajshahi ', 'Natore', 'Hatgurudaspur', 'Hatgurudaspur', 6440),
(1260, 'Rajshahi ', 'Natore', 'Laxman', 'Laxman', 6410),
(1261, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Natore Sadar', 6400),
(1262, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Digapatia', 6401),
(1263, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Baiddyabal Gharia', 6402),
(1264, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Madhnagar', 6403),
(1265, 'Rajshahi ', 'Natore', 'Singra', 'Singra', 6450),
(1266, 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Ahsanganj', 6596),
(1267, 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Bandai', 6597),
(1268, 'Rajshahi ', 'Naogaon', 'Badalgachhi', 'Badalgachhi', 6570),
(1269, 'Rajshahi ', 'Naogaon', 'Dhamuirhat', 'Dhamuirhat', 6580),
(1270, 'Rajshahi ', 'Naogaon', 'Mahadebpur', 'Mahadebpur', 6530),
(1271, 'Rajshahi ', 'Naogaon', 'Naogaon Sadar', 'Naogaon Sadar', 6500),
(1272, 'Rajshahi ', 'Naogaon', 'Niamatpur', 'Niamatpur', 6520),
(1273, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Nitpur', 6550),
(1274, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Porsa', 6551),
(1275, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Panguria', 6552),
(1276, 'Rajshahi ', 'Naogaon', 'Patnitala', 'Patnitala', 6540),
(1277, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Prasadpur', 6510),
(1278, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Manda', 6511),
(1279, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Balihar', 6512),
(1280, 'Rajshahi ', 'Naogaon', 'Raninagar', 'Raninagar', 6590),
(1281, 'Rajshahi ', 'Naogaon', 'Raninagar', 'Kashimpur', 6591),
(1282, 'Rajshahi ', 'Naogaon', 'Sapahar', 'Sapahar', 6560),
(1283, 'Rajshahi ', 'Naogaon', 'Sapahar', 'Moduhil', 6561),
(1284, 'Rajshahi ', 'Pabna', 'Banwarinagar', 'Banwarinagar', 6650),
(1285, 'Rajshahi ', 'Pabna', 'Bera', 'Bera', 6680),
(1286, 'Rajshahi ', 'Pabna', 'Bera', 'Nakalia', 6681),
(1287, 'Rajshahi ', 'Pabna', 'Bera', 'Kashinathpur', 6682),
(1288, 'Rajshahi ', 'Pabna', 'Bera', 'Puran Bharenga', 6683),
(1289, 'Rajshahi ', 'Pabna', 'Bhangura', 'Bhangura', 6640),
(1290, 'Rajshahi ', 'Pabna', 'Chatmohar', 'Chatmohar', 6630),
(1291, 'Rajshahi ', 'Pabna', 'Debottar', 'Debottar', 6610),
(1292, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Ishwardi', 6620),
(1293, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Dhapari', 6621),
(1294, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Pakshi', 6622),
(1295, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Rajapur', 6623),
(1296, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Pabna Sadar', 6600),
(1297, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Kaliko Cotton Mills', 6601),
(1298, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Hamayetpur', 6602),
(1299, 'Rajshahi ', 'Pabna', 'Sathia', 'Sathia', 6670),
(1300, 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sujanagar', 6660),
(1301, 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sagarkandi', 6661),
(1302, 'Rajshahi ', 'Sirajganj', 'Baiddya Jam Toil', 'Baiddya Jam Toil', 6730),
(1303, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Belkuchi', 6740),
(1304, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sohagpur', 6741),
(1305, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Rajapur', 6742),
(1306, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Enayetpur', 6751),
(1307, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sthal', 6752),
(1308, 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Dhangora', 6720),
(1309, 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Malonga', 6721),
(1310, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Kazipur', 6710),
(1311, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Shuvgachha', 6711),
(1312, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Gandail', 6712),
(1313, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Shahjadpur', 6770),
(1314, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Porjana', 6771),
(1315, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Jamirta', 6772),
(1316, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Kaijuri', 6773),
(1317, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Sirajganj Sadar', 6700),
(1318, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Raipur', 6701),
(1319, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Rashidabad', 6702),
(1320, 'Rajshahi ', 'Sirajganj', 'Tarash', 'Tarash', 6780),
(1321, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara', 6760),
(1322, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara R.S', 6761),
(1323, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Lahiri Mohanpur', 6762),
(1324, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Salap', 6763);

-- --------------------------------------------------------

--
-- Table structure for table `demo`
--

CREATE TABLE `demo` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `created` tinyint(1) NOT NULL DEFAULT '0',
  `interested` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `demo`
--

INSERT INTO `demo` (`id`, `user_id`, `post_id`, `created`, `interested`) VALUES
(1, 1, 2, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_stock`
--

CREATE TABLE `product_stock` (
  `id` int(11) NOT NULL,
  `product_rate_id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `note` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TABLE 2`
--

CREATE TABLE `TABLE 2` (
  `COL 1` varchar(76) DEFAULT NULL,
  `COL 2` int(4) DEFAULT NULL,
  `COL 3` varchar(11) DEFAULT NULL,
  `COL 4` varchar(14) DEFAULT NULL,
  `COL 5` varchar(20) DEFAULT NULL,
  `COL 6` varchar(21) DEFAULT NULL,
  `COL 7` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `TABLE 2`
--

INSERT INTO `TABLE 2` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`, `COL 7`) VALUES
(',1,Dhaka,Dhaka,Demra,Demra,1360\r\n', 2, 'Dhaka', 'Dhaka', 'Demra', 'Sarulia', '1361'),
(',3,Dhaka,Dhaka,Demra,Matuail,1362\r\n', 4, 'Dhaka', 'Dhaka', 'Dhaka GPO', 'Dhaka GPO', '1000'),
(',5,Dhaka,Dhaka,Dhaka Main PO,Dhaka Main PO,1100\r\n', 6, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Wari TSO', '1203'),
(',7,Dhaka,Dhaka,Dhaka Sadar,Gendaria TSO,1204\r\n', 8, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'New Market TSO', '1205'),
(',9,Dhaka,Dhaka,Dhaka Sadar,Dhaka CantonmentTSO,1206\r\n', 10, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mohammadpur Housing', '1207'),
(',11,Dhaka,Dhaka,Dhaka Sadar,Dhaka Politechnic,1208\r\n', 12, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Jigatala TSO', '1209'),
(',13,Dhaka,Dhaka,Dhaka Sadar,Posta TSO,1211\r\n', 14, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gulshan Model Town', '1212'),
(',15,Dhaka,Dhaka,Dhaka Sadar,Banani TSO,1213\r\n', 16, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Basabo TSO', '1214'),
(',17,Dhaka,Dhaka,Dhaka Sadar,Tejgaon TSO,1215\r\n', 18, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Shantinagr TSO', '1217'),
(',19,Dhaka,Dhaka,Dhaka Sadar,Mirpur TSO,1218\r\n', 20, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilgaonTSO', '1219'),
(',21,Dhaka,Dhaka,Dhaka Sadar,BangabhabanTSO,1222\r\n', 22, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'DilkushaTSO', '1223'),
(',23,Dhaka,Dhaka,Dhaka Sadar,Sangsad BhabanTSO,1225\r\n', 24, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilkhetTSO', '1229'),
(',25,Dhaka,Dhaka,Dhaka Sadar,Uttara Model TwonTSO,1231\r\n', 26, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhania TSO', '1232'),
(',27,Dhaka,Dhaka,Dhamrai,Dhamrai,1350\r\n', 28, 'Dhaka', 'Dhaka', 'Dhamrai', 'Kamalpur', '1351'),
(',29,Dhaka,Dhaka,Joypara,Joypara,1330\r\n', 30, 'Dhaka', 'Dhaka', 'Joypara', 'Palamganj', '1331'),
(',31,Dhaka,Dhaka,Joypara,Narisha,1332\r\n', 32, 'Dhaka', 'Dhaka', 'Keraniganj', 'Keraniganj', '1310'),
(',33,Dhaka,Dhaka,Keraniganj,Dhaka Jute Mills,1311\r\n', 34, 'Dhaka', 'Dhaka', 'Keraniganj', 'Ati', '1312'),
(',35,Dhaka,Dhaka,Keraniganj,Kalatia,1313\r\n', 36, 'Dhaka', 'Dhaka', 'Nawabganj', 'Nawabganj', '1320'),
(',37,Dhaka,Dhaka,Nawabganj,Hasnabad,1321\r\n', 38, 'Dhaka', 'Dhaka', 'Nawabganj', 'Daudpur', '1322'),
(',39,Dhaka,Dhaka,Nawabganj,Agla,1323\r\n', 40, 'Dhaka', 'Dhaka', 'Nawabganj', 'Khalpar', '1324'),
(',41,Dhaka,Dhaka,Nawabganj,Churain,1325\r\n', 42, 'Dhaka', 'Dhaka', 'Savar', 'Savar', '1340'),
(',43,Dhaka,Dhaka,Savar,Dairy Farm,1341\r\n', 44, 'Dhaka', 'Dhaka', 'Savar', 'Jahangirnagar Univer', '1342'),
(',45,Dhaka,Dhaka,Savar,Saver P.A.T.C,1343\r\n', 46, 'Dhaka', 'Dhaka', 'Savar', 'Savar Canttonment', '1344'),
(',47,Dhaka,Dhaka,Savar,Shimulia,1345\r\n', 48, 'Dhaka', 'Dhaka', 'Savar', 'Kashem Cotton Mills', '1346'),
(',49,Dhaka,Dhaka,Savar,Rajphulbaria,1347\r\n', 50, 'Dhaka', 'Dhaka', 'Savar', 'Amin Bazar', '1348'),
(',51,Dhaka,Dhaka,Savar,EPZ,1349\r\n', 52, 'Dhaka', 'Mymensingh', 'Bhaluka', 'Bhaluka', '2240'),
(',53,Dhaka,Mymensingh,Fulbaria,Fulbaria,2216\r\n', 54, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Gaforgaon', '2230'),
(',55,Dhaka,Mymensingh,Gaforgaon,Shibganj,2231\r\n', 56, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Usti', '2232'),
(',57,Dhaka,Mymensingh,Gaforgaon,Kandipara,2233\r\n', 58, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Duttarbazar', '2234'),
(',59,Dhaka,Mymensingh,Gouripur,Gouripur,2270\r\n', 60, 'Dhaka', 'Mymensingh', 'Gouripur', 'Ramgopalpur', '2271'),
(',61,Dhaka,Mymensingh,Haluaghat,Haluaghat,2260\r\n', 62, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Dhara', '2261'),
(',63,Dhaka,Mymensingh,Haluaghat,Munshirhat,2262\r\n', 64, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Isshwargonj', '2280'),
(',65,Dhaka,Mymensingh,Isshwargonj,Sohagi,2281\r\n', 66, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Atharabari', '2282'),
(',67,Dhaka,Mymensingh,Muktagachha,Muktagachha,2210\r\n', 68, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Mymensingh Sadar', '2200'),
(',69,Dhaka,Mymensingh,Mymensingh Sadar,Kawatkhali,2201\r\n', 70, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Agriculture Universi', '2202'),
(',71,Dhaka,Mymensingh,Mymensingh Sadar,Shombhuganj,2203\r\n', 72, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Biddyaganj', '2204'),
(',73,Dhaka,Mymensingh,Mymensingh Sadar,Pearpur,2205\r\n', 74, 'Dhaka', 'Mymensingh', 'Nandail', 'Nandail', '2290'),
(',75,Dhaka,Mymensingh,Nandail,Gangail,2291\r\n', 76, 'Dhaka', 'Mymensingh', 'Phulpur', 'Phulpur', '2250'),
(',77,Dhaka,Mymensingh,Phulpur,Beltia,2251\r\n', 78, 'Dhaka', 'Mymensingh', 'Phulpur', 'Tarakanda', '2252'),
(',79,Dhaka,Mymensingh,Trishal,Trishal,2220\r\n', 80, 'Dhaka', 'Mymensingh', 'Trishal', 'Ahmadbad', '2221'),
(',81,Dhaka,Mymensingh,Trishal,Ram Amritaganj,2222\r\n', 82, 'Dhaka', 'Mymensingh', 'Trishal', 'Dhala', '2223'),
(',83,Dhaka,Kishoreganj,Bajitpur,Bajitpur,2336\r\n', 84, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Sararchar', '2337'),
(',85,Dhaka,Kishoreganj,Bajitpur,Laksmipur,2338\r\n', 86, 'Dhaka', 'Kishoreganj', 'Bhairob', 'Bhairab', '2350'),
(',87,Dhaka,Kishoreganj,Hossenpur,Hossenpur,2320\r\n', 88, 'Dhaka', 'Kishoreganj', 'Itna', 'Itna', '2390'),
(',89,Dhaka,Kishoreganj,Karimganj,Karimganj,2310\r\n', 90, 'Dhaka', 'Kishoreganj', 'Katiadi', 'Katiadi', '2330'),
(',91,Dhaka,Kishoreganj,Katiadi,Gochhihata,2331\r\n', 92, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj Sadar', '2300'),
(',93,Dhaka,Kishoreganj,Kishoreganj Sadar,Kishoreganj S.Mills,2301\r\n', 94, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Maizhati', '2302'),
(',95,Dhaka,Kishoreganj,Kishoreganj Sadar,Nilganj,2303\r\n', 96, 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Kuliarchar', '2340'),
(',97,Dhaka,Kishoreganj,Kuliarchar,Chhoysuti,2341\r\n', 98, 'Dhaka', 'Kishoreganj', 'Mithamoin', 'MIthamoin', '2370'),
(',99,Dhaka,Kishoreganj,Mithamoin,Abdullahpur,2371\r\n', 100, 'Dhaka', 'Kishoreganj', 'Nikli', 'Nikli', '2360'),
(',101,Dhaka,Kishoreganj,Ostagram,Ostagram,2380\r\n', 102, 'Dhaka', 'Kishoreganj', 'Pakundia', 'Pakundia', '2326'),
(',103,Dhaka,Kishoreganj,Tarial,Tarial,2316\r\n', 104, 'Dhaka', 'Netrakona', 'Susung Durgapur', 'IBH WAs Here', '$mart'),
(',105,Dhaka,Netrakona,Susung Durgapur,Susnng Durgapur,2420\r\n', 106, 'Dhaka', 'Netrakona', 'Atpara', 'Atpara', '2470'),
(',107,Dhaka,Netrakona,Barhatta,Barhatta,2440\r\n', 108, 'Dhaka', 'Netrakona', 'Dharmapasha', 'Dharampasha', '2450'),
(',109,Dhaka,Netrakona,Dhobaura,Dhobaura,2416\r\n', 110, 'Dhaka', 'Netrakona', 'Dhobaura', 'Sakoai', '2417'),
(',111,Dhaka,Netrakona,Kalmakanda,Kalmakanda,2430\r\n', 112, 'Dhaka', 'Netrakona', 'Kendua', 'Kendua', '2480'),
(',113,Dhaka,Netrakona,Khaliajuri,Khaliajhri,2460\r\n', 114, 'Dhaka', 'Netrakona', 'Khaliajuri', 'Shaldigha', '2462'),
(',115,Dhaka,Netrakona,Madan,Madan,2490\r\n', 116, 'Dhaka', 'Netrakona', 'Moddhynagar', 'Moddoynagar', '2456'),
(',117,Dhaka,Netrakona,Mohanganj,Mohanganj,2446\r\n', 118, 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Netrakona Sadar', '2400'),
(',119,Dhaka,Netrakona,Netrakona Sadar,Baikherhati,2401\r\n', 120, 'Dhaka', 'Netrakona', 'Purbadhola', 'Purbadhola', '2410'),
(',121,Dhaka,Netrakona,Purbadhola,Shamgonj,2411\r\n', 122, 'Dhaka', 'Netrakona', 'Purbadhola', 'Jaria Jhanjhail', '2412'),
(',123,Dhaka,Narayanganj,Araihazar,Araihazar,1450\r\n', 124, 'Dhaka', 'Narayanganj', 'Araihazar', 'Gopaldi', '1451'),
(',125,Dhaka,Narayanganj,Baidder Bazar,Baidder Bazar,1440\r\n', 126, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Bara Nagar', '1441'),
(',127,Dhaka,Narayanganj,Baidder Bazar,Barodi,1442\r\n', 128, 'Dhaka', 'Narayanganj', 'Bandar', 'Bandar', '1410'),
(',129,Dhaka,Narayanganj,Bandar,D.C Mills,1411\r\n', 130, 'Dhaka', 'Narayanganj', 'Bandar', 'Nabiganj', '1412'),
(',131,Dhaka,Narayanganj,Bandar,BIDS,1413\r\n', 132, 'Dhaka', 'Narayanganj', 'Bandar', 'Madanganj', '1414'),
(',133,Dhaka,Narayanganj,Fatullah,Fatullah,1420\r\n', 134, 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatulla Bazar', '1421'),
(',135,Dhaka,Narayanganj,Narayanganj Sadar,Narayanganj Sadar,1400\r\n', 136, 'Dhaka', 'Narayanganj', 'Rupganj', 'Rupganj', '1460'),
(',137,Dhaka,Narayanganj,Rupganj,Kanchan,1461\r\n', 138, 'Dhaka', 'Narayanganj', 'Rupganj', 'Bhulta', '1462'),
(',139,Dhaka,Narayanganj,Rupganj,Nagri,1463\r\n', 140, 'Dhaka', 'Narayanganj', 'Rupganj', 'Murapara', '1464'),
(',141,Dhaka,Narayanganj,Siddirganj,Siddirganj,1430\r\n', 142, 'Dhaka', 'Narayanganj', 'Siddirganj', 'Adamjeenagar', '1431'),
(',143,Dhaka,Narayanganj,Siddirganj,LN Mills,1432\r\n', 144, 'Dhaka', 'Munshiganj', 'Gajaria', 'Gajaria', '1510'),
(',145,Dhaka,Munshiganj,Gajaria,Hossendi,1511\r\n', 146, 'Dhaka', 'Munshiganj', 'Gajaria', 'Rasulpur', '1512'),
(',147,Dhaka,Munshiganj,Lohajong,Haridia,1333\r\n', 148, 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', '1334'),
(',149,Dhaka,Munshiganj,Lohajong,Madini Mandal,1335\r\n', 150, 'Dhaka', 'Munshiganj', 'Lohajong', 'Lohajang', '1530'),
(',151,Dhaka,Munshiganj,Lohajong,Korhati,1531\r\n', 152, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haldia SO', '1532'),
(',153,Dhaka,Munshiganj,Lohajong,Haridia DESO,1533\r\n', 154, 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', '1534'),
(',155,Dhaka,Munshiganj,Lohajong,Medini Mandal EDSO,1535\r\n', 156, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Munshiganj Sadar', '1500'),
(',157,Dhaka,Munshiganj,Munshiganj Sadar,Rikabibazar,1501\r\n', 158, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Mirkadim', '1502'),
(',159,Dhaka,Munshiganj,Munshiganj Sadar,Kathakhali,1503\r\n', 160, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Sirajdikhan', '1540'),
(',161,Dhaka,Munshiganj,Sirajdikhan,Kola,1541\r\n', 162, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Ichapur', '1542'),
(',163,Dhaka,Munshiganj,Sirajdikhan,Malkha Nagar,1543\r\n', 164, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Shekher Nagar', '1544'),
(',165,Dhaka,Munshiganj,Srinagar,Srinagar,1550\r\n', 166, 'Dhaka', 'Munshiganj', 'Srinagar', 'Barikhal', '1551'),
(',167,Dhaka,Munshiganj,Srinagar,Mazpara,1552\r\n', 168, 'Dhaka', 'Munshiganj', 'Srinagar', 'Hashara', '1553'),
(',169,Dhaka,Munshiganj,Srinagar,Kolapara,1554\r\n', 170, 'Dhaka', 'Munshiganj', 'Srinagar', 'Kumarbhog', '1555'),
(',171,Dhaka,Munshiganj,Srinagar,Vaggyakul SO,1556\r\n', 172, 'Dhaka', 'Munshiganj', 'Srinagar', 'Baghra', '1557'),
(',173,Dhaka,Munshiganj,Srinagar,Bhaggyakul,1558\r\n', 174, 'Dhaka', 'Munshiganj', 'Tangibari', 'Tangibari', '1520'),
(',175,Dhaka,Munshiganj,Tangibari,Betkahat,1521\r\n', 176, 'Dhaka', 'Munshiganj', 'Tangibari', 'Baligao', '1522'),
(',177,Dhaka,Munshiganj,Tangibari,Bajrajugini,1523\r\n', 178, 'Dhaka', 'Munshiganj', 'Tangibari', 'Hasail', '1524'),
(',179,Dhaka,Munshiganj,Tangibari,Dighirpar,1525\r\n', 180, 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura EDSO', '1526'),
(',181,Dhaka,Munshiganj,Tangibari,Pura,1527\r\n', 182, 'Dhaka', 'Narshingdi', 'Belabo', 'Belabo', '1640'),
(',183,Dhaka,Narshingdi,Monohordi,Monohordi,1650\r\n', 184, 'Dhaka', 'Narshingdi', 'Monohordi', 'Hatirdia', '1651'),
(',185,Dhaka,Narshingdi,Monohordi,Katabaria,1652\r\n', 186, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi Sadar', '1600'),
(',187,Dhaka,Narshingdi,Narshingdi Sadar,UMC Jute Mills,1601\r\n', 188, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi College', '1602'),
(',189,Dhaka,Narshingdi,Narshingdi Sadar,Panchdona,1603\r\n', 190, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Madhabdi', '1604'),
(',191,Dhaka,Narshingdi,Narshingdi Sadar,Karimpur,1605\r\n', 192, 'Dhaka', 'Narshingdi', 'Palash', 'Palash', '1610'),
(',193,Dhaka,Narshingdi,Palash,Ghorashal Urea Facto,1611\r\n', 194, 'Dhaka', 'Narshingdi', 'Palash', 'Char Sindhur', '1612'),
(',195,Dhaka,Narshingdi,Palash,Ghorashal,1613\r\n', 196, 'Dhaka', 'Narshingdi', 'Raypura', 'Raypura', '1630'),
(',197,Dhaka,Narshingdi,Raypura,Bazar Hasnabad,1631\r\n', 198, 'Dhaka', 'Narshingdi', 'Raypura', 'Radhaganj bazar', '1632'),
(',199,Dhaka,Narshingdi,Shibpur,Shibpur,1620\r\n', 200, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Gazipur Sadar', '1700'),
(',201,Dhaka,Gazipur,Gazipur Sadar,B.R.R,1701\r\n', 202, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Chandna', '1702'),
(',203,Dhaka,Gazipur,Gazipur Sadar,B.O.F,1703\r\n', 204, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'National University', '1704'),
(',205,Dhaka,Gazipur,Kaliakaar,Kaliakaar,1750\r\n', 206, 'Dhaka', 'Gazipur', 'Kaliakaar', 'Safipur', '1751'),
(',207,Dhaka,Gazipur,Kaliganj,Kaliganj,1720\r\n', 208, 'Dhaka', 'Gazipur', 'Kaliganj', 'Pubail', '1721'),
(',209,Dhaka,Gazipur,Kaliganj,Santanpara,1722\r\n', 210, 'Dhaka', 'Gazipur', 'Kaliganj', 'Vaoal Jamalpur', '1723'),
(',211,Dhaka,Gazipur,Kapashia,kapashia,1730\r\n', 212, 'Dhaka', 'Gazipur', 'Monnunagar', 'Monnunagar', '1710'),
(',213,Dhaka,Gazipur,Monnunagar,Nishat Nagar,1711\r\n', 214, 'Dhaka', 'Gazipur', 'Monnunagar', 'Ershad Nagar', '1712'),
(',215,Dhaka,Gazipur,Sreepur,Sreepur,1740\r\n', 216, 'Dhaka', 'Gazipur', 'Sreepur', 'Barmi', '1743'),
(',217,Dhaka,Gazipur,Sreepur,Satkhamair,1744\r\n', 218, 'Dhaka', 'Gazipur', 'Sreepur', 'Kawraid', '1745'),
(',219,Dhaka,Gazipur,Sreepur,Bashamur,1747\r\n', 220, 'Dhaka', 'Gazipur', 'Sreepur', 'Boubi', '1748'),
(',221,Dhaka,Gazipur,Sripur,Rajendrapur,1741\r\n', 222, 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur Canttome', '1742'),
(',223,Dhaka,Rajbari,Baliakandi,Baliakandi,7730\r\n', 224, 'Dhaka', 'Rajbari', 'Baliakandi', 'Nalia', '7731'),
(',225,Dhaka,Rajbari,Pangsha,Pangsha,7720\r\n', 226, 'Dhaka', 'Rajbari', 'Pangsha', 'Ramkol', '7721'),
(',227,Dhaka,Rajbari,Pangsha,Ratandia,7722\r\n', 228, 'Dhaka', 'Rajbari', 'Pangsha', 'Mrigibazar', '7723'),
(',229,Dhaka,Rajbari,Rajbari Sadar,Rajbari Sadar,7700\r\n', 230, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Goalanda', '7710'),
(',231,Dhaka,Rajbari,Rajbari Sadar,Khankhanapur,7711\r\n', 232, 'Dhaka', 'Faridpur', 'Alfadanga', 'Alfadanga', '7870'),
(',233,Dhaka,Faridpur,Bhanga,Bhanga,7830\r\n', 234, 'Dhaka', 'Faridpur', 'Boalmari', 'Boalmari', '7860'),
(',235,Dhaka,Faridpur,Boalmari,Rupatpat,7861\r\n', 236, 'Dhaka', 'Faridpur', 'Charbhadrasan', 'Charbadrashan', '7810'),
(',237,Dhaka,Faridpur,Faridpur Sadar,Faridpursadar,7800\r\n', 238, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Kanaipur', '7801'),
(',239,Dhaka,Faridpur,Faridpur Sadar,Ambikapur,7802\r\n', 240, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Baitulaman Politecni', '7803'),
(',241,Dhaka,Faridpur,Madukhali,Madukhali,7850\r\n', 242, 'Dhaka', 'Faridpur', 'Madukhali', 'Kamarkali', '7851'),
(',243,Dhaka,Faridpur,Nagarkanda,Nagarkanda,7840\r\n', 244, 'Dhaka', 'Faridpur', 'Nagarkanda', 'Talma', '7841'),
(',245,Dhaka,Faridpur,Sadarpur,Sadarpur,7820\r\n', 246, 'Dhaka', 'Faridpur', 'Sadarpur', 'Hat Krishapur', '7821'),
(',247,Dhaka,Faridpur,Sadarpur,Bishwa jaker Manjil,7822\r\n', 248, 'Dhaka', 'Faridpur', 'Shriangan', 'Shriangan', '7804'),
(',249,Dhaka,Madaripur,Barhamganj,Barhamganj,7930\r\n', 250, 'Dhaka', 'Madaripur', 'Barhamganj', 'Nilaksmibandar', '7931'),
(',251,Dhaka,Madaripur,Barhamganj,Bahadurpur,7932\r\n', 252, 'Dhaka', 'Madaripur', 'Barhamganj', 'Umedpur', '7933'),
(',253,Dhaka,Madaripur,kalkini,Kalkini,7920\r\n', 254, 'Dhaka', 'Madaripur', 'kalkini', 'Sahabrampur', '7921'),
(',255,Dhaka,Madaripur,Madaripur Sadar,Madaripur Sadar,7900\r\n', 256, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Charmugria', '7901'),
(',257,Dhaka,Madaripur,Madaripur Sadar,Kulpaddi,7902\r\n', 258, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Habiganj', '7903'),
(',259,Dhaka,Madaripur,Madaripur Sadar,Mustafapur,7904\r\n', 260, 'Dhaka', 'Madaripur', 'Rajoir', 'Rajoir', '7910'),
(',261,Dhaka,Madaripur,Rajoir,Khalia,7911\r\n', 262, 'Dhaka', 'Shariatpur', 'Bhedorganj', 'Bhedorganj', '8030'),
(',263,Dhaka,Shariatpur,Damudhya,Damudhya,8040\r\n', 264, 'Dhaka', 'Shariatpur', 'Gosairhat', 'Gosairhat', '8050'),
(',265,Dhaka,Shariatpur,Jajira,Jajira,8010\r\n', 266, 'Dhaka', 'Shariatpur', 'Naria', 'Naria', '8020'),
(',267,Dhaka,Shariatpur,Naria,Bhozeshwar,8021\r\n', 268, 'Dhaka', 'Shariatpur', 'Naria', 'Gharisar', '8022'),
(',269,Dhaka,Shariatpur,Naria,Upshi,8023\r\n', 270, 'Dhaka', 'Shariatpur', 'Naria', 'Kartikpur', '8024'),
(',271,Dhaka,Shariatpur,Shariatpur Sadar,Shariatpur Sadar,8000\r\n', 272, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Angaria', '8001'),
(',273,Dhaka,Shariatpur,Shariatpur Sadar,Chikandi,8002\r\n', 274, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Chandradighalia', '8013'),
(',275,Dhaka,Gopalganj,Gopalganj Sadar,Gopalganj Sadar,8100\r\n', 276, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Ulpur', '8101'),
(',277,Dhaka,Gopalganj,Gopalganj Sadar,Barfa,8102\r\n', 278, 'Dhaka', 'Gopalganj', 'Kashiani', 'Kashiani', '8130'),
(',279,Dhaka,Gopalganj,Kashiani,Ramdia College,8131\r\n', 280, 'Dhaka', 'Gopalganj', 'Kashiani', 'Ratoil', '8132'),
(',281,Dhaka,Gopalganj,Kashiani,Jonapur,8133\r\n', 282, 'Dhaka', 'Gopalganj', 'Kotalipara', 'Kotalipara', '8110'),
(',283,Dhaka,Gopalganj,Maksudpur,Maksudpur,8140\r\n', 284, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Batkiamari', '8141'),
(',285,Dhaka,Gopalganj,Maksudpur,Khandarpara,8142\r\n', 286, 'Dhaka', 'Gopalganj', 'Tungipara', 'Tungipara', '8120'),
(',287,Dhaka,Gopalganj,Tungipara,Patgati,8121\r\n', 288, 'Dhaka', 'Manikganj', 'Doulatpur', 'Doulatpur', '1860'),
(',289,Dhaka,Manikganj,Gheor,Gheor,1840\r\n', 290, 'Dhaka', 'Manikganj', 'Lechhraganj', 'Lechhraganj', '1830'),
(',291,Dhaka,Manikganj,Lechhraganj,Jhitka,1831\r\n', 292, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Sadar', '1800'),
(',293,Dhaka,Manikganj,Manikganj Sadar,Manikganj Bazar,1801\r\n', 294, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Gorpara', '1802'),
(',295,Dhaka,Manikganj,Manikganj Sadar,Mahadebpur,1803\r\n', 296, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Barangail', '1804'),
(',297,Dhaka,Manikganj,Saturia,Saturia,1810\r\n', 298, 'Dhaka', 'Manikganj', 'Saturia', 'Baliati', '1811'),
(',299,Dhaka,Manikganj,Shibloya,Shibaloy,1850\r\n', 300, 'Dhaka', 'Manikganj', 'Shibloya', 'Aricha', '1851'),
(',301,Dhaka,Manikganj,Shibloya,Tewta,1852\r\n', 302, 'Dhaka', 'Manikganj', 'Shibloya', 'Uthli', '1853'),
(',303,Dhaka,Manikganj,Singari,Singair,1820\r\n', 304, 'Dhaka', 'Manikganj', 'Singari', 'Baira', '1821'),
(',305,Dhaka,Manikganj,Singari,joymantop,1822\r\n', 306, 'Dhaka', 'Tangail', 'Basail', 'Basail', '1920'),
(',307,Dhaka,Tangail,Bhuapur,Bhuapur,1960\r\n', 308, 'Dhaka', 'Tangail', 'Delduar', 'Delduar', '1910'),
(',309,Dhaka,Tangail,Delduar,Jangalia,1911\r\n', 310, 'Dhaka', 'Tangail', 'Delduar', 'Patharail', '1912'),
(',311,Dhaka,Tangail,Delduar,Elasin,1913\r\n', 312, 'Dhaka', 'Tangail', 'Delduar', 'Hinga Nagar', '1914'),
(',313,Dhaka,Tangail,Delduar,Lowhati,1915\r\n', 314, 'Dhaka', 'Tangail', 'Ghatail', 'Ghatial', '1980'),
(',315,Dhaka,Tangail,Ghatail,Zahidganj,1981\r\n', 316, 'Dhaka', 'Tangail', 'Ghatail', 'D. Pakutia', '1982'),
(',317,Dhaka,Tangail,Ghatail,Dhalapara,1983\r\n', 318, 'Dhaka', 'Tangail', 'Ghatail', 'Lohani', '1984'),
(',319,Dhaka,Tangail,Gopalpur,Gopalpur,1990\r\n', 320, 'Dhaka', 'Tangail', 'Gopalpur', 'Jhowail', '1991'),
(',321,Dhaka,Tangail,Gopalpur,Hemnagar,1992\r\n', 322, 'Dhaka', 'Tangail', 'Kalihati', 'Kalihati', '1970'),
(',323,Dhaka,Tangail,Kalihati,Rajafair,1971\r\n', 324, 'Dhaka', 'Tangail', 'Kalihati', 'Nagbari', '1972'),
(',325,Dhaka,Tangail,Kalihati,Ballabazar,1973\r\n', 326, 'Dhaka', 'Tangail', 'Kalihati', 'Elinga', '1974'),
(',327,Dhaka,Tangail,Kalihati,Palisha,1975\r\n', 328, 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari SO', '1976'),
(',329,Dhaka,Tangail,Kalihati,Nagarbari,1977\r\n', 330, 'Dhaka', 'Tangail', 'Kashkaolia', 'Kashkawlia', '1930'),
(',331,Dhaka,Tangail,Madhupur,Madhupur,1996\r\n', 332, 'Dhaka', 'Tangail', 'Madhupur', 'Dhobari', '1997'),
(',333,Dhaka,Tangail,Mirzapur,Mirzapur,1940\r\n', 334, 'Dhaka', 'Tangail', 'Mirzapur', 'Gorai', '1941'),
(',335,Dhaka,Tangail,Mirzapur,M.C. College,1942\r\n', 336, 'Dhaka', 'Tangail', 'Mirzapur', 'Warri paikpara', '1943'),
(',337,Dhaka,Tangail,Mirzapur,Jarmuki,1944\r\n', 338, 'Dhaka', 'Tangail', 'Mirzapur', 'Mohera', '1945'),
(',339,Dhaka,Tangail,Nagarpur,Nagarpur,1936\r\n', 340, 'Dhaka', 'Tangail', 'Nagarpur', 'Dhuburia', '1937'),
(',341,Dhaka,Tangail,Nagarpur,Salimabad,1938\r\n', 342, 'Dhaka', 'Tangail', 'Sakhipur', 'Sakhipur', '1950'),
(',343,Dhaka,Tangail,Sakhipur,Kochua,1951\r\n', 344, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Tangail Sadar', '1900'),
(',345,Dhaka,Tangail,Tangail Sadar,Kagmari,1901\r\n', 346, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Santosh', '1902'),
(',347,Dhaka,Tangail,Tangail Sadar,Korotia,1903\r\n', 348, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Purabari', '1904'),
(',349,Dhaka,Jamalpur,Dewangonj,Dewangonj,2030\r\n', 350, 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj S. Mills', '2031'),
(',351,Dhaka,Jamalpur,Islampur,Islampur,2020\r\n', 352, 'Dhaka', 'Jamalpur', 'Islampur', 'Durmoot', '2021'),
(',353,Dhaka,Jamalpur,Islampur,Gilabari,2022\r\n', 354, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Jamalpur', '2000'),
(',355,Dhaka,Jamalpur,Jamalpur,Nandina,2001\r\n', 356, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Narundi', '2002'),
(',357,Dhaka,Jamalpur,Malandah,Malandah,2010\r\n', 358, 'Dhaka', 'Jamalpur', 'Malandah', 'Jamalpur', '2011'),
(',359,Dhaka,Jamalpur,Malandah,Malancha,2012\r\n', 360, 'Dhaka', 'Jamalpur', 'Malandah', 'Mahmoodpur', '2013'),
(',361,Dhaka,Jamalpur,Mathargonj,Mathargonj,2040\r\n', 362, 'Dhaka', 'Jamalpur', 'Mathargonj', 'Balijhuri', '2041'),
(',363,Dhaka,Jamalpur,Shorishabari,Shorishabari,2050\r\n', 364, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Gunerbari', '2051'),
(',365,Dhaka,Jamalpur,Shorishabari,Bausee,2052\r\n', 366, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jagannath Ghat', '2053'),
(',367,Dhaka,Jamalpur,Shorishabari,Pingna,2054\r\n', 368, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jamuna Sar Karkhana', '2055'),
(',369,Dhaka,Sherpur,Bakshigonj,Bakshigonj,2140\r\n', 370, 'Dhaka', 'Sherpur', 'Jhinaigati', 'Jhinaigati', '2120'),
(',371,Dhaka,Sherpur,Nakla,Nakla,2150\r\n', 372, 'Dhaka', 'Sherpur', 'Nakla', 'Gonopaddi', '2151'),
(',373,Dhaka,Sherpur,Nalitabari,Nalitabari,2110\r\n', 374, 'Dhaka', 'Sherpur', 'Nalitabari', 'Hatibandha', '2111'),
(',375,Dhaka,Sherpur,Sherpur Shadar,Sherpur Shadar,2100\r\n', 376, 'Dhaka', 'Sherpur', 'Shribardi', 'Shribardi', '2130'),
(',377,Chittagong ,Brahmanbaria,Akhaura,Akhaura,3450\r\n', 378, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Azampur', '3451'),
(',379,Chittagong ,Brahmanbaria,Akhaura,Gangasagar,3452\r\n', 380, 'Chittagong ', 'Brahmanbaria', 'Banchharampur', 'Banchharampur', '3420'),
(',381,Chittagong ,Brahmanbaria,Brahamanbaria Sadar,Brahamanbaria Sadar,3400\r\n', 382, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Talshahar', '3401'),
(',383,Chittagong ,Brahmanbaria,Brahamanbaria Sadar,Ashuganj,3402\r\n', 384, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj Share', '3403'),
(',385,Chittagong ,Brahmanbaria,Brahamanbaria Sadar,Poun,3404\r\n', 386, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kasba', '3460'),
(',387,Chittagong ,Brahmanbaria,Kasba,Kuti,3461\r\n', 388, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chandidar', '3462'),
(',389,Chittagong ,Brahmanbaria,Kasba,Chargachh,3463\r\n', 390, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Gopinathpur', '3464'),
(',391,Chittagong ,Brahmanbaria,Nabinagar,Nabinagar,3410\r\n', 392, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Laubfatehpur', '3411'),
(',393,Chittagong ,Brahmanbaria,Nabinagar,Rasullabad,3412\r\n', 394, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shamgram', '3413'),
(',395,Chittagong ,Brahmanbaria,Nabinagar,Ratanpur,3414\r\n', 396, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shahapur', '3415'),
(',397,Chittagong ,Brahmanbaria,Nabinagar,Kaitala,3417\r\n', 398, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Salimganj', '3418'),
(',399,Chittagong ,Brahmanbaria,Nabinagar,Jibanganj,3419\r\n', 400, 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Nasirnagar', '3440'),
(',401,Chittagong ,Brahmanbaria,Nasirnagar,Fandauk,3441\r\n', 402, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Sarial', '3430'),
(',403,Chittagong ,Brahmanbaria,Sarail,Shahbajpur,3431\r\n', 404, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Chandura', '3432'),
(',405,Chittagong ,Comilla,Barura,Barura,3560\r\n', 406, 'Chittagong ', 'Comilla', 'Barura', 'Poyalgachha', '3561'),
(',407,Chittagong ,Comilla,Barura,Murdafarganj,3562\r\n', 408, 'Chittagong ', 'Comilla', 'Brahmanpara', 'Brahmanpara', '3526'),
(',409,Chittagong ,Comilla,Burichang,Burichang,3520\r\n', 410, 'Chittagong ', 'Comilla', 'Burichang', 'Maynamoti bazar', '3521'),
(',411,Chittagong ,Comilla,Chandina,Chandia,3510\r\n', 412, 'Chittagong ', 'Comilla', 'Chandina', 'Madhaiabazar', '3511'),
(',413,Chittagong ,Comilla,Chouddagram,Chouddagram,3550\r\n', 414, 'Chittagong ', 'Comilla', 'Chouddagram', 'Batisa', '3551'),
(',415,Chittagong ,Comilla,Chouddagram,Chiora,3552\r\n', 416, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Sadar', '3500'),
(',417,Chittagong ,Comilla,Comilla Sadar,Comilla Contoment,3501\r\n', 418, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Halimanagar', '3502'),
(',419,Chittagong ,Comilla,Comilla Sadar,Courtbari,3503\r\n', 420, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Suaganj', '3504'),
(',421,Chittagong ,Comilla,Daudkandi,Daudkandi,3516\r\n', 422, 'Chittagong ', 'Comilla', 'Daudkandi', 'Gouripur', '3517'),
(',423,Chittagong ,Comilla,Daudkandi,Dashpara,3518\r\n', 424, 'Chittagong ', 'Comilla', 'Daudkandi', 'Eliotganj', '3519'),
(',425,Chittagong ,Comilla,Davidhar,Davidhar,3530\r\n', 426, 'Chittagong ', 'Comilla', 'Davidhar', 'Gangamandal', '3531'),
(',427,Chittagong ,Comilla,Davidhar,Barashalghar,3532\r\n', 428, 'Chittagong ', 'Comilla', 'Davidhar', 'Dhamtee', '3533'),
(',429,Chittagong ,Comilla,Homna,Homna,3546\r\n', 430, 'Chittagong ', 'Comilla', 'Laksam', 'Laksam', '3570'),
(',431,Chittagong ,Comilla,Laksam,Lakshamanpur,3571\r\n', 432, 'Chittagong ', 'Comilla', 'Laksam', 'Bipulasar', '3572'),
(',433,Chittagong ,Comilla,Langalkot,Langalkot,3580\r\n', 434, 'Chittagong ', 'Comilla', 'Langalkot', 'Dhalua', '3581'),
(',435,Chittagong ,Comilla,Langalkot,Chhariabazar,3582\r\n', 436, 'Chittagong ', 'Comilla', 'Langalkot', 'Gunabati', '3583'),
(',437,Chittagong ,Comilla,Muradnagar,Muradnagar,3540\r\n', 438, 'Chittagong ', 'Comilla', 'Muradnagar', 'Ramchandarpur', '3541'),
(',439,Chittagong ,Comilla,Muradnagar,Companyganj,3542\r\n', 440, 'Chittagong ', 'Comilla', 'Muradnagar', 'Bangra', '3543'),
(',441,Chittagong ,Comilla,Muradnagar,Sonakanda,3544\r\n', 442, 'Chittagong ', 'Comilla', 'Muradnagar', 'Pantibazar', '3545'),
(',443,Chittagong ,Lakshmipur,Char Alexgander,Char Alexgander,3730\r\n', 444, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Hajirghat', '3731'),
(',445,Chittagong ,Lakshmipur,Char Alexgander,Ramgatirhat,3732\r\n', 446, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Lakshimpur Sadar', '3700'),
(',447,Chittagong ,Lakshmipur,Lakshimpur Sadar,Dalal Bazar,3701\r\n', 448, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Bhabaniganj', '3702'),
(',449,Chittagong ,Lakshmipur,Lakshimpur Sadar,Mandari,3703\r\n', 450, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Keramatganj', '3704'),
(',451,Chittagong ,Lakshmipur,Lakshimpur Sadar,Rupchara,3705\r\n', 452, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Duttapara', '3706'),
(',453,Chittagong ,Lakshmipur,Lakshimpur Sadar,Choupalli,3707\r\n', 454, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Chandraganj', '3708'),
(',455,Chittagong ,Lakshmipur,Lakshimpur Sadar,Amani Lakshimpur,3709\r\n', 456, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Ramganj', '3720'),
(',457,Chittagong ,Lakshmipur,Ramganj,Alipur,3721\r\n', 458, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Panpara', '3722'),
(',459,Chittagong ,Lakshmipur,Ramganj,Kanchanpur,3723\r\n', 460, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Naagmud', '3724'),
(',461,Chittagong ,Lakshmipur,Ramganj,Dolta,3725\r\n', 462, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Raypur', '3710'),
(',463,Chittagong ,Lakshmipur,Raypur,Rakhallia,3711\r\n', 464, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Nagerdighirpar', '3712'),
(',465,Chittagong ,Lakshmipur,Raypur,Haydarganj,3713\r\n', 466, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Bhuabari', '3714'),
(',467,Chittagong ,Noakhali,Basurhat,Basur Hat,3850\r\n', 468, 'Chittagong ', 'Noakhali', 'Basurhat', 'Charhajari', '3851'),
(',469,Chittagong ,Noakhali,Begumganj,Begumganj,3820\r\n', 470, 'Chittagong ', 'Noakhali', 'Begumganj', 'Choumohani', '3821'),
(',471,Chittagong ,Noakhali,Begumganj,Banglabazar,3822\r\n', 472, 'Chittagong ', 'Noakhali', 'Begumganj', 'Mir Owarishpur', '3823'),
(',473,Chittagong ,Noakhali,Begumganj,Bazra,3824\r\n', 474, 'Chittagong ', 'Noakhali', 'Begumganj', 'Jamidar Hat', '3825'),
(',475,Chittagong ,Noakhali,Begumganj,Sonaimuri,3827\r\n', 476, 'Chittagong ', 'Noakhali', 'Begumganj', 'Gopalpur', '3828'),
(',477,Chittagong ,Noakhali,Begumganj,Joynarayanpur,3829\r\n', 478, 'Chittagong ', 'Noakhali', 'Begumganj', 'Alaiarpur', '3831'),
(',479,Chittagong ,Noakhali,Begumganj,Tangirpar,3832\r\n', 480, 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalafat Bazar', '3833'),
(',481,Chittagong ,Noakhali,Begumganj,Rajganj,3834\r\n', 482, 'Chittagong ', 'Noakhali', 'Begumganj', 'Oachhekpur', '3835'),
(',483,Chittagong ,Noakhali,Begumganj,Bhabani Jibanpur,3837\r\n', 484, 'Chittagong ', 'Noakhali', 'Begumganj', 'Maheshganj', '3838'),
(',485,Chittagong ,Noakhali,Begumganj,Nadona,3839\r\n', 486, 'Chittagong ', 'Noakhali', 'Begumganj', 'Nandiapara', '3841'),
(',487,Chittagong ,Noakhali,Begumganj,Khalishpur,3842\r\n', 488, 'Chittagong ', 'Noakhali', 'Begumganj', 'Dauti', '3843'),
(',489,Chittagong ,Noakhali,Begumganj,Joyag,3844\r\n', 490, 'Chittagong ', 'Noakhali', 'Begumganj', 'Thanar Hat', '3845'),
(',491,Chittagong ,Noakhali,Begumganj,Amisha Para,3847\r\n', 492, 'Chittagong ', 'Noakhali', 'Begumganj', 'Durgapur', '3848'),
(',493,Chittagong ,Noakhali,Chatkhil,Chatkhil,3870\r\n', 494, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Palla', '3871'),
(',495,Chittagong ,Noakhali,Chatkhil,Khilpara,3872\r\n', 496, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bodalcourt', '3873'),
(',497,Chittagong ,Noakhali,Chatkhil,Rezzakpur,3874\r\n', 498, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Solla', '3875'),
(',499,Chittagong ,Noakhali,Chatkhil,Karihati,3877\r\n', 500, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Dosh Gharia', '3878'),
(',501,Chittagong ,Noakhali,Chatkhil,Bansa Bazar,3879\r\n', 502, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sahapur', '3881'),
(',503,Chittagong ,Noakhali,Chatkhil,Sampara,3882\r\n', 504, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Shingbahura', '3883'),
(',505,Chittagong ,Noakhali,Hatiya,Hatiya,3890\r\n', 506, 'Chittagong ', 'Noakhali', 'Hatiya', 'Afazia', '3891'),
(',507,Chittagong ,Noakhali,Hatiya,Tamoraddi,3892\r\n', 508, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali Sadar', '3800'),
(',509,Chittagong ,Noakhali,Noakhali Sadar,Noakhali College,3801\r\n', 510, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Sonapur', '3802'),
(',511,Chittagong ,Noakhali,Noakhali Sadar,Din Monir Hat,3803\r\n', 512, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Pak Kishoreganj', '3804'),
(',513,Chittagong ,Noakhali,Noakhali Sadar,Mriddarhat,3806\r\n', 514, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Kabirhat', '3807'),
(',515,Chittagong ,Noakhali,Noakhali Sadar,Khalifar Hat,3808\r\n', 516, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Charam Tua', '3809'),
(',517,Chittagong ,Noakhali,Noakhali Sadar,Chaprashir Hat,3811\r\n', 518, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Char Jabbar', '3812'),
(',519,Chittagong ,Noakhali,Senbag,Senbag,3860\r\n', 520, 'Chittagong ', 'Noakhali', 'Senbag', 'Kallyandi', '3861'),
(',521,Chittagong ,Noakhali,Senbag,Beezbag,3862\r\n', 522, 'Chittagong ', 'Noakhali', 'Senbag', 'Kankirhat', '3863'),
(',523,Chittagong ,Noakhali,Senbag,Chatarpaia,3864\r\n', 524, 'Chittagong ', 'Noakhali', 'Senbag', 'T.P. Lamua', '3865'),
(',525,Chittagong ,Feni,Chhagalnaia,Chhagalnaia,3910\r\n', 526, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Maharajganj', '3911'),
(',527,Chittagong ,Feni,Chhagalnaia,Daraga Hat,3912\r\n', 528, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Puabashimulia', '3913'),
(',529,Chittagong ,Feni,Dagonbhuia,Dagondhuia,3920\r\n', 530, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dudmukha', '3921'),
(',531,Chittagong ,Feni,Dagonbhuia,Chhilonia,3922\r\n', 532, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Rajapur', '3923'),
(',533,Chittagong ,Feni,Feni Sadar,Feni Sadar,3900\r\n', 534, 'Chittagong ', 'Feni', 'Feni Sadar', 'Fazilpur', '3901'),
(',535,Chittagong ,Feni,Feni Sadar,Sharshadie,3902\r\n', 536, 'Chittagong ', 'Feni', 'Feni Sadar', 'Laskarhat', '3903'),
(',537,Chittagong ,Feni,Pashurampur,Pashurampur,3940\r\n', 538, 'Chittagong ', 'Feni', 'Pashurampur', 'Shuarbazar', '3941'),
(',539,Chittagong ,Feni,Pashurampur,Fulgazi,3942\r\n', 540, 'Chittagong ', 'Feni', 'Pashurampur', 'Munshirhat', '3943'),
(',541,Chittagong ,Feni,Sonagazi,Sonagazi,3930\r\n', 542, 'Chittagong ', 'Feni', 'Sonagazi', 'Motiganj', '3931'),
(',543,Chittagong ,Feni,Sonagazi,Ahmadpur,3932\r\n', 544, 'Chittagong ', 'Feni', 'Sonagazi', 'Kazirhat', '3933'),
(',545,Chittagong ,Chittagong,Anawara,Anowara,4376\r\n', 546, 'Chittagong ', 'Chittagong', 'Anawara', 'Paroikora', '4377'),
(',547,Chittagong ,Chittagong,Anawara,Battali,4378\r\n', 548, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kanungopara', '4363'),
(',549,Chittagong ,Chittagong,Boalkhali,Saroatoli,4364\r\n', 550, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Iqbal Park', '4365'),
(',551,Chittagong ,Chittagong,Boalkhali,Boalkhali,4366\r\n', 552, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Sakpura', '4367'),
(',553,Chittagong ,Chittagong,Boalkhali,Kadurkhal,4368\r\n', 554, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Charandwip', '4369'),
(',555,Chittagong ,Chittagong,Chittagong Sadar,Chittagong GPO,4000\r\n', 556, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Bandar', '4100'),
(',557,Chittagong ,Chittagong,Chittagong Sadar,Pahartoli,4202\r\n', 558, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chawkbazar', '4203'),
(',559,Chittagong ,Chittagong,Chittagong Sadar,Patenga,4204\r\n', 560, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Airport', '4205'),
(',561,Chittagong ,Chittagong,Chittagong Sadar,Jaldia Merine Accade,4206\r\n', 562, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Firozshah', '4207'),
(',563,Chittagong ,Chittagong,Chittagong Sadar,Mohard,4208\r\n', 564, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Politechnic In', '4209'),
(',565,Chittagong ,Chittagong,Chittagong Sadar,Bayezid Bostami,4210\r\n', 566, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Amin Jute Mills', '4211'),
(',567,Chittagong ,Chittagong,Chittagong Sadar,Chandgaon,4212\r\n', 568, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Wazedia', '4213'),
(',569,Chittagong ,Chittagong,Chittagong Sadar,Jalalabad,4214\r\n', 570, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Anandabazar', '4215'),
(',571,Chittagong ,Chittagong,Chittagong Sadar,Halishahar,4216\r\n', 572, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Katuli', '4217'),
(',573,Chittagong ,Chittagong,Chittagong Sadar,Chitt. Sailers Colon,4218\r\n', 574, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Customs Acca', '4219'),
(',575,Chittagong ,Chittagong,Chittagong Sadar,Chitt. Cantonment,4220\r\n', 576, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Al- Amin Baria Madra', '4221'),
(',577,Chittagong ,Chittagong,Chittagong Sadar,Middle Patenga,4222\r\n', 578, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Export Processing', '4223'),
(',579,Chittagong ,Chittagong,Chittagong Sadar,Rampura TSO,4224\r\n', 580, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishshar', '4225'),
(',581,Chittagong ,Chittagong,Chittagong Sadar,North Halishahar,4226\r\n', 582, 'Chittagong ', 'Chittagong', 'East Joara', 'East Joara', '4380'),
(',583,Chittagong ,Chittagong,East Joara,Gachbaria,4381\r\n', 584, 'Chittagong ', 'Chittagong', 'East Joara', 'Dohazari', '4382'),
(',585,Chittagong ,Chittagong,East Joara,Barma,4383\r\n', 586, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Fatikchhari', '4350'),
(',587,Chittagong ,Chittagong,Fatikchhari,Nanupur,4351\r\n', 588, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Bhandar Sharif', '4352'),
(',589,Chittagong ,Chittagong,Fatikchhari,Najirhat,4353\r\n', 590, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Harualchhari', '4354'),
(',591,Chittagong ,Chittagong,Fatikchhari,Narayanhat,4355\r\n', 592, 'Chittagong ', 'Chittagong', 'Hathazari', 'Hathazari', '4330'),
(',593,Chittagong ,Chittagong,Hathazari,Chitt.University,4331\r\n', 594, 'Chittagong ', 'Chittagong', 'Hathazari', 'Gorduara', '4332'),
(',595,Chittagong ,Chittagong,Hathazari,Katirhat,4333\r\n', 596, 'Chittagong ', 'Chittagong', 'Hathazari', 'Mirzapur', '4334'),
(',597,Chittagong ,Chittagong,Hathazari,Fatahabad,4335\r\n', 598, 'Chittagong ', 'Chittagong', 'Hathazari', 'Nuralibari', '4337'),
(',599,Chittagong ,Chittagong,Hathazari,Yunus Nagar,4338\r\n', 600, 'Chittagong ', 'Chittagong', 'Hathazari', 'Madrasa', '4339'),
(',601,Chittagong ,Chittagong,Jaldi,Jaldi,4390\r\n', 602, 'Chittagong ', 'Chittagong', 'Jaldi', 'Khan Bahadur', '4391'),
(',603,Chittagong ,Chittagong,Jaldi,Gunagari,4392\r\n', 604, 'Chittagong ', 'Chittagong', 'Jaldi', 'Banigram', '4393'),
(',605,Chittagong ,Chittagong,Lohagara,Lohagara,4396\r\n', 606, 'Chittagong ', 'Chittagong', 'Lohagara', 'Padua', '4397'),
(',607,Chittagong ,Chittagong,Lohagara,Chunti,4398\r\n', 608, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mirsharai', '4320'),
(',609,Chittagong ,Chittagong,Mirsharai,Abutorab,4321\r\n', 610, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Darrogahat', '4322'),
(',611,Chittagong ,Chittagong,Mirsharai,Bharawazhat,4323\r\n', 612, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Joarganj', '4324'),
(',613,Chittagong ,Chittagong,Mirsharai,Azampur,4325\r\n', 614, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Korerhat', '4327'),
(',615,Chittagong ,Chittagong,Mirsharai,Mohazanhat,4328\r\n', 616, 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Patia Head Office', '4370'),
(',617,Chittagong ,Chittagong,Patia Head Office,Budhpara,4371\r\n', 618, 'Chittagong ', 'Chittagong', 'Rangunia', 'Rangunia', '4360'),
(',619,Chittagong ,Chittagong,Rangunia,Dhamair,4361\r\n', 620, 'Chittagong ', 'Chittagong', 'Rouzan', 'Rouzan', '4340'),
(',621,Chittagong ,Chittagong,Rouzan,Beenajuri,4341\r\n', 622, 'Chittagong ', 'Chittagong', 'Rouzan', 'Kundeshwari', '4342'),
(',623,Chittagong ,Chittagong,Rouzan,Gahira,4343\r\n', 624, 'Chittagong ', 'Chittagong', 'Rouzan', 'jagannath Hat', '4344'),
(',625,Chittagong ,Chittagong,Rouzan,Fatepur,4345\r\n', 626, 'Chittagong ', 'Chittagong', 'Rouzan', 'Guzra Noapara', '4346'),
(',627,Chittagong ,Chittagong,Rouzan,Dewanpur,4347\r\n', 628, 'Chittagong ', 'Chittagong', 'Rouzan', 'Mohamuni', '4348'),
(',629,Chittagong ,Chittagong,Rouzan,B.I.T Post Office,4349\r\n', 630, 'Chittagong ', 'Chittagong', 'Sandwip', 'Sandwip', '4300'),
(',631,Chittagong ,Chittagong,Sandwip,Shiberhat,4301\r\n', 632, 'Chittagong ', 'Chittagong', 'Sandwip', 'Urirchar', '4302'),
(',633,Chittagong ,Chittagong,Satkania,Satkania,4386\r\n', 634, 'Chittagong ', 'Chittagong', 'Satkania', 'Baitul Ijjat', '4387'),
(',635,Chittagong ,Chittagong,Satkania,Bazalia,4388\r\n', 636, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Sitakunda', '4310'),
(',637,Chittagong ,Chittagong,Sitakunda,Baroidhala,4311\r\n', 638, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Barabkunda', '4312'),
(',639,Chittagong ,Chittagong,Sitakunda,Bawashbaria,4313\r\n', 640, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Kumira', '4314'),
(',641,Chittagong ,Chittagong,Sitakunda,Bhatiari,4315\r\n', 642, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Fouzdarhat', '4316'),
(',643,Chittagong ,Chittagong,Sitakunda,Jafrabad,4317\r\n', 644, 'Chittagong ', 'Khagrachari', 'Diginala', 'Diginala', '4420'),
(',645,Chittagong ,Khagrachari,Khagrachari Sadar,Khagrachari Sadar,4400\r\n', 646, 'Chittagong ', 'Khagrachari', 'Laxmichhari', 'Laxmichhari', '4470'),
(',647,Chittagong ,Khagrachari,Mahalchhari,Mahalchhari,4430\r\n', 648, 'Chittagong ', 'Khagrachari', 'Manikchhari', 'Manikchhari', '4460'),
(',649,Chittagong ,Khagrachari,Matiranga,Matiranga,4450\r\n', 650, 'Chittagong ', 'Khagrachari', 'Panchhari', 'Panchhari', '4410'),
(',651,Chittagong ,Khagrachari,Ramghar Head Office,Ramghar Head Office,4440\r\n', 652, 'Chittagong ', 'Rangamati', 'Barakal', 'Barakal', '4570'),
(',653,Chittagong ,Rangamati,Bilaichhari,Bilaichhari,4550\r\n', 654, 'Chittagong ', 'Rangamati', 'Jarachhari', 'Jarachhari', '4560'),
(',655,Chittagong ,Rangamati,Kalampati,Kalampati,4510\r\n', 656, 'Chittagong ', 'Rangamati', 'Kalampati', 'Betbunia', '4511'),
(',657,Chittagong ,Rangamati,kaptai,Kaptai,4530\r\n', 658, 'Chittagong ', 'Rangamati', 'kaptai', 'Chandraghona', '4531'),
(',659,Chittagong ,Rangamati,kaptai,Kaptai Project,4532\r\n', 660, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Nuton Bazar', '4533'),
(',661,Chittagong ,Rangamati,Longachh,Longachh,4580\r\n', 662, 'Chittagong ', 'Rangamati', 'Marishya', 'Marishya', '4590'),
(',663,Chittagong ,Rangamati,Naniachhar,Nanichhar,4520\r\n', 664, 'Chittagong ', 'Rangamati', 'Rajsthali', 'Rajsthali', '4540'),
(',665,Chittagong ,Rangamati,Rangamati Sadar,Rangamati Sadar,4500\r\n', 666, 'Chittagong ', 'Bandarban', 'Alikadam', 'Alikadam', '4650'),
(',667,Chittagong ,Bandarban,Bandarban Sadar,Bandarban Sadar,4600\r\n', 668, 'Chittagong ', 'Bandarban', 'Naikhong', 'Naikhong', '4660'),
(',669,Chittagong ,Bandarban,Roanchhari,Roanchhari,4610\r\n', 670, 'Chittagong ', 'Bandarban', 'Ruma', 'Ruma', '4620'),
(',671,Chittagong ,Bandarban,Thanchi,Thanchi,4630\r\n', 672, 'Chittagong ', 'Bandarban', 'Thanchi', 'Lama', '4641'),
(',673,Chittagong ,Coxs Bazar,Chiringga,Chiringga,4740\r\n', 674, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga S.O', '4741'),
(',675,Chittagong ,Coxs Bazar,Chiringga,Badarkali,4742\r\n', 676, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Malumghat', '4743'),
(',677,Chittagong ,Coxs Bazar,Coxs Bazar Sadar,Coxs Bazar Sadar,4700\r\n', 678, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Zhilanja', '4701'),
(',679,Chittagong ,Coxs Bazar,Coxs Bazar Sadar,Eidga,4702\r\n', 680, 'Chittagong ', 'Coxs Bazar', 'Gorakghat', 'Gorakghat', '4710'),
(',681,Chittagong ,Coxs Bazar,Kutubdia,Kutubdia,4720\r\n', 682, 'Chittagong ', 'Coxs Bazar', 'Ramu', 'Ramu', '4730'),
(',683,Chittagong ,Coxs Bazar,Teknaf,Teknaf,4760\r\n', 684, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Hnila', '4761'),
(',685,Chittagong ,Coxs Bazar,Teknaf,St.Martin,4762\r\n', 686, 'Chittagong ', 'Coxs Bazar', 'Ukhia', 'Ukhia', '4750'),
(',687,Khulna ,Kustia,Bheramara,Bheramara,7040\r\n', 688, 'Khulna ', 'Kustia', 'Bheramara', 'Ganges Bheramara', '7041'),
(',689,Khulna ,Kustia,Bheramara,Allardarga,7042\r\n', 690, 'Khulna ', 'Kustia', 'Janipur', 'Janipur', '7020'),
(',691,Khulna ,Kustia,Janipur,Khoksa,7021\r\n', 692, 'Khulna ', 'Kustia', 'Kumarkhali', 'Kumarkhali', '7010'),
(',693,Khulna ,Kustia,Kumarkhali,Panti,7011\r\n', 694, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kustia Sadar', '7000'),
(',695,Khulna ,Kustia,Kustia Sadar,Kushtia Mohini,7001\r\n', 696, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Jagati', '7002'),
(',697,Khulna ,Kustia,Kustia Sadar,Islami University,7003\r\n', 698, 'Khulna ', 'Kustia', 'Mirpur', 'Mirpur', '7030'),
(',699,Khulna ,Kustia,Mirpur,Poradaha,7031\r\n', 700, 'Khulna ', 'Kustia', 'Mirpur', 'Amla Sadarpur', '7032'),
(',701,Khulna ,Kustia,Rafayetpur,Rafayetpur,7050\r\n', 702, 'Khulna ', 'Kustia', 'Rafayetpur', 'Taragunia', '7051'),
(',703,Khulna ,Kustia,Rafayetpur,Khasmathurapur,7052\r\n', 704, 'Khulna ', 'Meherpur', 'Gangni', 'Gangni', '7110'),
(',705,Khulna ,Meherpur,Meherpur Sadar,Meherpur Sadar,7100\r\n', 706, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', '7101'),
(',707,Khulna ,Meherpur,Meherpur Sadar,Mujib Nagar Complex,7102\r\n', 708, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', '7152'),
(',709,Khulna ,Chuadanga,Alamdanga,Alamdanga,7210\r\n', 710, 'Khulna ', 'Chuadanga', 'Alamdanga', 'Hardi', '7211'),
(',711,Khulna ,Chuadanga,Chuadanga Sadar,Chuadanga Sadar,7200\r\n', 712, 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Munshiganj', '7201'),
(',713,Khulna ,Chuadanga,Damurhuda,Damurhuda,7220\r\n', 714, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Darshana', '7221'),
(',715,Khulna ,Chuadanga,Damurhuda,Andulbaria,7222\r\n', 716, 'Khulna ', 'Chuadanga', 'Doulatganj', 'Doulatganj', '7230'),
(',717,Khulna ,Jinaidaha,Harinakundu,Harinakundu,7310\r\n', 718, 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Sadar', '7300'),
(',719,Khulna ,Jinaidaha,Jinaidaha Sadar,Jinaidaha Cadet College,7301\r\n', 720, 'Khulna ', 'Jinaidaha', 'Kotchandpur', 'Kotchandpur', '7330'),
(',721,Khulna ,Jinaidaha,Maheshpur,Maheshpur,7340\r\n', 722, 'Khulna ', 'Jinaidaha', 'Naldanga', 'Naldanga', '7350'),
(',723,Khulna ,Jinaidaha,Naldanga,Hatbar Bazar,7351\r\n', 724, 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Shailakupa', '7320'),
(',725,Khulna ,Jinaidaha,Shailakupa,Kumiradaha,7321\r\n', 726, 'Khulna ', 'Jessore', 'Bagharpara', 'Bagharpara', '7470'),
(',727,Khulna ,Jessore,Bagharpara,Gouranagar,7471\r\n', 728, 'Khulna ', 'Jessore', 'Chaugachha', 'Chougachha', '7410'),
(',729,Khulna ,Jessore,Jessore Sadar,Jessore Sadar,7400\r\n', 730, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Upa-Shahar', '7401'),
(',731,Khulna ,Jessore,Jessore Sadar,Chanchra,7402\r\n', 732, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore canttonment', '7403'),
(',733,Khulna ,Jessore,Jessore Sadar,Jessore Airbach,7404\r\n', 734, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Rupdia', '7405'),
(',735,Khulna ,Jessore,Jessore Sadar,Basundia,7406\r\n', 736, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Churamankathi', '7407'),
(',737,Khulna ,Jessore,Jhikargachha,Jhikargachha,7420\r\n', 738, 'Khulna ', 'Jessore', 'Keshabpur', 'Keshobpur', '7450'),
(',739,Khulna ,Jessore,Monirampur,Monirampur,7440\r\n', 740, 'Khulna ', 'Jessore', 'Noapara', 'Noapara', '7460'),
(',741,Khulna ,Jessore,Noapara,Rajghat,7461\r\n', 742, 'Khulna ', 'Jessore', 'Noapara', 'Bhugilhat', '7462'),
(',743,Khulna ,Jessore,Sarsa,Sarsa,7430\r\n', 744, 'Khulna ', 'Jessore', 'Sarsa', 'Benapole', '7431'),
(',745,Khulna ,Jessore,Sarsa,Jadabpur,7432\r\n', 746, 'Khulna ', 'Jessore', 'Sarsa', 'Bag Achra', '7433'),
(',747,Khulna ,Narail,Kalia,Kalia,7520\r\n', 748, 'Khulna ', 'Narail', 'Laxmipasha', 'Laxmipasha', '7510'),
(',749,Khulna ,Narail,Laxmipasha,Lohagora,7511\r\n', 750, 'Khulna ', 'Narail', 'Laxmipasha', 'Itna', '7512'),
(',751,Khulna ,Narail,Laxmipasha,Naldi,7513\r\n', 752, 'Khulna ', 'Narail', 'Laxmipasha', 'Baradia', '7514'),
(',753,Khulna ,Narail,Mohajan,Mohajan,7521\r\n', 754, 'Khulna ', 'Narail', 'Narail Sadar', 'Narail Sadar', '7500'),
(',755,Khulna ,Narail,Narail Sadar,Ratanganj,7501\r\n', 756, 'Khulna ', 'Magura', 'Arpara', 'Arpara', '7620'),
(',757,Khulna ,Magura,Magura Sadar,Magura Sadar,7600\r\n', 758, 'Khulna ', 'Magura', 'Mohammadpur', 'Mohammadpur', '7630'),
(',759,Khulna ,Magura,Mohammadpur,Binodpur,7631\r\n', 760, 'Khulna ', 'Magura', 'Mohammadpur', 'Nahata', '7632'),
(',761,Khulna ,Magura,Shripur,Shripur,7610\r\n', 762, 'Khulna ', 'Magura', 'Shripur', 'Langalbadh', '7611'),
(',763,Khulna ,Magura,Shripur,Nachol,7612\r\n', 764, 'Khulna ', 'Khulna', 'Alaipur', 'Alaipur', '9240'),
(',765,Khulna ,Khulna,Alaipur,Rupsha,9241\r\n', 766, 'Khulna ', 'Khulna', 'Alaipur', 'Belphulia', '9242'),
(',767,Khulna ,Khulna,Batiaghat,Batiaghat,9260\r\n', 768, 'Khulna ', 'Khulna', 'Batiaghat', 'Surkalee', '9261'),
(',769,Khulna ,Khulna,Chalna Bazar,Chalna Bazar,9270\r\n', 770, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Dakup', '9271'),
(',771,Khulna ,Khulna,Chalna Bazar,Bajua,9272\r\n', 772, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Nalian', '9273'),
(',773,Khulna ,Khulna,Digalia,Digalia,9220\r\n', 774, 'Khulna ', 'Khulna', 'Digalia', 'Chandni Mahal', '9221'),
(',775,Khulna ,Khulna,Digalia,Senhati,9222\r\n', 776, 'Khulna ', 'Khulna', 'Digalia', 'Ghoshghati', '9223'),
(',777,Khulna ,Khulna,Digalia,Gazirhat,9224\r\n', 778, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna G.P.O', '9000'),
(',779,Khulna ,Khulna,Khulna Sadar,Khula Sadar,9100\r\n', 780, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna Shipyard', '9201'),
(',781,Khulna ,Khulna,Khulna Sadar,Doulatpur,9202\r\n', 782, 'Khulna ', 'Khulna', 'Khulna Sadar', 'BIT Khulna', '9203'),
(',783,Khulna ,Khulna,Khulna Sadar,Siramani,9204\r\n', 784, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Jahanabad Canttonmen', '9205'),
(',785,Khulna ,Khulna,Khulna Sadar,Sonali Jute Mills,9206\r\n', 786, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Atra Shilpa Area', '9207'),
(',787,Khulna ,Khulna,Khulna Sadar,Khulna University,9208\r\n', 788, 'Khulna ', 'Khulna', 'Madinabad', 'Madinabad', '9290'),
(',789,Khulna ,Khulna,Madinabad,Amadee,9291\r\n', 790, 'Khulna ', 'Khulna', 'Paikgachha', 'Paikgachha', '9280'),
(',791,Khulna ,Khulna,Paikgachha,Godaipur,9281\r\n', 792, 'Khulna ', 'Khulna', 'Paikgachha', 'Kapilmoni', '9282'),
(',793,Khulna ,Khulna,Paikgachha,Katipara,9283\r\n', 794, 'Khulna ', 'Khulna', 'Paikgachha', 'Chandkhali', '9284'),
(',795,Khulna ,Khulna,Paikgachha,Garaikhali,9285\r\n', 796, 'Khulna ', 'Khulna', 'Phultala', 'Phultala', '9210'),
(',797,Khulna ,Khulna,Sajiara,Sajiara,9250\r\n', 798, 'Khulna ', 'Khulna', 'Sajiara', 'Ghonabanda', '9251'),
(',799,Khulna ,Khulna,Sajiara,Chuknagar,9252\r\n', 800, 'Khulna ', 'Khulna', 'Sajiara', 'Shahapur', '9253'),
(',801,Khulna ,Khulna,Terakhada,Terakhada,9230\r\n', 802, 'Khulna ', 'Khulna', 'Terakhada', 'Pak Barasat', '9231'),
(',803,Khulna ,IBH WAs Here,Bagerhat Sadar,Bagerhat Sadar,9300\r\n', 804, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'P.C College', '9301'),
(',805,Khulna ,IBH WAs Here,Bagerhat Sadar,Rangdia,9302\r\n', 806, 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Chalna Ankorage', '9350'),
(',807,Khulna ,IBH WAs Here,Chalna Ankorage,Mongla Port,9351\r\n', 808, 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Chitalmari', '9360'),
(',809,Khulna ,IBH WAs Here,Chitalmari,Barabaria,9361\r\n', 810, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Fakirhat', '9370'),
(',811,Khulna ,IBH WAs Here,Fakirhat,Mansa,9371\r\n', 812, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Bhanganpar Bazar', '9372'),
(',813,Khulna ,IBH WAs Here,Kachua UPO,Kachua,9310\r\n', 814, 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Sonarkola', '9311'),
(',815,Khulna ,IBH WAs Here,Mollahat,Mollahat,9380\r\n', 816, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Kahalpur', '9381'),
(',817,Khulna ,IBH WAs Here,Mollahat,Dariala,9382\r\n', 818, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Charkulia', '9383'),
(',819,Khulna ,IBH WAs Here,Mollahat,Nagarkandi,9384\r\n', 820, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Pak Gangni', '9385'),
(',821,Khulna ,IBH WAs Here,Morelganj,Morelganj,9320\r\n', 822, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Sannasi Bazar', '9321'),
(',823,Khulna ,IBH WAs Here,Morelganj,Telisatee,9322\r\n', 824, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Rampal', '9340'),
(',825,Khulna ,IBH WAs Here,Rampal,Foylahat,9341\r\n', 826, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Sonatunia', '9342'),
(',827,Khulna ,IBH WAs Here,Rampal,Gourambha,9343\r\n', 828, 'Khulna ', 'IBH WAs Here', 'Rayenda', 'Rayenda', '9330');
INSERT INTO `TABLE 2` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`, `COL 7`) VALUES
(',829,Khulna ,Satkhira,Ashashuni,Ashashuni,9460\r\n', 830, 'Khulna ', 'Satkhira', 'Ashashuni', 'Baradal', '9461'),
(',831,Khulna ,Satkhira,Debbhata,Debbhata,9430\r\n', 832, 'Khulna ', 'Satkhira', 'Debbhata', 'Gurugram', '9431'),
(',833,Khulna ,Satkhira,kalaroa,kalaroa,9410\r\n', 834, 'Khulna ', 'Satkhira', 'kalaroa', 'Murarikati', '9411'),
(',835,Khulna ,Satkhira,kalaroa,Jhaudanga,9412\r\n', 836, 'Khulna ', 'Satkhira', 'kalaroa', 'Hamidpur', '9413'),
(',837,Khulna ,Satkhira,kalaroa,Khordo,9414\r\n', 838, 'Khulna ', 'Satkhira', 'kalaroa', 'Chandanpur', '9415'),
(',839,Khulna ,Satkhira,Kaliganj UPO,Kaliganj UPO,9440\r\n', 840, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Nalta Mubaroknagar', '9441'),
(',841,Khulna ,Satkhira,Kaliganj UPO,Ratanpur,9442\r\n', 842, 'Khulna ', 'Satkhira', 'Nakipur', 'Nakipur', '9450'),
(',843,Khulna ,Satkhira,Nakipur,Noornagar,9451\r\n', 844, 'Khulna ', 'Satkhira', 'Nakipur', 'Naobeki', '9452'),
(',845,Khulna ,Satkhira,Nakipur,Buri Goalini,9453\r\n', 846, 'Khulna ', 'Satkhira', 'Nakipur', 'Gabura', '9454'),
(',847,Khulna ,Satkhira,Nakipur,Habinagar,9455\r\n', 848, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Sadar', '9400'),
(',849,Khulna ,Satkhira,Satkhira Sadar,Satkhira Islamia Acc,9401\r\n', 850, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Gunakar kati', '9402'),
(',851,Khulna ,Satkhira,Satkhira Sadar,Budhhat,9403\r\n', 852, 'Khulna ', 'Satkhira', 'Taala', 'Taala', '9420'),
(',853,Khulna ,Satkhira,Taala,Patkelghata,9421\r\n', 854, 'Sylhet ', 'Sunamganj', 'Bishamsarpur', 'Bishamsapur', '3010'),
(',855,Sylhet ,Sunamganj,Chhatak,Chhatak,3080\r\n', 856, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Cement Facto', '3081'),
(',857,Sylhet ,Sunamganj,Chhatak,Chhatak Paper Mills,3082\r\n', 858, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj', '3083'),
(',859,Sylhet ,Sunamganj,Chhatak,Gabindaganj Natun Ba,3084\r\n', 860, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Khurma', '3085'),
(',861,Sylhet ,Sunamganj,Chhatak,Moinpur,3086\r\n', 862, 'Sylhet ', 'Sunamganj', 'Chhatak', 'jahidpur', '3087'),
(',863,Sylhet ,Sunamganj,Chhatak,Islamabad,3088\r\n', 864, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chourangi Bazar', '3893'),
(',865,Sylhet ,Sunamganj,Dhirai Chandpur,Dhirai Chandpur,3040\r\n', 866, 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Jagdal', '3041'),
(',867,Sylhet ,Sunamganj,Duara bazar,Duara bazar,3070\r\n', 868, 'Sylhet ', 'Sunamganj', 'Ghungiar', 'Ghungiar', '3050'),
(',869,Sylhet ,Sunamganj,Jagnnathpur,Jagnnathpur,3060\r\n', 870, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Syedpur', '3061'),
(',871,Sylhet ,Sunamganj,Jagnnathpur,Atuajan,3062\r\n', 872, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Hasan Fatemapur', '3063'),
(',873,Sylhet ,Sunamganj,Jagnnathpur,Rasulganj,3064\r\n', 874, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Shiramsi', '3065'),
(',875,Sylhet ,Sunamganj,Sachna,Sachna,3020\r\n', 876, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Sunamganj Sadar', '3000'),
(',877,Sylhet ,Sunamganj,Sunamganj Sadar,Pagla,3001\r\n', 878, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Patharia', '3002'),
(',879,Sylhet ,Sunamganj,Tahirpur,Tahirpur,3030\r\n', 880, 'Sylhet ', 'Sylhet', 'Balaganj', 'Balaganj', '3120'),
(',881,Sylhet ,Sylhet,Balaganj,Karua,3121\r\n', 882, 'Sylhet ', 'Sylhet', 'Balaganj', 'Brahman Shashon', '3122'),
(',883,Sylhet ,Sylhet,Balaganj,Tajpur,3123\r\n', 884, 'Sylhet ', 'Sylhet', 'Balaganj', 'Goala Bazar', '3124'),
(',885,Sylhet ,Sylhet,Balaganj,Begumpur,3125\r\n', 886, 'Sylhet ', 'Sylhet', 'Balaganj', 'Omarpur', '3126'),
(',887,Sylhet ,Sylhet,Balaganj,Kathal Khair,3127\r\n', 888, 'Sylhet ', 'Sylhet', 'Balaganj', 'Gaharpur', '3128'),
(',889,Sylhet ,Sylhet,Balaganj,Natun Bazar,3129\r\n', 890, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Bianibazar', '3170'),
(',891,Sylhet ,Sylhet,Bianibazar,jaldup,3171\r\n', 892, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Mathiura', '3172'),
(',893,Sylhet ,Sylhet,Bianibazar,Kurar bazar,3173\r\n', 894, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Salia bazar', '3174'),
(',895,Sylhet ,Sylhet,Bianibazar,Churkai,3175\r\n', 896, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Bishwanath', '3130'),
(',897,Sylhet ,Sylhet,Bishwanath,Dashghar,3131\r\n', 898, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Doulathpur', '3132'),
(',899,Sylhet ,Sylhet,Bishwanath,Deokalas,3133\r\n', 900, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Singer kanch', '3134'),
(',901,Sylhet ,Sylhet,Fenchuganj,Fenchuganj,3116\r\n', 902, 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj SareKarkh', '3117'),
(',903,Sylhet ,Sylhet,Goainhat,Goainhat,3150\r\n', 904, 'Sylhet ', 'Sylhet', 'Goainhat', 'Jaflong', '3151'),
(',905,Sylhet ,Sylhet,Goainhat,Chiknagul,3152\r\n', 906, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Gopalgannj', '3160'),
(',907,Sylhet ,Sylhet,Gopalganj,Dhaka Dakkhin,3161\r\n', 908, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dakkhin Bhadashore', '3162'),
(',909,Sylhet ,Sylhet,Gopalganj,Ranaping,3163\r\n', 910, 'Sylhet ', 'Sylhet', 'Gopalganj', 'banigram', '3164'),
(',911,Sylhet ,Sylhet,Gopalganj,Chandanpur,3165\r\n', 912, 'Sylhet ', 'Sylhet', 'Jaintapur', 'Jainthapur', '3156'),
(',913,Sylhet ,Sylhet,Jakiganj,Jakiganj,3190\r\n', 914, 'Sylhet ', 'Sylhet', 'Jakiganj', 'Ichhamati', '3191'),
(',915,Sylhet ,Sylhet,Kanaighat,Kanaighat,3180\r\n', 916, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Chatulbazar', '3181'),
(',917,Sylhet ,Sylhet,Kanaighat,Manikganj,3182\r\n', 918, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Gachbari', '3183'),
(',919,Sylhet ,Sylhet,Kompanyganj,Kompanyganj,3140\r\n', 920, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhe Sadar', '3100'),
(',921,Sylhet ,Sylhet,Sylhet Sadar,Sylhet Cadet Col,3101\r\n', 922, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Biman Bondar', '3102'),
(',923,Sylhet ,Sylhet,Sylhet Sadar,Khadimnagar,3103\r\n', 924, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad Cantoment', '3104'),
(',925,Sylhet ,Sylhet,Sylhet Sadar,Silam,3105\r\n', 926, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Birahimpur', '3106'),
(',927,Sylhet ,Sylhet,Sylhet Sadar,Jalalabad,3107\r\n', 928, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Mogla', '3108'),
(',929,Sylhet ,Sylhet,Sylhet Sadar,Ranga Hajiganj,3109\r\n', 930, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kadamtali', '3111'),
(',931,Sylhet ,Sylhet,Sylhet Sadar,Kamalbazer,3112\r\n', 932, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Lalbazar', '3113'),
(',933,Sylhet ,Sylhet,Sylhet Sadar,Shahajalal Science &,3114\r\n', 934, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Baralekha', '3250'),
(',935,Sylhet ,Moulvibazar,Baralekha,Juri,3251\r\n', 936, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Dhakkhinbag', '3252'),
(',937,Sylhet ,Moulvibazar,Baralekha,Purbashahabajpur,3253\r\n', 938, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Kamalganj', '3220'),
(',939,Sylhet ,Moulvibazar,Kamalganj,Keramatnaga,3221\r\n', 940, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Patrakhola', '3222'),
(',941,Sylhet ,Moulvibazar,Kamalganj,Shamsher Nagar,3223\r\n', 942, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Munshibazar', '3224'),
(',943,Sylhet ,Moulvibazar,Kulaura,Kulaura,3230\r\n', 944, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Tillagaon', '3231'),
(',945,Sylhet ,Moulvibazar,Kulaura,Langla,3232\r\n', 946, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Prithimpasha', '3233'),
(',947,Sylhet ,Moulvibazar,Kulaura,Kajaldhara,3234\r\n', 948, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Karimpur', '3235'),
(',949,Sylhet ,Moulvibazar,Kulaura,Baramchal,3237\r\n', 950, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Moulvibazar Sadar', '3200'),
(',951,Sylhet ,Moulvibazar,Moulvibazar Sadar,Barakapan,3201\r\n', 952, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Monumukh', '3202'),
(',953,Sylhet ,Moulvibazar,Moulvibazar Sadar,Afrozganj,3203\r\n', 954, 'Sylhet ', 'Moulvibazar', 'Rajnagar', 'Rajnagar', '3240'),
(',955,Sylhet ,Moulvibazar,Srimangal,Srimangal,3210\r\n', 956, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Narain Chora', '3211'),
(',957,Sylhet ,Moulvibazar,Srimangal,Kalighat,3212\r\n', 958, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Khejurichhara', '3213'),
(',959,Sylhet ,Moulvibazar,Srimangal,Satgaon,3214\r\n', 960, 'Sylhet ', 'Hobiganj', 'Azmireeganj', 'Azmireeganj', '3360'),
(',961,Sylhet ,Hobiganj,Bahubal,Bahubal,3310\r\n', 962, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Baniachang', '3350'),
(',963,Sylhet ,Hobiganj,Baniachang,Jatrapasha,3351\r\n', 964, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Kadirganj', '3352'),
(',965,Sylhet ,Hobiganj,Chunarughat,Chunarughat,3320\r\n', 966, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chandpurbagan', '3321'),
(',967,Sylhet ,Hobiganj,Chunarughat,Narapati,3322\r\n', 968, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Hobiganj Sadar', '3300'),
(',969,Sylhet ,Hobiganj,Hobiganj Sadar,Shaestaganj,3301\r\n', 970, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Gopaya', '3302'),
(',971,Sylhet ,Hobiganj,Kalauk,Kalauk,3340\r\n', 972, 'Sylhet ', 'Hobiganj', 'Kalauk', 'Lakhai', '3341'),
(',973,Sylhet ,Hobiganj,Madhabpur,Madhabpur,3330\r\n', 974, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Itakhola', '3331'),
(',975,Sylhet ,Hobiganj,Madhabpur,Shahajibazar,3332\r\n', 976, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Saihamnagar', '3333'),
(',977,Sylhet ,Hobiganj,Nabiganj,Nabiganj,3370\r\n', 978, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Goplarbazar', '3371'),
(',979,Sylhet ,Hobiganj,Nabiganj,Golduba,3372\r\n', 980, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Digalbak', '3373'),
(',981,Sylhet ,Hobiganj,Nabiganj,Inathganj,3374\r\n', 982, 'Barisal ', 'Barishal', 'Agailzhara', 'Agailzhara', '8240'),
(',983,Barisal ,Barishal,Agailzhara,Gaila,8241\r\n', 984, 'Barisal ', 'Barishal', 'Agailzhara', 'Paisarhat', '8242'),
(',985,Barisal ,Barishal,Babuganj,Babuganj,8210\r\n', 986, 'Barisal ', 'Barishal', 'Babuganj', 'Rahamatpur', '8211'),
(',987,Barisal ,Barishal,Babuganj,Chandpasha,8212\r\n', 988, 'Barisal ', 'Barishal', 'Babuganj', 'Madhabpasha', '8213'),
(',989,Barisal ,Barishal,Babuganj,Thakur Mallik,8214\r\n', 990, 'Barisal ', 'Barishal', 'Babuganj', 'Nizamuddin College', '8215'),
(',991,Barisal ,Barishal,Babuganj,Barishal Cadet,8216\r\n', 992, 'Barisal ', 'Barishal', 'Barajalia', 'Barajalia', '8260'),
(',993,Barisal ,Barishal,Barajalia,Osman Manjil,8261\r\n', 994, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Barishal Sadar', '8200'),
(',995,Barisal ,Barishal,Barishal Sadar,Bukhainagar,8201\r\n', 996, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Saheberhat', '8202'),
(',997,Barisal ,Barishal,Barishal Sadar,Sugandia,8203\r\n', 998, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Patang', '8204'),
(',999,Barisal ,Barishal,Barishal Sadar,Kashipur,8205\r\n', 1000, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Jaguarhat', '8206'),
(',1001,Barisal ,Barishal,Gouranadi,Gouranadi,8230\r\n', 1002, 'Barisal ', 'Barishal', 'Gouranadi', 'Tarki Bandar', '8231'),
(',1003,Barisal ,Barishal,Gouranadi,Kashemabad,8232\r\n', 1004, 'Barisal ', 'Barishal', 'Gouranadi', 'Batajor', '8233'),
(',1005,Barisal ,Barishal,Mahendiganj,Mahendiganj,8270\r\n', 1006, 'Barisal ', 'Barishal', 'Mahendiganj', 'Laskarpur', '8271'),
(',1007,Barisal ,Barishal,Mahendiganj,Ulania,8272\r\n', 1008, 'Barisal ', 'Barishal', 'Mahendiganj', 'Nalgora', '8273'),
(',1009,Barisal ,Barishal,Mahendiganj,Langutia,8274\r\n', 1010, 'Barisal ', 'Barishal', 'Muladi', 'Muladi', '8250'),
(',1011,Barisal ,Barishal,Muladi,Kazirchar,8251\r\n', 1012, 'Barisal ', 'Barishal', 'Muladi', 'Charkalekhan', '8252'),
(',1013,Barisal ,Barishal,Sahebganj,Sahebganj,8280\r\n', 1014, 'Barisal ', 'Barishal', 'Sahebganj', 'Charamandi', '8281'),
(',1015,Barisal ,Barishal,Sahebganj,Padri Shibpur,8282\r\n', 1016, 'Barisal ', 'Barishal', 'Sahebganj', 'Shialguni', '8283'),
(',1017,Barisal ,Barishal,Sahebganj,kalaskati,8284\r\n', 1018, 'Barisal ', 'Barishal', 'Uzirpur', 'Uzirpur', '8220'),
(',1019,Barisal ,Barishal,Uzirpur,Dhamura,8221\r\n', 1020, 'Barisal ', 'Barishal', 'Uzirpur', 'Jugirkanda', '8222'),
(',1021,Barisal ,Barishal,Uzirpur,Dakuarhat,8223\r\n', 1022, 'Barisal ', 'Barishal', 'Uzirpur', 'Shikarpur', '8224'),
(',1023,Barisal ,Bhola,Bhola Sadar,Bhola Sadar,8300\r\n', 1024, 'Barisal ', 'Bhola', 'Bhola Sadar', 'Joynagar', '8301'),
(',1025,Barisal ,Bhola,Borhanuddin UPO,Borhanuddin UPO,8320\r\n', 1026, 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Mirzakalu', '8321'),
(',1027,Barisal ,Bhola,Charfashion,Charfashion,8340\r\n', 1028, 'Barisal ', 'Bhola', 'Charfashion', 'Dularhat', '8341'),
(',1029,Barisal ,Bhola,Charfashion,Keramatganj,8342\r\n', 1030, 'Barisal ', 'Bhola', 'Doulatkhan', 'Doulatkhan', '8310'),
(',1031,Barisal ,Bhola,Doulatkhan,Hajipur,8311\r\n', 1032, 'Barisal ', 'Bhola', 'Hajirhat', 'Hajirhat', '8360'),
(',1033,Barisal ,Bhola,Hatshoshiganj,Hatshoshiganj,8350\r\n', 1034, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Lalmohan UPO', '8330'),
(',1035,Barisal ,Bhola,Lalmohan UPO,Daurihat,8331\r\n', 1036, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Gazaria', '8332'),
(',1037,Barisal ,Jhalokathi,Jhalokathi Sadar,Jhalokathi Sadar,8400\r\n', 1038, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Nabagram', '8401'),
(',1039,Barisal ,Jhalokathi,Jhalokathi Sadar,Baukathi,8402\r\n', 1040, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Gabha', '8403'),
(',1041,Barisal ,Jhalokathi,Jhalokathi Sadar,Shekherhat,8404\r\n', 1042, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Kathalia', '8430'),
(',1043,Barisal ,Jhalokathi,Kathalia,Amua,8431\r\n', 1044, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Niamatee', '8432'),
(',1045,Barisal ,Jhalokathi,Kathalia,Shoulajalia,8433\r\n', 1046, 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Nalchhiti', '8420'),
(',1047,Barisal ,Jhalokathi,Nalchhiti,Beerkathi,8421\r\n', 1048, 'Barisal ', 'Jhalokathi', 'Rajapur', 'Rajapur', '8410'),
(',1049,Barisal ,Pirojpur,Banaripara,Banaripara,8530\r\n', 1050, 'Barisal ', 'Pirojpur', 'Banaripara', 'Chakhar', '8531'),
(',1051,Barisal ,Pirojpur,Bhandaria,Bhandaria,8550\r\n', 1052, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Kanudashkathi', '8551'),
(',1053,Barisal ,Pirojpur,Bhandaria,Dhaoa,8552\r\n', 1054, 'Barisal ', 'Pirojpur', 'kaukhali', 'Kaukhali', '8510'),
(',1055,Barisal ,Pirojpur,kaukhali,Keundia,8511\r\n', 1056, 'Barisal ', 'Pirojpur', 'kaukhali', 'Joykul', '8512'),
(',1057,Barisal ,Pirojpur,kaukhali,Jolagati,8513\r\n', 1058, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Mathbaria', '8560'),
(',1059,Barisal ,Pirojpur,Mathbaria,Tushkhali,8561\r\n', 1060, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Halta', '8562'),
(',1061,Barisal ,Pirojpur,Mathbaria,Gulishakhali,8563\r\n', 1062, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tiarkhali', '8564'),
(',1063,Barisal ,Pirojpur,Mathbaria,Betmor Natun Hat,8565\r\n', 1064, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Shilarganj', '8566'),
(',1065,Barisal ,Pirojpur,Nazirpur,Nazirpur,8540\r\n', 1066, 'Barisal ', 'Pirojpur', 'Nazirpur', 'Sriramkathi', '8541'),
(',1067,Barisal ,Pirojpur,Pirojpur Sadar,Pirojpur Sadar,8500\r\n', 1068, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Hularhat', '8501'),
(',1069,Barisal ,Pirojpur,Pirojpur Sadar,Parerhat,8502\r\n', 1070, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Swarupkathi', '8520'),
(',1071,Barisal ,Pirojpur,Swarupkathi,Darus Sunnat,8521\r\n', 1072, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Kaurikhara', '8522'),
(',1073,Barisal ,Pirojpur,Swarupkathi,Jalabari,8523\r\n', 1074, 'Barisal ', 'Patuakhali', 'Bauphal', 'Bauphal', '8620'),
(',1075,Barisal ,Patuakhali,Bauphal,Bagabandar,8621\r\n', 1076, 'Barisal ', 'Patuakhali', 'Bauphal', 'Birpasha', '8622'),
(',1077,Barisal ,Patuakhali,Bauphal,Kalishari,8623\r\n', 1078, 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalaia', '8624'),
(',1079,Barisal ,Patuakhali,Dashmina,Dashmina,8630\r\n', 1080, 'Barisal ', 'Patuakhali', 'Galachipa', 'Galachipa', '8640'),
(',1081,Barisal ,Patuakhali,Galachipa,Gazipur Bandar,8641\r\n', 1082, 'Barisal ', 'Patuakhali', 'Khepupara', 'Khepupara', '8650'),
(',1083,Barisal ,Patuakhali,Khepupara,Mahipur,8651\r\n', 1084, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Patuakhali Sadar', '8600'),
(',1085,Barisal ,Patuakhali,Patuakhali Sadar,Moukaran,8601\r\n', 1086, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Dumkee', '8602'),
(',1087,Barisal ,Patuakhali,Patuakhali Sadar,Rahimabad,8603\r\n', 1088, 'Barisal ', 'Patuakhali', 'Subidkhali', 'Subidkhali', '8610'),
(',1089,Barisal ,Barguna,Amtali,Amtali,8710\r\n', 1090, 'Barisal ', 'Barguna', 'Bamna', 'Bamna', '8730'),
(',1091,Barisal ,Barguna,Barguna Sadar,Barguna Sadar,8700\r\n', 1092, 'Barisal ', 'Barguna', 'Barguna Sadar', 'Nali Bandar', '8701'),
(',1093,Barisal ,Barguna,Betagi,Betagi,8740\r\n', 1094, 'Barisal ', 'Barguna', 'Betagi', 'Darul Ulam', '8741'),
(',1095,Barisal ,Barguna,Patharghata,Patharghata,8720\r\n', 1096, 'Barisal ', 'Barguna', 'Patharghata', 'Kakchira', '8721'),
(',1097,Rajshahi ,Panchagarh,Boda,Boda,5010\r\n', 1098, 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Chotto Dab', '5040'),
(',1099,Rajshahi ,Panchagarh,Chotto Dab,Mirjapur,5041\r\n', 1100, 'Rajshahi ', 'Panchagarh', 'Dabiganj', 'Dabiganj', '5020'),
(',1101,Rajshahi ,Panchagarh,Panchagra Sadar,Panchagar Sadar,5000\r\n', 1102, 'Rajshahi ', 'Panchagarh', 'Tetulia', 'Tetulia', '5030'),
(',1103,Rajshahi ,Thakurgaon,Baliadangi,Baliadangi,5140\r\n', 1104, 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Lahiri', '5141'),
(',1105,Rajshahi ,Thakurgaon,Jibanpur,Jibanpur,5130\r\n', 1106, 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', '5110'),
(',1107,Rajshahi ,Thakurgaon,Pirganj,Pirganj,5470\r\n', 1108, 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Rani Sankail', '5120'),
(',1109,Rajshahi ,Thakurgaon,Rani Sankail,Nekmarad,5121\r\n', 1110, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Sadar', '5100'),
(',1111,Rajshahi ,Thakurgaon,Thakurgaon Sadar,Thakurgaon Road,5101\r\n', 1112, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Shibganj', '5102'),
(',1113,Rajshahi ,Thakurgaon,Thakurgaon Sadar,Ruhia,5103\r\n', 1114, 'Rajshahi ', 'Dinajpur', 'Bangla Hili', 'Bangla Hili', '5270'),
(',1115,Rajshahi ,Dinajpur,Biral,Biral,5210\r\n', 1116, 'Rajshahi ', 'Dinajpur', 'Birampur', 'Birampur', '5266'),
(',1117,Rajshahi ,Dinajpur,Birganj,Birganj,5220\r\n', 1118, 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Chrirbandar', '5240'),
(',1119,Rajshahi ,Dinajpur,Chrirbandar,Ranirbandar,5241\r\n', 1120, 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Sadar', '5200'),
(',1121,Rajshahi ,Dinajpur,Dinajpur Sadar,Dinajpur Rajbari,5201\r\n', 1122, 'Rajshahi ', 'Dinajpur', 'Khansama', 'Khansama', '5230'),
(',1123,Rajshahi ,Dinajpur,Khansama,Pakarhat,5231\r\n', 1124, 'Rajshahi ', 'Dinajpur', 'Maharajganj', 'Maharajganj', '5226'),
(',1125,Rajshahi ,Dinajpur,Nababganj,Nababganj,5280\r\n', 1126, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Daudpur', '5281'),
(',1127,Rajshahi ,Dinajpur,Nababganj,Gopalpur,5282\r\n', 1128, 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Osmanpur', '5290'),
(',1129,Rajshahi ,Dinajpur,Osmanpur,Ghoraghat,5291\r\n', 1130, 'Rajshahi ', 'Dinajpur', 'Parbatipur', 'Parbatipur', '5250'),
(',1131,Rajshahi ,Dinajpur,Phulbari,Phulbari,5260\r\n', 1132, 'Rajshahi ', 'Dinajpur', 'Setabganj', 'Setabganj', '5216'),
(',1133,Rajshahi ,Nilphamari,Dimla,Dimla,5350\r\n', 1134, 'Rajshahi ', 'Nilphamari', 'Dimla', 'Ghaga Kharibari', '5351'),
(',1135,Rajshahi ,Nilphamari,Domar,Domar,5340\r\n', 1136, 'Rajshahi ', 'Nilphamari', 'Domar', 'Chilahati', '5341'),
(',1137,Rajshahi ,Nilphamari,Jaldhaka,Jaldhaka,5330\r\n', 1138, 'Rajshahi ', 'Nilphamari', 'Kishoriganj', 'Kishoriganj', '5320'),
(',1139,Rajshahi ,Nilphamari,Nilphamari Sadar,Nilphamari Sadar,5300\r\n', 1140, 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sugar Mil', '5301'),
(',1141,Rajshahi ,Nilphamari,Syedpur,Syedpur,5310\r\n', 1142, 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur Upashahar', '5311'),
(',1143,Rajshahi ,Rangpur,Badarganj,Badarganj,5430\r\n', 1144, 'Rajshahi ', 'Rangpur', 'Badarganj', 'Shyampur', '5431'),
(',1145,Rajshahi ,Rangpur,Gangachara,Gangachara,5410\r\n', 1146, 'Rajshahi ', 'Rangpur', 'Kaunia', 'Kaunia', '5440'),
(',1147,Rajshahi ,Rangpur,Kaunia,Haragachh,5441\r\n', 1148, 'Rajshahi ', 'Rangpur', 'Mithapukur', 'Mithapukur', '5460'),
(',1149,Rajshahi ,Rangpur,Pirgachha,Pirgachha,5450\r\n', 1150, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Sadar', '5400'),
(',1151,Rajshahi ,Rangpur,Rangpur Sadar,Rangpur Upa-Shahar,5401\r\n', 1152, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Alamnagar', '5402'),
(',1153,Rajshahi ,Rangpur,Rangpur Sadar,Mahiganj,5403\r\n', 1154, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Cadet Colleg', '5404'),
(',1155,Rajshahi ,Rangpur,Rangpur Sadar,Rangpur Carmiecal Col,5405\r\n', 1156, 'Rajshahi ', 'Rangpur', 'Taraganj', 'Taraganj', '5420'),
(',1157,Rajshahi ,Lalmonirhat,Aditmari,Aditmari,5510\r\n', 1158, 'Rajshahi ', 'Lalmonirhat', 'Hatibandha', 'Hatibandha', '5530'),
(',1159,Rajshahi ,Lalmonirhat,Lalmonirhat Sadar,Lalmonirhat Sadar,5500\r\n', 1160, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Moghalhat', '5501'),
(',1161,Rajshahi ,Lalmonirhat,Lalmonirhat Sadar,Kulaghat SO,5502\r\n', 1162, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Patgram', '5540'),
(',1163,Rajshahi ,Lalmonirhat,Patgram,Baura,5541\r\n', 1164, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Burimari', '5542'),
(',1165,Rajshahi ,Lalmonirhat,Tushbhandar,Tushbhandar,5520\r\n', 1166, 'Rajshahi ', 'Kurigram', 'Bhurungamari', 'Bhurungamari', '5670'),
(',1167,Rajshahi ,Kurigram,Chilmari,Chilmari,5630\r\n', 1168, 'Rajshahi ', 'Kurigram', 'Chilmari', 'Jorgachh', '5631'),
(',1169,Rajshahi ,Kurigram,Kurigram Sadar,Kurigram Sadar,5600\r\n', 1170, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Pandul', '5601'),
(',1171,Rajshahi ,Kurigram,Kurigram Sadar,Phulbari,5680\r\n', 1172, 'Rajshahi ', 'Kurigram', 'Nageshwar', 'Nageshwar', '5660'),
(',1173,Rajshahi ,Kurigram,Rajarhat,Rajarhat,5610\r\n', 1174, 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Nazimkhan', '5611'),
(',1175,Rajshahi ,Kurigram,Rajibpur,Rajibpur,5650\r\n', 1176, 'Rajshahi ', 'Kurigram', 'Roumari', 'Roumari', '5640'),
(',1177,Rajshahi ,Kurigram,Ulipur,Ulipur,5620\r\n', 1178, 'Rajshahi ', 'Kurigram', 'Ulipur', 'Bazarhat', '5621'),
(',1179,Rajshahi ,Gaibandha,Bonarpara,Bonarpara,5750\r\n', 1180, 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'saghata', '5751'),
(',1181,Rajshahi ,Gaibandha,Gaibandha Sadar,Gaibandha Sadar,5700\r\n', 1182, 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Gobindhaganj', '5740'),
(',1183,Rajshahi ,Gaibandha,Gobindaganj,Mahimaganj,5741\r\n', 1184, 'Rajshahi ', 'Gaibandha', 'Palashbari', 'Palashbari', '5730'),
(',1185,Rajshahi ,Gaibandha,Phulchhari,Phulchhari,5760\r\n', 1186, 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Bharatkhali', '5761'),
(',1187,Rajshahi ,Gaibandha,Saadullapur,Saadullapur,5710\r\n', 1188, 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Naldanga', '5711'),
(',1189,Rajshahi ,Gaibandha,Sundarganj,Sundarganj,5720\r\n', 1190, 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Bamandanga', '5721'),
(',1191,Rajshahi ,Bogra,Alamdighi,Adamdighi,5890\r\n', 1192, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Santahar', '5891'),
(',1193,Rajshahi ,Bogra,Alamdighi,Nasharatpur,5892\r\n', 1194, 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Sadar', '5800'),
(',1195,Rajshahi ,Bogra,Bogra Sadar,Bogra Canttonment,5801\r\n', 1196, 'Rajshahi ', 'Bogra', 'Dhunat', 'Dhunat', '5850'),
(',1197,Rajshahi ,Bogra,Dhunat,Gosaibari,5851\r\n', 1198, 'Rajshahi ', 'Bogra', 'Dupchachia', 'Dupchachia', '5880'),
(',1199,Rajshahi ,Bogra,Dupchachia,Talora,5881\r\n', 1200, 'Rajshahi ', 'Bogra', 'Gabtoli', 'Gabtoli', '5820'),
(',1201,Rajshahi ,Bogra,Gabtoli,Sukhanpukur,5821\r\n', 1202, 'Rajshahi ', 'Bogra', 'Kahalu', 'Kahalu', '5870'),
(',1203,Rajshahi ,Bogra,Nandigram,Nandigram,5860\r\n', 1204, 'Rajshahi ', 'Bogra', 'Sariakandi', 'Sariakandi', '5830'),
(',1205,Rajshahi ,Bogra,Sariakandi,Chandan Baisha,5831\r\n', 1206, 'Rajshahi ', 'Bogra', 'Sherpur', 'Sherpur', '5840'),
(',1207,Rajshahi ,Bogra,Sherpur,Chandaikona,5841\r\n', 1208, 'Rajshahi ', 'Bogra', 'Sherpur', 'Palli Unnyan Accadem', '5842'),
(',1209,Rajshahi ,Bogra,Shibganj,Shibganj,5810\r\n', 1210, 'Rajshahi ', 'Bogra', 'Sonatola', 'Sonatola', '5826'),
(',1211,Rajshahi ,Joypurhat,Akkelpur,Akklepur,5940\r\n', 1212, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'jamalganj', '5941'),
(',1213,Rajshahi ,Joypurhat,Akkelpur,Tilakpur,5942\r\n', 1214, 'Rajshahi ', 'Joypurhat', 'Joypurhat Sadar', 'Joypurhat Sadar', '5900'),
(',1215,Rajshahi ,Joypurhat,kalai,kalai,5930\r\n', 1216, 'Rajshahi ', 'Joypurhat', 'Khetlal', 'Khetlal', '5920'),
(',1217,Rajshahi ,Joypurhat,panchbibi,Panchbibi,5910\r\n', 1218, 'Rajshahi ', 'Rajshahi', 'Bagha', 'Bagha', '6280'),
(',1219,Rajshahi ,Rajshahi,Bagha,Arani,6281\r\n', 1220, 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Bhabaniganj', '6250'),
(',1221,Rajshahi ,Rajshahi,Bhabaniganj,Taharpur,6251\r\n', 1222, 'Rajshahi ', 'Rajshahi', 'Charghat', 'Charghat', '6270'),
(',1223,Rajshahi ,Rajshahi,Charghat,Sarda,6271\r\n', 1224, 'Rajshahi ', 'Rajshahi', 'Durgapur', 'Durgapur', '6240'),
(',1225,Rajshahi ,Rajshahi,Godagari,Godagari,6290\r\n', 1226, 'Rajshahi ', 'Rajshahi', 'Godagari', 'Premtoli', '6291'),
(',1227,Rajshahi ,Rajshahi,Khod Mohanpur,Khodmohanpur,6220\r\n', 1228, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Lalitganj', '6210'),
(',1229,Rajshahi ,Rajshahi,Lalitganj,Rajshahi Sugar Mills,6211\r\n', 1230, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Shyampur', '6212'),
(',1231,Rajshahi ,Rajshahi,Putia,Putia,6260\r\n', 1232, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Sadar', '6000'),
(',1233,Rajshahi ,Rajshahi,Rajshahi Sadar,Ghuramara,6100\r\n', 1234, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Court', '6201'),
(',1235,Rajshahi ,Rajshahi,Rajshahi Sadar,Rajshahi Canttonment,6202\r\n', 1236, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Sapura', '6203'),
(',1237,Rajshahi ,Rajshahi,Rajshahi Sadar,Kazla,6204\r\n', 1238, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi University', '6205'),
(',1239,Rajshahi ,Rajshahi,Rajshahi Sadar,Binodpur Bazar,6206\r\n', 1240, 'Rajshahi ', 'Rajshahi', 'Tanor', 'Tanor', '6230'),
(',1241,Rajshahi ,Chapinawabganj,Bholahat,Bholahat,6330\r\n', 1242, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Chapinawbganj Sadar', '6300'),
(',1243,Rajshahi ,Chapinawabganj,Chapinawabganj Sadar,Rajarampur,6301\r\n', 1244, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Ramchandrapur', '6302'),
(',1245,Rajshahi ,Chapinawabganj,Chapinawabganj Sadar,Amnura,6303\r\n', 1246, 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Nachol', '6310'),
(',1247,Rajshahi ,Chapinawabganj,Nachol,Mandumala,6311\r\n', 1248, 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Rohanpur', '6320'),
(',1249,Rajshahi ,Chapinawabganj,Rohanpur,Gomashtapur,6321\r\n', 1250, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Shibganj U.P.O', '6340'),
(',1251,Rajshahi ,Chapinawabganj,Shibganj U.P.O,Kansart,6341\r\n', 1252, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Manaksha', '6342'),
(',1253,Rajshahi ,Natore,Gopalpur UPO,Gopalpur U.P.O,6420\r\n', 1254, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Lalpur S.O', '6421'),
(',1255,Rajshahi ,Natore,Gopalpur UPO,Abdulpur,6422\r\n', 1256, 'Rajshahi ', 'Natore', 'Harua', 'Harua', '6430'),
(',1257,Rajshahi ,Natore,Harua,Dayarampur,6431\r\n', 1258, 'Rajshahi ', 'Natore', 'Harua', 'Baraigram', '6432'),
(',1259,Rajshahi ,Natore,Hatgurudaspur,Hatgurudaspur,6440\r\n', 1260, 'Rajshahi ', 'Natore', 'Laxman', 'Laxman', '6410'),
(',1261,Rajshahi ,Natore,Natore Sadar,Natore Sadar,6400\r\n', 1262, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Digapatia', '6401'),
(',1263,Rajshahi ,Natore,Natore Sadar,Baiddyabal Gharia,6402\r\n', 1264, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Madhnagar', '6403'),
(',1265,Rajshahi ,Natore,Singra,Singra,6450\r\n', 1266, 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Ahsanganj', '6596'),
(',1267,Rajshahi ,Naogaon,Ahsanganj,Bandai,6597\r\n', 1268, 'Rajshahi ', 'Naogaon', 'Badalgachhi', 'Badalgachhi', '6570'),
(',1269,Rajshahi ,Naogaon,Dhamuirhat,Dhamuirhat,6580\r\n', 1270, 'Rajshahi ', 'Naogaon', 'Mahadebpur', 'Mahadebpur', '6530'),
(',1271,Rajshahi ,Naogaon,Naogaon Sadar,Naogaon Sadar,6500\r\n', 1272, 'Rajshahi ', 'Naogaon', 'Niamatpur', 'Niamatpur', '6520'),
(',1273,Rajshahi ,Naogaon,Nitpur,Nitpur,6550\r\n', 1274, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Porsa', '6551'),
(',1275,Rajshahi ,Naogaon,Nitpur,Panguria,6552\r\n', 1276, 'Rajshahi ', 'Naogaon', 'Patnitala', 'Patnitala', '6540'),
(',1277,Rajshahi ,Naogaon,Prasadpur,Prasadpur,6510\r\n', 1278, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Manda', '6511'),
(',1279,Rajshahi ,Naogaon,Prasadpur,Balihar,6512\r\n', 1280, 'Rajshahi ', 'Naogaon', 'Raninagar', 'Raninagar', '6590'),
(',1281,Rajshahi ,Naogaon,Raninagar,Kashimpur,6591\r\n', 1282, 'Rajshahi ', 'Naogaon', 'Sapahar', 'Sapahar', '6560'),
(',1283,Rajshahi ,Naogaon,Sapahar,Moduhil,6561\r\n', 1284, 'Rajshahi ', 'Pabna', 'Banwarinagar', 'Banwarinagar', '6650'),
(',1285,Rajshahi ,Pabna,Bera,Bera,6680\r\n', 1286, 'Rajshahi ', 'Pabna', 'Bera', 'Nakalia', '6681'),
(',1287,Rajshahi ,Pabna,Bera,Kashinathpur,6682\r\n', 1288, 'Rajshahi ', 'Pabna', 'Bera', 'Puran Bharenga', '6683'),
(',1289,Rajshahi ,Pabna,Bhangura,Bhangura,6640\r\n', 1290, 'Rajshahi ', 'Pabna', 'Chatmohar', 'Chatmohar', '6630'),
(',1291,Rajshahi ,Pabna,Debottar,Debottar,6610\r\n', 1292, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Ishwardi', '6620'),
(',1293,Rajshahi ,Pabna,Ishwardi,Dhapari,6621\r\n', 1294, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Pakshi', '6622'),
(',1295,Rajshahi ,Pabna,Ishwardi,Rajapur,6623\r\n', 1296, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Pabna Sadar', '6600'),
(',1297,Rajshahi ,Pabna,Pabna Sadar,Kaliko Cotton Mills,6601\r\n', 1298, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Hamayetpur', '6602'),
(',1299,Rajshahi ,Pabna,Sathia,Sathia,6670\r\n', 1300, 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sujanagar', '6660'),
(',1301,Rajshahi ,Pabna,Sujanagar,Sagarkandi,6661\r\n', 1302, 'Rajshahi ', 'Sirajganj', 'Baiddya Jam Toil', 'Baiddya Jam Toil', '6730'),
(',1303,Rajshahi ,Sirajganj,Belkuchi,Belkuchi,6740\r\n', 1304, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sohagpur', '6741'),
(',1305,Rajshahi ,Sirajganj,Belkuchi,Rajapur,6742\r\n', 1306, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Enayetpur', '6751'),
(',1307,Rajshahi ,Sirajganj,Belkuchi,Sthal,6752\r\n', 1308, 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Dhangora', '6720'),
(',1309,Rajshahi ,Sirajganj,Dhangora,Malonga,6721\r\n', 1310, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Kazipur', '6710'),
(',1311,Rajshahi ,Sirajganj,Kazipur,Shuvgachha,6711\r\n', 1312, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Gandail', '6712'),
(',1313,Rajshahi ,Sirajganj,Shahjadpur,Shahjadpur,6770\r\n', 1314, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Porjana', '6771'),
(',1315,Rajshahi ,Sirajganj,Shahjadpur,Jamirta,6772\r\n', 1316, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Kaijuri', '6773'),
(',1317,Rajshahi ,Sirajganj,Sirajganj Sadar,Sirajganj Sadar,6700\r\n', 1318, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Raipur', '6701'),
(',1319,Rajshahi ,Sirajganj,Sirajganj Sadar,Rashidabad,6702\r\n', 1320, 'Rajshahi ', 'Sirajganj', 'Tarash', 'Tarash', '6780'),
(',1321,Rajshahi ,Sirajganj,Ullapara,Ullapara,6760\r\n', 1322, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara R.S', '6761'),
(',1323,Rajshahi ,Sirajganj,Ullapara,Lahiri Mohanpur,6762\r\n', 1324, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Salap', '6763');

-- --------------------------------------------------------

--
-- Table structure for table `TABLE 3`
--

CREATE TABLE `TABLE 3` (
  `COL 1` int(4) DEFAULT NULL,
  `COL 2` varchar(11) DEFAULT NULL,
  `COL 3` varchar(14) DEFAULT NULL,
  `COL 4` varchar(20) DEFAULT NULL,
  `COL 5` varchar(23) DEFAULT NULL,
  `COL 6` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `TABLE 3`
--

INSERT INTO `TABLE 3` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`) VALUES
(1, 'Dhaka', 'Dhaka', 'Demra', 'Demra', '1360'),
(2, 'Dhaka', 'Dhaka', 'Demra', 'Sarulia', '1361'),
(3, 'Dhaka', 'Dhaka', 'Demra', 'Matuail', '1362'),
(4, 'Dhaka', 'Dhaka', 'Dhaka GPO', 'Dhaka GPO', '1000'),
(5, 'Dhaka', 'Dhaka', 'Dhaka Main PO', 'Dhaka Main PO', '1100'),
(6, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Wari TSO', '1203'),
(7, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gendaria TSO', '1204'),
(8, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'New Market TSO', '1205'),
(9, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhaka CantonmentTSO', '1206'),
(10, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mohammadpur Housing', '1207'),
(11, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhaka Politechnic', '1208'),
(12, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Jigatala TSO', '1209'),
(13, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Posta TSO', '1211'),
(14, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gulshan Model Town', '1212'),
(15, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Banani TSO', '1213'),
(16, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Basabo TSO', '1214'),
(17, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Tejgaon TSO', '1215'),
(18, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Shantinagr TSO', '1217'),
(19, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mirpur TSO', '1218'),
(20, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilgaonTSO', '1219'),
(21, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'BangabhabanTSO', '1222'),
(22, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'DilkushaTSO', '1223'),
(23, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Sangsad BhabanTSO', '1225'),
(24, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilkhetTSO', '1229'),
(25, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Uttara Model TwonTSO', '1231'),
(26, 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhania TSO', '1232'),
(27, 'Dhaka', 'Dhaka', 'Dhamrai', 'Dhamrai', '1350'),
(28, 'Dhaka', 'Dhaka', 'Dhamrai', 'Kamalpur', '1351'),
(29, 'Dhaka', 'Dhaka', 'Joypara', 'Joypara', '1330'),
(30, 'Dhaka', 'Dhaka', 'Joypara', 'Palamganj', '1331'),
(31, 'Dhaka', 'Dhaka', 'Joypara', 'Narisha', '1332'),
(32, 'Dhaka', 'Dhaka', 'Keraniganj', 'Keraniganj', '1310'),
(33, 'Dhaka', 'Dhaka', 'Keraniganj', 'Dhaka Jute Mills', '1311'),
(34, 'Dhaka', 'Dhaka', 'Keraniganj', 'Ati', '1312'),
(35, 'Dhaka', 'Dhaka', 'Keraniganj', 'Kalatia', '1313'),
(36, 'Dhaka', 'Dhaka', 'Nawabganj', 'Nawabganj', '1320'),
(37, 'Dhaka', 'Dhaka', 'Nawabganj', 'Hasnabad', '1321'),
(38, 'Dhaka', 'Dhaka', 'Nawabganj', 'Daudpur', '1322'),
(39, 'Dhaka', 'Dhaka', 'Nawabganj', 'Agla', '1323'),
(40, 'Dhaka', 'Dhaka', 'Nawabganj', 'Khalpar', '1324'),
(41, 'Dhaka', 'Dhaka', 'Nawabganj', 'Churain', '1325'),
(42, 'Dhaka', 'Dhaka', 'Savar', 'Savar', '1340'),
(43, 'Dhaka', 'Dhaka', 'Savar', 'Dairy Farm', '1341'),
(44, 'Dhaka', 'Dhaka', 'Savar', 'Jahangirnagar Univer', '1342'),
(45, 'Dhaka', 'Dhaka', 'Savar', 'Saver P.A.T.C', '1343'),
(46, 'Dhaka', 'Dhaka', 'Savar', 'Savar Canttonment', '1344'),
(47, 'Dhaka', 'Dhaka', 'Savar', 'Shimulia', '1345'),
(48, 'Dhaka', 'Dhaka', 'Savar', 'Kashem Cotton Mills', '1346'),
(49, 'Dhaka', 'Dhaka', 'Savar', 'Rajphulbaria', '1347'),
(50, 'Dhaka', 'Dhaka', 'Savar', 'Amin Bazar', '1348'),
(51, 'Dhaka', 'Dhaka', 'Savar', 'EPZ', '1349'),
(52, 'Dhaka', 'Mymensingh', 'Bhaluka', 'Bhaluka', '2240'),
(53, 'Dhaka', 'Mymensingh', 'Fulbaria', 'Fulbaria', '2216'),
(54, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Gaforgaon', '2230'),
(55, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Shibganj', '2231'),
(56, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Usti', '2232'),
(57, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Kandipara', '2233'),
(58, 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Duttarbazar', '2234'),
(59, 'Dhaka', 'Mymensingh', 'Gouripur', 'Gouripur', '2270'),
(60, 'Dhaka', 'Mymensingh', 'Gouripur', 'Ramgopalpur', '2271'),
(61, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Haluaghat', '2260'),
(62, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Dhara', '2261'),
(63, 'Dhaka', 'Mymensingh', 'Haluaghat', 'Munshirhat', '2262'),
(64, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Isshwargonj', '2280'),
(65, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Sohagi', '2281'),
(66, 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Atharabari', '2282'),
(67, 'Dhaka', 'Mymensingh', 'Muktagachha', 'Muktagachha', '2210'),
(68, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Mymensingh Sadar', '2200'),
(69, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Kawatkhali', '2201'),
(70, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Agriculture Universi', '2202'),
(71, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Shombhuganj', '2203'),
(72, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Biddyaganj', '2204'),
(73, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Pearpur', '2205'),
(74, 'Dhaka', 'Mymensingh', 'Nandail', 'Nandail', '2290'),
(75, 'Dhaka', 'Mymensingh', 'Nandail', 'Gangail', '2291'),
(76, 'Dhaka', 'Mymensingh', 'Phulpur', 'Phulpur', '2250'),
(77, 'Dhaka', 'Mymensingh', 'Phulpur', 'Beltia', '2251'),
(78, 'Dhaka', 'Mymensingh', 'Phulpur', 'Tarakanda', '2252'),
(79, 'Dhaka', 'Mymensingh', 'Trishal', 'Trishal', '2220'),
(80, 'Dhaka', 'Mymensingh', 'Trishal', 'Ahmadbad', '2221'),
(81, 'Dhaka', 'Mymensingh', 'Trishal', 'Ram Amritaganj', '2222'),
(82, 'Dhaka', 'Mymensingh', 'Trishal', 'Dhala', '2223'),
(83, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Bajitpur', '2336'),
(84, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Sararchar', '2337'),
(85, 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Laksmipur', '2338'),
(86, 'Dhaka', 'Kishoreganj', 'Bhairob', 'Bhairab', '2350'),
(87, 'Dhaka', 'Kishoreganj', 'Hossenpur', 'Hossenpur', '2320'),
(88, 'Dhaka', 'Kishoreganj', 'Itna', 'Itna', '2390'),
(89, 'Dhaka', 'Kishoreganj', 'Karimganj', 'Karimganj', '2310'),
(90, 'Dhaka', 'Kishoreganj', 'Katiadi', 'Katiadi', '2330'),
(91, 'Dhaka', 'Kishoreganj', 'Katiadi', 'Gochhihata', '2331'),
(92, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj Sadar', '2300'),
(93, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj S.Mills', '2301'),
(94, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Maizhati', '2302'),
(95, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Nilganj', '2303'),
(96, 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Kuliarchar', '2340'),
(97, 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Chhoysuti', '2341'),
(98, 'Dhaka', 'Kishoreganj', 'Mithamoin', 'MIthamoin', '2370'),
(99, 'Dhaka', 'Kishoreganj', 'Mithamoin', 'Abdullahpur', '2371'),
(100, 'Dhaka', 'Kishoreganj', 'Nikli', 'Nikli', '2360'),
(101, 'Dhaka', 'Kishoreganj', 'Ostagram', 'Ostagram', '2380'),
(102, 'Dhaka', 'Kishoreganj', 'Pakundia', 'Pakundia', '2326'),
(103, 'Dhaka', 'Kishoreganj', 'Tarial', 'Tarial', '2316'),
(104, 'Dhaka', 'Netrakona', 'Susung Durgapur', 'IBH WAs Here', '$mart'),
(105, 'Dhaka', 'Netrakona', 'Susung Durgapur', 'Susnng Durgapur', '2420'),
(106, 'Dhaka', 'Netrakona', 'Atpara', 'Atpara', '2470'),
(107, 'Dhaka', 'Netrakona', 'Barhatta', 'Barhatta', '2440'),
(108, 'Dhaka', 'Netrakona', 'Dharmapasha', 'Dharampasha', '2450'),
(109, 'Dhaka', 'Netrakona', 'Dhobaura', 'Dhobaura', '2416'),
(110, 'Dhaka', 'Netrakona', 'Dhobaura', 'Sakoai', '2417'),
(111, 'Dhaka', 'Netrakona', 'Kalmakanda', 'Kalmakanda', '2430'),
(112, 'Dhaka', 'Netrakona', 'Kendua', 'Kendua', '2480'),
(113, 'Dhaka', 'Netrakona', 'Khaliajuri', 'Khaliajhri', '2460'),
(114, 'Dhaka', 'Netrakona', 'Khaliajuri', 'Shaldigha', '2462'),
(115, 'Dhaka', 'Netrakona', 'Madan', 'Madan', '2490'),
(116, 'Dhaka', 'Netrakona', 'Moddhynagar', 'Moddoynagar', '2456'),
(117, 'Dhaka', 'Netrakona', 'Mohanganj', 'Mohanganj', '2446'),
(118, 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Netrakona Sadar', '2400'),
(119, 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Baikherhati', '2401'),
(120, 'Dhaka', 'Netrakona', 'Purbadhola', 'Purbadhola', '2410'),
(121, 'Dhaka', 'Netrakona', 'Purbadhola', 'Shamgonj', '2411'),
(122, 'Dhaka', 'Netrakona', 'Purbadhola', 'Jaria Jhanjhail', '2412'),
(123, 'Dhaka', 'Narayanganj', 'Araihazar', 'Araihazar', '1450'),
(124, 'Dhaka', 'Narayanganj', 'Araihazar', 'Gopaldi', '1451'),
(125, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Baidder Bazar', '1440'),
(126, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Bara Nagar', '1441'),
(127, 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Barodi', '1442'),
(128, 'Dhaka', 'Narayanganj', 'Bandar', 'Bandar', '1410'),
(129, 'Dhaka', 'Narayanganj', 'Bandar', 'D.C Mills', '1411'),
(130, 'Dhaka', 'Narayanganj', 'Bandar', 'Nabiganj', '1412'),
(131, 'Dhaka', 'Narayanganj', 'Bandar', 'BIDS', '1413'),
(132, 'Dhaka', 'Narayanganj', 'Bandar', 'Madanganj', '1414'),
(133, 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatullah', '1420'),
(134, 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatulla Bazar', '1421'),
(135, 'Dhaka', 'Narayanganj', 'Narayanganj Sadar', 'Narayanganj Sadar', '1400'),
(136, 'Dhaka', 'Narayanganj', 'Rupganj', 'Rupganj', '1460'),
(137, 'Dhaka', 'Narayanganj', 'Rupganj', 'Kanchan', '1461'),
(138, 'Dhaka', 'Narayanganj', 'Rupganj', 'Bhulta', '1462'),
(139, 'Dhaka', 'Narayanganj', 'Rupganj', 'Nagri', '1463'),
(140, 'Dhaka', 'Narayanganj', 'Rupganj', 'Murapara', '1464'),
(141, 'Dhaka', 'Narayanganj', 'Siddirganj', 'Siddirganj', '1430'),
(142, 'Dhaka', 'Narayanganj', 'Siddirganj', 'Adamjeenagar', '1431'),
(143, 'Dhaka', 'Narayanganj', 'Siddirganj', 'LN Mills', '1432'),
(144, 'Dhaka', 'Munshiganj', 'Gajaria', 'Gajaria', '1510'),
(145, 'Dhaka', 'Munshiganj', 'Gajaria', 'Hossendi', '1511'),
(146, 'Dhaka', 'Munshiganj', 'Gajaria', 'Rasulpur', '1512'),
(147, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haridia', '1333'),
(148, 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', '1334'),
(149, 'Dhaka', 'Munshiganj', 'Lohajong', 'Madini Mandal', '1335'),
(150, 'Dhaka', 'Munshiganj', 'Lohajong', 'Lohajang', '1530'),
(151, 'Dhaka', 'Munshiganj', 'Lohajong', 'Korhati', '1531'),
(152, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haldia SO', '1532'),
(153, 'Dhaka', 'Munshiganj', 'Lohajong', 'Haridia DESO', '1533'),
(154, 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', '1534'),
(155, 'Dhaka', 'Munshiganj', 'Lohajong', 'Medini Mandal EDSO', '1535'),
(156, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Munshiganj Sadar', '1500'),
(157, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Rikabibazar', '1501'),
(158, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Mirkadim', '1502'),
(159, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Kathakhali', '1503'),
(160, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Sirajdikhan', '1540'),
(161, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Kola', '1541'),
(162, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Ichapur', '1542'),
(163, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Malkha Nagar', '1543'),
(164, 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Shekher Nagar', '1544'),
(165, 'Dhaka', 'Munshiganj', 'Srinagar', 'Srinagar', '1550'),
(166, 'Dhaka', 'Munshiganj', 'Srinagar', 'Barikhal', '1551'),
(167, 'Dhaka', 'Munshiganj', 'Srinagar', 'Mazpara', '1552'),
(168, 'Dhaka', 'Munshiganj', 'Srinagar', 'Hashara', '1553'),
(169, 'Dhaka', 'Munshiganj', 'Srinagar', 'Kolapara', '1554'),
(170, 'Dhaka', 'Munshiganj', 'Srinagar', 'Kumarbhog', '1555'),
(171, 'Dhaka', 'Munshiganj', 'Srinagar', 'Vaggyakul SO', '1556'),
(172, 'Dhaka', 'Munshiganj', 'Srinagar', 'Baghra', '1557'),
(173, 'Dhaka', 'Munshiganj', 'Srinagar', 'Bhaggyakul', '1558'),
(174, 'Dhaka', 'Munshiganj', 'Tangibari', 'Tangibari', '1520'),
(175, 'Dhaka', 'Munshiganj', 'Tangibari', 'Betkahat', '1521'),
(176, 'Dhaka', 'Munshiganj', 'Tangibari', 'Baligao', '1522'),
(177, 'Dhaka', 'Munshiganj', 'Tangibari', 'Bajrajugini', '1523'),
(178, 'Dhaka', 'Munshiganj', 'Tangibari', 'Hasail', '1524'),
(179, 'Dhaka', 'Munshiganj', 'Tangibari', 'Dighirpar', '1525'),
(180, 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura EDSO', '1526'),
(181, 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura', '1527'),
(182, 'Dhaka', 'Narshingdi', 'Belabo', 'Belabo', '1640'),
(183, 'Dhaka', 'Narshingdi', 'Monohordi', 'Monohordi', '1650'),
(184, 'Dhaka', 'Narshingdi', 'Monohordi', 'Hatirdia', '1651'),
(185, 'Dhaka', 'Narshingdi', 'Monohordi', 'Katabaria', '1652'),
(186, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi Sadar', '1600'),
(187, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'UMC Jute Mills', '1601'),
(188, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi College', '1602'),
(189, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Panchdona', '1603'),
(190, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Madhabdi', '1604'),
(191, 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Karimpur', '1605'),
(192, 'Dhaka', 'Narshingdi', 'Palash', 'Palash', '1610'),
(193, 'Dhaka', 'Narshingdi', 'Palash', 'Ghorashal Urea Facto', '1611'),
(194, 'Dhaka', 'Narshingdi', 'Palash', 'Char Sindhur', '1612'),
(195, 'Dhaka', 'Narshingdi', 'Palash', 'Ghorashal', '1613'),
(196, 'Dhaka', 'Narshingdi', 'Raypura', 'Raypura', '1630'),
(197, 'Dhaka', 'Narshingdi', 'Raypura', 'Bazar Hasnabad', '1631'),
(198, 'Dhaka', 'Narshingdi', 'Raypura', 'Radhaganj bazar', '1632'),
(199, 'Dhaka', 'Narshingdi', 'Shibpur', 'Shibpur', '1620'),
(200, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Gazipur Sadar', '1700'),
(201, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'B.R.R', '1701'),
(202, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Chandna', '1702'),
(203, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'B.O.F', '1703'),
(204, 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'National University', '1704'),
(205, 'Dhaka', 'Gazipur', 'Kaliakaar', 'Kaliakaar', '1750'),
(206, 'Dhaka', 'Gazipur', 'Kaliakaar', 'Safipur', '1751'),
(207, 'Dhaka', 'Gazipur', 'Kaliganj', 'Kaliganj', '1720'),
(208, 'Dhaka', 'Gazipur', 'Kaliganj', 'Pubail', '1721'),
(209, 'Dhaka', 'Gazipur', 'Kaliganj', 'Santanpara', '1722'),
(210, 'Dhaka', 'Gazipur', 'Kaliganj', 'Vaoal Jamalpur', '1723'),
(211, 'Dhaka', 'Gazipur', 'Kapashia', 'kapashia', '1730'),
(212, 'Dhaka', 'Gazipur', 'Monnunagar', 'Monnunagar', '1710'),
(213, 'Dhaka', 'Gazipur', 'Monnunagar', 'Nishat Nagar', '1711'),
(214, 'Dhaka', 'Gazipur', 'Monnunagar', 'Ershad Nagar', '1712'),
(215, 'Dhaka', 'Gazipur', 'Sreepur', 'Sreepur', '1740'),
(216, 'Dhaka', 'Gazipur', 'Sreepur', 'Barmi', '1743'),
(217, 'Dhaka', 'Gazipur', 'Sreepur', 'Satkhamair', '1744'),
(218, 'Dhaka', 'Gazipur', 'Sreepur', 'Kawraid', '1745'),
(219, 'Dhaka', 'Gazipur', 'Sreepur', 'Bashamur', '1747'),
(220, 'Dhaka', 'Gazipur', 'Sreepur', 'Boubi', '1748'),
(221, 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur', '1741'),
(222, 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur Canttome', '1742'),
(223, 'Dhaka', 'Rajbari', 'Baliakandi', 'Baliakandi', '7730'),
(224, 'Dhaka', 'Rajbari', 'Baliakandi', 'Nalia', '7731'),
(225, 'Dhaka', 'Rajbari', 'Pangsha', 'Pangsha', '7720'),
(226, 'Dhaka', 'Rajbari', 'Pangsha', 'Ramkol', '7721'),
(227, 'Dhaka', 'Rajbari', 'Pangsha', 'Ratandia', '7722'),
(228, 'Dhaka', 'Rajbari', 'Pangsha', 'Mrigibazar', '7723'),
(229, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Rajbari Sadar', '7700'),
(230, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Goalanda', '7710'),
(231, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Khankhanapur', '7711'),
(232, 'Dhaka', 'Faridpur', 'Alfadanga', 'Alfadanga', '7870'),
(233, 'Dhaka', 'Faridpur', 'Bhanga', 'Bhanga', '7830'),
(234, 'Dhaka', 'Faridpur', 'Boalmari', 'Boalmari', '7860'),
(235, 'Dhaka', 'Faridpur', 'Boalmari', 'Rupatpat', '7861'),
(236, 'Dhaka', 'Faridpur', 'Charbhadrasan', 'Charbadrashan', '7810'),
(237, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Faridpursadar', '7800'),
(238, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Kanaipur', '7801'),
(239, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Ambikapur', '7802'),
(240, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Baitulaman Politecni', '7803'),
(241, 'Dhaka', 'Faridpur', 'Madukhali', 'Madukhali', '7850'),
(242, 'Dhaka', 'Faridpur', 'Madukhali', 'Kamarkali', '7851'),
(243, 'Dhaka', 'Faridpur', 'Nagarkanda', 'Nagarkanda', '7840'),
(244, 'Dhaka', 'Faridpur', 'Nagarkanda', 'Talma', '7841'),
(245, 'Dhaka', 'Faridpur', 'Sadarpur', 'Sadarpur', '7820'),
(246, 'Dhaka', 'Faridpur', 'Sadarpur', 'Hat Krishapur', '7821'),
(247, 'Dhaka', 'Faridpur', 'Sadarpur', 'Bishwa jaker Manjil', '7822'),
(248, 'Dhaka', 'Faridpur', 'Shriangan', 'Shriangan', '7804'),
(249, 'Dhaka', 'Madaripur', 'Barhamganj', 'Barhamganj', '7930'),
(250, 'Dhaka', 'Madaripur', 'Barhamganj', 'Nilaksmibandar', '7931'),
(251, 'Dhaka', 'Madaripur', 'Barhamganj', 'Bahadurpur', '7932'),
(252, 'Dhaka', 'Madaripur', 'Barhamganj', 'Umedpur', '7933'),
(253, 'Dhaka', 'Madaripur', 'kalkini', 'Kalkini', '7920'),
(254, 'Dhaka', 'Madaripur', 'kalkini', 'Sahabrampur', '7921'),
(255, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Madaripur Sadar', '7900'),
(256, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Charmugria', '7901'),
(257, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Kulpaddi', '7902'),
(258, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Habiganj', '7903'),
(259, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Mustafapur', '7904'),
(260, 'Dhaka', 'Madaripur', 'Rajoir', 'Rajoir', '7910'),
(261, 'Dhaka', 'Madaripur', 'Rajoir', 'Khalia', '7911'),
(262, 'Dhaka', 'Shariatpur', 'Bhedorganj', 'Bhedorganj', '8030'),
(263, 'Dhaka', 'Shariatpur', 'Damudhya', 'Damudhya', '8040'),
(264, 'Dhaka', 'Shariatpur', 'Gosairhat', 'Gosairhat', '8050'),
(265, 'Dhaka', 'Shariatpur', 'Jajira', 'Jajira', '8010'),
(266, 'Dhaka', 'Shariatpur', 'Naria', 'Naria', '8020'),
(267, 'Dhaka', 'Shariatpur', 'Naria', 'Bhozeshwar', '8021'),
(268, 'Dhaka', 'Shariatpur', 'Naria', 'Gharisar', '8022'),
(269, 'Dhaka', 'Shariatpur', 'Naria', 'Upshi', '8023'),
(270, 'Dhaka', 'Shariatpur', 'Naria', 'Kartikpur', '8024'),
(271, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Shariatpur Sadar', '8000'),
(272, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Angaria', '8001'),
(273, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Chikandi', '8002'),
(274, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Chandradighalia', '8013'),
(275, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Gopalganj Sadar', '8100'),
(276, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Ulpur', '8101'),
(277, 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Barfa', '8102'),
(278, 'Dhaka', 'Gopalganj', 'Kashiani', 'Kashiani', '8130'),
(279, 'Dhaka', 'Gopalganj', 'Kashiani', 'Ramdia College', '8131'),
(280, 'Dhaka', 'Gopalganj', 'Kashiani', 'Ratoil', '8132'),
(281, 'Dhaka', 'Gopalganj', 'Kashiani', 'Jonapur', '8133'),
(282, 'Dhaka', 'Gopalganj', 'Kotalipara', 'Kotalipara', '8110'),
(283, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Maksudpur', '8140'),
(284, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Batkiamari', '8141'),
(285, 'Dhaka', 'Gopalganj', 'Maksudpur', 'Khandarpara', '8142'),
(286, 'Dhaka', 'Gopalganj', 'Tungipara', 'Tungipara', '8120'),
(287, 'Dhaka', 'Gopalganj', 'Tungipara', 'Patgati', '8121'),
(288, 'Dhaka', 'Manikganj', 'Doulatpur', 'Doulatpur', '1860'),
(289, 'Dhaka', 'Manikganj', 'Gheor', 'Gheor', '1840'),
(290, 'Dhaka', 'Manikganj', 'Lechhraganj', 'Lechhraganj', '1830'),
(291, 'Dhaka', 'Manikganj', 'Lechhraganj', 'Jhitka', '1831'),
(292, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Sadar', '1800'),
(293, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Bazar', '1801'),
(294, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Gorpara', '1802'),
(295, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Mahadebpur', '1803'),
(296, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Barangail', '1804'),
(297, 'Dhaka', 'Manikganj', 'Saturia', 'Saturia', '1810'),
(298, 'Dhaka', 'Manikganj', 'Saturia', 'Baliati', '1811'),
(299, 'Dhaka', 'Manikganj', 'Shibloya', 'Shibaloy', '1850'),
(300, 'Dhaka', 'Manikganj', 'Shibloya', 'Aricha', '1851'),
(301, 'Dhaka', 'Manikganj', 'Shibloya', 'Tewta', '1852'),
(302, 'Dhaka', 'Manikganj', 'Shibloya', 'Uthli', '1853'),
(303, 'Dhaka', 'Manikganj', 'Singari', 'Singair', '1820'),
(304, 'Dhaka', 'Manikganj', 'Singari', 'Baira', '1821'),
(305, 'Dhaka', 'Manikganj', 'Singari', 'joymantop', '1822'),
(306, 'Dhaka', 'Tangail', 'Basail', 'Basail', '1920'),
(307, 'Dhaka', 'Tangail', 'Bhuapur', 'Bhuapur', '1960'),
(308, 'Dhaka', 'Tangail', 'Delduar', 'Delduar', '1910'),
(309, 'Dhaka', 'Tangail', 'Delduar', 'Jangalia', '1911'),
(310, 'Dhaka', 'Tangail', 'Delduar', 'Patharail', '1912'),
(311, 'Dhaka', 'Tangail', 'Delduar', 'Elasin', '1913'),
(312, 'Dhaka', 'Tangail', 'Delduar', 'Hinga Nagar', '1914'),
(313, 'Dhaka', 'Tangail', 'Delduar', 'Lowhati', '1915'),
(314, 'Dhaka', 'Tangail', 'Ghatail', 'Ghatial', '1980'),
(315, 'Dhaka', 'Tangail', 'Ghatail', 'Zahidganj', '1981'),
(316, 'Dhaka', 'Tangail', 'Ghatail', 'D. Pakutia', '1982'),
(317, 'Dhaka', 'Tangail', 'Ghatail', 'Dhalapara', '1983'),
(318, 'Dhaka', 'Tangail', 'Ghatail', 'Lohani', '1984'),
(319, 'Dhaka', 'Tangail', 'Gopalpur', 'Gopalpur', '1990'),
(320, 'Dhaka', 'Tangail', 'Gopalpur', 'Jhowail', '1991'),
(321, 'Dhaka', 'Tangail', 'Gopalpur', 'Hemnagar', '1992'),
(322, 'Dhaka', 'Tangail', 'Kalihati', 'Kalihati', '1970'),
(323, 'Dhaka', 'Tangail', 'Kalihati', 'Rajafair', '1971'),
(324, 'Dhaka', 'Tangail', 'Kalihati', 'Nagbari', '1972'),
(325, 'Dhaka', 'Tangail', 'Kalihati', 'Ballabazar', '1973'),
(326, 'Dhaka', 'Tangail', 'Kalihati', 'Elinga', '1974'),
(327, 'Dhaka', 'Tangail', 'Kalihati', 'Palisha', '1975'),
(328, 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari SO', '1976'),
(329, 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari', '1977'),
(330, 'Dhaka', 'Tangail', 'Kashkaolia', 'Kashkawlia', '1930'),
(331, 'Dhaka', 'Tangail', 'Madhupur', 'Madhupur', '1996'),
(332, 'Dhaka', 'Tangail', 'Madhupur', 'Dhobari', '1997'),
(333, 'Dhaka', 'Tangail', 'Mirzapur', 'Mirzapur', '1940'),
(334, 'Dhaka', 'Tangail', 'Mirzapur', 'Gorai', '1941'),
(335, 'Dhaka', 'Tangail', 'Mirzapur', 'M.C. College', '1942'),
(336, 'Dhaka', 'Tangail', 'Mirzapur', 'Warri paikpara', '1943'),
(337, 'Dhaka', 'Tangail', 'Mirzapur', 'Jarmuki', '1944'),
(338, 'Dhaka', 'Tangail', 'Mirzapur', 'Mohera', '1945'),
(339, 'Dhaka', 'Tangail', 'Nagarpur', 'Nagarpur', '1936'),
(340, 'Dhaka', 'Tangail', 'Nagarpur', 'Dhuburia', '1937'),
(341, 'Dhaka', 'Tangail', 'Nagarpur', 'Salimabad', '1938'),
(342, 'Dhaka', 'Tangail', 'Sakhipur', 'Sakhipur', '1950'),
(343, 'Dhaka', 'Tangail', 'Sakhipur', 'Kochua', '1951'),
(344, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Tangail Sadar', '1900'),
(345, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Kagmari', '1901'),
(346, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Santosh', '1902'),
(347, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Korotia', '1903'),
(348, 'Dhaka', 'Tangail', 'Tangail Sadar', 'Purabari', '1904'),
(349, 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj', '2030'),
(350, 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj S. Mills', '2031'),
(351, 'Dhaka', 'Jamalpur', 'Islampur', 'Islampur', '2020'),
(352, 'Dhaka', 'Jamalpur', 'Islampur', 'Durmoot', '2021'),
(353, 'Dhaka', 'Jamalpur', 'Islampur', 'Gilabari', '2022'),
(354, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Jamalpur', '2000'),
(355, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Nandina', '2001'),
(356, 'Dhaka', 'Jamalpur', 'Jamalpur', 'Narundi', '2002'),
(357, 'Dhaka', 'Jamalpur', 'Malandah', 'Malandah', '2010'),
(358, 'Dhaka', 'Jamalpur', 'Malandah', 'Jamalpur', '2011'),
(359, 'Dhaka', 'Jamalpur', 'Malandah', 'Malancha', '2012'),
(360, 'Dhaka', 'Jamalpur', 'Malandah', 'Mahmoodpur', '2013'),
(361, 'Dhaka', 'Jamalpur', 'Mathargonj', 'Mathargonj', '2040'),
(362, 'Dhaka', 'Jamalpur', 'Mathargonj', 'Balijhuri', '2041'),
(363, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Shorishabari', '2050'),
(364, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Gunerbari', '2051'),
(365, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Bausee', '2052'),
(366, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jagannath Ghat', '2053'),
(367, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Pingna', '2054'),
(368, 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jamuna Sar Karkhana', '2055'),
(369, 'Dhaka', 'Sherpur', 'Bakshigonj', 'Bakshigonj', '2140'),
(370, 'Dhaka', 'Sherpur', 'Jhinaigati', 'Jhinaigati', '2120'),
(371, 'Dhaka', 'Sherpur', 'Nakla', 'Nakla', '2150'),
(372, 'Dhaka', 'Sherpur', 'Nakla', 'Gonopaddi', '2151'),
(373, 'Dhaka', 'Sherpur', 'Nalitabari', 'Nalitabari', '2110'),
(374, 'Dhaka', 'Sherpur', 'Nalitabari', 'Hatibandha', '2111'),
(375, 'Dhaka', 'Sherpur', 'Sherpur Shadar', 'Sherpur Shadar', '2100'),
(376, 'Dhaka', 'Sherpur', 'Shribardi', 'Shribardi', '2130'),
(377, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Akhaura', '3450'),
(378, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Azampur', '3451'),
(379, 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Gangasagar', '3452'),
(380, 'Chittagong ', 'Brahmanbaria', 'Banchharampur', 'Banchharampur', '3420'),
(381, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Brahamanbaria Sadar', '3400'),
(382, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Talshahar', '3401'),
(383, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj', '3402'),
(384, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj Share', '3403'),
(385, 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Poun', '3404'),
(386, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kasba', '3460'),
(387, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kuti', '3461'),
(388, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chandidar', '3462'),
(389, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chargachh', '3463'),
(390, 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Gopinathpur', '3464'),
(391, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Nabinagar', '3410'),
(392, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Laubfatehpur', '3411'),
(393, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Rasullabad', '3412'),
(394, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shamgram', '3413'),
(395, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Ratanpur', '3414'),
(396, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shahapur', '3415'),
(397, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Kaitala', '3417'),
(398, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Salimganj', '3418'),
(399, 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Jibanganj', '3419'),
(400, 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Nasirnagar', '3440'),
(401, 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Fandauk', '3441'),
(402, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Sarial', '3430'),
(403, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Shahbajpur', '3431'),
(404, 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Chandura', '3432'),
(405, 'Chittagong ', 'Comilla', 'Barura', 'Barura', '3560'),
(406, 'Chittagong ', 'Comilla', 'Barura', 'Poyalgachha', '3561'),
(407, 'Chittagong ', 'Comilla', 'Barura', 'Murdafarganj', '3562'),
(408, 'Chittagong ', 'Comilla', 'Brahmanpara', 'Brahmanpara', '3526'),
(409, 'Chittagong ', 'Comilla', 'Burichang', 'Burichang', '3520'),
(410, 'Chittagong ', 'Comilla', 'Burichang', 'Maynamoti bazar', '3521'),
(411, 'Chittagong ', 'Comilla', 'Chandina', 'Chandia', '3510'),
(412, 'Chittagong ', 'Comilla', 'Chandina', 'Madhaiabazar', '3511'),
(413, 'Chittagong ', 'Comilla', 'Chouddagram', 'Chouddagram', '3550'),
(414, 'Chittagong ', 'Comilla', 'Chouddagram', 'Batisa', '3551'),
(415, 'Chittagong ', 'Comilla', 'Chouddagram', 'Chiora', '3552'),
(416, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Sadar', '3500'),
(417, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Contoment', '3501'),
(418, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Halimanagar', '3502'),
(419, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Courtbari', '3503'),
(420, 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Suaganj', '3504'),
(421, 'Chittagong ', 'Comilla', 'Daudkandi', 'Daudkandi', '3516'),
(422, 'Chittagong ', 'Comilla', 'Daudkandi', 'Gouripur', '3517'),
(423, 'Chittagong ', 'Comilla', 'Daudkandi', 'Dashpara', '3518'),
(424, 'Chittagong ', 'Comilla', 'Daudkandi', 'Eliotganj', '3519'),
(425, 'Chittagong ', 'Comilla', 'Davidhar', 'Davidhar', '3530'),
(426, 'Chittagong ', 'Comilla', 'Davidhar', 'Gangamandal', '3531'),
(427, 'Chittagong ', 'Comilla', 'Davidhar', 'Barashalghar', '3532'),
(428, 'Chittagong ', 'Comilla', 'Davidhar', 'Dhamtee', '3533'),
(429, 'Chittagong ', 'Comilla', 'Homna', 'Homna', '3546'),
(430, 'Chittagong ', 'Comilla', 'Laksam', 'Laksam', '3570'),
(431, 'Chittagong ', 'Comilla', 'Laksam', 'Lakshamanpur', '3571'),
(432, 'Chittagong ', 'Comilla', 'Laksam', 'Bipulasar', '3572'),
(433, 'Chittagong ', 'Comilla', 'Langalkot', 'Langalkot', '3580'),
(434, 'Chittagong ', 'Comilla', 'Langalkot', 'Dhalua', '3581'),
(435, 'Chittagong ', 'Comilla', 'Langalkot', 'Chhariabazar', '3582'),
(436, 'Chittagong ', 'Comilla', 'Langalkot', 'Gunabati', '3583'),
(437, 'Chittagong ', 'Comilla', 'Muradnagar', 'Muradnagar', '3540'),
(438, 'Chittagong ', 'Comilla', 'Muradnagar', 'Ramchandarpur', '3541'),
(439, 'Chittagong ', 'Comilla', 'Muradnagar', 'Companyganj', '3542'),
(440, 'Chittagong ', 'Comilla', 'Muradnagar', 'Bangra', '3543'),
(441, 'Chittagong ', 'Comilla', 'Muradnagar', 'Sonakanda', '3544'),
(442, 'Chittagong ', 'Comilla', 'Muradnagar', 'Pantibazar', '3545'),
(443, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Char Alexgander', '3730'),
(444, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Hajirghat', '3731'),
(445, 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Ramgatirhat', '3732'),
(446, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Lakshimpur Sadar', '3700'),
(447, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Dalal Bazar', '3701'),
(448, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Bhabaniganj', '3702'),
(449, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Mandari', '3703'),
(450, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Keramatganj', '3704'),
(451, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Rupchara', '3705'),
(452, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Duttapara', '3706'),
(453, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Choupalli', '3707'),
(454, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Chandraganj', '3708'),
(455, 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Amani Lakshimpur', '3709'),
(456, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Ramganj', '3720'),
(457, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Alipur', '3721'),
(458, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Panpara', '3722'),
(459, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Kanchanpur', '3723'),
(460, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Naagmud', '3724'),
(461, 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Dolta', '3725'),
(462, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Raypur', '3710'),
(463, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Rakhallia', '3711'),
(464, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Nagerdighirpar', '3712'),
(465, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Haydarganj', '3713'),
(466, 'Chittagong ', 'Lakshmipur', 'Raypur', 'Bhuabari', '3714'),
(467, 'Chittagong ', 'Noakhali', 'Basurhat', 'Basur Hat', '3850'),
(468, 'Chittagong ', 'Noakhali', 'Basurhat', 'Charhajari', '3851'),
(469, 'Chittagong ', 'Noakhali', 'Begumganj', 'Begumganj', '3820'),
(470, 'Chittagong ', 'Noakhali', 'Begumganj', 'Choumohani', '3821'),
(471, 'Chittagong ', 'Noakhali', 'Begumganj', 'Banglabazar', '3822'),
(472, 'Chittagong ', 'Noakhali', 'Begumganj', 'Mir Owarishpur', '3823'),
(473, 'Chittagong ', 'Noakhali', 'Begumganj', 'Bazra', '3824'),
(474, 'Chittagong ', 'Noakhali', 'Begumganj', 'Jamidar Hat', '3825'),
(475, 'Chittagong ', 'Noakhali', 'Begumganj', 'Sonaimuri', '3827'),
(476, 'Chittagong ', 'Noakhali', 'Begumganj', 'Gopalpur', '3828'),
(477, 'Chittagong ', 'Noakhali', 'Begumganj', 'Joynarayanpur', '3829'),
(478, 'Chittagong ', 'Noakhali', 'Begumganj', 'Alaiarpur', '3831'),
(479, 'Chittagong ', 'Noakhali', 'Begumganj', 'Tangirpar', '3832'),
(480, 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalafat Bazar', '3833'),
(481, 'Chittagong ', 'Noakhali', 'Begumganj', 'Rajganj', '3834'),
(482, 'Chittagong ', 'Noakhali', 'Begumganj', 'Oachhekpur', '3835'),
(483, 'Chittagong ', 'Noakhali', 'Begumganj', 'Bhabani Jibanpur', '3837'),
(484, 'Chittagong ', 'Noakhali', 'Begumganj', 'Maheshganj', '3838'),
(485, 'Chittagong ', 'Noakhali', 'Begumganj', 'Nadona', '3839'),
(486, 'Chittagong ', 'Noakhali', 'Begumganj', 'Nandiapara', '3841'),
(487, 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalishpur', '3842'),
(488, 'Chittagong ', 'Noakhali', 'Begumganj', 'Dauti', '3843'),
(489, 'Chittagong ', 'Noakhali', 'Begumganj', 'Joyag', '3844'),
(490, 'Chittagong ', 'Noakhali', 'Begumganj', 'Thanar Hat', '3845'),
(491, 'Chittagong ', 'Noakhali', 'Begumganj', 'Amisha Para', '3847'),
(492, 'Chittagong ', 'Noakhali', 'Begumganj', 'Durgapur', '3848'),
(493, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Chatkhil', '3870'),
(494, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Palla', '3871'),
(495, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Khilpara', '3872'),
(496, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bodalcourt', '3873'),
(497, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Rezzakpur', '3874'),
(498, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Solla', '3875'),
(499, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Karihati', '3877'),
(500, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Dosh Gharia', '3878'),
(501, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bansa Bazar', '3879'),
(502, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sahapur', '3881'),
(503, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sampara', '3882'),
(504, 'Chittagong ', 'Noakhali', 'Chatkhil', 'Shingbahura', '3883'),
(505, 'Chittagong ', 'Noakhali', 'Hatiya', 'Hatiya', '3890'),
(506, 'Chittagong ', 'Noakhali', 'Hatiya', 'Afazia', '3891'),
(507, 'Chittagong ', 'Noakhali', 'Hatiya', 'Tamoraddi', '3892'),
(508, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali Sadar', '3800'),
(509, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali College', '3801'),
(510, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Sonapur', '3802'),
(511, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Din Monir Hat', '3803'),
(512, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Pak Kishoreganj', '3804'),
(513, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Mriddarhat', '3806'),
(514, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Kabirhat', '3807'),
(515, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Khalifar Hat', '3808'),
(516, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Charam Tua', '3809'),
(517, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Chaprashir Hat', '3811'),
(518, 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Char Jabbar', '3812'),
(519, 'Chittagong ', 'Noakhali', 'Senbag', 'Senbag', '3860'),
(520, 'Chittagong ', 'Noakhali', 'Senbag', 'Kallyandi', '3861'),
(521, 'Chittagong ', 'Noakhali', 'Senbag', 'Beezbag', '3862'),
(522, 'Chittagong ', 'Noakhali', 'Senbag', 'Kankirhat', '3863'),
(523, 'Chittagong ', 'Noakhali', 'Senbag', 'Chatarpaia', '3864'),
(524, 'Chittagong ', 'Noakhali', 'Senbag', 'T.P. Lamua', '3865'),
(525, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Chhagalnaia', '3910'),
(526, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Maharajganj', '3911'),
(527, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Daraga Hat', '3912'),
(528, 'Chittagong ', 'Feni', 'Chhagalnaia', 'Puabashimulia', '3913'),
(529, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dagondhuia', '3920'),
(530, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dudmukha', '3921'),
(531, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Chhilonia', '3922'),
(532, 'Chittagong ', 'Feni', 'Dagonbhuia', 'Rajapur', '3923'),
(533, 'Chittagong ', 'Feni', 'Feni Sadar', 'Feni Sadar', '3900'),
(534, 'Chittagong ', 'Feni', 'Feni Sadar', 'Fazilpur', '3901'),
(535, 'Chittagong ', 'Feni', 'Feni Sadar', 'Sharshadie', '3902'),
(536, 'Chittagong ', 'Feni', 'Feni Sadar', 'Laskarhat', '3903'),
(537, 'Chittagong ', 'Feni', 'Pashurampur', 'Pashurampur', '3940'),
(538, 'Chittagong ', 'Feni', 'Pashurampur', 'Shuarbazar', '3941'),
(539, 'Chittagong ', 'Feni', 'Pashurampur', 'Fulgazi', '3942'),
(540, 'Chittagong ', 'Feni', 'Pashurampur', 'Munshirhat', '3943'),
(541, 'Chittagong ', 'Feni', 'Sonagazi', 'Sonagazi', '3930'),
(542, 'Chittagong ', 'Feni', 'Sonagazi', 'Motiganj', '3931'),
(543, 'Chittagong ', 'Feni', 'Sonagazi', 'Ahmadpur', '3932'),
(544, 'Chittagong ', 'Feni', 'Sonagazi', 'Kazirhat', '3933'),
(545, 'Chittagong ', 'Chittagong', 'Anawara', 'Anowara', '4376'),
(546, 'Chittagong ', 'Chittagong', 'Anawara', 'Paroikora', '4377'),
(547, 'Chittagong ', 'Chittagong', 'Anawara', 'Battali', '4378'),
(548, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kanungopara', '4363'),
(549, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Saroatoli', '4364'),
(550, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Iqbal Park', '4365'),
(551, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Boalkhali', '4366'),
(552, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Sakpura', '4367'),
(553, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kadurkhal', '4368'),
(554, 'Chittagong ', 'Chittagong', 'Boalkhali', 'Charandwip', '4369'),
(555, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong GPO', '4000'),
(556, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Bandar', '4100'),
(557, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Pahartoli', '4202'),
(558, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chawkbazar', '4203'),
(559, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Patenga', '4204'),
(560, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Airport', '4205'),
(561, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Jaldia Merine Accade', '4206'),
(562, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Firozshah', '4207'),
(563, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Mohard', '4208'),
(564, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Politechnic In', '4209'),
(565, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Bayezid Bostami', '4210'),
(566, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Amin Jute Mills', '4211'),
(567, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chandgaon', '4212'),
(568, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Wazedia', '4213'),
(569, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Jalalabad', '4214'),
(570, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Anandabazar', '4215'),
(571, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishahar', '4216'),
(572, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Katuli', '4217'),
(573, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Sailers Colon', '4218'),
(574, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Customs Acca', '4219'),
(575, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Cantonment', '4220'),
(576, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Al- Amin Baria Madra', '4221'),
(577, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Middle Patenga', '4222'),
(578, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Export Processing', '4223'),
(579, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Rampura TSO', '4224'),
(580, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishshar', '4225'),
(581, 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Halishahar', '4226'),
(582, 'Chittagong ', 'Chittagong', 'East Joara', 'East Joara', '4380'),
(583, 'Chittagong ', 'Chittagong', 'East Joara', 'Gachbaria', '4381'),
(584, 'Chittagong ', 'Chittagong', 'East Joara', 'Dohazari', '4382'),
(585, 'Chittagong ', 'Chittagong', 'East Joara', 'Barma', '4383'),
(586, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Fatikchhari', '4350'),
(587, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Nanupur', '4351'),
(588, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Bhandar Sharif', '4352'),
(589, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Najirhat', '4353'),
(590, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Harualchhari', '4354'),
(591, 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Narayanhat', '4355'),
(592, 'Chittagong ', 'Chittagong', 'Hathazari', 'Hathazari', '4330'),
(593, 'Chittagong ', 'Chittagong', 'Hathazari', 'Chitt.University', '4331'),
(594, 'Chittagong ', 'Chittagong', 'Hathazari', 'Gorduara', '4332'),
(595, 'Chittagong ', 'Chittagong', 'Hathazari', 'Katirhat', '4333'),
(596, 'Chittagong ', 'Chittagong', 'Hathazari', 'Mirzapur', '4334'),
(597, 'Chittagong ', 'Chittagong', 'Hathazari', 'Fatahabad', '4335'),
(598, 'Chittagong ', 'Chittagong', 'Hathazari', 'Nuralibari', '4337'),
(599, 'Chittagong ', 'Chittagong', 'Hathazari', 'Yunus Nagar', '4338'),
(600, 'Chittagong ', 'Chittagong', 'Hathazari', 'Madrasa', '4339'),
(601, 'Chittagong ', 'Chittagong', 'Jaldi', 'Jaldi', '4390'),
(602, 'Chittagong ', 'Chittagong', 'Jaldi', 'Khan Bahadur', '4391'),
(603, 'Chittagong ', 'Chittagong', 'Jaldi', 'Gunagari', '4392'),
(604, 'Chittagong ', 'Chittagong', 'Jaldi', 'Banigram', '4393'),
(605, 'Chittagong ', 'Chittagong', 'Lohagara', 'Lohagara', '4396'),
(606, 'Chittagong ', 'Chittagong', 'Lohagara', 'Padua', '4397'),
(607, 'Chittagong ', 'Chittagong', 'Lohagara', 'Chunti', '4398'),
(608, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mirsharai', '4320'),
(609, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Abutorab', '4321'),
(610, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Darrogahat', '4322'),
(611, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Bharawazhat', '4323'),
(612, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Joarganj', '4324'),
(613, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Azampur', '4325'),
(614, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Korerhat', '4327'),
(615, 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mohazanhat', '4328'),
(616, 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Patia Head Office', '4370'),
(617, 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Budhpara', '4371'),
(618, 'Chittagong ', 'Chittagong', 'Rangunia', 'Rangunia', '4360'),
(619, 'Chittagong ', 'Chittagong', 'Rangunia', 'Dhamair', '4361'),
(620, 'Chittagong ', 'Chittagong', 'Rouzan', 'Rouzan', '4340'),
(621, 'Chittagong ', 'Chittagong', 'Rouzan', 'Beenajuri', '4341'),
(622, 'Chittagong ', 'Chittagong', 'Rouzan', 'Kundeshwari', '4342'),
(623, 'Chittagong ', 'Chittagong', 'Rouzan', 'Gahira', '4343'),
(624, 'Chittagong ', 'Chittagong', 'Rouzan', 'jagannath Hat', '4344'),
(625, 'Chittagong ', 'Chittagong', 'Rouzan', 'Fatepur', '4345'),
(626, 'Chittagong ', 'Chittagong', 'Rouzan', 'Guzra Noapara', '4346'),
(627, 'Chittagong ', 'Chittagong', 'Rouzan', 'Dewanpur', '4347'),
(628, 'Chittagong ', 'Chittagong', 'Rouzan', 'Mohamuni', '4348'),
(629, 'Chittagong ', 'Chittagong', 'Rouzan', 'B.I.T Post Office', '4349'),
(630, 'Chittagong ', 'Chittagong', 'Sandwip', 'Sandwip', '4300'),
(631, 'Chittagong ', 'Chittagong', 'Sandwip', 'Shiberhat', '4301'),
(632, 'Chittagong ', 'Chittagong', 'Sandwip', 'Urirchar', '4302'),
(633, 'Chittagong ', 'Chittagong', 'Satkania', 'Satkania', '4386'),
(634, 'Chittagong ', 'Chittagong', 'Satkania', 'Baitul Ijjat', '4387'),
(635, 'Chittagong ', 'Chittagong', 'Satkania', 'Bazalia', '4388'),
(636, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Sitakunda', '4310'),
(637, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Baroidhala', '4311'),
(638, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Barabkunda', '4312'),
(639, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Bawashbaria', '4313'),
(640, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Kumira', '4314'),
(641, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Bhatiari', '4315'),
(642, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Fouzdarhat', '4316'),
(643, 'Chittagong ', 'Chittagong', 'Sitakunda', 'Jafrabad', '4317'),
(644, 'Chittagong ', 'Khagrachari', 'Diginala', 'Diginala', '4420'),
(645, 'Chittagong ', 'Khagrachari', 'Khagrachari Sadar', 'Khagrachari Sadar', '4400'),
(646, 'Chittagong ', 'Khagrachari', 'Laxmichhari', 'Laxmichhari', '4470'),
(647, 'Chittagong ', 'Khagrachari', 'Mahalchhari', 'Mahalchhari', '4430'),
(648, 'Chittagong ', 'Khagrachari', 'Manikchhari', 'Manikchhari', '4460'),
(649, 'Chittagong ', 'Khagrachari', 'Matiranga', 'Matiranga', '4450'),
(650, 'Chittagong ', 'Khagrachari', 'Panchhari', 'Panchhari', '4410'),
(651, 'Chittagong ', 'Khagrachari', 'Ramghar Head Office', 'Ramghar Head Office', '4440'),
(652, 'Chittagong ', 'Rangamati', 'Barakal', 'Barakal', '4570'),
(653, 'Chittagong ', 'Rangamati', 'Bilaichhari', 'Bilaichhari', '4550'),
(654, 'Chittagong ', 'Rangamati', 'Jarachhari', 'Jarachhari', '4560'),
(655, 'Chittagong ', 'Rangamati', 'Kalampati', 'Kalampati', '4510'),
(656, 'Chittagong ', 'Rangamati', 'Kalampati', 'Betbunia', '4511'),
(657, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai', '4530'),
(658, 'Chittagong ', 'Rangamati', 'kaptai', 'Chandraghona', '4531'),
(659, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Project', '4532'),
(660, 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Nuton Bazar', '4533'),
(661, 'Chittagong ', 'Rangamati', 'Longachh', 'Longachh', '4580'),
(662, 'Chittagong ', 'Rangamati', 'Marishya', 'Marishya', '4590'),
(663, 'Chittagong ', 'Rangamati', 'Naniachhar', 'Nanichhar', '4520'),
(664, 'Chittagong ', 'Rangamati', 'Rajsthali', 'Rajsthali', '4540'),
(665, 'Chittagong ', 'Rangamati', 'Rangamati Sadar', 'Rangamati Sadar', '4500'),
(666, 'Chittagong ', 'Bandarban', 'Alikadam', 'Alikadam', '4650'),
(667, 'Chittagong ', 'Bandarban', 'Bandarban Sadar', 'Bandarban Sadar', '4600'),
(668, 'Chittagong ', 'Bandarban', 'Naikhong', 'Naikhong', '4660'),
(669, 'Chittagong ', 'Bandarban', 'Roanchhari', 'Roanchhari', '4610'),
(670, 'Chittagong ', 'Bandarban', 'Ruma', 'Ruma', '4620'),
(671, 'Chittagong ', 'Bandarban', 'Thanchi', 'Thanchi', '4630'),
(672, 'Chittagong ', 'Bandarban', 'Thanchi', 'Lama', '4641'),
(673, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga', '4740'),
(674, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga S.O', '4741'),
(675, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Badarkali', '4742'),
(676, 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Malumghat', '4743'),
(677, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Coxs Bazar Sadar', '4700'),
(678, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Zhilanja', '4701'),
(679, 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Eidga', '4702'),
(680, 'Chittagong ', 'Coxs Bazar', 'Gorakghat', 'Gorakghat', '4710'),
(681, 'Chittagong ', 'Coxs Bazar', 'Kutubdia', 'Kutubdia', '4720'),
(682, 'Chittagong ', 'Coxs Bazar', 'Ramu', 'Ramu', '4730'),
(683, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Teknaf', '4760'),
(684, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Hnila', '4761'),
(685, 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'St.Martin', '4762'),
(686, 'Chittagong ', 'Coxs Bazar', 'Ukhia', 'Ukhia', '4750'),
(687, 'Khulna ', 'Kustia', 'Bheramara', 'Bheramara', '7040'),
(688, 'Khulna ', 'Kustia', 'Bheramara', 'Ganges Bheramara', '7041'),
(689, 'Khulna ', 'Kustia', 'Bheramara', 'Allardarga', '7042'),
(690, 'Khulna ', 'Kustia', 'Janipur', 'Janipur', '7020'),
(691, 'Khulna ', 'Kustia', 'Janipur', 'Khoksa', '7021'),
(692, 'Khulna ', 'Kustia', 'Kumarkhali', 'Kumarkhali', '7010'),
(693, 'Khulna ', 'Kustia', 'Kumarkhali', 'Panti', '7011'),
(694, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kustia Sadar', '7000'),
(695, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kushtia Mohini', '7001'),
(696, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Jagati', '7002'),
(697, 'Khulna ', 'Kustia', 'Kustia Sadar', 'Islami University', '7003'),
(698, 'Khulna ', 'Kustia', 'Mirpur', 'Mirpur', '7030'),
(699, 'Khulna ', 'Kustia', 'Mirpur', 'Poradaha', '7031'),
(700, 'Khulna ', 'Kustia', 'Mirpur', 'Amla Sadarpur', '7032'),
(701, 'Khulna ', 'Kustia', 'Rafayetpur', 'Rafayetpur', '7050'),
(702, 'Khulna ', 'Kustia', 'Rafayetpur', 'Taragunia', '7051'),
(703, 'Khulna ', 'Kustia', 'Rafayetpur', 'Khasmathurapur', '7052'),
(704, 'Khulna ', 'Meherpur', 'Gangni', 'Gangni', '7110'),
(705, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Meherpur Sadar', '7100'),
(706, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', '7101'),
(707, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Mujib Nagar Complex', '7102'),
(708, 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', '7152'),
(709, 'Khulna ', 'Chuadanga', 'Alamdanga', 'Alamdanga', '7210'),
(710, 'Khulna ', 'Chuadanga', 'Alamdanga', 'Hardi', '7211'),
(711, 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Chuadanga Sadar', '7200'),
(712, 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Munshiganj', '7201'),
(713, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Damurhuda', '7220'),
(714, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Darshana', '7221'),
(715, 'Khulna ', 'Chuadanga', 'Damurhuda', 'Andulbaria', '7222'),
(716, 'Khulna ', 'Chuadanga', 'Doulatganj', 'Doulatganj', '7230'),
(717, 'Khulna ', 'Jinaidaha', 'Harinakundu', 'Harinakundu', '7310'),
(718, 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Sadar', '7300'),
(719, 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Cadet College', '7301'),
(720, 'Khulna ', 'Jinaidaha', 'Kotchandpur', 'Kotchandpur', '7330'),
(721, 'Khulna ', 'Jinaidaha', 'Maheshpur', 'Maheshpur', '7340'),
(722, 'Khulna ', 'Jinaidaha', 'Naldanga', 'Naldanga', '7350'),
(723, 'Khulna ', 'Jinaidaha', 'Naldanga', 'Hatbar Bazar', '7351'),
(724, 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Shailakupa', '7320'),
(725, 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Kumiradaha', '7321'),
(726, 'Khulna ', 'Jessore', 'Bagharpara', 'Bagharpara', '7470'),
(727, 'Khulna ', 'Jessore', 'Bagharpara', 'Gouranagar', '7471'),
(728, 'Khulna ', 'Jessore', 'Chaugachha', 'Chougachha', '7410'),
(729, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Sadar', '7400'),
(730, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Upa-Shahar', '7401'),
(731, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Chanchra', '7402'),
(732, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore canttonment', '7403'),
(733, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Airbach', '7404'),
(734, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Rupdia', '7405'),
(735, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Basundia', '7406'),
(736, 'Khulna ', 'Jessore', 'Jessore Sadar', 'Churamankathi', '7407'),
(737, 'Khulna ', 'Jessore', 'Jhikargachha', 'Jhikargachha', '7420'),
(738, 'Khulna ', 'Jessore', 'Keshabpur', 'Keshobpur', '7450'),
(739, 'Khulna ', 'Jessore', 'Monirampur', 'Monirampur', '7440'),
(740, 'Khulna ', 'Jessore', 'Noapara', 'Noapara', '7460'),
(741, 'Khulna ', 'Jessore', 'Noapara', 'Rajghat', '7461'),
(742, 'Khulna ', 'Jessore', 'Noapara', 'Bhugilhat', '7462'),
(743, 'Khulna ', 'Jessore', 'Sarsa', 'Sarsa', '7430'),
(744, 'Khulna ', 'Jessore', 'Sarsa', 'Benapole', '7431'),
(745, 'Khulna ', 'Jessore', 'Sarsa', 'Jadabpur', '7432'),
(746, 'Khulna ', 'Jessore', 'Sarsa', 'Bag Achra', '7433'),
(747, 'Khulna ', 'Narail', 'Kalia', 'Kalia', '7520'),
(748, 'Khulna ', 'Narail', 'Laxmipasha', 'Laxmipasha', '7510'),
(749, 'Khulna ', 'Narail', 'Laxmipasha', 'Lohagora', '7511'),
(750, 'Khulna ', 'Narail', 'Laxmipasha', 'Itna', '7512'),
(751, 'Khulna ', 'Narail', 'Laxmipasha', 'Naldi', '7513'),
(752, 'Khulna ', 'Narail', 'Laxmipasha', 'Baradia', '7514'),
(753, 'Khulna ', 'Narail', 'Mohajan', 'Mohajan', '7521'),
(754, 'Khulna ', 'Narail', 'Narail Sadar', 'Narail Sadar', '7500'),
(755, 'Khulna ', 'Narail', 'Narail Sadar', 'Ratanganj', '7501'),
(756, 'Khulna ', 'Magura', 'Arpara', 'Arpara', '7620'),
(757, 'Khulna ', 'Magura', 'Magura Sadar', 'Magura Sadar', '7600'),
(758, 'Khulna ', 'Magura', 'Mohammadpur', 'Mohammadpur', '7630'),
(759, 'Khulna ', 'Magura', 'Mohammadpur', 'Binodpur', '7631'),
(760, 'Khulna ', 'Magura', 'Mohammadpur', 'Nahata', '7632'),
(761, 'Khulna ', 'Magura', 'Shripur', 'Shripur', '7610'),
(762, 'Khulna ', 'Magura', 'Shripur', 'Langalbadh', '7611'),
(763, 'Khulna ', 'Magura', 'Shripur', 'Nachol', '7612'),
(764, 'Khulna ', 'Khulna', 'Alaipur', 'Alaipur', '9240'),
(765, 'Khulna ', 'Khulna', 'Alaipur', 'Rupsha', '9241'),
(766, 'Khulna ', 'Khulna', 'Alaipur', 'Belphulia', '9242'),
(767, 'Khulna ', 'Khulna', 'Batiaghat', 'Batiaghat', '9260'),
(768, 'Khulna ', 'Khulna', 'Batiaghat', 'Surkalee', '9261'),
(769, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Chalna Bazar', '9270'),
(770, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Dakup', '9271'),
(771, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Bajua', '9272'),
(772, 'Khulna ', 'Khulna', 'Chalna Bazar', 'Nalian', '9273'),
(773, 'Khulna ', 'Khulna', 'Digalia', 'Digalia', '9220'),
(774, 'Khulna ', 'Khulna', 'Digalia', 'Chandni Mahal', '9221'),
(775, 'Khulna ', 'Khulna', 'Digalia', 'Senhati', '9222'),
(776, 'Khulna ', 'Khulna', 'Digalia', 'Ghoshghati', '9223'),
(777, 'Khulna ', 'Khulna', 'Digalia', 'Gazirhat', '9224'),
(778, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna G.P.O', '9000');
INSERT INTO `TABLE 3` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`) VALUES
(779, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khula Sadar', '9100'),
(780, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna Shipyard', '9201'),
(781, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Doulatpur', '9202'),
(782, 'Khulna ', 'Khulna', 'Khulna Sadar', 'BIT Khulna', '9203'),
(783, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Siramani', '9204'),
(784, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Jahanabad Canttonmen', '9205'),
(785, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Sonali Jute Mills', '9206'),
(786, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Atra Shilpa Area', '9207'),
(787, 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna University', '9208'),
(788, 'Khulna ', 'Khulna', 'Madinabad', 'Madinabad', '9290'),
(789, 'Khulna ', 'Khulna', 'Madinabad', 'Amadee', '9291'),
(790, 'Khulna ', 'Khulna', 'Paikgachha', 'Paikgachha', '9280'),
(791, 'Khulna ', 'Khulna', 'Paikgachha', 'Godaipur', '9281'),
(792, 'Khulna ', 'Khulna', 'Paikgachha', 'Kapilmoni', '9282'),
(793, 'Khulna ', 'Khulna', 'Paikgachha', 'Katipara', '9283'),
(794, 'Khulna ', 'Khulna', 'Paikgachha', 'Chandkhali', '9284'),
(795, 'Khulna ', 'Khulna', 'Paikgachha', 'Garaikhali', '9285'),
(796, 'Khulna ', 'Khulna', 'Phultala', 'Phultala', '9210'),
(797, 'Khulna ', 'Khulna', 'Sajiara', 'Sajiara', '9250'),
(798, 'Khulna ', 'Khulna', 'Sajiara', 'Ghonabanda', '9251'),
(799, 'Khulna ', 'Khulna', 'Sajiara', 'Chuknagar', '9252'),
(800, 'Khulna ', 'Khulna', 'Sajiara', 'Shahapur', '9253'),
(801, 'Khulna ', 'Khulna', 'Terakhada', 'Terakhada', '9230'),
(802, 'Khulna ', 'Khulna', 'Terakhada', 'Pak Barasat', '9231'),
(803, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'Bagerhat Sadar', '9300'),
(804, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'P.C College', '9301'),
(805, 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'Rangdia', '9302'),
(806, 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Chalna Ankorage', '9350'),
(807, 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Mongla Port', '9351'),
(808, 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Chitalmari', '9360'),
(809, 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Barabaria', '9361'),
(810, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Fakirhat', '9370'),
(811, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Mansa', '9371'),
(812, 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Bhanganpar Bazar', '9372'),
(813, 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Kachua', '9310'),
(814, 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Sonarkola', '9311'),
(815, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Mollahat', '9380'),
(816, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Kahalpur', '9381'),
(817, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Dariala', '9382'),
(818, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Charkulia', '9383'),
(819, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Nagarkandi', '9384'),
(820, 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Pak Gangni', '9385'),
(821, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Morelganj', '9320'),
(822, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Sannasi Bazar', '9321'),
(823, 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Telisatee', '9322'),
(824, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Rampal', '9340'),
(825, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Foylahat', '9341'),
(826, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Sonatunia', '9342'),
(827, 'Khulna ', 'IBH WAs Here', 'Rampal', 'Gourambha', '9343'),
(828, 'Khulna ', 'IBH WAs Here', 'Rayenda', 'Rayenda', '9330'),
(829, 'Khulna ', 'Satkhira', 'Ashashuni', 'Ashashuni', '9460'),
(830, 'Khulna ', 'Satkhira', 'Ashashuni', 'Baradal', '9461'),
(831, 'Khulna ', 'Satkhira', 'Debbhata', 'Debbhata', '9430'),
(832, 'Khulna ', 'Satkhira', 'Debbhata', 'Gurugram', '9431'),
(833, 'Khulna ', 'Satkhira', 'kalaroa', 'kalaroa', '9410'),
(834, 'Khulna ', 'Satkhira', 'kalaroa', 'Murarikati', '9411'),
(835, 'Khulna ', 'Satkhira', 'kalaroa', 'Jhaudanga', '9412'),
(836, 'Khulna ', 'Satkhira', 'kalaroa', 'Hamidpur', '9413'),
(837, 'Khulna ', 'Satkhira', 'kalaroa', 'Khordo', '9414'),
(838, 'Khulna ', 'Satkhira', 'kalaroa', 'Chandanpur', '9415'),
(839, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Kaliganj UPO', '9440'),
(840, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Nalta Mubaroknagar', '9441'),
(841, 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Ratanpur', '9442'),
(842, 'Khulna ', 'Satkhira', 'Nakipur', 'Nakipur', '9450'),
(843, 'Khulna ', 'Satkhira', 'Nakipur', 'Noornagar', '9451'),
(844, 'Khulna ', 'Satkhira', 'Nakipur', 'Naobeki', '9452'),
(845, 'Khulna ', 'Satkhira', 'Nakipur', 'Buri Goalini', '9453'),
(846, 'Khulna ', 'Satkhira', 'Nakipur', 'Gabura', '9454'),
(847, 'Khulna ', 'Satkhira', 'Nakipur', 'Habinagar', '9455'),
(848, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Sadar', '9400'),
(849, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Islamia Acc', '9401'),
(850, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Gunakar kati', '9402'),
(851, 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Budhhat', '9403'),
(852, 'Khulna ', 'Satkhira', 'Taala', 'Taala', '9420'),
(853, 'Khulna ', 'Satkhira', 'Taala', 'Patkelghata', '9421'),
(854, 'Sylhet ', 'Sunamganj', 'Bishamsarpur', 'Bishamsapur', '3010'),
(855, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak', '3080'),
(856, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Cement Facto', '3081'),
(857, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Paper Mills', '3082'),
(858, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj', '3083'),
(859, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj Natun Ba', '3084'),
(860, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Khurma', '3085'),
(861, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Moinpur', '3086'),
(862, 'Sylhet ', 'Sunamganj', 'Chhatak', 'jahidpur', '3087'),
(863, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Islamabad', '3088'),
(864, 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chourangi Bazar', '3893'),
(865, 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Dhirai Chandpur', '3040'),
(866, 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Jagdal', '3041'),
(867, 'Sylhet ', 'Sunamganj', 'Duara bazar', 'Duara bazar', '3070'),
(868, 'Sylhet ', 'Sunamganj', 'Ghungiar', 'Ghungiar', '3050'),
(869, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Jagnnathpur', '3060'),
(870, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Syedpur', '3061'),
(871, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Atuajan', '3062'),
(872, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Hasan Fatemapur', '3063'),
(873, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Rasulganj', '3064'),
(874, 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Shiramsi', '3065'),
(875, 'Sylhet ', 'Sunamganj', 'Sachna', 'Sachna', '3020'),
(876, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Sunamganj Sadar', '3000'),
(877, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Pagla', '3001'),
(878, 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Patharia', '3002'),
(879, 'Sylhet ', 'Sunamganj', 'Tahirpur', 'Tahirpur', '3030'),
(880, 'Sylhet ', 'Sylhet', 'Balaganj', 'Balaganj', '3120'),
(881, 'Sylhet ', 'Sylhet', 'Balaganj', 'Karua', '3121'),
(882, 'Sylhet ', 'Sylhet', 'Balaganj', 'Brahman Shashon', '3122'),
(883, 'Sylhet ', 'Sylhet', 'Balaganj', 'Tajpur', '3123'),
(884, 'Sylhet ', 'Sylhet', 'Balaganj', 'Goala Bazar', '3124'),
(885, 'Sylhet ', 'Sylhet', 'Balaganj', 'Begumpur', '3125'),
(886, 'Sylhet ', 'Sylhet', 'Balaganj', 'Omarpur', '3126'),
(887, 'Sylhet ', 'Sylhet', 'Balaganj', 'Kathal Khair', '3127'),
(888, 'Sylhet ', 'Sylhet', 'Balaganj', 'Gaharpur', '3128'),
(889, 'Sylhet ', 'Sylhet', 'Balaganj', 'Natun Bazar', '3129'),
(890, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Bianibazar', '3170'),
(891, 'Sylhet ', 'Sylhet', 'Bianibazar', 'jaldup', '3171'),
(892, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Mathiura', '3172'),
(893, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Kurar bazar', '3173'),
(894, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Salia bazar', '3174'),
(895, 'Sylhet ', 'Sylhet', 'Bianibazar', 'Churkai', '3175'),
(896, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Bishwanath', '3130'),
(897, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Dashghar', '3131'),
(898, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Doulathpur', '3132'),
(899, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Deokalas', '3133'),
(900, 'Sylhet ', 'Sylhet', 'Bishwanath', 'Singer kanch', '3134'),
(901, 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj', '3116'),
(902, 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj SareKarkh', '3117'),
(903, 'Sylhet ', 'Sylhet', 'Goainhat', 'Goainhat', '3150'),
(904, 'Sylhet ', 'Sylhet', 'Goainhat', 'Jaflong', '3151'),
(905, 'Sylhet ', 'Sylhet', 'Goainhat', 'Chiknagul', '3152'),
(906, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Gopalgannj', '3160'),
(907, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dhaka Dakkhin', '3161'),
(908, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dakkhin Bhadashore', '3162'),
(909, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Ranaping', '3163'),
(910, 'Sylhet ', 'Sylhet', 'Gopalganj', 'banigram', '3164'),
(911, 'Sylhet ', 'Sylhet', 'Gopalganj', 'Chandanpur', '3165'),
(912, 'Sylhet ', 'Sylhet', 'Jaintapur', 'Jainthapur', '3156'),
(913, 'Sylhet ', 'Sylhet', 'Jakiganj', 'Jakiganj', '3190'),
(914, 'Sylhet ', 'Sylhet', 'Jakiganj', 'Ichhamati', '3191'),
(915, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Kanaighat', '3180'),
(916, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Chatulbazar', '3181'),
(917, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Manikganj', '3182'),
(918, 'Sylhet ', 'Sylhet', 'Kanaighat', 'Gachbari', '3183'),
(919, 'Sylhet ', 'Sylhet', 'Kompanyganj', 'Kompanyganj', '3140'),
(920, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhe Sadar', '3100'),
(921, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Cadet Col', '3101'),
(922, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Biman Bondar', '3102'),
(923, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Khadimnagar', '3103'),
(924, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad Cantoment', '3104'),
(925, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Silam', '3105'),
(926, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Birahimpur', '3106'),
(927, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad', '3107'),
(928, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Mogla', '3108'),
(929, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Ranga Hajiganj', '3109'),
(930, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kadamtali', '3111'),
(931, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kamalbazer', '3112'),
(932, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Lalbazar', '3113'),
(933, 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Shahajalal Science &', '3114'),
(934, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Baralekha', '3250'),
(935, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Juri', '3251'),
(936, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Dhakkhinbag', '3252'),
(937, 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Purbashahabajpur', '3253'),
(938, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Kamalganj', '3220'),
(939, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Keramatnaga', '3221'),
(940, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Patrakhola', '3222'),
(941, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Shamsher Nagar', '3223'),
(942, 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Munshibazar', '3224'),
(943, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Kulaura', '3230'),
(944, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Tillagaon', '3231'),
(945, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Langla', '3232'),
(946, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Prithimpasha', '3233'),
(947, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Kajaldhara', '3234'),
(948, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Karimpur', '3235'),
(949, 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Baramchal', '3237'),
(950, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Moulvibazar Sadar', '3200'),
(951, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Barakapan', '3201'),
(952, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Monumukh', '3202'),
(953, 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Afrozganj', '3203'),
(954, 'Sylhet ', 'Moulvibazar', 'Rajnagar', 'Rajnagar', '3240'),
(955, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Srimangal', '3210'),
(956, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Narain Chora', '3211'),
(957, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Kalighat', '3212'),
(958, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Khejurichhara', '3213'),
(959, 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Satgaon', '3214'),
(960, 'Sylhet ', 'Hobiganj', 'Azmireeganj', 'Azmireeganj', '3360'),
(961, 'Sylhet ', 'Hobiganj', 'Bahubal', 'Bahubal', '3310'),
(962, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Baniachang', '3350'),
(963, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Jatrapasha', '3351'),
(964, 'Sylhet ', 'Hobiganj', 'Baniachang', 'Kadirganj', '3352'),
(965, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chunarughat', '3320'),
(966, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chandpurbagan', '3321'),
(967, 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Narapati', '3322'),
(968, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Hobiganj Sadar', '3300'),
(969, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Shaestaganj', '3301'),
(970, 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Gopaya', '3302'),
(971, 'Sylhet ', 'Hobiganj', 'Kalauk', 'Kalauk', '3340'),
(972, 'Sylhet ', 'Hobiganj', 'Kalauk', 'Lakhai', '3341'),
(973, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Madhabpur', '3330'),
(974, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Itakhola', '3331'),
(975, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Shahajibazar', '3332'),
(976, 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Saihamnagar', '3333'),
(977, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Nabiganj', '3370'),
(978, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Goplarbazar', '3371'),
(979, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Golduba', '3372'),
(980, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Digalbak', '3373'),
(981, 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Inathganj', '3374'),
(982, 'Barisal ', 'Barishal', 'Agailzhara', 'Agailzhara', '8240'),
(983, 'Barisal ', 'Barishal', 'Agailzhara', 'Gaila', '8241'),
(984, 'Barisal ', 'Barishal', 'Agailzhara', 'Paisarhat', '8242'),
(985, 'Barisal ', 'Barishal', 'Babuganj', 'Babuganj', '8210'),
(986, 'Barisal ', 'Barishal', 'Babuganj', 'Rahamatpur', '8211'),
(987, 'Barisal ', 'Barishal', 'Babuganj', 'Chandpasha', '8212'),
(988, 'Barisal ', 'Barishal', 'Babuganj', 'Madhabpasha', '8213'),
(989, 'Barisal ', 'Barishal', 'Babuganj', 'Thakur Mallik', '8214'),
(990, 'Barisal ', 'Barishal', 'Babuganj', 'Nizamuddin College', '8215'),
(991, 'Barisal ', 'Barishal', 'Babuganj', 'Barishal Cadet', '8216'),
(992, 'Barisal ', 'Barishal', 'Barajalia', 'Barajalia', '8260'),
(993, 'Barisal ', 'Barishal', 'Barajalia', 'Osman Manjil', '8261'),
(994, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Barishal Sadar', '8200'),
(995, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Bukhainagar', '8201'),
(996, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Saheberhat', '8202'),
(997, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Sugandia', '8203'),
(998, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Patang', '8204'),
(999, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Kashipur', '8205'),
(1000, 'Barisal ', 'Barishal', 'Barishal Sadar', 'Jaguarhat', '8206'),
(1001, 'Barisal ', 'Barishal', 'Gouranadi', 'Gouranadi', '8230'),
(1002, 'Barisal ', 'Barishal', 'Gouranadi', 'Tarki Bandar', '8231'),
(1003, 'Barisal ', 'Barishal', 'Gouranadi', 'Kashemabad', '8232'),
(1004, 'Barisal ', 'Barishal', 'Gouranadi', 'Batajor', '8233'),
(1005, 'Barisal ', 'Barishal', 'Mahendiganj', 'Mahendiganj', '8270'),
(1006, 'Barisal ', 'Barishal', 'Mahendiganj', 'Laskarpur', '8271'),
(1007, 'Barisal ', 'Barishal', 'Mahendiganj', 'Ulania', '8272'),
(1008, 'Barisal ', 'Barishal', 'Mahendiganj', 'Nalgora', '8273'),
(1009, 'Barisal ', 'Barishal', 'Mahendiganj', 'Langutia', '8274'),
(1010, 'Barisal ', 'Barishal', 'Muladi', 'Muladi', '8250'),
(1011, 'Barisal ', 'Barishal', 'Muladi', 'Kazirchar', '8251'),
(1012, 'Barisal ', 'Barishal', 'Muladi', 'Charkalekhan', '8252'),
(1013, 'Barisal ', 'Barishal', 'Sahebganj', 'Sahebganj', '8280'),
(1014, 'Barisal ', 'Barishal', 'Sahebganj', 'Charamandi', '8281'),
(1015, 'Barisal ', 'Barishal', 'Sahebganj', 'Padri Shibpur', '8282'),
(1016, 'Barisal ', 'Barishal', 'Sahebganj', 'Shialguni', '8283'),
(1017, 'Barisal ', 'Barishal', 'Sahebganj', 'kalaskati', '8284'),
(1018, 'Barisal ', 'Barishal', 'Uzirpur', 'Uzirpur', '8220'),
(1019, 'Barisal ', 'Barishal', 'Uzirpur', 'Dhamura', '8221'),
(1020, 'Barisal ', 'Barishal', 'Uzirpur', 'Jugirkanda', '8222'),
(1021, 'Barisal ', 'Barishal', 'Uzirpur', 'Dakuarhat', '8223'),
(1022, 'Barisal ', 'Barishal', 'Uzirpur', 'Shikarpur', '8224'),
(1023, 'Barisal ', 'Bhola', 'Bhola Sadar', 'Bhola Sadar', '8300'),
(1024, 'Barisal ', 'Bhola', 'Bhola Sadar', 'Joynagar', '8301'),
(1025, 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Borhanuddin UPO', '8320'),
(1026, 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Mirzakalu', '8321'),
(1027, 'Barisal ', 'Bhola', 'Charfashion', 'Charfashion', '8340'),
(1028, 'Barisal ', 'Bhola', 'Charfashion', 'Dularhat', '8341'),
(1029, 'Barisal ', 'Bhola', 'Charfashion', 'Keramatganj', '8342'),
(1030, 'Barisal ', 'Bhola', 'Doulatkhan', 'Doulatkhan', '8310'),
(1031, 'Barisal ', 'Bhola', 'Doulatkhan', 'Hajipur', '8311'),
(1032, 'Barisal ', 'Bhola', 'Hajirhat', 'Hajirhat', '8360'),
(1033, 'Barisal ', 'Bhola', 'Hatshoshiganj', 'Hatshoshiganj', '8350'),
(1034, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Lalmohan UPO', '8330'),
(1035, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Daurihat', '8331'),
(1036, 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Gazaria', '8332'),
(1037, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Jhalokathi Sadar', '8400'),
(1038, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Nabagram', '8401'),
(1039, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Baukathi', '8402'),
(1040, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Gabha', '8403'),
(1041, 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Shekherhat', '8404'),
(1042, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Kathalia', '8430'),
(1043, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Amua', '8431'),
(1044, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Niamatee', '8432'),
(1045, 'Barisal ', 'Jhalokathi', 'Kathalia', 'Shoulajalia', '8433'),
(1046, 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Nalchhiti', '8420'),
(1047, 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Beerkathi', '8421'),
(1048, 'Barisal ', 'Jhalokathi', 'Rajapur', 'Rajapur', '8410'),
(1049, 'Barisal ', 'Pirojpur', 'Banaripara', 'Banaripara', '8530'),
(1050, 'Barisal ', 'Pirojpur', 'Banaripara', 'Chakhar', '8531'),
(1051, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Bhandaria', '8550'),
(1052, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Kanudashkathi', '8551'),
(1053, 'Barisal ', 'Pirojpur', 'Bhandaria', 'Dhaoa', '8552'),
(1054, 'Barisal ', 'Pirojpur', 'kaukhali', 'Kaukhali', '8510'),
(1055, 'Barisal ', 'Pirojpur', 'kaukhali', 'Keundia', '8511'),
(1056, 'Barisal ', 'Pirojpur', 'kaukhali', 'Joykul', '8512'),
(1057, 'Barisal ', 'Pirojpur', 'kaukhali', 'Jolagati', '8513'),
(1058, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Mathbaria', '8560'),
(1059, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tushkhali', '8561'),
(1060, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Halta', '8562'),
(1061, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Gulishakhali', '8563'),
(1062, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tiarkhali', '8564'),
(1063, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Betmor Natun Hat', '8565'),
(1064, 'Barisal ', 'Pirojpur', 'Mathbaria', 'Shilarganj', '8566'),
(1065, 'Barisal ', 'Pirojpur', 'Nazirpur', 'Nazirpur', '8540'),
(1066, 'Barisal ', 'Pirojpur', 'Nazirpur', 'Sriramkathi', '8541'),
(1067, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Pirojpur Sadar', '8500'),
(1068, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Hularhat', '8501'),
(1069, 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Parerhat', '8502'),
(1070, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Swarupkathi', '8520'),
(1071, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Darus Sunnat', '8521'),
(1072, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Kaurikhara', '8522'),
(1073, 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Jalabari', '8523'),
(1074, 'Barisal ', 'Patuakhali', 'Bauphal', 'Bauphal', '8620'),
(1075, 'Barisal ', 'Patuakhali', 'Bauphal', 'Bagabandar', '8621'),
(1076, 'Barisal ', 'Patuakhali', 'Bauphal', 'Birpasha', '8622'),
(1077, 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalishari', '8623'),
(1078, 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalaia', '8624'),
(1079, 'Barisal ', 'Patuakhali', 'Dashmina', 'Dashmina', '8630'),
(1080, 'Barisal ', 'Patuakhali', 'Galachipa', 'Galachipa', '8640'),
(1081, 'Barisal ', 'Patuakhali', 'Galachipa', 'Gazipur Bandar', '8641'),
(1082, 'Barisal ', 'Patuakhali', 'Khepupara', 'Khepupara', '8650'),
(1083, 'Barisal ', 'Patuakhali', 'Khepupara', 'Mahipur', '8651'),
(1084, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Patuakhali Sadar', '8600'),
(1085, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Moukaran', '8601'),
(1086, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Dumkee', '8602'),
(1087, 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Rahimabad', '8603'),
(1088, 'Barisal ', 'Patuakhali', 'Subidkhali', 'Subidkhali', '8610'),
(1089, 'Barisal ', 'Barguna', 'Amtali', 'Amtali', '8710'),
(1090, 'Barisal ', 'Barguna', 'Bamna', 'Bamna', '8730'),
(1091, 'Barisal ', 'Barguna', 'Barguna Sadar', 'Barguna Sadar', '8700'),
(1092, 'Barisal ', 'Barguna', 'Barguna Sadar', 'Nali Bandar', '8701'),
(1093, 'Barisal ', 'Barguna', 'Betagi', 'Betagi', '8740'),
(1094, 'Barisal ', 'Barguna', 'Betagi', 'Darul Ulam', '8741'),
(1095, 'Barisal ', 'Barguna', 'Patharghata', 'Patharghata', '8720'),
(1096, 'Barisal ', 'Barguna', 'Patharghata', 'Kakchira', '8721'),
(1097, 'Rajshahi ', 'Panchagarh', 'Boda', 'Boda', '5010'),
(1098, 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Chotto Dab', '5040'),
(1099, 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Mirjapur', '5041'),
(1100, 'Rajshahi ', 'Panchagarh', 'Dabiganj', 'Dabiganj', '5020'),
(1101, 'Rajshahi ', 'Panchagarh', 'Panchagra Sadar', 'Panchagar Sadar', '5000'),
(1102, 'Rajshahi ', 'Panchagarh', 'Tetulia', 'Tetulia', '5030'),
(1103, 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Baliadangi', '5140'),
(1104, 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Lahiri', '5141'),
(1105, 'Rajshahi ', 'Thakurgaon', 'Jibanpur', 'Jibanpur', '5130'),
(1106, 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', '5110'),
(1107, 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', '5470'),
(1108, 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Rani Sankail', '5120'),
(1109, 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Nekmarad', '5121'),
(1110, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Sadar', '5100'),
(1111, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Road', '5101'),
(1112, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Shibganj', '5102'),
(1113, 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Ruhia', '5103'),
(1114, 'Rajshahi ', 'Dinajpur', 'Bangla Hili', 'Bangla Hili', '5270'),
(1115, 'Rajshahi ', 'Dinajpur', 'Biral', 'Biral', '5210'),
(1116, 'Rajshahi ', 'Dinajpur', 'Birampur', 'Birampur', '5266'),
(1117, 'Rajshahi ', 'Dinajpur', 'Birganj', 'Birganj', '5220'),
(1118, 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Chrirbandar', '5240'),
(1119, 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Ranirbandar', '5241'),
(1120, 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Sadar', '5200'),
(1121, 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Rajbari', '5201'),
(1122, 'Rajshahi ', 'Dinajpur', 'Khansama', 'Khansama', '5230'),
(1123, 'Rajshahi ', 'Dinajpur', 'Khansama', 'Pakarhat', '5231'),
(1124, 'Rajshahi ', 'Dinajpur', 'Maharajganj', 'Maharajganj', '5226'),
(1125, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Nababganj', '5280'),
(1126, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Daudpur', '5281'),
(1127, 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Gopalpur', '5282'),
(1128, 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Osmanpur', '5290'),
(1129, 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Ghoraghat', '5291'),
(1130, 'Rajshahi ', 'Dinajpur', 'Parbatipur', 'Parbatipur', '5250'),
(1131, 'Rajshahi ', 'Dinajpur', 'Phulbari', 'Phulbari', '5260'),
(1132, 'Rajshahi ', 'Dinajpur', 'Setabganj', 'Setabganj', '5216'),
(1133, 'Rajshahi ', 'Nilphamari', 'Dimla', 'Dimla', '5350'),
(1134, 'Rajshahi ', 'Nilphamari', 'Dimla', 'Ghaga Kharibari', '5351'),
(1135, 'Rajshahi ', 'Nilphamari', 'Domar', 'Domar', '5340'),
(1136, 'Rajshahi ', 'Nilphamari', 'Domar', 'Chilahati', '5341'),
(1137, 'Rajshahi ', 'Nilphamari', 'Jaldhaka', 'Jaldhaka', '5330'),
(1138, 'Rajshahi ', 'Nilphamari', 'Kishoriganj', 'Kishoriganj', '5320'),
(1139, 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sadar', '5300'),
(1140, 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sugar Mil', '5301'),
(1141, 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur', '5310'),
(1142, 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur Upashahar', '5311'),
(1143, 'Rajshahi ', 'Rangpur', 'Badarganj', 'Badarganj', '5430'),
(1144, 'Rajshahi ', 'Rangpur', 'Badarganj', 'Shyampur', '5431'),
(1145, 'Rajshahi ', 'Rangpur', 'Gangachara', 'Gangachara', '5410'),
(1146, 'Rajshahi ', 'Rangpur', 'Kaunia', 'Kaunia', '5440'),
(1147, 'Rajshahi ', 'Rangpur', 'Kaunia', 'Haragachh', '5441'),
(1148, 'Rajshahi ', 'Rangpur', 'Mithapukur', 'Mithapukur', '5460'),
(1149, 'Rajshahi ', 'Rangpur', 'Pirgachha', 'Pirgachha', '5450'),
(1150, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Sadar', '5400'),
(1151, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Upa-Shahar', '5401'),
(1152, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Alamnagar', '5402'),
(1153, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Mahiganj', '5403'),
(1154, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Cadet Colleg', '5404'),
(1155, 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Carmiecal Col', '5405'),
(1156, 'Rajshahi ', 'Rangpur', 'Taraganj', 'Taraganj', '5420'),
(1157, 'Rajshahi ', 'Lalmonirhat', 'Aditmari', 'Aditmari', '5510'),
(1158, 'Rajshahi ', 'Lalmonirhat', 'Hatibandha', 'Hatibandha', '5530'),
(1159, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Lalmonirhat Sadar', '5500'),
(1160, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Moghalhat', '5501'),
(1161, 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Kulaghat SO', '5502'),
(1162, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Patgram', '5540'),
(1163, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Baura', '5541'),
(1164, 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Burimari', '5542'),
(1165, 'Rajshahi ', 'Lalmonirhat', 'Tushbhandar', 'Tushbhandar', '5520'),
(1166, 'Rajshahi ', 'Kurigram', 'Bhurungamari', 'Bhurungamari', '5670'),
(1167, 'Rajshahi ', 'Kurigram', 'Chilmari', 'Chilmari', '5630'),
(1168, 'Rajshahi ', 'Kurigram', 'Chilmari', 'Jorgachh', '5631'),
(1169, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Kurigram Sadar', '5600'),
(1170, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Pandul', '5601'),
(1171, 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Phulbari', '5680'),
(1172, 'Rajshahi ', 'Kurigram', 'Nageshwar', 'Nageshwar', '5660'),
(1173, 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Rajarhat', '5610'),
(1174, 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Nazimkhan', '5611'),
(1175, 'Rajshahi ', 'Kurigram', 'Rajibpur', 'Rajibpur', '5650'),
(1176, 'Rajshahi ', 'Kurigram', 'Roumari', 'Roumari', '5640'),
(1177, 'Rajshahi ', 'Kurigram', 'Ulipur', 'Ulipur', '5620'),
(1178, 'Rajshahi ', 'Kurigram', 'Ulipur', 'Bazarhat', '5621'),
(1179, 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'Bonarpara', '5750'),
(1180, 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'saghata', '5751'),
(1181, 'Rajshahi ', 'Gaibandha', 'Gaibandha Sadar', 'Gaibandha Sadar', '5700'),
(1182, 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Gobindhaganj', '5740'),
(1183, 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Mahimaganj', '5741'),
(1184, 'Rajshahi ', 'Gaibandha', 'Palashbari', 'Palashbari', '5730'),
(1185, 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Phulchhari', '5760'),
(1186, 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Bharatkhali', '5761'),
(1187, 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Saadullapur', '5710'),
(1188, 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Naldanga', '5711'),
(1189, 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Sundarganj', '5720'),
(1190, 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Bamandanga', '5721'),
(1191, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Adamdighi', '5890'),
(1192, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Santahar', '5891'),
(1193, 'Rajshahi ', 'Bogra', 'Alamdighi', 'Nasharatpur', '5892'),
(1194, 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Sadar', '5800'),
(1195, 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Canttonment', '5801'),
(1196, 'Rajshahi ', 'Bogra', 'Dhunat', 'Dhunat', '5850'),
(1197, 'Rajshahi ', 'Bogra', 'Dhunat', 'Gosaibari', '5851'),
(1198, 'Rajshahi ', 'Bogra', 'Dupchachia', 'Dupchachia', '5880'),
(1199, 'Rajshahi ', 'Bogra', 'Dupchachia', 'Talora', '5881'),
(1200, 'Rajshahi ', 'Bogra', 'Gabtoli', 'Gabtoli', '5820'),
(1201, 'Rajshahi ', 'Bogra', 'Gabtoli', 'Sukhanpukur', '5821'),
(1202, 'Rajshahi ', 'Bogra', 'Kahalu', 'Kahalu', '5870'),
(1203, 'Rajshahi ', 'Bogra', 'Nandigram', 'Nandigram', '5860'),
(1204, 'Rajshahi ', 'Bogra', 'Sariakandi', 'Sariakandi', '5830'),
(1205, 'Rajshahi ', 'Bogra', 'Sariakandi', 'Chandan Baisha', '5831'),
(1206, 'Rajshahi ', 'Bogra', 'Sherpur', 'Sherpur', '5840'),
(1207, 'Rajshahi ', 'Bogra', 'Sherpur', 'Chandaikona', '5841'),
(1208, 'Rajshahi ', 'Bogra', 'Sherpur', 'Palli Unnyan Accadem', '5842'),
(1209, 'Rajshahi ', 'Bogra', 'Shibganj', 'Shibganj', '5810'),
(1210, 'Rajshahi ', 'Bogra', 'Sonatola', 'Sonatola', '5826'),
(1211, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'Akklepur', '5940'),
(1212, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'jamalganj', '5941'),
(1213, 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'Tilakpur', '5942'),
(1214, 'Rajshahi ', 'Joypurhat', 'Joypurhat Sadar', 'Joypurhat Sadar', '5900'),
(1215, 'Rajshahi ', 'Joypurhat', 'kalai', 'kalai', '5930'),
(1216, 'Rajshahi ', 'Joypurhat', 'Khetlal', 'Khetlal', '5920'),
(1217, 'Rajshahi ', 'Joypurhat', 'panchbibi', 'Panchbibi', '5910'),
(1218, 'Rajshahi ', 'Rajshahi', 'Bagha', 'Bagha', '6280'),
(1219, 'Rajshahi ', 'Rajshahi', 'Bagha', 'Arani', '6281'),
(1220, 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Bhabaniganj', '6250'),
(1221, 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Taharpur', '6251'),
(1222, 'Rajshahi ', 'Rajshahi', 'Charghat', 'Charghat', '6270'),
(1223, 'Rajshahi ', 'Rajshahi', 'Charghat', 'Sarda', '6271'),
(1224, 'Rajshahi ', 'Rajshahi', 'Durgapur', 'Durgapur', '6240'),
(1225, 'Rajshahi ', 'Rajshahi', 'Godagari', 'Godagari', '6290'),
(1226, 'Rajshahi ', 'Rajshahi', 'Godagari', 'Premtoli', '6291'),
(1227, 'Rajshahi ', 'Rajshahi', 'Khod Mohanpur', 'Khodmohanpur', '6220'),
(1228, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Lalitganj', '6210'),
(1229, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Rajshahi Sugar Mills', '6211'),
(1230, 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Shyampur', '6212'),
(1231, 'Rajshahi ', 'Rajshahi', 'Putia', 'Putia', '6260'),
(1232, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Sadar', '6000'),
(1233, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Ghuramara', '6100'),
(1234, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Court', '6201'),
(1235, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Canttonment', '6202'),
(1236, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Sapura', '6203'),
(1237, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Kazla', '6204'),
(1238, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi University', '6205'),
(1239, 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Binodpur Bazar', '6206'),
(1240, 'Rajshahi ', 'Rajshahi', 'Tanor', 'Tanor', '6230'),
(1241, 'Rajshahi ', 'Chapinawabganj', 'Bholahat', 'Bholahat', '6330'),
(1242, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Chapinawbganj Sadar', '6300'),
(1243, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Rajarampur', '6301'),
(1244, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Ramchandrapur', '6302'),
(1245, 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Amnura', '6303'),
(1246, 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Nachol', '6310'),
(1247, 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Mandumala', '6311'),
(1248, 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Rohanpur', '6320'),
(1249, 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Gomashtapur', '6321'),
(1250, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Shibganj U.P.O', '6340'),
(1251, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Kansart', '6341'),
(1252, 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Manaksha', '6342'),
(1253, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Gopalpur U.P.O', '6420'),
(1254, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Lalpur S.O', '6421'),
(1255, 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Abdulpur', '6422'),
(1256, 'Rajshahi ', 'Natore', 'Harua', 'Harua', '6430'),
(1257, 'Rajshahi ', 'Natore', 'Harua', 'Dayarampur', '6431'),
(1258, 'Rajshahi ', 'Natore', 'Harua', 'Baraigram', '6432'),
(1259, 'Rajshahi ', 'Natore', 'Hatgurudaspur', 'Hatgurudaspur', '6440'),
(1260, 'Rajshahi ', 'Natore', 'Laxman', 'Laxman', '6410'),
(1261, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Natore Sadar', '6400'),
(1262, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Digapatia', '6401'),
(1263, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Baiddyabal Gharia', '6402'),
(1264, 'Rajshahi ', 'Natore', 'Natore Sadar', 'Madhnagar', '6403'),
(1265, 'Rajshahi ', 'Natore', 'Singra', 'Singra', '6450'),
(1266, 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Ahsanganj', '6596'),
(1267, 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Bandai', '6597'),
(1268, 'Rajshahi ', 'Naogaon', 'Badalgachhi', 'Badalgachhi', '6570'),
(1269, 'Rajshahi ', 'Naogaon', 'Dhamuirhat', 'Dhamuirhat', '6580'),
(1270, 'Rajshahi ', 'Naogaon', 'Mahadebpur', 'Mahadebpur', '6530'),
(1271, 'Rajshahi ', 'Naogaon', 'Naogaon Sadar', 'Naogaon Sadar', '6500'),
(1272, 'Rajshahi ', 'Naogaon', 'Niamatpur', 'Niamatpur', '6520'),
(1273, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Nitpur', '6550'),
(1274, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Porsa', '6551'),
(1275, 'Rajshahi ', 'Naogaon', 'Nitpur', 'Panguria', '6552'),
(1276, 'Rajshahi ', 'Naogaon', 'Patnitala', 'Patnitala', '6540'),
(1277, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Prasadpur', '6510'),
(1278, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Manda', '6511'),
(1279, 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Balihar', '6512'),
(1280, 'Rajshahi ', 'Naogaon', 'Raninagar', 'Raninagar', '6590'),
(1281, 'Rajshahi ', 'Naogaon', 'Raninagar', 'Kashimpur', '6591'),
(1282, 'Rajshahi ', 'Naogaon', 'Sapahar', 'Sapahar', '6560'),
(1283, 'Rajshahi ', 'Naogaon', 'Sapahar', 'Moduhil', '6561'),
(1284, 'Rajshahi ', 'Pabna', 'Banwarinagar', 'Banwarinagar', '6650'),
(1285, 'Rajshahi ', 'Pabna', 'Bera', 'Bera', '6680'),
(1286, 'Rajshahi ', 'Pabna', 'Bera', 'Nakalia', '6681'),
(1287, 'Rajshahi ', 'Pabna', 'Bera', 'Kashinathpur', '6682'),
(1288, 'Rajshahi ', 'Pabna', 'Bera', 'Puran Bharenga', '6683'),
(1289, 'Rajshahi ', 'Pabna', 'Bhangura', 'Bhangura', '6640'),
(1290, 'Rajshahi ', 'Pabna', 'Chatmohar', 'Chatmohar', '6630'),
(1291, 'Rajshahi ', 'Pabna', 'Debottar', 'Debottar', '6610'),
(1292, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Ishwardi', '6620'),
(1293, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Dhapari', '6621'),
(1294, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Pakshi', '6622'),
(1295, 'Rajshahi ', 'Pabna', 'Ishwardi', 'Rajapur', '6623'),
(1296, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Pabna Sadar', '6600'),
(1297, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Kaliko Cotton Mills', '6601'),
(1298, 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Hamayetpur', '6602'),
(1299, 'Rajshahi ', 'Pabna', 'Sathia', 'Sathia', '6670'),
(1300, 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sujanagar', '6660'),
(1301, 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sagarkandi', '6661'),
(1302, 'Rajshahi ', 'Sirajganj', 'Baiddya Jam Toil', 'Baiddya Jam Toil', '6730'),
(1303, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Belkuchi', '6740'),
(1304, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sohagpur', '6741'),
(1305, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Rajapur', '6742'),
(1306, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Enayetpur', '6751'),
(1307, 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sthal', '6752'),
(1308, 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Dhangora', '6720'),
(1309, 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Malonga', '6721'),
(1310, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Kazipur', '6710'),
(1311, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Shuvgachha', '6711'),
(1312, 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Gandail', '6712'),
(1313, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Shahjadpur', '6770'),
(1314, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Porjana', '6771'),
(1315, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Jamirta', '6772'),
(1316, 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Kaijuri', '6773'),
(1317, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Sirajganj Sadar', '6700'),
(1318, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Raipur', '6701'),
(1319, 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Rashidabad', '6702'),
(1320, 'Rajshahi ', 'Sirajganj', 'Tarash', 'Tarash', '6780'),
(1321, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara', '6760'),
(1322, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara R.S', '6761'),
(1323, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Lahiri Mohanpur', '6762'),
(1324, 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Salap', '6763');

-- --------------------------------------------------------

--
-- Table structure for table `TABLE 4`
--

CREATE TABLE `TABLE 4` (
  `COL 1` varchar(6) DEFAULT NULL,
  `COL 2` varchar(11) DEFAULT NULL,
  `COL 3` varchar(14) DEFAULT NULL,
  `COL 4` varchar(20) DEFAULT NULL,
  `COL 5` varchar(23) DEFAULT NULL,
  `COL 6` varchar(5) DEFAULT NULL,
  `COL 7` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `TABLE 4`
--

INSERT INTO `TABLE 4` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`, `COL 7`) VALUES
('1', 'Dhaka', 'Dhaka', 'Demra', 'Demra', '1360', ''),
('\r\n2', 'Dhaka', 'Dhaka', 'Demra', 'Sarulia', '1361', ''),
('\r\n3', 'Dhaka', 'Dhaka', 'Demra', 'Matuail', '1362', ''),
('\r\n4', 'Dhaka', 'Dhaka', 'Dhaka GPO', 'Dhaka GPO', '1000', ''),
('\r\n5', 'Dhaka', 'Dhaka', 'Dhaka Main PO', 'Dhaka Main PO', '1100', ''),
('\r\n6', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Wari TSO', '1203', ''),
('\r\n7', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gendaria TSO', '1204', ''),
('\r\n8', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'New Market TSO', '1205', ''),
('\r\n9', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhaka CantonmentTSO', '1206', ''),
('\r\n10', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mohammadpur Housing', '1207', ''),
('\r\n11', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhaka Politechnic', '1208', ''),
('\r\n12', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Jigatala TSO', '1209', ''),
('\r\n13', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Posta TSO', '1211', ''),
('\r\n14', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Gulshan Model Town', '1212', ''),
('\r\n15', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Banani TSO', '1213', ''),
('\r\n16', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Basabo TSO', '1214', ''),
('\r\n17', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Tejgaon TSO', '1215', ''),
('\r\n18', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Shantinagr TSO', '1217', ''),
('\r\n19', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Mirpur TSO', '1218', ''),
('\r\n20', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilgaonTSO', '1219', ''),
('\r\n21', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'BangabhabanTSO', '1222', ''),
('\r\n22', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'DilkushaTSO', '1223', ''),
('\r\n23', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Sangsad BhabanTSO', '1225', ''),
('\r\n24', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'KhilkhetTSO', '1229', ''),
('\r\n25', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Uttara Model TwonTSO', '1231', ''),
('\r\n26', 'Dhaka', 'Dhaka', 'Dhaka Sadar', 'Dhania TSO', '1232', ''),
('\r\n27', 'Dhaka', 'Dhaka', 'Dhamrai', 'Dhamrai', '1350', ''),
('\r\n28', 'Dhaka', 'Dhaka', 'Dhamrai', 'Kamalpur', '1351', ''),
('\r\n29', 'Dhaka', 'Dhaka', 'Joypara', 'Joypara', '1330', ''),
('\r\n30', 'Dhaka', 'Dhaka', 'Joypara', 'Palamganj', '1331', ''),
('\r\n31', 'Dhaka', 'Dhaka', 'Joypara', 'Narisha', '1332', ''),
('\r\n32', 'Dhaka', 'Dhaka', 'Keraniganj', 'Keraniganj', '1310', ''),
('\r\n33', 'Dhaka', 'Dhaka', 'Keraniganj', 'Dhaka Jute Mills', '1311', ''),
('\r\n34', 'Dhaka', 'Dhaka', 'Keraniganj', 'Ati', '1312', ''),
('\r\n35', 'Dhaka', 'Dhaka', 'Keraniganj', 'Kalatia', '1313', ''),
('\r\n36', 'Dhaka', 'Dhaka', 'Nawabganj', 'Nawabganj', '1320', ''),
('\r\n37', 'Dhaka', 'Dhaka', 'Nawabganj', 'Hasnabad', '1321', ''),
('\r\n38', 'Dhaka', 'Dhaka', 'Nawabganj', 'Daudpur', '1322', ''),
('\r\n39', 'Dhaka', 'Dhaka', 'Nawabganj', 'Agla', '1323', ''),
('\r\n40', 'Dhaka', 'Dhaka', 'Nawabganj', 'Khalpar', '1324', ''),
('\r\n41', 'Dhaka', 'Dhaka', 'Nawabganj', 'Churain', '1325', ''),
('\r\n42', 'Dhaka', 'Dhaka', 'Savar', 'Savar', '1340', ''),
('\r\n43', 'Dhaka', 'Dhaka', 'Savar', 'Dairy Farm', '1341', ''),
('\r\n44', 'Dhaka', 'Dhaka', 'Savar', 'Jahangirnagar Univer', '1342', ''),
('\r\n45', 'Dhaka', 'Dhaka', 'Savar', 'Saver P.A.T.C', '1343', ''),
('\r\n46', 'Dhaka', 'Dhaka', 'Savar', 'Savar Canttonment', '1344', ''),
('\r\n47', 'Dhaka', 'Dhaka', 'Savar', 'Shimulia', '1345', ''),
('\r\n48', 'Dhaka', 'Dhaka', 'Savar', 'Kashem Cotton Mills', '1346', ''),
('\r\n49', 'Dhaka', 'Dhaka', 'Savar', 'Rajphulbaria', '1347', ''),
('\r\n50', 'Dhaka', 'Dhaka', 'Savar', 'Amin Bazar', '1348', ''),
('\r\n51', 'Dhaka', 'Dhaka', 'Savar', 'EPZ', '1349', ''),
('\r\n52', 'Dhaka', 'Mymensingh', 'Bhaluka', 'Bhaluka', '2240', ''),
('\r\n53', 'Dhaka', 'Mymensingh', 'Fulbaria', 'Fulbaria', '2216', ''),
('\r\n54', 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Gaforgaon', '2230', ''),
('\r\n55', 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Shibganj', '2231', ''),
('\r\n56', 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Usti', '2232', ''),
('\r\n57', 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Kandipara', '2233', ''),
('\r\n58', 'Dhaka', 'Mymensingh', 'Gaforgaon', 'Duttarbazar', '2234', ''),
('\r\n59', 'Dhaka', 'Mymensingh', 'Gouripur', 'Gouripur', '2270', ''),
('\r\n60', 'Dhaka', 'Mymensingh', 'Gouripur', 'Ramgopalpur', '2271', ''),
('\r\n61', 'Dhaka', 'Mymensingh', 'Haluaghat', 'Haluaghat', '2260', ''),
('\r\n62', 'Dhaka', 'Mymensingh', 'Haluaghat', 'Dhara', '2261', ''),
('\r\n63', 'Dhaka', 'Mymensingh', 'Haluaghat', 'Munshirhat', '2262', ''),
('\r\n64', 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Isshwargonj', '2280', ''),
('\r\n65', 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Sohagi', '2281', ''),
('\r\n66', 'Dhaka', 'Mymensingh', 'Isshwargonj', 'Atharabari', '2282', ''),
('\r\n67', 'Dhaka', 'Mymensingh', 'Muktagachha', 'Muktagachha', '2210', ''),
('\r\n68', 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Mymensingh Sadar', '2200', ''),
('\r\n69', 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Kawatkhali', '2201', ''),
('\r\n70', 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Agriculture Universi', '2202', ''),
('\r\n71', 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Shombhuganj', '2203', ''),
('\r\n72', 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Biddyaganj', '2204', ''),
('\r\n73', 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 'Pearpur', '2205', ''),
('\r\n74', 'Dhaka', 'Mymensingh', 'Nandail', 'Nandail', '2290', ''),
('\r\n75', 'Dhaka', 'Mymensingh', 'Nandail', 'Gangail', '2291', ''),
('\r\n76', 'Dhaka', 'Mymensingh', 'Phulpur', 'Phulpur', '2250', ''),
('\r\n77', 'Dhaka', 'Mymensingh', 'Phulpur', 'Beltia', '2251', ''),
('\r\n78', 'Dhaka', 'Mymensingh', 'Phulpur', 'Tarakanda', '2252', ''),
('\r\n79', 'Dhaka', 'Mymensingh', 'Trishal', 'Trishal', '2220', ''),
('\r\n80', 'Dhaka', 'Mymensingh', 'Trishal', 'Ahmadbad', '2221', ''),
('\r\n81', 'Dhaka', 'Mymensingh', 'Trishal', 'Ram Amritaganj', '2222', ''),
('\r\n82', 'Dhaka', 'Mymensingh', 'Trishal', 'Dhala', '2223', ''),
('\r\n83', 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Bajitpur', '2336', ''),
('\r\n84', 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Sararchar', '2337', ''),
('\r\n85', 'Dhaka', 'Kishoreganj', 'Bajitpur', 'Laksmipur', '2338', ''),
('\r\n86', 'Dhaka', 'Kishoreganj', 'Bhairob', 'Bhairab', '2350', ''),
('\r\n87', 'Dhaka', 'Kishoreganj', 'Hossenpur', 'Hossenpur', '2320', ''),
('\r\n88', 'Dhaka', 'Kishoreganj', 'Itna', 'Itna', '2390', ''),
('\r\n89', 'Dhaka', 'Kishoreganj', 'Karimganj', 'Karimganj', '2310', ''),
('\r\n90', 'Dhaka', 'Kishoreganj', 'Katiadi', 'Katiadi', '2330', ''),
('\r\n91', 'Dhaka', 'Kishoreganj', 'Katiadi', 'Gochhihata', '2331', ''),
('\r\n92', 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj Sadar', '2300', ''),
('\r\n93', 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Kishoreganj S.Mills', '2301', ''),
('\r\n94', 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Maizhati', '2302', ''),
('\r\n95', 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 'Nilganj', '2303', ''),
('\r\n96', 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Kuliarchar', '2340', ''),
('\r\n97', 'Dhaka', 'Kishoreganj', 'Kuliarchar', 'Chhoysuti', '2341', ''),
('\r\n98', 'Dhaka', 'Kishoreganj', 'Mithamoin', 'MIthamoin', '2370', ''),
('\r\n99', 'Dhaka', 'Kishoreganj', 'Mithamoin', 'Abdullahpur', '2371', ''),
('\r\n100', 'Dhaka', 'Kishoreganj', 'Nikli', 'Nikli', '2360', ''),
('\r\n101', 'Dhaka', 'Kishoreganj', 'Ostagram', 'Ostagram', '2380', ''),
('\r\n102', 'Dhaka', 'Kishoreganj', 'Pakundia', 'Pakundia', '2326', ''),
('\r\n103', 'Dhaka', 'Kishoreganj', 'Tarial', 'Tarial', '2316', ''),
('\r\n104', 'Dhaka', 'Netrakona', 'Susung Durgapur', 'IBH WAs Here', '$mart', ''),
('\r\n105', 'Dhaka', 'Netrakona', 'Susung Durgapur', 'Susnng Durgapur', '2420', ''),
('\r\n106', 'Dhaka', 'Netrakona', 'Atpara', 'Atpara', '2470', ''),
('\r\n107', 'Dhaka', 'Netrakona', 'Barhatta', 'Barhatta', '2440', ''),
('\r\n108', 'Dhaka', 'Netrakona', 'Dharmapasha', 'Dharampasha', '2450', ''),
('\r\n109', 'Dhaka', 'Netrakona', 'Dhobaura', 'Dhobaura', '2416', ''),
('\r\n110', 'Dhaka', 'Netrakona', 'Dhobaura', 'Sakoai', '2417', ''),
('\r\n111', 'Dhaka', 'Netrakona', 'Kalmakanda', 'Kalmakanda', '2430', ''),
('\r\n112', 'Dhaka', 'Netrakona', 'Kendua', 'Kendua', '2480', ''),
('\r\n113', 'Dhaka', 'Netrakona', 'Khaliajuri', 'Khaliajhri', '2460', ''),
('\r\n114', 'Dhaka', 'Netrakona', 'Khaliajuri', 'Shaldigha', '2462', ''),
('\r\n115', 'Dhaka', 'Netrakona', 'Madan', 'Madan', '2490', ''),
('\r\n116', 'Dhaka', 'Netrakona', 'Moddhynagar', 'Moddoynagar', '2456', ''),
('\r\n117', 'Dhaka', 'Netrakona', 'Mohanganj', 'Mohanganj', '2446', ''),
('\r\n118', 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Netrakona Sadar', '2400', ''),
('\r\n119', 'Dhaka', 'Netrakona', 'Netrakona Sadar', 'Baikherhati', '2401', ''),
('\r\n120', 'Dhaka', 'Netrakona', 'Purbadhola', 'Purbadhola', '2410', ''),
('\r\n121', 'Dhaka', 'Netrakona', 'Purbadhola', 'Shamgonj', '2411', ''),
('\r\n122', 'Dhaka', 'Netrakona', 'Purbadhola', 'Jaria Jhanjhail', '2412', ''),
('\r\n123', 'Dhaka', 'Narayanganj', 'Araihazar', 'Araihazar', '1450', ''),
('\r\n124', 'Dhaka', 'Narayanganj', 'Araihazar', 'Gopaldi', '1451', ''),
('\r\n125', 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Baidder Bazar', '1440', ''),
('\r\n126', 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Bara Nagar', '1441', ''),
('\r\n127', 'Dhaka', 'Narayanganj', 'Baidder Bazar', 'Barodi', '1442', ''),
('\r\n128', 'Dhaka', 'Narayanganj', 'Bandar', 'Bandar', '1410', ''),
('\r\n129', 'Dhaka', 'Narayanganj', 'Bandar', 'D.C Mills', '1411', ''),
('\r\n130', 'Dhaka', 'Narayanganj', 'Bandar', 'Nabiganj', '1412', ''),
('\r\n131', 'Dhaka', 'Narayanganj', 'Bandar', 'BIDS', '1413', ''),
('\r\n132', 'Dhaka', 'Narayanganj', 'Bandar', 'Madanganj', '1414', ''),
('\r\n133', 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatullah', '1420', ''),
('\r\n134', 'Dhaka', 'Narayanganj', 'Fatullah', 'Fatulla Bazar', '1421', ''),
('\r\n135', 'Dhaka', 'Narayanganj', 'Narayanganj Sadar', 'Narayanganj Sadar', '1400', ''),
('\r\n136', 'Dhaka', 'Narayanganj', 'Rupganj', 'Rupganj', '1460', ''),
('\r\n137', 'Dhaka', 'Narayanganj', 'Rupganj', 'Kanchan', '1461', ''),
('\r\n138', 'Dhaka', 'Narayanganj', 'Rupganj', 'Bhulta', '1462', ''),
('\r\n139', 'Dhaka', 'Narayanganj', 'Rupganj', 'Nagri', '1463', ''),
('\r\n140', 'Dhaka', 'Narayanganj', 'Rupganj', 'Murapara', '1464', ''),
('\r\n141', 'Dhaka', 'Narayanganj', 'Siddirganj', 'Siddirganj', '1430', ''),
('\r\n142', 'Dhaka', 'Narayanganj', 'Siddirganj', 'Adamjeenagar', '1431', ''),
('\r\n143', 'Dhaka', 'Narayanganj', 'Siddirganj', 'LN Mills', '1432', ''),
('\r\n144', 'Dhaka', 'Munshiganj', 'Gajaria', 'Gajaria', '1510', ''),
('\r\n145', 'Dhaka', 'Munshiganj', 'Gajaria', 'Hossendi', '1511', ''),
('\r\n146', 'Dhaka', 'Munshiganj', 'Gajaria', 'Rasulpur', '1512', ''),
('\r\n147', 'Dhaka', 'Munshiganj', 'Lohajong', 'Haridia', '1333', ''),
('\r\n148', 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', '1334', ''),
('\r\n149', 'Dhaka', 'Munshiganj', 'Lohajong', 'Madini Mandal', '1335', ''),
('\r\n150', 'Dhaka', 'Munshiganj', 'Lohajong', 'Lohajang', '1530', ''),
('\r\n151', 'Dhaka', 'Munshiganj', 'Lohajong', 'Korhati', '1531', ''),
('\r\n152', 'Dhaka', 'Munshiganj', 'Lohajong', 'Haldia SO', '1532', ''),
('\r\n153', 'Dhaka', 'Munshiganj', 'Lohajong', 'Haridia DESO', '1533', ''),
('\r\n154', 'Dhaka', 'Munshiganj', 'Lohajong', 'Gouragonj', '1534', ''),
('\r\n155', 'Dhaka', 'Munshiganj', 'Lohajong', 'Medini Mandal EDSO', '1535', ''),
('\r\n156', 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Munshiganj Sadar', '1500', ''),
('\r\n157', 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Rikabibazar', '1501', ''),
('\r\n158', 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Mirkadim', '1502', ''),
('\r\n159', 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 'Kathakhali', '1503', ''),
('\r\n160', 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Sirajdikhan', '1540', ''),
('\r\n161', 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Kola', '1541', ''),
('\r\n162', 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Ichapur', '1542', ''),
('\r\n163', 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Malkha Nagar', '1543', ''),
('\r\n164', 'Dhaka', 'Munshiganj', 'Sirajdikhan', 'Shekher Nagar', '1544', ''),
('\r\n165', 'Dhaka', 'Munshiganj', 'Srinagar', 'Srinagar', '1550', ''),
('\r\n166', 'Dhaka', 'Munshiganj', 'Srinagar', 'Barikhal', '1551', ''),
('\r\n167', 'Dhaka', 'Munshiganj', 'Srinagar', 'Mazpara', '1552', ''),
('\r\n168', 'Dhaka', 'Munshiganj', 'Srinagar', 'Hashara', '1553', ''),
('\r\n169', 'Dhaka', 'Munshiganj', 'Srinagar', 'Kolapara', '1554', ''),
('\r\n170', 'Dhaka', 'Munshiganj', 'Srinagar', 'Kumarbhog', '1555', ''),
('\r\n171', 'Dhaka', 'Munshiganj', 'Srinagar', 'Vaggyakul SO', '1556', ''),
('\r\n172', 'Dhaka', 'Munshiganj', 'Srinagar', 'Baghra', '1557', ''),
('\r\n173', 'Dhaka', 'Munshiganj', 'Srinagar', 'Bhaggyakul', '1558', ''),
('\r\n174', 'Dhaka', 'Munshiganj', 'Tangibari', 'Tangibari', '1520', ''),
('\r\n175', 'Dhaka', 'Munshiganj', 'Tangibari', 'Betkahat', '1521', ''),
('\r\n176', 'Dhaka', 'Munshiganj', 'Tangibari', 'Baligao', '1522', ''),
('\r\n177', 'Dhaka', 'Munshiganj', 'Tangibari', 'Bajrajugini', '1523', ''),
('\r\n178', 'Dhaka', 'Munshiganj', 'Tangibari', 'Hasail', '1524', ''),
('\r\n179', 'Dhaka', 'Munshiganj', 'Tangibari', 'Dighirpar', '1525', ''),
('\r\n180', 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura EDSO', '1526', ''),
('\r\n181', 'Dhaka', 'Munshiganj', 'Tangibari', 'Pura', '1527', ''),
('\r\n182', 'Dhaka', 'Narshingdi', 'Belabo', 'Belabo', '1640', ''),
('\r\n183', 'Dhaka', 'Narshingdi', 'Monohordi', 'Monohordi', '1650', ''),
('\r\n184', 'Dhaka', 'Narshingdi', 'Monohordi', 'Hatirdia', '1651', ''),
('\r\n185', 'Dhaka', 'Narshingdi', 'Monohordi', 'Katabaria', '1652', ''),
('\r\n186', 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi Sadar', '1600', ''),
('\r\n187', 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'UMC Jute Mills', '1601', ''),
('\r\n188', 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Narshingdi College', '1602', ''),
('\r\n189', 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Panchdona', '1603', ''),
('\r\n190', 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Madhabdi', '1604', ''),
('\r\n191', 'Dhaka', 'Narshingdi', 'Narshingdi Sadar', 'Karimpur', '1605', ''),
('\r\n192', 'Dhaka', 'Narshingdi', 'Palash', 'Palash', '1610', ''),
('\r\n193', 'Dhaka', 'Narshingdi', 'Palash', 'Ghorashal Urea Facto', '1611', ''),
('\r\n194', 'Dhaka', 'Narshingdi', 'Palash', 'Char Sindhur', '1612', ''),
('\r\n195', 'Dhaka', 'Narshingdi', 'Palash', 'Ghorashal', '1613', ''),
('\r\n196', 'Dhaka', 'Narshingdi', 'Raypura', 'Raypura', '1630', ''),
('\r\n197', 'Dhaka', 'Narshingdi', 'Raypura', 'Bazar Hasnabad', '1631', ''),
('\r\n198', 'Dhaka', 'Narshingdi', 'Raypura', 'Radhaganj bazar', '1632', ''),
('\r\n199', 'Dhaka', 'Narshingdi', 'Shibpur', 'Shibpur', '1620', ''),
('\r\n200', 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Gazipur Sadar', '1700', ''),
('\r\n201', 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'B.R.R', '1701', ''),
('\r\n202', 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'Chandna', '1702', ''),
('\r\n203', 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'B.O.F', '1703', ''),
('\r\n204', 'Dhaka', 'Gazipur', 'Gazipur Sadar', 'National University', '1704', ''),
('\r\n205', 'Dhaka', 'Gazipur', 'Kaliakaar', 'Kaliakaar', '1750', ''),
('\r\n206', 'Dhaka', 'Gazipur', 'Kaliakaar', 'Safipur', '1751', ''),
('\r\n207', 'Dhaka', 'Gazipur', 'Kaliganj', 'Kaliganj', '1720', ''),
('\r\n208', 'Dhaka', 'Gazipur', 'Kaliganj', 'Pubail', '1721', ''),
('\r\n209', 'Dhaka', 'Gazipur', 'Kaliganj', 'Santanpara', '1722', ''),
('\r\n210', 'Dhaka', 'Gazipur', 'Kaliganj', 'Vaoal Jamalpur', '1723', ''),
('\r\n211', 'Dhaka', 'Gazipur', 'Kapashia', 'kapashia', '1730', ''),
('\r\n212', 'Dhaka', 'Gazipur', 'Monnunagar', 'Monnunagar', '1710', ''),
('\r\n213', 'Dhaka', 'Gazipur', 'Monnunagar', 'Nishat Nagar', '1711', ''),
('\r\n214', 'Dhaka', 'Gazipur', 'Monnunagar', 'Ershad Nagar', '1712', ''),
('\r\n215', 'Dhaka', 'Gazipur', 'Sreepur', 'Sreepur', '1740', ''),
('\r\n216', 'Dhaka', 'Gazipur', 'Sreepur', 'Barmi', '1743', ''),
('\r\n217', 'Dhaka', 'Gazipur', 'Sreepur', 'Satkhamair', '1744', ''),
('\r\n218', 'Dhaka', 'Gazipur', 'Sreepur', 'Kawraid', '1745', ''),
('\r\n219', 'Dhaka', 'Gazipur', 'Sreepur', 'Bashamur', '1747', ''),
('\r\n220', 'Dhaka', 'Gazipur', 'Sreepur', 'Boubi', '1748', ''),
('\r\n221', 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur', '1741', ''),
('\r\n222', 'Dhaka', 'Gazipur', 'Sripur', 'Rajendrapur Canttome', '1742', ''),
('\r\n223', 'Dhaka', 'Rajbari', 'Baliakandi', 'Baliakandi', '7730', ''),
('\r\n224', 'Dhaka', 'Rajbari', 'Baliakandi', 'Nalia', '7731', ''),
('\r\n225', 'Dhaka', 'Rajbari', 'Pangsha', 'Pangsha', '7720', ''),
('\r\n226', 'Dhaka', 'Rajbari', 'Pangsha', 'Ramkol', '7721', ''),
('\r\n227', 'Dhaka', 'Rajbari', 'Pangsha', 'Ratandia', '7722', ''),
('\r\n228', 'Dhaka', 'Rajbari', 'Pangsha', 'Mrigibazar', '7723', ''),
('\r\n229', 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Rajbari Sadar', '7700', ''),
('\r\n230', 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Goalanda', '7710', ''),
('\r\n231', 'Dhaka', 'Rajbari', 'Rajbari Sadar', 'Khankhanapur', '7711', ''),
('\r\n232', 'Dhaka', 'Faridpur', 'Alfadanga', 'Alfadanga', '7870', ''),
('\r\n233', 'Dhaka', 'Faridpur', 'Bhanga', 'Bhanga', '7830', ''),
('\r\n234', 'Dhaka', 'Faridpur', 'Boalmari', 'Boalmari', '7860', ''),
('\r\n235', 'Dhaka', 'Faridpur', 'Boalmari', 'Rupatpat', '7861', ''),
('\r\n236', 'Dhaka', 'Faridpur', 'Charbhadrasan', 'Charbadrashan', '7810', ''),
('\r\n237', 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Faridpursadar', '7800', ''),
('\r\n238', 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Kanaipur', '7801', ''),
('\r\n239', 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Ambikapur', '7802', ''),
('\r\n240', 'Dhaka', 'Faridpur', 'Faridpur Sadar', 'Baitulaman Politecni', '7803', ''),
('\r\n241', 'Dhaka', 'Faridpur', 'Madukhali', 'Madukhali', '7850', ''),
('\r\n242', 'Dhaka', 'Faridpur', 'Madukhali', 'Kamarkali', '7851', ''),
('\r\n243', 'Dhaka', 'Faridpur', 'Nagarkanda', 'Nagarkanda', '7840', ''),
('\r\n244', 'Dhaka', 'Faridpur', 'Nagarkanda', 'Talma', '7841', ''),
('\r\n245', 'Dhaka', 'Faridpur', 'Sadarpur', 'Sadarpur', '7820', ''),
('\r\n246', 'Dhaka', 'Faridpur', 'Sadarpur', 'Hat Krishapur', '7821', ''),
('\r\n247', 'Dhaka', 'Faridpur', 'Sadarpur', 'Bishwa jaker Manjil', '7822', ''),
('\r\n248', 'Dhaka', 'Faridpur', 'Shriangan', 'Shriangan', '7804', ''),
('\r\n249', 'Dhaka', 'Madaripur', 'Barhamganj', 'Barhamganj', '7930', ''),
('\r\n250', 'Dhaka', 'Madaripur', 'Barhamganj', 'Nilaksmibandar', '7931', ''),
('\r\n251', 'Dhaka', 'Madaripur', 'Barhamganj', 'Bahadurpur', '7932', ''),
('\r\n252', 'Dhaka', 'Madaripur', 'Barhamganj', 'Umedpur', '7933', ''),
('\r\n253', 'Dhaka', 'Madaripur', 'kalkini', 'Kalkini', '7920', ''),
('\r\n254', 'Dhaka', 'Madaripur', 'kalkini', 'Sahabrampur', '7921', ''),
('\r\n255', 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Madaripur Sadar', '7900', ''),
('\r\n256', 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Charmugria', '7901', ''),
('\r\n257', 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Kulpaddi', '7902', ''),
('\r\n258', 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Habiganj', '7903', ''),
('\r\n259', 'Dhaka', 'Madaripur', 'Madaripur Sadar', 'Mustafapur', '7904', ''),
('\r\n260', 'Dhaka', 'Madaripur', 'Rajoir', 'Rajoir', '7910', ''),
('\r\n261', 'Dhaka', 'Madaripur', 'Rajoir', 'Khalia', '7911', ''),
('\r\n262', 'Dhaka', 'Shariatpur', 'Bhedorganj', 'Bhedorganj', '8030', ''),
('\r\n263', 'Dhaka', 'Shariatpur', 'Damudhya', 'Damudhya', '8040', ''),
('\r\n264', 'Dhaka', 'Shariatpur', 'Gosairhat', 'Gosairhat', '8050', ''),
('\r\n265', 'Dhaka', 'Shariatpur', 'Jajira', 'Jajira', '8010', ''),
('\r\n266', 'Dhaka', 'Shariatpur', 'Naria', 'Naria', '8020', ''),
('\r\n267', 'Dhaka', 'Shariatpur', 'Naria', 'Bhozeshwar', '8021', ''),
('\r\n268', 'Dhaka', 'Shariatpur', 'Naria', 'Gharisar', '8022', ''),
('\r\n269', 'Dhaka', 'Shariatpur', 'Naria', 'Upshi', '8023', ''),
('\r\n270', 'Dhaka', 'Shariatpur', 'Naria', 'Kartikpur', '8024', ''),
('\r\n271', 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Shariatpur Sadar', '8000', ''),
('\r\n272', 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Angaria', '8001', ''),
('\r\n273', 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 'Chikandi', '8002', ''),
('\r\n274', 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Chandradighalia', '8013', ''),
('\r\n275', 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Gopalganj Sadar', '8100', ''),
('\r\n276', 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Ulpur', '8101', ''),
('\r\n277', 'Dhaka', 'Gopalganj', 'Gopalganj Sadar', 'Barfa', '8102', ''),
('\r\n278', 'Dhaka', 'Gopalganj', 'Kashiani', 'Kashiani', '8130', ''),
('\r\n279', 'Dhaka', 'Gopalganj', 'Kashiani', 'Ramdia College', '8131', ''),
('\r\n280', 'Dhaka', 'Gopalganj', 'Kashiani', 'Ratoil', '8132', ''),
('\r\n281', 'Dhaka', 'Gopalganj', 'Kashiani', 'Jonapur', '8133', ''),
('\r\n282', 'Dhaka', 'Gopalganj', 'Kotalipara', 'Kotalipara', '8110', ''),
('\r\n283', 'Dhaka', 'Gopalganj', 'Maksudpur', 'Maksudpur', '8140', ''),
('\r\n284', 'Dhaka', 'Gopalganj', 'Maksudpur', 'Batkiamari', '8141', ''),
('\r\n285', 'Dhaka', 'Gopalganj', 'Maksudpur', 'Khandarpara', '8142', ''),
('\r\n286', 'Dhaka', 'Gopalganj', 'Tungipara', 'Tungipara', '8120', ''),
('\r\n287', 'Dhaka', 'Gopalganj', 'Tungipara', 'Patgati', '8121', ''),
('\r\n288', 'Dhaka', 'Manikganj', 'Doulatpur', 'Doulatpur', '1860', ''),
('\r\n289', 'Dhaka', 'Manikganj', 'Gheor', 'Gheor', '1840', ''),
('\r\n290', 'Dhaka', 'Manikganj', 'Lechhraganj', 'Lechhraganj', '1830', ''),
('\r\n291', 'Dhaka', 'Manikganj', 'Lechhraganj', 'Jhitka', '1831', ''),
('\r\n292', 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Sadar', '1800', ''),
('\r\n293', 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Manikganj Bazar', '1801', ''),
('\r\n294', 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Gorpara', '1802', ''),
('\r\n295', 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Mahadebpur', '1803', ''),
('\r\n296', 'Dhaka', 'Manikganj', 'Manikganj Sadar', 'Barangail', '1804', ''),
('\r\n297', 'Dhaka', 'Manikganj', 'Saturia', 'Saturia', '1810', ''),
('\r\n298', 'Dhaka', 'Manikganj', 'Saturia', 'Baliati', '1811', ''),
('\r\n299', 'Dhaka', 'Manikganj', 'Shibloya', 'Shibaloy', '1850', ''),
('\r\n300', 'Dhaka', 'Manikganj', 'Shibloya', 'Aricha', '1851', ''),
('\r\n301', 'Dhaka', 'Manikganj', 'Shibloya', 'Tewta', '1852', ''),
('\r\n302', 'Dhaka', 'Manikganj', 'Shibloya', 'Uthli', '1853', ''),
('\r\n303', 'Dhaka', 'Manikganj', 'Singari', 'Singair', '1820', ''),
('\r\n304', 'Dhaka', 'Manikganj', 'Singari', 'Baira', '1821', ''),
('\r\n305', 'Dhaka', 'Manikganj', 'Singari', 'joymantop', '1822', ''),
('\r\n306', 'Dhaka', 'Tangail', 'Basail', 'Basail', '1920', ''),
('\r\n307', 'Dhaka', 'Tangail', 'Bhuapur', 'Bhuapur', '1960', ''),
('\r\n308', 'Dhaka', 'Tangail', 'Delduar', 'Delduar', '1910', ''),
('\r\n309', 'Dhaka', 'Tangail', 'Delduar', 'Jangalia', '1911', ''),
('\r\n310', 'Dhaka', 'Tangail', 'Delduar', 'Patharail', '1912', ''),
('\r\n311', 'Dhaka', 'Tangail', 'Delduar', 'Elasin', '1913', ''),
('\r\n312', 'Dhaka', 'Tangail', 'Delduar', 'Hinga Nagar', '1914', ''),
('\r\n313', 'Dhaka', 'Tangail', 'Delduar', 'Lowhati', '1915', ''),
('\r\n314', 'Dhaka', 'Tangail', 'Ghatail', 'Ghatial', '1980', ''),
('\r\n315', 'Dhaka', 'Tangail', 'Ghatail', 'Zahidganj', '1981', ''),
('\r\n316', 'Dhaka', 'Tangail', 'Ghatail', 'D. Pakutia', '1982', ''),
('\r\n317', 'Dhaka', 'Tangail', 'Ghatail', 'Dhalapara', '1983', ''),
('\r\n318', 'Dhaka', 'Tangail', 'Ghatail', 'Lohani', '1984', ''),
('\r\n319', 'Dhaka', 'Tangail', 'Gopalpur', 'Gopalpur', '1990', ''),
('\r\n320', 'Dhaka', 'Tangail', 'Gopalpur', 'Jhowail', '1991', ''),
('\r\n321', 'Dhaka', 'Tangail', 'Gopalpur', 'Hemnagar', '1992', ''),
('\r\n322', 'Dhaka', 'Tangail', 'Kalihati', 'Kalihati', '1970', ''),
('\r\n323', 'Dhaka', 'Tangail', 'Kalihati', 'Rajafair', '1971', ''),
('\r\n324', 'Dhaka', 'Tangail', 'Kalihati', 'Nagbari', '1972', ''),
('\r\n325', 'Dhaka', 'Tangail', 'Kalihati', 'Ballabazar', '1973', ''),
('\r\n326', 'Dhaka', 'Tangail', 'Kalihati', 'Elinga', '1974', ''),
('\r\n327', 'Dhaka', 'Tangail', 'Kalihati', 'Palisha', '1975', ''),
('\r\n328', 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari SO', '1976', ''),
('\r\n329', 'Dhaka', 'Tangail', 'Kalihati', 'Nagarbari', '1977', ''),
('\r\n330', 'Dhaka', 'Tangail', 'Kashkaolia', 'Kashkawlia', '1930', ''),
('\r\n331', 'Dhaka', 'Tangail', 'Madhupur', 'Madhupur', '1996', ''),
('\r\n332', 'Dhaka', 'Tangail', 'Madhupur', 'Dhobari', '1997', ''),
('\r\n333', 'Dhaka', 'Tangail', 'Mirzapur', 'Mirzapur', '1940', ''),
('\r\n334', 'Dhaka', 'Tangail', 'Mirzapur', 'Gorai', '1941', ''),
('\r\n335', 'Dhaka', 'Tangail', 'Mirzapur', 'M.C. College', '1942', ''),
('\r\n336', 'Dhaka', 'Tangail', 'Mirzapur', 'Warri paikpara', '1943', ''),
('\r\n337', 'Dhaka', 'Tangail', 'Mirzapur', 'Jarmuki', '1944', ''),
('\r\n338', 'Dhaka', 'Tangail', 'Mirzapur', 'Mohera', '1945', ''),
('\r\n339', 'Dhaka', 'Tangail', 'Nagarpur', 'Nagarpur', '1936', ''),
('\r\n340', 'Dhaka', 'Tangail', 'Nagarpur', 'Dhuburia', '1937', ''),
('\r\n341', 'Dhaka', 'Tangail', 'Nagarpur', 'Salimabad', '1938', ''),
('\r\n342', 'Dhaka', 'Tangail', 'Sakhipur', 'Sakhipur', '1950', ''),
('\r\n343', 'Dhaka', 'Tangail', 'Sakhipur', 'Kochua', '1951', ''),
('\r\n344', 'Dhaka', 'Tangail', 'Tangail Sadar', 'Tangail Sadar', '1900', ''),
('\r\n345', 'Dhaka', 'Tangail', 'Tangail Sadar', 'Kagmari', '1901', ''),
('\r\n346', 'Dhaka', 'Tangail', 'Tangail Sadar', 'Santosh', '1902', ''),
('\r\n347', 'Dhaka', 'Tangail', 'Tangail Sadar', 'Korotia', '1903', ''),
('\r\n348', 'Dhaka', 'Tangail', 'Tangail Sadar', 'Purabari', '1904', ''),
('\r\n349', 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj', '2030', ''),
('\r\n350', 'Dhaka', 'Jamalpur', 'Dewangonj', 'Dewangonj S. Mills', '2031', ''),
('\r\n351', 'Dhaka', 'Jamalpur', 'Islampur', 'Islampur', '2020', ''),
('\r\n352', 'Dhaka', 'Jamalpur', 'Islampur', 'Durmoot', '2021', ''),
('\r\n353', 'Dhaka', 'Jamalpur', 'Islampur', 'Gilabari', '2022', ''),
('\r\n354', 'Dhaka', 'Jamalpur', 'Jamalpur', 'Jamalpur', '2000', ''),
('\r\n355', 'Dhaka', 'Jamalpur', 'Jamalpur', 'Nandina', '2001', ''),
('\r\n356', 'Dhaka', 'Jamalpur', 'Jamalpur', 'Narundi', '2002', ''),
('\r\n357', 'Dhaka', 'Jamalpur', 'Malandah', 'Malandah', '2010', ''),
('\r\n358', 'Dhaka', 'Jamalpur', 'Malandah', 'Jamalpur', '2011', ''),
('\r\n359', 'Dhaka', 'Jamalpur', 'Malandah', 'Malancha', '2012', ''),
('\r\n360', 'Dhaka', 'Jamalpur', 'Malandah', 'Mahmoodpur', '2013', ''),
('\r\n361', 'Dhaka', 'Jamalpur', 'Mathargonj', 'Mathargonj', '2040', ''),
('\r\n362', 'Dhaka', 'Jamalpur', 'Mathargonj', 'Balijhuri', '2041', ''),
('\r\n363', 'Dhaka', 'Jamalpur', 'Shorishabari', 'Shorishabari', '2050', ''),
('\r\n364', 'Dhaka', 'Jamalpur', 'Shorishabari', 'Gunerbari', '2051', ''),
('\r\n365', 'Dhaka', 'Jamalpur', 'Shorishabari', 'Bausee', '2052', ''),
('\r\n366', 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jagannath Ghat', '2053', ''),
('\r\n367', 'Dhaka', 'Jamalpur', 'Shorishabari', 'Pingna', '2054', ''),
('\r\n368', 'Dhaka', 'Jamalpur', 'Shorishabari', 'Jamuna Sar Karkhana', '2055', ''),
('\r\n369', 'Dhaka', 'Sherpur', 'Bakshigonj', 'Bakshigonj', '2140', ''),
('\r\n370', 'Dhaka', 'Sherpur', 'Jhinaigati', 'Jhinaigati', '2120', ''),
('\r\n371', 'Dhaka', 'Sherpur', 'Nakla', 'Nakla', '2150', ''),
('\r\n372', 'Dhaka', 'Sherpur', 'Nakla', 'Gonopaddi', '2151', ''),
('\r\n373', 'Dhaka', 'Sherpur', 'Nalitabari', 'Nalitabari', '2110', ''),
('\r\n374', 'Dhaka', 'Sherpur', 'Nalitabari', 'Hatibandha', '2111', ''),
('\r\n375', 'Dhaka', 'Sherpur', 'Sherpur Shadar', 'Sherpur Shadar', '2100', ''),
('\r\n376', 'Dhaka', 'Sherpur', 'Shribardi', 'Shribardi', '2130', ''),
('\r\n377', 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Akhaura', '3450', ''),
('\r\n378', 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Azampur', '3451', ''),
('\r\n379', 'Chittagong ', 'Brahmanbaria', 'Akhaura', 'Gangasagar', '3452', ''),
('\r\n380', 'Chittagong ', 'Brahmanbaria', 'Banchharampur', 'Banchharampur', '3420', ''),
('\r\n381', 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Brahamanbaria Sadar', '3400', ''),
('\r\n382', 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Talshahar', '3401', ''),
('\r\n383', 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj', '3402', ''),
('\r\n384', 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Ashuganj Share', '3403', ''),
('\r\n385', 'Chittagong ', 'Brahmanbaria', 'Brahamanbaria Sadar', 'Poun', '3404', ''),
('\r\n386', 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kasba', '3460', ''),
('\r\n387', 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Kuti', '3461', ''),
('\r\n388', 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chandidar', '3462', ''),
('\r\n389', 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Chargachh', '3463', ''),
('\r\n390', 'Chittagong ', 'Brahmanbaria', 'Kasba', 'Gopinathpur', '3464', ''),
('\r\n391', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Nabinagar', '3410', ''),
('\r\n392', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Laubfatehpur', '3411', ''),
('\r\n393', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Rasullabad', '3412', ''),
('\r\n394', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shamgram', '3413', ''),
('\r\n395', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Ratanpur', '3414', ''),
('\r\n396', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Shahapur', '3415', ''),
('\r\n397', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Kaitala', '3417', ''),
('\r\n398', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Salimganj', '3418', ''),
('\r\n399', 'Chittagong ', 'Brahmanbaria', 'Nabinagar', 'Jibanganj', '3419', ''),
('\r\n400', 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Nasirnagar', '3440', ''),
('\r\n401', 'Chittagong ', 'Brahmanbaria', 'Nasirnagar', 'Fandauk', '3441', ''),
('\r\n402', 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Sarial', '3430', ''),
('\r\n403', 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Shahbajpur', '3431', ''),
('\r\n404', 'Chittagong ', 'Brahmanbaria', 'Sarail', 'Chandura', '3432', ''),
('\r\n405', 'Chittagong ', 'Comilla', 'Barura', 'Barura', '3560', ''),
('\r\n406', 'Chittagong ', 'Comilla', 'Barura', 'Poyalgachha', '3561', ''),
('\r\n407', 'Chittagong ', 'Comilla', 'Barura', 'Murdafarganj', '3562', ''),
('\r\n408', 'Chittagong ', 'Comilla', 'Brahmanpara', 'Brahmanpara', '3526', ''),
('\r\n409', 'Chittagong ', 'Comilla', 'Burichang', 'Burichang', '3520', ''),
('\r\n410', 'Chittagong ', 'Comilla', 'Burichang', 'Maynamoti bazar', '3521', ''),
('\r\n411', 'Chittagong ', 'Comilla', 'Chandina', 'Chandia', '3510', ''),
('\r\n412', 'Chittagong ', 'Comilla', 'Chandina', 'Madhaiabazar', '3511', ''),
('\r\n413', 'Chittagong ', 'Comilla', 'Chouddagram', 'Chouddagram', '3550', ''),
('\r\n414', 'Chittagong ', 'Comilla', 'Chouddagram', 'Batisa', '3551', ''),
('\r\n415', 'Chittagong ', 'Comilla', 'Chouddagram', 'Chiora', '3552', ''),
('\r\n416', 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Sadar', '3500', ''),
('\r\n417', 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Comilla Contoment', '3501', ''),
('\r\n418', 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Halimanagar', '3502', ''),
('\r\n419', 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Courtbari', '3503', ''),
('\r\n420', 'Chittagong ', 'Comilla', 'Comilla Sadar', 'Suaganj', '3504', ''),
('\r\n421', 'Chittagong ', 'Comilla', 'Daudkandi', 'Daudkandi', '3516', ''),
('\r\n422', 'Chittagong ', 'Comilla', 'Daudkandi', 'Gouripur', '3517', ''),
('\r\n423', 'Chittagong ', 'Comilla', 'Daudkandi', 'Dashpara', '3518', ''),
('\r\n424', 'Chittagong ', 'Comilla', 'Daudkandi', 'Eliotganj', '3519', ''),
('\r\n425', 'Chittagong ', 'Comilla', 'Davidhar', 'Davidhar', '3530', ''),
('\r\n426', 'Chittagong ', 'Comilla', 'Davidhar', 'Gangamandal', '3531', ''),
('\r\n427', 'Chittagong ', 'Comilla', 'Davidhar', 'Barashalghar', '3532', ''),
('\r\n428', 'Chittagong ', 'Comilla', 'Davidhar', 'Dhamtee', '3533', ''),
('\r\n429', 'Chittagong ', 'Comilla', 'Homna', 'Homna', '3546', ''),
('\r\n430', 'Chittagong ', 'Comilla', 'Laksam', 'Laksam', '3570', ''),
('\r\n431', 'Chittagong ', 'Comilla', 'Laksam', 'Lakshamanpur', '3571', ''),
('\r\n432', 'Chittagong ', 'Comilla', 'Laksam', 'Bipulasar', '3572', ''),
('\r\n433', 'Chittagong ', 'Comilla', 'Langalkot', 'Langalkot', '3580', ''),
('\r\n434', 'Chittagong ', 'Comilla', 'Langalkot', 'Dhalua', '3581', ''),
('\r\n435', 'Chittagong ', 'Comilla', 'Langalkot', 'Chhariabazar', '3582', ''),
('\r\n436', 'Chittagong ', 'Comilla', 'Langalkot', 'Gunabati', '3583', ''),
('\r\n437', 'Chittagong ', 'Comilla', 'Muradnagar', 'Muradnagar', '3540', ''),
('\r\n438', 'Chittagong ', 'Comilla', 'Muradnagar', 'Ramchandarpur', '3541', ''),
('\r\n439', 'Chittagong ', 'Comilla', 'Muradnagar', 'Companyganj', '3542', ''),
('\r\n440', 'Chittagong ', 'Comilla', 'Muradnagar', 'Bangra', '3543', ''),
('\r\n441', 'Chittagong ', 'Comilla', 'Muradnagar', 'Sonakanda', '3544', ''),
('\r\n442', 'Chittagong ', 'Comilla', 'Muradnagar', 'Pantibazar', '3545', ''),
('\r\n443', 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Char Alexgander', '3730', ''),
('\r\n444', 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Hajirghat', '3731', ''),
('\r\n445', 'Chittagong ', 'Lakshmipur', 'Char Alexgander', 'Ramgatirhat', '3732', ''),
('\r\n446', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Lakshimpur Sadar', '3700', ''),
('\r\n447', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Dalal Bazar', '3701', ''),
('\r\n448', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Bhabaniganj', '3702', ''),
('\r\n449', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Mandari', '3703', ''),
('\r\n450', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Keramatganj', '3704', ''),
('\r\n451', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Rupchara', '3705', ''),
('\r\n452', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Duttapara', '3706', ''),
('\r\n453', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Choupalli', '3707', ''),
('\r\n454', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Chandraganj', '3708', ''),
('\r\n455', 'Chittagong ', 'Lakshmipur', 'Lakshimpur Sadar', 'Amani Lakshimpur', '3709', ''),
('\r\n456', 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Ramganj', '3720', ''),
('\r\n457', 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Alipur', '3721', ''),
('\r\n458', 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Panpara', '3722', ''),
('\r\n459', 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Kanchanpur', '3723', ''),
('\r\n460', 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Naagmud', '3724', ''),
('\r\n461', 'Chittagong ', 'Lakshmipur', 'Ramganj', 'Dolta', '3725', ''),
('\r\n462', 'Chittagong ', 'Lakshmipur', 'Raypur', 'Raypur', '3710', ''),
('\r\n463', 'Chittagong ', 'Lakshmipur', 'Raypur', 'Rakhallia', '3711', ''),
('\r\n464', 'Chittagong ', 'Lakshmipur', 'Raypur', 'Nagerdighirpar', '3712', ''),
('\r\n465', 'Chittagong ', 'Lakshmipur', 'Raypur', 'Haydarganj', '3713', ''),
('\r\n466', 'Chittagong ', 'Lakshmipur', 'Raypur', 'Bhuabari', '3714', ''),
('\r\n467', 'Chittagong ', 'Noakhali', 'Basurhat', 'Basur Hat', '3850', ''),
('\r\n468', 'Chittagong ', 'Noakhali', 'Basurhat', 'Charhajari', '3851', ''),
('\r\n469', 'Chittagong ', 'Noakhali', 'Begumganj', 'Begumganj', '3820', ''),
('\r\n470', 'Chittagong ', 'Noakhali', 'Begumganj', 'Choumohani', '3821', ''),
('\r\n471', 'Chittagong ', 'Noakhali', 'Begumganj', 'Banglabazar', '3822', ''),
('\r\n472', 'Chittagong ', 'Noakhali', 'Begumganj', 'Mir Owarishpur', '3823', ''),
('\r\n473', 'Chittagong ', 'Noakhali', 'Begumganj', 'Bazra', '3824', ''),
('\r\n474', 'Chittagong ', 'Noakhali', 'Begumganj', 'Jamidar Hat', '3825', ''),
('\r\n475', 'Chittagong ', 'Noakhali', 'Begumganj', 'Sonaimuri', '3827', ''),
('\r\n476', 'Chittagong ', 'Noakhali', 'Begumganj', 'Gopalpur', '3828', ''),
('\r\n477', 'Chittagong ', 'Noakhali', 'Begumganj', 'Joynarayanpur', '3829', ''),
('\r\n478', 'Chittagong ', 'Noakhali', 'Begumganj', 'Alaiarpur', '3831', ''),
('\r\n479', 'Chittagong ', 'Noakhali', 'Begumganj', 'Tangirpar', '3832', ''),
('\r\n480', 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalafat Bazar', '3833', ''),
('\r\n481', 'Chittagong ', 'Noakhali', 'Begumganj', 'Rajganj', '3834', ''),
('\r\n482', 'Chittagong ', 'Noakhali', 'Begumganj', 'Oachhekpur', '3835', ''),
('\r\n483', 'Chittagong ', 'Noakhali', 'Begumganj', 'Bhabani Jibanpur', '3837', ''),
('\r\n484', 'Chittagong ', 'Noakhali', 'Begumganj', 'Maheshganj', '3838', ''),
('\r\n485', 'Chittagong ', 'Noakhali', 'Begumganj', 'Nadona', '3839', ''),
('\r\n486', 'Chittagong ', 'Noakhali', 'Begumganj', 'Nandiapara', '3841', ''),
('\r\n487', 'Chittagong ', 'Noakhali', 'Begumganj', 'Khalishpur', '3842', ''),
('\r\n488', 'Chittagong ', 'Noakhali', 'Begumganj', 'Dauti', '3843', ''),
('\r\n489', 'Chittagong ', 'Noakhali', 'Begumganj', 'Joyag', '3844', ''),
('\r\n490', 'Chittagong ', 'Noakhali', 'Begumganj', 'Thanar Hat', '3845', ''),
('\r\n491', 'Chittagong ', 'Noakhali', 'Begumganj', 'Amisha Para', '3847', ''),
('\r\n492', 'Chittagong ', 'Noakhali', 'Begumganj', 'Durgapur', '3848', ''),
('\r\n493', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Chatkhil', '3870', ''),
('\r\n494', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Palla', '3871', ''),
('\r\n495', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Khilpara', '3872', ''),
('\r\n496', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bodalcourt', '3873', ''),
('\r\n497', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Rezzakpur', '3874', ''),
('\r\n498', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Solla', '3875', ''),
('\r\n499', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Karihati', '3877', ''),
('\r\n500', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Dosh Gharia', '3878', ''),
('\r\n501', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Bansa Bazar', '3879', ''),
('\r\n502', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sahapur', '3881', ''),
('\r\n503', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Sampara', '3882', ''),
('\r\n504', 'Chittagong ', 'Noakhali', 'Chatkhil', 'Shingbahura', '3883', ''),
('\r\n505', 'Chittagong ', 'Noakhali', 'Hatiya', 'Hatiya', '3890', ''),
('\r\n506', 'Chittagong ', 'Noakhali', 'Hatiya', 'Afazia', '3891', ''),
('\r\n507', 'Chittagong ', 'Noakhali', 'Hatiya', 'Tamoraddi', '3892', ''),
('\r\n508', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali Sadar', '3800', ''),
('\r\n509', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Noakhali College', '3801', ''),
('\r\n510', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Sonapur', '3802', ''),
('\r\n511', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Din Monir Hat', '3803', ''),
('\r\n512', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Pak Kishoreganj', '3804', ''),
('\r\n513', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Mriddarhat', '3806', ''),
('\r\n514', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Kabirhat', '3807', ''),
('\r\n515', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Khalifar Hat', '3808', ''),
('\r\n516', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Charam Tua', '3809', ''),
('\r\n517', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Chaprashir Hat', '3811', ''),
('\r\n518', 'Chittagong ', 'Noakhali', 'Noakhali Sadar', 'Char Jabbar', '3812', ''),
('\r\n519', 'Chittagong ', 'Noakhali', 'Senbag', 'Senbag', '3860', ''),
('\r\n520', 'Chittagong ', 'Noakhali', 'Senbag', 'Kallyandi', '3861', ''),
('\r\n521', 'Chittagong ', 'Noakhali', 'Senbag', 'Beezbag', '3862', ''),
('\r\n522', 'Chittagong ', 'Noakhali', 'Senbag', 'Kankirhat', '3863', ''),
('\r\n523', 'Chittagong ', 'Noakhali', 'Senbag', 'Chatarpaia', '3864', ''),
('\r\n524', 'Chittagong ', 'Noakhali', 'Senbag', 'T.P. Lamua', '3865', ''),
('\r\n525', 'Chittagong ', 'Feni', 'Chhagalnaia', 'Chhagalnaia', '3910', ''),
('\r\n526', 'Chittagong ', 'Feni', 'Chhagalnaia', 'Maharajganj', '3911', ''),
('\r\n527', 'Chittagong ', 'Feni', 'Chhagalnaia', 'Daraga Hat', '3912', ''),
('\r\n528', 'Chittagong ', 'Feni', 'Chhagalnaia', 'Puabashimulia', '3913', ''),
('\r\n529', 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dagondhuia', '3920', ''),
('\r\n530', 'Chittagong ', 'Feni', 'Dagonbhuia', 'Dudmukha', '3921', ''),
('\r\n531', 'Chittagong ', 'Feni', 'Dagonbhuia', 'Chhilonia', '3922', ''),
('\r\n532', 'Chittagong ', 'Feni', 'Dagonbhuia', 'Rajapur', '3923', ''),
('\r\n533', 'Chittagong ', 'Feni', 'Feni Sadar', 'Feni Sadar', '3900', ''),
('\r\n534', 'Chittagong ', 'Feni', 'Feni Sadar', 'Fazilpur', '3901', ''),
('\r\n535', 'Chittagong ', 'Feni', 'Feni Sadar', 'Sharshadie', '3902', ''),
('\r\n536', 'Chittagong ', 'Feni', 'Feni Sadar', 'Laskarhat', '3903', ''),
('\r\n537', 'Chittagong ', 'Feni', 'Pashurampur', 'Pashurampur', '3940', ''),
('\r\n538', 'Chittagong ', 'Feni', 'Pashurampur', 'Shuarbazar', '3941', ''),
('\r\n539', 'Chittagong ', 'Feni', 'Pashurampur', 'Fulgazi', '3942', ''),
('\r\n540', 'Chittagong ', 'Feni', 'Pashurampur', 'Munshirhat', '3943', ''),
('\r\n541', 'Chittagong ', 'Feni', 'Sonagazi', 'Sonagazi', '3930', ''),
('\r\n542', 'Chittagong ', 'Feni', 'Sonagazi', 'Motiganj', '3931', ''),
('\r\n543', 'Chittagong ', 'Feni', 'Sonagazi', 'Ahmadpur', '3932', ''),
('\r\n544', 'Chittagong ', 'Feni', 'Sonagazi', 'Kazirhat', '3933', ''),
('\r\n545', 'Chittagong ', 'Chittagong', 'Anawara', 'Anowara', '4376', ''),
('\r\n546', 'Chittagong ', 'Chittagong', 'Anawara', 'Paroikora', '4377', ''),
('\r\n547', 'Chittagong ', 'Chittagong', 'Anawara', 'Battali', '4378', ''),
('\r\n548', 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kanungopara', '4363', ''),
('\r\n549', 'Chittagong ', 'Chittagong', 'Boalkhali', 'Saroatoli', '4364', ''),
('\r\n550', 'Chittagong ', 'Chittagong', 'Boalkhali', 'Iqbal Park', '4365', ''),
('\r\n551', 'Chittagong ', 'Chittagong', 'Boalkhali', 'Boalkhali', '4366', ''),
('\r\n552', 'Chittagong ', 'Chittagong', 'Boalkhali', 'Sakpura', '4367', ''),
('\r\n553', 'Chittagong ', 'Chittagong', 'Boalkhali', 'Kadurkhal', '4368', ''),
('\r\n554', 'Chittagong ', 'Chittagong', 'Boalkhali', 'Charandwip', '4369', ''),
('\r\n555', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong GPO', '4000', ''),
('\r\n556', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Bandar', '4100', ''),
('\r\n557', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Pahartoli', '4202', ''),
('\r\n558', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chawkbazar', '4203', ''),
('\r\n559', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Patenga', '4204', ''),
('\r\n560', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chittagong Airport', '4205', ''),
('\r\n561', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Jaldia Merine Accade', '4206', ''),
('\r\n562', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Firozshah', '4207', ''),
('\r\n563', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Mohard', '4208', ''),
('\r\n564', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Politechnic In', '4209', ''),
('\r\n565', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Bayezid Bostami', '4210', ''),
('\r\n566', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Amin Jute Mills', '4211', ''),
('\r\n567', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chandgaon', '4212', ''),
('\r\n568', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Wazedia', '4213', ''),
('\r\n569', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Jalalabad', '4214', ''),
('\r\n570', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Anandabazar', '4215', ''),
('\r\n571', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishahar', '4216', ''),
('\r\n572', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Katuli', '4217', ''),
('\r\n573', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Sailers Colon', '4218', ''),
('\r\n574', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Customs Acca', '4219', ''),
('\r\n575', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Chitt. Cantonment', '4220', ''),
('\r\n576', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Al- Amin Baria Madra', '4221', ''),
('\r\n577', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Middle Patenga', '4222', ''),
('\r\n578', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Export Processing', '4223', ''),
('\r\n579', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Rampura TSO', '4224', ''),
('\r\n580', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'Halishshar', '4225', ''),
('\r\n581', 'Chittagong ', 'Chittagong', 'Chittagong Sadar', 'North Halishahar', '4226', ''),
('\r\n582', 'Chittagong ', 'Chittagong', 'East Joara', 'East Joara', '4380', ''),
('\r\n583', 'Chittagong ', 'Chittagong', 'East Joara', 'Gachbaria', '4381', ''),
('\r\n584', 'Chittagong ', 'Chittagong', 'East Joara', 'Dohazari', '4382', ''),
('\r\n585', 'Chittagong ', 'Chittagong', 'East Joara', 'Barma', '4383', ''),
('\r\n586', 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Fatikchhari', '4350', ''),
('\r\n587', 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Nanupur', '4351', ''),
('\r\n588', 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Bhandar Sharif', '4352', ''),
('\r\n589', 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Najirhat', '4353', ''),
('\r\n590', 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Harualchhari', '4354', ''),
('\r\n591', 'Chittagong ', 'Chittagong', 'Fatikchhari', 'Narayanhat', '4355', ''),
('\r\n592', 'Chittagong ', 'Chittagong', 'Hathazari', 'Hathazari', '4330', ''),
('\r\n593', 'Chittagong ', 'Chittagong', 'Hathazari', 'Chitt.University', '4331', ''),
('\r\n594', 'Chittagong ', 'Chittagong', 'Hathazari', 'Gorduara', '4332', ''),
('\r\n595', 'Chittagong ', 'Chittagong', 'Hathazari', 'Katirhat', '4333', ''),
('\r\n596', 'Chittagong ', 'Chittagong', 'Hathazari', 'Mirzapur', '4334', ''),
('\r\n597', 'Chittagong ', 'Chittagong', 'Hathazari', 'Fatahabad', '4335', ''),
('\r\n598', 'Chittagong ', 'Chittagong', 'Hathazari', 'Nuralibari', '4337', ''),
('\r\n599', 'Chittagong ', 'Chittagong', 'Hathazari', 'Yunus Nagar', '4338', ''),
('\r\n600', 'Chittagong ', 'Chittagong', 'Hathazari', 'Madrasa', '4339', ''),
('\r\n601', 'Chittagong ', 'Chittagong', 'Jaldi', 'Jaldi', '4390', ''),
('\r\n602', 'Chittagong ', 'Chittagong', 'Jaldi', 'Khan Bahadur', '4391', ''),
('\r\n603', 'Chittagong ', 'Chittagong', 'Jaldi', 'Gunagari', '4392', ''),
('\r\n604', 'Chittagong ', 'Chittagong', 'Jaldi', 'Banigram', '4393', ''),
('\r\n605', 'Chittagong ', 'Chittagong', 'Lohagara', 'Lohagara', '4396', ''),
('\r\n606', 'Chittagong ', 'Chittagong', 'Lohagara', 'Padua', '4397', ''),
('\r\n607', 'Chittagong ', 'Chittagong', 'Lohagara', 'Chunti', '4398', ''),
('\r\n608', 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mirsharai', '4320', ''),
('\r\n609', 'Chittagong ', 'Chittagong', 'Mirsharai', 'Abutorab', '4321', ''),
('\r\n610', 'Chittagong ', 'Chittagong', 'Mirsharai', 'Darrogahat', '4322', ''),
('\r\n611', 'Chittagong ', 'Chittagong', 'Mirsharai', 'Bharawazhat', '4323', ''),
('\r\n612', 'Chittagong ', 'Chittagong', 'Mirsharai', 'Joarganj', '4324', ''),
('\r\n613', 'Chittagong ', 'Chittagong', 'Mirsharai', 'Azampur', '4325', ''),
('\r\n614', 'Chittagong ', 'Chittagong', 'Mirsharai', 'Korerhat', '4327', ''),
('\r\n615', 'Chittagong ', 'Chittagong', 'Mirsharai', 'Mohazanhat', '4328', ''),
('\r\n616', 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Patia Head Office', '4370', ''),
('\r\n617', 'Chittagong ', 'Chittagong', 'Patia Head Office', 'Budhpara', '4371', ''),
('\r\n618', 'Chittagong ', 'Chittagong', 'Rangunia', 'Rangunia', '4360', ''),
('\r\n619', 'Chittagong ', 'Chittagong', 'Rangunia', 'Dhamair', '4361', ''),
('\r\n620', 'Chittagong ', 'Chittagong', 'Rouzan', 'Rouzan', '4340', ''),
('\r\n621', 'Chittagong ', 'Chittagong', 'Rouzan', 'Beenajuri', '4341', ''),
('\r\n622', 'Chittagong ', 'Chittagong', 'Rouzan', 'Kundeshwari', '4342', ''),
('\r\n623', 'Chittagong ', 'Chittagong', 'Rouzan', 'Gahira', '4343', ''),
('\r\n624', 'Chittagong ', 'Chittagong', 'Rouzan', 'jagannath Hat', '4344', ''),
('\r\n625', 'Chittagong ', 'Chittagong', 'Rouzan', 'Fatepur', '4345', ''),
('\r\n626', 'Chittagong ', 'Chittagong', 'Rouzan', 'Guzra Noapara', '4346', ''),
('\r\n627', 'Chittagong ', 'Chittagong', 'Rouzan', 'Dewanpur', '4347', ''),
('\r\n628', 'Chittagong ', 'Chittagong', 'Rouzan', 'Mohamuni', '4348', ''),
('\r\n629', 'Chittagong ', 'Chittagong', 'Rouzan', 'B.I.T Post Office', '4349', ''),
('\r\n630', 'Chittagong ', 'Chittagong', 'Sandwip', 'Sandwip', '4300', ''),
('\r\n631', 'Chittagong ', 'Chittagong', 'Sandwip', 'Shiberhat', '4301', ''),
('\r\n632', 'Chittagong ', 'Chittagong', 'Sandwip', 'Urirchar', '4302', ''),
('\r\n633', 'Chittagong ', 'Chittagong', 'Satkania', 'Satkania', '4386', ''),
('\r\n634', 'Chittagong ', 'Chittagong', 'Satkania', 'Baitul Ijjat', '4387', ''),
('\r\n635', 'Chittagong ', 'Chittagong', 'Satkania', 'Bazalia', '4388', ''),
('\r\n636', 'Chittagong ', 'Chittagong', 'Sitakunda', 'Sitakunda', '4310', ''),
('\r\n637', 'Chittagong ', 'Chittagong', 'Sitakunda', 'Baroidhala', '4311', ''),
('\r\n638', 'Chittagong ', 'Chittagong', 'Sitakunda', 'Barabkunda', '4312', ''),
('\r\n639', 'Chittagong ', 'Chittagong', 'Sitakunda', 'Bawashbaria', '4313', ''),
('\r\n640', 'Chittagong ', 'Chittagong', 'Sitakunda', 'Kumira', '4314', ''),
('\r\n641', 'Chittagong ', 'Chittagong', 'Sitakunda', 'Bhatiari', '4315', ''),
('\r\n642', 'Chittagong ', 'Chittagong', 'Sitakunda', 'Fouzdarhat', '4316', ''),
('\r\n643', 'Chittagong ', 'Chittagong', 'Sitakunda', 'Jafrabad', '4317', ''),
('\r\n644', 'Chittagong ', 'Khagrachari', 'Diginala', 'Diginala', '4420', ''),
('\r\n645', 'Chittagong ', 'Khagrachari', 'Khagrachari Sadar', 'Khagrachari Sadar', '4400', ''),
('\r\n646', 'Chittagong ', 'Khagrachari', 'Laxmichhari', 'Laxmichhari', '4470', ''),
('\r\n647', 'Chittagong ', 'Khagrachari', 'Mahalchhari', 'Mahalchhari', '4430', ''),
('\r\n648', 'Chittagong ', 'Khagrachari', 'Manikchhari', 'Manikchhari', '4460', ''),
('\r\n649', 'Chittagong ', 'Khagrachari', 'Matiranga', 'Matiranga', '4450', ''),
('\r\n650', 'Chittagong ', 'Khagrachari', 'Panchhari', 'Panchhari', '4410', ''),
('\r\n651', 'Chittagong ', 'Khagrachari', 'Ramghar Head Office', 'Ramghar Head Office', '4440', ''),
('\r\n652', 'Chittagong ', 'Rangamati', 'Barakal', 'Barakal', '4570', ''),
('\r\n653', 'Chittagong ', 'Rangamati', 'Bilaichhari', 'Bilaichhari', '4550', ''),
('\r\n654', 'Chittagong ', 'Rangamati', 'Jarachhari', 'Jarachhari', '4560', ''),
('\r\n655', 'Chittagong ', 'Rangamati', 'Kalampati', 'Kalampati', '4510', ''),
('\r\n656', 'Chittagong ', 'Rangamati', 'Kalampati', 'Betbunia', '4511', ''),
('\r\n657', 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai', '4530', ''),
('\r\n658', 'Chittagong ', 'Rangamati', 'kaptai', 'Chandraghona', '4531', ''),
('\r\n659', 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Project', '4532', ''),
('\r\n660', 'Chittagong ', 'Rangamati', 'kaptai', 'Kaptai Nuton Bazar', '4533', ''),
('\r\n661', 'Chittagong ', 'Rangamati', 'Longachh', 'Longachh', '4580', ''),
('\r\n662', 'Chittagong ', 'Rangamati', 'Marishya', 'Marishya', '4590', ''),
('\r\n663', 'Chittagong ', 'Rangamati', 'Naniachhar', 'Nanichhar', '4520', ''),
('\r\n664', 'Chittagong ', 'Rangamati', 'Rajsthali', 'Rajsthali', '4540', ''),
('\r\n665', 'Chittagong ', 'Rangamati', 'Rangamati Sadar', 'Rangamati Sadar', '4500', ''),
('\r\n666', 'Chittagong ', 'Bandarban', 'Alikadam', 'Alikadam', '4650', ''),
('\r\n667', 'Chittagong ', 'Bandarban', 'Bandarban Sadar', 'Bandarban Sadar', '4600', ''),
('\r\n668', 'Chittagong ', 'Bandarban', 'Naikhong', 'Naikhong', '4660', ''),
('\r\n669', 'Chittagong ', 'Bandarban', 'Roanchhari', 'Roanchhari', '4610', ''),
('\r\n670', 'Chittagong ', 'Bandarban', 'Ruma', 'Ruma', '4620', ''),
('\r\n671', 'Chittagong ', 'Bandarban', 'Thanchi', 'Thanchi', '4630', '');
INSERT INTO `TABLE 4` (`COL 1`, `COL 2`, `COL 3`, `COL 4`, `COL 5`, `COL 6`, `COL 7`) VALUES
('\r\n672', 'Chittagong ', 'Bandarban', 'Thanchi', 'Lama', '4641', ''),
('\r\n673', 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga', '4740', ''),
('\r\n674', 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Chiringga S.O', '4741', ''),
('\r\n675', 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Badarkali', '4742', ''),
('\r\n676', 'Chittagong ', 'Coxs Bazar', 'Chiringga', 'Malumghat', '4743', ''),
('\r\n677', 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Coxs Bazar Sadar', '4700', ''),
('\r\n678', 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Zhilanja', '4701', ''),
('\r\n679', 'Chittagong ', 'Coxs Bazar', 'Coxs Bazar Sadar', 'Eidga', '4702', ''),
('\r\n680', 'Chittagong ', 'Coxs Bazar', 'Gorakghat', 'Gorakghat', '4710', ''),
('\r\n681', 'Chittagong ', 'Coxs Bazar', 'Kutubdia', 'Kutubdia', '4720', ''),
('\r\n682', 'Chittagong ', 'Coxs Bazar', 'Ramu', 'Ramu', '4730', ''),
('\r\n683', 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Teknaf', '4760', ''),
('\r\n684', 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'Hnila', '4761', ''),
('\r\n685', 'Chittagong ', 'Coxs Bazar', 'Teknaf', 'St.Martin', '4762', ''),
('\r\n686', 'Chittagong ', 'Coxs Bazar', 'Ukhia', 'Ukhia', '4750', ''),
('\r\n687', 'Khulna ', 'Kustia', 'Bheramara', 'Bheramara', '7040', ''),
('\r\n688', 'Khulna ', 'Kustia', 'Bheramara', 'Ganges Bheramara', '7041', ''),
('\r\n689', 'Khulna ', 'Kustia', 'Bheramara', 'Allardarga', '7042', ''),
('\r\n690', 'Khulna ', 'Kustia', 'Janipur', 'Janipur', '7020', ''),
('\r\n691', 'Khulna ', 'Kustia', 'Janipur', 'Khoksa', '7021', ''),
('\r\n692', 'Khulna ', 'Kustia', 'Kumarkhali', 'Kumarkhali', '7010', ''),
('\r\n693', 'Khulna ', 'Kustia', 'Kumarkhali', 'Panti', '7011', ''),
('\r\n694', 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kustia Sadar', '7000', ''),
('\r\n695', 'Khulna ', 'Kustia', 'Kustia Sadar', 'Kushtia Mohini', '7001', ''),
('\r\n696', 'Khulna ', 'Kustia', 'Kustia Sadar', 'Jagati', '7002', ''),
('\r\n697', 'Khulna ', 'Kustia', 'Kustia Sadar', 'Islami University', '7003', ''),
('\r\n698', 'Khulna ', 'Kustia', 'Mirpur', 'Mirpur', '7030', ''),
('\r\n699', 'Khulna ', 'Kustia', 'Mirpur', 'Poradaha', '7031', ''),
('\r\n700', 'Khulna ', 'Kustia', 'Mirpur', 'Amla Sadarpur', '7032', ''),
('\r\n701', 'Khulna ', 'Kustia', 'Rafayetpur', 'Rafayetpur', '7050', ''),
('\r\n702', 'Khulna ', 'Kustia', 'Rafayetpur', 'Taragunia', '7051', ''),
('\r\n703', 'Khulna ', 'Kustia', 'Rafayetpur', 'Khasmathurapur', '7052', ''),
('\r\n704', 'Khulna ', 'Meherpur', 'Gangni', 'Gangni', '7110', ''),
('\r\n705', 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Meherpur Sadar', '7100', ''),
('\r\n706', 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', '7101', ''),
('\r\n707', 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Mujib Nagar Complex', '7102', ''),
('\r\n708', 'Khulna ', 'Meherpur', 'Meherpur Sadar', 'Amjhupi', '7152', ''),
('\r\n709', 'Khulna ', 'Chuadanga', 'Alamdanga', 'Alamdanga', '7210', ''),
('\r\n710', 'Khulna ', 'Chuadanga', 'Alamdanga', 'Hardi', '7211', ''),
('\r\n711', 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Chuadanga Sadar', '7200', ''),
('\r\n712', 'Khulna ', 'Chuadanga', 'Chuadanga Sadar', 'Munshiganj', '7201', ''),
('\r\n713', 'Khulna ', 'Chuadanga', 'Damurhuda', 'Damurhuda', '7220', ''),
('\r\n714', 'Khulna ', 'Chuadanga', 'Damurhuda', 'Darshana', '7221', ''),
('\r\n715', 'Khulna ', 'Chuadanga', 'Damurhuda', 'Andulbaria', '7222', ''),
('\r\n716', 'Khulna ', 'Chuadanga', 'Doulatganj', 'Doulatganj', '7230', ''),
('\r\n717', 'Khulna ', 'Jinaidaha', 'Harinakundu', 'Harinakundu', '7310', ''),
('\r\n718', 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Sadar', '7300', ''),
('\r\n719', 'Khulna ', 'Jinaidaha', 'Jinaidaha Sadar', 'Jinaidaha Cadet College', '7301', ''),
('\r\n720', 'Khulna ', 'Jinaidaha', 'Kotchandpur', 'Kotchandpur', '7330', ''),
('\r\n721', 'Khulna ', 'Jinaidaha', 'Maheshpur', 'Maheshpur', '7340', ''),
('\r\n722', 'Khulna ', 'Jinaidaha', 'Naldanga', 'Naldanga', '7350', ''),
('\r\n723', 'Khulna ', 'Jinaidaha', 'Naldanga', 'Hatbar Bazar', '7351', ''),
('\r\n724', 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Shailakupa', '7320', ''),
('\r\n725', 'Khulna ', 'Jinaidaha', 'Shailakupa', 'Kumiradaha', '7321', ''),
('\r\n726', 'Khulna ', 'Jessore', 'Bagharpara', 'Bagharpara', '7470', ''),
('\r\n727', 'Khulna ', 'Jessore', 'Bagharpara', 'Gouranagar', '7471', ''),
('\r\n728', 'Khulna ', 'Jessore', 'Chaugachha', 'Chougachha', '7410', ''),
('\r\n729', 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Sadar', '7400', ''),
('\r\n730', 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Upa-Shahar', '7401', ''),
('\r\n731', 'Khulna ', 'Jessore', 'Jessore Sadar', 'Chanchra', '7402', ''),
('\r\n732', 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore canttonment', '7403', ''),
('\r\n733', 'Khulna ', 'Jessore', 'Jessore Sadar', 'Jessore Airbach', '7404', ''),
('\r\n734', 'Khulna ', 'Jessore', 'Jessore Sadar', 'Rupdia', '7405', ''),
('\r\n735', 'Khulna ', 'Jessore', 'Jessore Sadar', 'Basundia', '7406', ''),
('\r\n736', 'Khulna ', 'Jessore', 'Jessore Sadar', 'Churamankathi', '7407', ''),
('\r\n737', 'Khulna ', 'Jessore', 'Jhikargachha', 'Jhikargachha', '7420', ''),
('\r\n738', 'Khulna ', 'Jessore', 'Keshabpur', 'Keshobpur', '7450', ''),
('\r\n739', 'Khulna ', 'Jessore', 'Monirampur', 'Monirampur', '7440', ''),
('\r\n740', 'Khulna ', 'Jessore', 'Noapara', 'Noapara', '7460', ''),
('\r\n741', 'Khulna ', 'Jessore', 'Noapara', 'Rajghat', '7461', ''),
('\r\n742', 'Khulna ', 'Jessore', 'Noapara', 'Bhugilhat', '7462', ''),
('\r\n743', 'Khulna ', 'Jessore', 'Sarsa', 'Sarsa', '7430', ''),
('\r\n744', 'Khulna ', 'Jessore', 'Sarsa', 'Benapole', '7431', ''),
('\r\n745', 'Khulna ', 'Jessore', 'Sarsa', 'Jadabpur', '7432', ''),
('\r\n746', 'Khulna ', 'Jessore', 'Sarsa', 'Bag Achra', '7433', ''),
('\r\n747', 'Khulna ', 'Narail', 'Kalia', 'Kalia', '7520', ''),
('\r\n748', 'Khulna ', 'Narail', 'Laxmipasha', 'Laxmipasha', '7510', ''),
('\r\n749', 'Khulna ', 'Narail', 'Laxmipasha', 'Lohagora', '7511', ''),
('\r\n750', 'Khulna ', 'Narail', 'Laxmipasha', 'Itna', '7512', ''),
('\r\n751', 'Khulna ', 'Narail', 'Laxmipasha', 'Naldi', '7513', ''),
('\r\n752', 'Khulna ', 'Narail', 'Laxmipasha', 'Baradia', '7514', ''),
('\r\n753', 'Khulna ', 'Narail', 'Mohajan', 'Mohajan', '7521', ''),
('\r\n754', 'Khulna ', 'Narail', 'Narail Sadar', 'Narail Sadar', '7500', ''),
('\r\n755', 'Khulna ', 'Narail', 'Narail Sadar', 'Ratanganj', '7501', ''),
('\r\n756', 'Khulna ', 'Magura', 'Arpara', 'Arpara', '7620', ''),
('\r\n757', 'Khulna ', 'Magura', 'Magura Sadar', 'Magura Sadar', '7600', ''),
('\r\n758', 'Khulna ', 'Magura', 'Mohammadpur', 'Mohammadpur', '7630', ''),
('\r\n759', 'Khulna ', 'Magura', 'Mohammadpur', 'Binodpur', '7631', ''),
('\r\n760', 'Khulna ', 'Magura', 'Mohammadpur', 'Nahata', '7632', ''),
('\r\n761', 'Khulna ', 'Magura', 'Shripur', 'Shripur', '7610', ''),
('\r\n762', 'Khulna ', 'Magura', 'Shripur', 'Langalbadh', '7611', ''),
('\r\n763', 'Khulna ', 'Magura', 'Shripur', 'Nachol', '7612', ''),
('\r\n764', 'Khulna ', 'Khulna', 'Alaipur', 'Alaipur', '9240', ''),
('\r\n765', 'Khulna ', 'Khulna', 'Alaipur', 'Rupsha', '9241', ''),
('\r\n766', 'Khulna ', 'Khulna', 'Alaipur', 'Belphulia', '9242', ''),
('\r\n767', 'Khulna ', 'Khulna', 'Batiaghat', 'Batiaghat', '9260', ''),
('\r\n768', 'Khulna ', 'Khulna', 'Batiaghat', 'Surkalee', '9261', ''),
('\r\n769', 'Khulna ', 'Khulna', 'Chalna Bazar', 'Chalna Bazar', '9270', ''),
('\r\n770', 'Khulna ', 'Khulna', 'Chalna Bazar', 'Dakup', '9271', ''),
('\r\n771', 'Khulna ', 'Khulna', 'Chalna Bazar', 'Bajua', '9272', ''),
('\r\n772', 'Khulna ', 'Khulna', 'Chalna Bazar', 'Nalian', '9273', ''),
('\r\n773', 'Khulna ', 'Khulna', 'Digalia', 'Digalia', '9220', ''),
('\r\n774', 'Khulna ', 'Khulna', 'Digalia', 'Chandni Mahal', '9221', ''),
('\r\n775', 'Khulna ', 'Khulna', 'Digalia', 'Senhati', '9222', ''),
('\r\n776', 'Khulna ', 'Khulna', 'Digalia', 'Ghoshghati', '9223', ''),
('\r\n777', 'Khulna ', 'Khulna', 'Digalia', 'Gazirhat', '9224', ''),
('\r\n778', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna G.P.O', '9000', ''),
('\r\n779', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khula Sadar', '9100', ''),
('\r\n780', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna Shipyard', '9201', ''),
('\r\n781', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Doulatpur', '9202', ''),
('\r\n782', 'Khulna ', 'Khulna', 'Khulna Sadar', 'BIT Khulna', '9203', ''),
('\r\n783', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Siramani', '9204', ''),
('\r\n784', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Jahanabad Canttonmen', '9205', ''),
('\r\n785', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Sonali Jute Mills', '9206', ''),
('\r\n786', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Atra Shilpa Area', '9207', ''),
('\r\n787', 'Khulna ', 'Khulna', 'Khulna Sadar', 'Khulna University', '9208', ''),
('\r\n788', 'Khulna ', 'Khulna', 'Madinabad', 'Madinabad', '9290', ''),
('\r\n789', 'Khulna ', 'Khulna', 'Madinabad', 'Amadee', '9291', ''),
('\r\n790', 'Khulna ', 'Khulna', 'Paikgachha', 'Paikgachha', '9280', ''),
('\r\n791', 'Khulna ', 'Khulna', 'Paikgachha', 'Godaipur', '9281', ''),
('\r\n792', 'Khulna ', 'Khulna', 'Paikgachha', 'Kapilmoni', '9282', ''),
('\r\n793', 'Khulna ', 'Khulna', 'Paikgachha', 'Katipara', '9283', ''),
('\r\n794', 'Khulna ', 'Khulna', 'Paikgachha', 'Chandkhali', '9284', ''),
('\r\n795', 'Khulna ', 'Khulna', 'Paikgachha', 'Garaikhali', '9285', ''),
('\r\n796', 'Khulna ', 'Khulna', 'Phultala', 'Phultala', '9210', ''),
('\r\n797', 'Khulna ', 'Khulna', 'Sajiara', 'Sajiara', '9250', ''),
('\r\n798', 'Khulna ', 'Khulna', 'Sajiara', 'Ghonabanda', '9251', ''),
('\r\n799', 'Khulna ', 'Khulna', 'Sajiara', 'Chuknagar', '9252', ''),
('\r\n800', 'Khulna ', 'Khulna', 'Sajiara', 'Shahapur', '9253', ''),
('\r\n801', 'Khulna ', 'Khulna', 'Terakhada', 'Terakhada', '9230', ''),
('\r\n802', 'Khulna ', 'Khulna', 'Terakhada', 'Pak Barasat', '9231', ''),
('\r\n803', 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'Bagerhat Sadar', '9300', ''),
('\r\n804', 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'P.C College', '9301', ''),
('\r\n805', 'Khulna ', 'IBH WAs Here', 'Bagerhat Sadar', 'Rangdia', '9302', ''),
('\r\n806', 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Chalna Ankorage', '9350', ''),
('\r\n807', 'Khulna ', 'IBH WAs Here', 'Chalna Ankorage', 'Mongla Port', '9351', ''),
('\r\n808', 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Chitalmari', '9360', ''),
('\r\n809', 'Khulna ', 'IBH WAs Here', 'Chitalmari', 'Barabaria', '9361', ''),
('\r\n810', 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Fakirhat', '9370', ''),
('\r\n811', 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Mansa', '9371', ''),
('\r\n812', 'Khulna ', 'IBH WAs Here', 'Fakirhat', 'Bhanganpar Bazar', '9372', ''),
('\r\n813', 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Kachua', '9310', ''),
('\r\n814', 'Khulna ', 'IBH WAs Here', 'Kachua UPO', 'Sonarkola', '9311', ''),
('\r\n815', 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Mollahat', '9380', ''),
('\r\n816', 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Kahalpur', '9381', ''),
('\r\n817', 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Dariala', '9382', ''),
('\r\n818', 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Charkulia', '9383', ''),
('\r\n819', 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Nagarkandi', '9384', ''),
('\r\n820', 'Khulna ', 'IBH WAs Here', 'Mollahat', 'Pak Gangni', '9385', ''),
('\r\n821', 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Morelganj', '9320', ''),
('\r\n822', 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Sannasi Bazar', '9321', ''),
('\r\n823', 'Khulna ', 'IBH WAs Here', 'Morelganj', 'Telisatee', '9322', ''),
('\r\n824', 'Khulna ', 'IBH WAs Here', 'Rampal', 'Rampal', '9340', ''),
('\r\n825', 'Khulna ', 'IBH WAs Here', 'Rampal', 'Foylahat', '9341', ''),
('\r\n826', 'Khulna ', 'IBH WAs Here', 'Rampal', 'Sonatunia', '9342', ''),
('\r\n827', 'Khulna ', 'IBH WAs Here', 'Rampal', 'Gourambha', '9343', ''),
('\r\n828', 'Khulna ', 'IBH WAs Here', 'Rayenda', 'Rayenda', '9330', ''),
('\r\n829', 'Khulna ', 'Satkhira', 'Ashashuni', 'Ashashuni', '9460', ''),
('\r\n830', 'Khulna ', 'Satkhira', 'Ashashuni', 'Baradal', '9461', ''),
('\r\n831', 'Khulna ', 'Satkhira', 'Debbhata', 'Debbhata', '9430', ''),
('\r\n832', 'Khulna ', 'Satkhira', 'Debbhata', 'Gurugram', '9431', ''),
('\r\n833', 'Khulna ', 'Satkhira', 'kalaroa', 'kalaroa', '9410', ''),
('\r\n834', 'Khulna ', 'Satkhira', 'kalaroa', 'Murarikati', '9411', ''),
('\r\n835', 'Khulna ', 'Satkhira', 'kalaroa', 'Jhaudanga', '9412', ''),
('\r\n836', 'Khulna ', 'Satkhira', 'kalaroa', 'Hamidpur', '9413', ''),
('\r\n837', 'Khulna ', 'Satkhira', 'kalaroa', 'Khordo', '9414', ''),
('\r\n838', 'Khulna ', 'Satkhira', 'kalaroa', 'Chandanpur', '9415', ''),
('\r\n839', 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Kaliganj UPO', '9440', ''),
('\r\n840', 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Nalta Mubaroknagar', '9441', ''),
('\r\n841', 'Khulna ', 'Satkhira', 'Kaliganj UPO', 'Ratanpur', '9442', ''),
('\r\n842', 'Khulna ', 'Satkhira', 'Nakipur', 'Nakipur', '9450', ''),
('\r\n843', 'Khulna ', 'Satkhira', 'Nakipur', 'Noornagar', '9451', ''),
('\r\n844', 'Khulna ', 'Satkhira', 'Nakipur', 'Naobeki', '9452', ''),
('\r\n845', 'Khulna ', 'Satkhira', 'Nakipur', 'Buri Goalini', '9453', ''),
('\r\n846', 'Khulna ', 'Satkhira', 'Nakipur', 'Gabura', '9454', ''),
('\r\n847', 'Khulna ', 'Satkhira', 'Nakipur', 'Habinagar', '9455', ''),
('\r\n848', 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Sadar', '9400', ''),
('\r\n849', 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Satkhira Islamia Acc', '9401', ''),
('\r\n850', 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Gunakar kati', '9402', ''),
('\r\n851', 'Khulna ', 'Satkhira', 'Satkhira Sadar', 'Budhhat', '9403', ''),
('\r\n852', 'Khulna ', 'Satkhira', 'Taala', 'Taala', '9420', ''),
('\r\n853', 'Khulna ', 'Satkhira', 'Taala', 'Patkelghata', '9421', ''),
('\r\n854', 'Sylhet ', 'Sunamganj', 'Bishamsarpur', 'Bishamsapur', '3010', ''),
('\r\n855', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak', '3080', ''),
('\r\n856', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Cement Facto', '3081', ''),
('\r\n857', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chhatak Paper Mills', '3082', ''),
('\r\n858', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj', '3083', ''),
('\r\n859', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Gabindaganj Natun Ba', '3084', ''),
('\r\n860', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Khurma', '3085', ''),
('\r\n861', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Moinpur', '3086', ''),
('\r\n862', 'Sylhet ', 'Sunamganj', 'Chhatak', 'jahidpur', '3087', ''),
('\r\n863', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Islamabad', '3088', ''),
('\r\n864', 'Sylhet ', 'Sunamganj', 'Chhatak', 'Chourangi Bazar', '3893', ''),
('\r\n865', 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Dhirai Chandpur', '3040', ''),
('\r\n866', 'Sylhet ', 'Sunamganj', 'Dhirai Chandpur', 'Jagdal', '3041', ''),
('\r\n867', 'Sylhet ', 'Sunamganj', 'Duara bazar', 'Duara bazar', '3070', ''),
('\r\n868', 'Sylhet ', 'Sunamganj', 'Ghungiar', 'Ghungiar', '3050', ''),
('\r\n869', 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Jagnnathpur', '3060', ''),
('\r\n870', 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Syedpur', '3061', ''),
('\r\n871', 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Atuajan', '3062', ''),
('\r\n872', 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Hasan Fatemapur', '3063', ''),
('\r\n873', 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Rasulganj', '3064', ''),
('\r\n874', 'Sylhet ', 'Sunamganj', 'Jagnnathpur', 'Shiramsi', '3065', ''),
('\r\n875', 'Sylhet ', 'Sunamganj', 'Sachna', 'Sachna', '3020', ''),
('\r\n876', 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Sunamganj Sadar', '3000', ''),
('\r\n877', 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Pagla', '3001', ''),
('\r\n878', 'Sylhet ', 'Sunamganj', 'Sunamganj Sadar', 'Patharia', '3002', ''),
('\r\n879', 'Sylhet ', 'Sunamganj', 'Tahirpur', 'Tahirpur', '3030', ''),
('\r\n880', 'Sylhet ', 'Sylhet', 'Balaganj', 'Balaganj', '3120', ''),
('\r\n881', 'Sylhet ', 'Sylhet', 'Balaganj', 'Karua', '3121', ''),
('\r\n882', 'Sylhet ', 'Sylhet', 'Balaganj', 'Brahman Shashon', '3122', ''),
('\r\n883', 'Sylhet ', 'Sylhet', 'Balaganj', 'Tajpur', '3123', ''),
('\r\n884', 'Sylhet ', 'Sylhet', 'Balaganj', 'Goala Bazar', '3124', ''),
('\r\n885', 'Sylhet ', 'Sylhet', 'Balaganj', 'Begumpur', '3125', ''),
('\r\n886', 'Sylhet ', 'Sylhet', 'Balaganj', 'Omarpur', '3126', ''),
('\r\n887', 'Sylhet ', 'Sylhet', 'Balaganj', 'Kathal Khair', '3127', ''),
('\r\n888', 'Sylhet ', 'Sylhet', 'Balaganj', 'Gaharpur', '3128', ''),
('\r\n889', 'Sylhet ', 'Sylhet', 'Balaganj', 'Natun Bazar', '3129', ''),
('\r\n890', 'Sylhet ', 'Sylhet', 'Bianibazar', 'Bianibazar', '3170', ''),
('\r\n891', 'Sylhet ', 'Sylhet', 'Bianibazar', 'jaldup', '3171', ''),
('\r\n892', 'Sylhet ', 'Sylhet', 'Bianibazar', 'Mathiura', '3172', ''),
('\r\n893', 'Sylhet ', 'Sylhet', 'Bianibazar', 'Kurar bazar', '3173', ''),
('\r\n894', 'Sylhet ', 'Sylhet', 'Bianibazar', 'Salia bazar', '3174', ''),
('\r\n895', 'Sylhet ', 'Sylhet', 'Bianibazar', 'Churkai', '3175', ''),
('\r\n896', 'Sylhet ', 'Sylhet', 'Bishwanath', 'Bishwanath', '3130', ''),
('\r\n897', 'Sylhet ', 'Sylhet', 'Bishwanath', 'Dashghar', '3131', ''),
('\r\n898', 'Sylhet ', 'Sylhet', 'Bishwanath', 'Doulathpur', '3132', ''),
('\r\n899', 'Sylhet ', 'Sylhet', 'Bishwanath', 'Deokalas', '3133', ''),
('\r\n900', 'Sylhet ', 'Sylhet', 'Bishwanath', 'Singer kanch', '3134', ''),
('\r\n901', 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj', '3116', ''),
('\r\n902', 'Sylhet ', 'Sylhet', 'Fenchuganj', 'Fenchuganj SareKarkh', '3117', ''),
('\r\n903', 'Sylhet ', 'Sylhet', 'Goainhat', 'Goainhat', '3150', ''),
('\r\n904', 'Sylhet ', 'Sylhet', 'Goainhat', 'Jaflong', '3151', ''),
('\r\n905', 'Sylhet ', 'Sylhet', 'Goainhat', 'Chiknagul', '3152', ''),
('\r\n906', 'Sylhet ', 'Sylhet', 'Gopalganj', 'Gopalgannj', '3160', ''),
('\r\n907', 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dhaka Dakkhin', '3161', ''),
('\r\n908', 'Sylhet ', 'Sylhet', 'Gopalganj', 'Dakkhin Bhadashore', '3162', ''),
('\r\n909', 'Sylhet ', 'Sylhet', 'Gopalganj', 'Ranaping', '3163', ''),
('\r\n910', 'Sylhet ', 'Sylhet', 'Gopalganj', 'banigram', '3164', ''),
('\r\n911', 'Sylhet ', 'Sylhet', 'Gopalganj', 'Chandanpur', '3165', ''),
('\r\n912', 'Sylhet ', 'Sylhet', 'Jaintapur', 'Jainthapur', '3156', ''),
('\r\n913', 'Sylhet ', 'Sylhet', 'Jakiganj', 'Jakiganj', '3190', ''),
('\r\n914', 'Sylhet ', 'Sylhet', 'Jakiganj', 'Ichhamati', '3191', ''),
('\r\n915', 'Sylhet ', 'Sylhet', 'Kanaighat', 'Kanaighat', '3180', ''),
('\r\n916', 'Sylhet ', 'Sylhet', 'Kanaighat', 'Chatulbazar', '3181', ''),
('\r\n917', 'Sylhet ', 'Sylhet', 'Kanaighat', 'Manikganj', '3182', ''),
('\r\n918', 'Sylhet ', 'Sylhet', 'Kanaighat', 'Gachbari', '3183', ''),
('\r\n919', 'Sylhet ', 'Sylhet', 'Kompanyganj', 'Kompanyganj', '3140', ''),
('\r\n920', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhe Sadar', '3100', ''),
('\r\n921', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Cadet Col', '3101', ''),
('\r\n922', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Sylhet Biman Bondar', '3102', ''),
('\r\n923', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Khadimnagar', '3103', ''),
('\r\n924', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad Cantoment', '3104', ''),
('\r\n925', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Silam', '3105', ''),
('\r\n926', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Birahimpur', '3106', ''),
('\r\n927', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Jalalabad', '3107', ''),
('\r\n928', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Mogla', '3108', ''),
('\r\n929', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Ranga Hajiganj', '3109', ''),
('\r\n930', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kadamtali', '3111', ''),
('\r\n931', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Kamalbazer', '3112', ''),
('\r\n932', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Lalbazar', '3113', ''),
('\r\n933', 'Sylhet ', 'Sylhet', 'Sylhet Sadar', 'Shahajalal Science &', '3114', ''),
('\r\n934', 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Baralekha', '3250', ''),
('\r\n935', 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Juri', '3251', ''),
('\r\n936', 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Dhakkhinbag', '3252', ''),
('\r\n937', 'Sylhet ', 'Moulvibazar', 'Baralekha', 'Purbashahabajpur', '3253', ''),
('\r\n938', 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Kamalganj', '3220', ''),
('\r\n939', 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Keramatnaga', '3221', ''),
('\r\n940', 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Patrakhola', '3222', ''),
('\r\n941', 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Shamsher Nagar', '3223', ''),
('\r\n942', 'Sylhet ', 'Moulvibazar', 'Kamalganj', 'Munshibazar', '3224', ''),
('\r\n943', 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Kulaura', '3230', ''),
('\r\n944', 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Tillagaon', '3231', ''),
('\r\n945', 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Langla', '3232', ''),
('\r\n946', 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Prithimpasha', '3233', ''),
('\r\n947', 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Kajaldhara', '3234', ''),
('\r\n948', 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Karimpur', '3235', ''),
('\r\n949', 'Sylhet ', 'Moulvibazar', 'Kulaura', 'Baramchal', '3237', ''),
('\r\n950', 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Moulvibazar Sadar', '3200', ''),
('\r\n951', 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Barakapan', '3201', ''),
('\r\n952', 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Monumukh', '3202', ''),
('\r\n953', 'Sylhet ', 'Moulvibazar', 'Moulvibazar Sadar', 'Afrozganj', '3203', ''),
('\r\n954', 'Sylhet ', 'Moulvibazar', 'Rajnagar', 'Rajnagar', '3240', ''),
('\r\n955', 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Srimangal', '3210', ''),
('\r\n956', 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Narain Chora', '3211', ''),
('\r\n957', 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Kalighat', '3212', ''),
('\r\n958', 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Khejurichhara', '3213', ''),
('\r\n959', 'Sylhet ', 'Moulvibazar', 'Srimangal', 'Satgaon', '3214', ''),
('\r\n960', 'Sylhet ', 'Hobiganj', 'Azmireeganj', 'Azmireeganj', '3360', ''),
('\r\n961', 'Sylhet ', 'Hobiganj', 'Bahubal', 'Bahubal', '3310', ''),
('\r\n962', 'Sylhet ', 'Hobiganj', 'Baniachang', 'Baniachang', '3350', ''),
('\r\n963', 'Sylhet ', 'Hobiganj', 'Baniachang', 'Jatrapasha', '3351', ''),
('\r\n964', 'Sylhet ', 'Hobiganj', 'Baniachang', 'Kadirganj', '3352', ''),
('\r\n965', 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chunarughat', '3320', ''),
('\r\n966', 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Chandpurbagan', '3321', ''),
('\r\n967', 'Sylhet ', 'Hobiganj', 'Chunarughat', 'Narapati', '3322', ''),
('\r\n968', 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Hobiganj Sadar', '3300', ''),
('\r\n969', 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Shaestaganj', '3301', ''),
('\r\n970', 'Sylhet ', 'Hobiganj', 'Hobiganj Sadar', 'Gopaya', '3302', ''),
('\r\n971', 'Sylhet ', 'Hobiganj', 'Kalauk', 'Kalauk', '3340', ''),
('\r\n972', 'Sylhet ', 'Hobiganj', 'Kalauk', 'Lakhai', '3341', ''),
('\r\n973', 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Madhabpur', '3330', ''),
('\r\n974', 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Itakhola', '3331', ''),
('\r\n975', 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Shahajibazar', '3332', ''),
('\r\n976', 'Sylhet ', 'Hobiganj', 'Madhabpur', 'Saihamnagar', '3333', ''),
('\r\n977', 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Nabiganj', '3370', ''),
('\r\n978', 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Goplarbazar', '3371', ''),
('\r\n979', 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Golduba', '3372', ''),
('\r\n980', 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Digalbak', '3373', ''),
('\r\n981', 'Sylhet ', 'Hobiganj', 'Nabiganj', 'Inathganj', '3374', ''),
('\r\n982', 'Barisal ', 'Barishal', 'Agailzhara', 'Agailzhara', '8240', ''),
('\r\n983', 'Barisal ', 'Barishal', 'Agailzhara', 'Gaila', '8241', ''),
('\r\n984', 'Barisal ', 'Barishal', 'Agailzhara', 'Paisarhat', '8242', ''),
('\r\n985', 'Barisal ', 'Barishal', 'Babuganj', 'Babuganj', '8210', ''),
('\r\n986', 'Barisal ', 'Barishal', 'Babuganj', 'Rahamatpur', '8211', ''),
('\r\n987', 'Barisal ', 'Barishal', 'Babuganj', 'Chandpasha', '8212', ''),
('\r\n988', 'Barisal ', 'Barishal', 'Babuganj', 'Madhabpasha', '8213', ''),
('\r\n989', 'Barisal ', 'Barishal', 'Babuganj', 'Thakur Mallik', '8214', ''),
('\r\n990', 'Barisal ', 'Barishal', 'Babuganj', 'Nizamuddin College', '8215', ''),
('\r\n991', 'Barisal ', 'Barishal', 'Babuganj', 'Barishal Cadet', '8216', ''),
('\r\n992', 'Barisal ', 'Barishal', 'Barajalia', 'Barajalia', '8260', ''),
('\r\n993', 'Barisal ', 'Barishal', 'Barajalia', 'Osman Manjil', '8261', ''),
('\r\n994', 'Barisal ', 'Barishal', 'Barishal Sadar', 'Barishal Sadar', '8200', ''),
('\r\n995', 'Barisal ', 'Barishal', 'Barishal Sadar', 'Bukhainagar', '8201', ''),
('\r\n996', 'Barisal ', 'Barishal', 'Barishal Sadar', 'Saheberhat', '8202', ''),
('\r\n997', 'Barisal ', 'Barishal', 'Barishal Sadar', 'Sugandia', '8203', ''),
('\r\n998', 'Barisal ', 'Barishal', 'Barishal Sadar', 'Patang', '8204', ''),
('\r\n999', 'Barisal ', 'Barishal', 'Barishal Sadar', 'Kashipur', '8205', ''),
('\r\n1000', 'Barisal ', 'Barishal', 'Barishal Sadar', 'Jaguarhat', '8206', ''),
('\r\n1001', 'Barisal ', 'Barishal', 'Gouranadi', 'Gouranadi', '8230', ''),
('\r\n1002', 'Barisal ', 'Barishal', 'Gouranadi', 'Tarki Bandar', '8231', ''),
('\r\n1003', 'Barisal ', 'Barishal', 'Gouranadi', 'Kashemabad', '8232', ''),
('\r\n1004', 'Barisal ', 'Barishal', 'Gouranadi', 'Batajor', '8233', ''),
('\r\n1005', 'Barisal ', 'Barishal', 'Mahendiganj', 'Mahendiganj', '8270', ''),
('\r\n1006', 'Barisal ', 'Barishal', 'Mahendiganj', 'Laskarpur', '8271', ''),
('\r\n1007', 'Barisal ', 'Barishal', 'Mahendiganj', 'Ulania', '8272', ''),
('\r\n1008', 'Barisal ', 'Barishal', 'Mahendiganj', 'Nalgora', '8273', ''),
('\r\n1009', 'Barisal ', 'Barishal', 'Mahendiganj', 'Langutia', '8274', ''),
('\r\n1010', 'Barisal ', 'Barishal', 'Muladi', 'Muladi', '8250', ''),
('\r\n1011', 'Barisal ', 'Barishal', 'Muladi', 'Kazirchar', '8251', ''),
('\r\n1012', 'Barisal ', 'Barishal', 'Muladi', 'Charkalekhan', '8252', ''),
('\r\n1013', 'Barisal ', 'Barishal', 'Sahebganj', 'Sahebganj', '8280', ''),
('\r\n1014', 'Barisal ', 'Barishal', 'Sahebganj', 'Charamandi', '8281', ''),
('\r\n1015', 'Barisal ', 'Barishal', 'Sahebganj', 'Padri Shibpur', '8282', ''),
('\r\n1016', 'Barisal ', 'Barishal', 'Sahebganj', 'Shialguni', '8283', ''),
('\r\n1017', 'Barisal ', 'Barishal', 'Sahebganj', 'kalaskati', '8284', ''),
('\r\n1018', 'Barisal ', 'Barishal', 'Uzirpur', 'Uzirpur', '8220', ''),
('\r\n1019', 'Barisal ', 'Barishal', 'Uzirpur', 'Dhamura', '8221', ''),
('\r\n1020', 'Barisal ', 'Barishal', 'Uzirpur', 'Jugirkanda', '8222', ''),
('\r\n1021', 'Barisal ', 'Barishal', 'Uzirpur', 'Dakuarhat', '8223', ''),
('\r\n1022', 'Barisal ', 'Barishal', 'Uzirpur', 'Shikarpur', '8224', ''),
('\r\n1023', 'Barisal ', 'Bhola', 'Bhola Sadar', 'Bhola Sadar', '8300', ''),
('\r\n1024', 'Barisal ', 'Bhola', 'Bhola Sadar', 'Joynagar', '8301', ''),
('\r\n1025', 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Borhanuddin UPO', '8320', ''),
('\r\n1026', 'Barisal ', 'Bhola', 'Borhanuddin UPO', 'Mirzakalu', '8321', ''),
('\r\n1027', 'Barisal ', 'Bhola', 'Charfashion', 'Charfashion', '8340', ''),
('\r\n1028', 'Barisal ', 'Bhola', 'Charfashion', 'Dularhat', '8341', ''),
('\r\n1029', 'Barisal ', 'Bhola', 'Charfashion', 'Keramatganj', '8342', ''),
('\r\n1030', 'Barisal ', 'Bhola', 'Doulatkhan', 'Doulatkhan', '8310', ''),
('\r\n1031', 'Barisal ', 'Bhola', 'Doulatkhan', 'Hajipur', '8311', ''),
('\r\n1032', 'Barisal ', 'Bhola', 'Hajirhat', 'Hajirhat', '8360', ''),
('\r\n1033', 'Barisal ', 'Bhola', 'Hatshoshiganj', 'Hatshoshiganj', '8350', ''),
('\r\n1034', 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Lalmohan UPO', '8330', ''),
('\r\n1035', 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Daurihat', '8331', ''),
('\r\n1036', 'Barisal ', 'Bhola', 'Lalmohan UPO', 'Gazaria', '8332', ''),
('\r\n1037', 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Jhalokathi Sadar', '8400', ''),
('\r\n1038', 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Nabagram', '8401', ''),
('\r\n1039', 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Baukathi', '8402', ''),
('\r\n1040', 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Gabha', '8403', ''),
('\r\n1041', 'Barisal ', 'Jhalokathi', 'Jhalokathi Sadar', 'Shekherhat', '8404', ''),
('\r\n1042', 'Barisal ', 'Jhalokathi', 'Kathalia', 'Kathalia', '8430', ''),
('\r\n1043', 'Barisal ', 'Jhalokathi', 'Kathalia', 'Amua', '8431', ''),
('\r\n1044', 'Barisal ', 'Jhalokathi', 'Kathalia', 'Niamatee', '8432', ''),
('\r\n1045', 'Barisal ', 'Jhalokathi', 'Kathalia', 'Shoulajalia', '8433', ''),
('\r\n1046', 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Nalchhiti', '8420', ''),
('\r\n1047', 'Barisal ', 'Jhalokathi', 'Nalchhiti', 'Beerkathi', '8421', ''),
('\r\n1048', 'Barisal ', 'Jhalokathi', 'Rajapur', 'Rajapur', '8410', ''),
('\r\n1049', 'Barisal ', 'Pirojpur', 'Banaripara', 'Banaripara', '8530', ''),
('\r\n1050', 'Barisal ', 'Pirojpur', 'Banaripara', 'Chakhar', '8531', ''),
('\r\n1051', 'Barisal ', 'Pirojpur', 'Bhandaria', 'Bhandaria', '8550', ''),
('\r\n1052', 'Barisal ', 'Pirojpur', 'Bhandaria', 'Kanudashkathi', '8551', ''),
('\r\n1053', 'Barisal ', 'Pirojpur', 'Bhandaria', 'Dhaoa', '8552', ''),
('\r\n1054', 'Barisal ', 'Pirojpur', 'kaukhali', 'Kaukhali', '8510', ''),
('\r\n1055', 'Barisal ', 'Pirojpur', 'kaukhali', 'Keundia', '8511', ''),
('\r\n1056', 'Barisal ', 'Pirojpur', 'kaukhali', 'Joykul', '8512', ''),
('\r\n1057', 'Barisal ', 'Pirojpur', 'kaukhali', 'Jolagati', '8513', ''),
('\r\n1058', 'Barisal ', 'Pirojpur', 'Mathbaria', 'Mathbaria', '8560', ''),
('\r\n1059', 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tushkhali', '8561', ''),
('\r\n1060', 'Barisal ', 'Pirojpur', 'Mathbaria', 'Halta', '8562', ''),
('\r\n1061', 'Barisal ', 'Pirojpur', 'Mathbaria', 'Gulishakhali', '8563', ''),
('\r\n1062', 'Barisal ', 'Pirojpur', 'Mathbaria', 'Tiarkhali', '8564', ''),
('\r\n1063', 'Barisal ', 'Pirojpur', 'Mathbaria', 'Betmor Natun Hat', '8565', ''),
('\r\n1064', 'Barisal ', 'Pirojpur', 'Mathbaria', 'Shilarganj', '8566', ''),
('\r\n1065', 'Barisal ', 'Pirojpur', 'Nazirpur', 'Nazirpur', '8540', ''),
('\r\n1066', 'Barisal ', 'Pirojpur', 'Nazirpur', 'Sriramkathi', '8541', ''),
('\r\n1067', 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Pirojpur Sadar', '8500', ''),
('\r\n1068', 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Hularhat', '8501', ''),
('\r\n1069', 'Barisal ', 'Pirojpur', 'Pirojpur Sadar', 'Parerhat', '8502', ''),
('\r\n1070', 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Swarupkathi', '8520', ''),
('\r\n1071', 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Darus Sunnat', '8521', ''),
('\r\n1072', 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Kaurikhara', '8522', ''),
('\r\n1073', 'Barisal ', 'Pirojpur', 'Swarupkathi', 'Jalabari', '8523', ''),
('\r\n1074', 'Barisal ', 'Patuakhali', 'Bauphal', 'Bauphal', '8620', ''),
('\r\n1075', 'Barisal ', 'Patuakhali', 'Bauphal', 'Bagabandar', '8621', ''),
('\r\n1076', 'Barisal ', 'Patuakhali', 'Bauphal', 'Birpasha', '8622', ''),
('\r\n1077', 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalishari', '8623', ''),
('\r\n1078', 'Barisal ', 'Patuakhali', 'Bauphal', 'Kalaia', '8624', ''),
('\r\n1079', 'Barisal ', 'Patuakhali', 'Dashmina', 'Dashmina', '8630', ''),
('\r\n1080', 'Barisal ', 'Patuakhali', 'Galachipa', 'Galachipa', '8640', ''),
('\r\n1081', 'Barisal ', 'Patuakhali', 'Galachipa', 'Gazipur Bandar', '8641', ''),
('\r\n1082', 'Barisal ', 'Patuakhali', 'Khepupara', 'Khepupara', '8650', ''),
('\r\n1083', 'Barisal ', 'Patuakhali', 'Khepupara', 'Mahipur', '8651', ''),
('\r\n1084', 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Patuakhali Sadar', '8600', ''),
('\r\n1085', 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Moukaran', '8601', ''),
('\r\n1086', 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Dumkee', '8602', ''),
('\r\n1087', 'Barisal ', 'Patuakhali', 'Patuakhali Sadar', 'Rahimabad', '8603', ''),
('\r\n1088', 'Barisal ', 'Patuakhali', 'Subidkhali', 'Subidkhali', '8610', ''),
('\r\n1089', 'Barisal ', 'Barguna', 'Amtali', 'Amtali', '8710', ''),
('\r\n1090', 'Barisal ', 'Barguna', 'Bamna', 'Bamna', '8730', ''),
('\r\n1091', 'Barisal ', 'Barguna', 'Barguna Sadar', 'Barguna Sadar', '8700', ''),
('\r\n1092', 'Barisal ', 'Barguna', 'Barguna Sadar', 'Nali Bandar', '8701', ''),
('\r\n1093', 'Barisal ', 'Barguna', 'Betagi', 'Betagi', '8740', ''),
('\r\n1094', 'Barisal ', 'Barguna', 'Betagi', 'Darul Ulam', '8741', ''),
('\r\n1095', 'Barisal ', 'Barguna', 'Patharghata', 'Patharghata', '8720', ''),
('\r\n1096', 'Barisal ', 'Barguna', 'Patharghata', 'Kakchira', '8721', ''),
('\r\n1097', 'Rajshahi ', 'Panchagarh', 'Boda', 'Boda', '5010', ''),
('\r\n1098', 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Chotto Dab', '5040', ''),
('\r\n1099', 'Rajshahi ', 'Panchagarh', 'Chotto Dab', 'Mirjapur', '5041', ''),
('\r\n1100', 'Rajshahi ', 'Panchagarh', 'Dabiganj', 'Dabiganj', '5020', ''),
('\r\n1101', 'Rajshahi ', 'Panchagarh', 'Panchagra Sadar', 'Panchagar Sadar', '5000', ''),
('\r\n1102', 'Rajshahi ', 'Panchagarh', 'Tetulia', 'Tetulia', '5030', ''),
('\r\n1103', 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Baliadangi', '5140', ''),
('\r\n1104', 'Rajshahi ', 'Thakurgaon', 'Baliadangi', 'Lahiri', '5141', ''),
('\r\n1105', 'Rajshahi ', 'Thakurgaon', 'Jibanpur', 'Jibanpur', '5130', ''),
('\r\n1106', 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', '5110', ''),
('\r\n1107', 'Rajshahi ', 'Thakurgaon', 'Pirganj', 'Pirganj', '5470', ''),
('\r\n1108', 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Rani Sankail', '5120', ''),
('\r\n1109', 'Rajshahi ', 'Thakurgaon', 'Rani Sankail', 'Nekmarad', '5121', ''),
('\r\n1110', 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Sadar', '5100', ''),
('\r\n1111', 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Thakurgaon Road', '5101', ''),
('\r\n1112', 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Shibganj', '5102', ''),
('\r\n1113', 'Rajshahi ', 'Thakurgaon', 'Thakurgaon Sadar', 'Ruhia', '5103', ''),
('\r\n1114', 'Rajshahi ', 'Dinajpur', 'Bangla Hili', 'Bangla Hili', '5270', ''),
('\r\n1115', 'Rajshahi ', 'Dinajpur', 'Biral', 'Biral', '5210', ''),
('\r\n1116', 'Rajshahi ', 'Dinajpur', 'Birampur', 'Birampur', '5266', ''),
('\r\n1117', 'Rajshahi ', 'Dinajpur', 'Birganj', 'Birganj', '5220', ''),
('\r\n1118', 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Chrirbandar', '5240', ''),
('\r\n1119', 'Rajshahi ', 'Dinajpur', 'Chrirbandar', 'Ranirbandar', '5241', ''),
('\r\n1120', 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Sadar', '5200', ''),
('\r\n1121', 'Rajshahi ', 'Dinajpur', 'Dinajpur Sadar', 'Dinajpur Rajbari', '5201', ''),
('\r\n1122', 'Rajshahi ', 'Dinajpur', 'Khansama', 'Khansama', '5230', ''),
('\r\n1123', 'Rajshahi ', 'Dinajpur', 'Khansama', 'Pakarhat', '5231', ''),
('\r\n1124', 'Rajshahi ', 'Dinajpur', 'Maharajganj', 'Maharajganj', '5226', ''),
('\r\n1125', 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Nababganj', '5280', ''),
('\r\n1126', 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Daudpur', '5281', ''),
('\r\n1127', 'Rajshahi ', 'Dinajpur', 'Nababganj', 'Gopalpur', '5282', ''),
('\r\n1128', 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Osmanpur', '5290', ''),
('\r\n1129', 'Rajshahi ', 'Dinajpur', 'Osmanpur', 'Ghoraghat', '5291', ''),
('\r\n1130', 'Rajshahi ', 'Dinajpur', 'Parbatipur', 'Parbatipur', '5250', ''),
('\r\n1131', 'Rajshahi ', 'Dinajpur', 'Phulbari', 'Phulbari', '5260', ''),
('\r\n1132', 'Rajshahi ', 'Dinajpur', 'Setabganj', 'Setabganj', '5216', ''),
('\r\n1133', 'Rajshahi ', 'Nilphamari', 'Dimla', 'Dimla', '5350', ''),
('\r\n1134', 'Rajshahi ', 'Nilphamari', 'Dimla', 'Ghaga Kharibari', '5351', ''),
('\r\n1135', 'Rajshahi ', 'Nilphamari', 'Domar', 'Domar', '5340', ''),
('\r\n1136', 'Rajshahi ', 'Nilphamari', 'Domar', 'Chilahati', '5341', ''),
('\r\n1137', 'Rajshahi ', 'Nilphamari', 'Jaldhaka', 'Jaldhaka', '5330', ''),
('\r\n1138', 'Rajshahi ', 'Nilphamari', 'Kishoriganj', 'Kishoriganj', '5320', ''),
('\r\n1139', 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sadar', '5300', ''),
('\r\n1140', 'Rajshahi ', 'Nilphamari', 'Nilphamari Sadar', 'Nilphamari Sugar Mil', '5301', ''),
('\r\n1141', 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur', '5310', ''),
('\r\n1142', 'Rajshahi ', 'Nilphamari', 'Syedpur', 'Syedpur Upashahar', '5311', ''),
('\r\n1143', 'Rajshahi ', 'Rangpur', 'Badarganj', 'Badarganj', '5430', ''),
('\r\n1144', 'Rajshahi ', 'Rangpur', 'Badarganj', 'Shyampur', '5431', ''),
('\r\n1145', 'Rajshahi ', 'Rangpur', 'Gangachara', 'Gangachara', '5410', ''),
('\r\n1146', 'Rajshahi ', 'Rangpur', 'Kaunia', 'Kaunia', '5440', ''),
('\r\n1147', 'Rajshahi ', 'Rangpur', 'Kaunia', 'Haragachh', '5441', ''),
('\r\n1148', 'Rajshahi ', 'Rangpur', 'Mithapukur', 'Mithapukur', '5460', ''),
('\r\n1149', 'Rajshahi ', 'Rangpur', 'Pirgachha', 'Pirgachha', '5450', ''),
('\r\n1150', 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Sadar', '5400', ''),
('\r\n1151', 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Upa-Shahar', '5401', ''),
('\r\n1152', 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Alamnagar', '5402', ''),
('\r\n1153', 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Mahiganj', '5403', ''),
('\r\n1154', 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Cadet Colleg', '5404', ''),
('\r\n1155', 'Rajshahi ', 'Rangpur', 'Rangpur Sadar', 'Rangpur Carmiecal Col', '5405', ''),
('\r\n1156', 'Rajshahi ', 'Rangpur', 'Taraganj', 'Taraganj', '5420', ''),
('\r\n1157', 'Rajshahi ', 'Lalmonirhat', 'Aditmari', 'Aditmari', '5510', ''),
('\r\n1158', 'Rajshahi ', 'Lalmonirhat', 'Hatibandha', 'Hatibandha', '5530', ''),
('\r\n1159', 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Lalmonirhat Sadar', '5500', ''),
('\r\n1160', 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Moghalhat', '5501', ''),
('\r\n1161', 'Rajshahi ', 'Lalmonirhat', 'Lalmonirhat Sadar', 'Kulaghat SO', '5502', ''),
('\r\n1162', 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Patgram', '5540', ''),
('\r\n1163', 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Baura', '5541', ''),
('\r\n1164', 'Rajshahi ', 'Lalmonirhat', 'Patgram', 'Burimari', '5542', ''),
('\r\n1165', 'Rajshahi ', 'Lalmonirhat', 'Tushbhandar', 'Tushbhandar', '5520', ''),
('\r\n1166', 'Rajshahi ', 'Kurigram', 'Bhurungamari', 'Bhurungamari', '5670', ''),
('\r\n1167', 'Rajshahi ', 'Kurigram', 'Chilmari', 'Chilmari', '5630', ''),
('\r\n1168', 'Rajshahi ', 'Kurigram', 'Chilmari', 'Jorgachh', '5631', ''),
('\r\n1169', 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Kurigram Sadar', '5600', ''),
('\r\n1170', 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Pandul', '5601', ''),
('\r\n1171', 'Rajshahi ', 'Kurigram', 'Kurigram Sadar', 'Phulbari', '5680', ''),
('\r\n1172', 'Rajshahi ', 'Kurigram', 'Nageshwar', 'Nageshwar', '5660', ''),
('\r\n1173', 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Rajarhat', '5610', ''),
('\r\n1174', 'Rajshahi ', 'Kurigram', 'Rajarhat', 'Nazimkhan', '5611', ''),
('\r\n1175', 'Rajshahi ', 'Kurigram', 'Rajibpur', 'Rajibpur', '5650', ''),
('\r\n1176', 'Rajshahi ', 'Kurigram', 'Roumari', 'Roumari', '5640', ''),
('\r\n1177', 'Rajshahi ', 'Kurigram', 'Ulipur', 'Ulipur', '5620', ''),
('\r\n1178', 'Rajshahi ', 'Kurigram', 'Ulipur', 'Bazarhat', '5621', ''),
('\r\n1179', 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'Bonarpara', '5750', ''),
('\r\n1180', 'Rajshahi ', 'Gaibandha', 'Bonarpara', 'saghata', '5751', ''),
('\r\n1181', 'Rajshahi ', 'Gaibandha', 'Gaibandha Sadar', 'Gaibandha Sadar', '5700', ''),
('\r\n1182', 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Gobindhaganj', '5740', ''),
('\r\n1183', 'Rajshahi ', 'Gaibandha', 'Gobindaganj', 'Mahimaganj', '5741', ''),
('\r\n1184', 'Rajshahi ', 'Gaibandha', 'Palashbari', 'Palashbari', '5730', ''),
('\r\n1185', 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Phulchhari', '5760', ''),
('\r\n1186', 'Rajshahi ', 'Gaibandha', 'Phulchhari', 'Bharatkhali', '5761', ''),
('\r\n1187', 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Saadullapur', '5710', ''),
('\r\n1188', 'Rajshahi ', 'Gaibandha', 'Saadullapur', 'Naldanga', '5711', ''),
('\r\n1189', 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Sundarganj', '5720', ''),
('\r\n1190', 'Rajshahi ', 'Gaibandha', 'Sundarganj', 'Bamandanga', '5721', ''),
('\r\n1191', 'Rajshahi ', 'Bogra', 'Alamdighi', 'Adamdighi', '5890', ''),
('\r\n1192', 'Rajshahi ', 'Bogra', 'Alamdighi', 'Santahar', '5891', ''),
('\r\n1193', 'Rajshahi ', 'Bogra', 'Alamdighi', 'Nasharatpur', '5892', ''),
('\r\n1194', 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Sadar', '5800', ''),
('\r\n1195', 'Rajshahi ', 'Bogra', 'Bogra Sadar', 'Bogra Canttonment', '5801', ''),
('\r\n1196', 'Rajshahi ', 'Bogra', 'Dhunat', 'Dhunat', '5850', ''),
('\r\n1197', 'Rajshahi ', 'Bogra', 'Dhunat', 'Gosaibari', '5851', ''),
('\r\n1198', 'Rajshahi ', 'Bogra', 'Dupchachia', 'Dupchachia', '5880', ''),
('\r\n1199', 'Rajshahi ', 'Bogra', 'Dupchachia', 'Talora', '5881', ''),
('\r\n1200', 'Rajshahi ', 'Bogra', 'Gabtoli', 'Gabtoli', '5820', ''),
('\r\n1201', 'Rajshahi ', 'Bogra', 'Gabtoli', 'Sukhanpukur', '5821', ''),
('\r\n1202', 'Rajshahi ', 'Bogra', 'Kahalu', 'Kahalu', '5870', ''),
('\r\n1203', 'Rajshahi ', 'Bogra', 'Nandigram', 'Nandigram', '5860', ''),
('\r\n1204', 'Rajshahi ', 'Bogra', 'Sariakandi', 'Sariakandi', '5830', ''),
('\r\n1205', 'Rajshahi ', 'Bogra', 'Sariakandi', 'Chandan Baisha', '5831', ''),
('\r\n1206', 'Rajshahi ', 'Bogra', 'Sherpur', 'Sherpur', '5840', ''),
('\r\n1207', 'Rajshahi ', 'Bogra', 'Sherpur', 'Chandaikona', '5841', ''),
('\r\n1208', 'Rajshahi ', 'Bogra', 'Sherpur', 'Palli Unnyan Accadem', '5842', ''),
('\r\n1209', 'Rajshahi ', 'Bogra', 'Shibganj', 'Shibganj', '5810', ''),
('\r\n1210', 'Rajshahi ', 'Bogra', 'Sonatola', 'Sonatola', '5826', ''),
('\r\n1211', 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'Akklepur', '5940', ''),
('\r\n1212', 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'jamalganj', '5941', ''),
('\r\n1213', 'Rajshahi ', 'Joypurhat', 'Akkelpur', 'Tilakpur', '5942', ''),
('\r\n1214', 'Rajshahi ', 'Joypurhat', 'Joypurhat Sadar', 'Joypurhat Sadar', '5900', ''),
('\r\n1215', 'Rajshahi ', 'Joypurhat', 'kalai', 'kalai', '5930', ''),
('\r\n1216', 'Rajshahi ', 'Joypurhat', 'Khetlal', 'Khetlal', '5920', ''),
('\r\n1217', 'Rajshahi ', 'Joypurhat', 'panchbibi', 'Panchbibi', '5910', ''),
('\r\n1218', 'Rajshahi ', 'Rajshahi', 'Bagha', 'Bagha', '6280', ''),
('\r\n1219', 'Rajshahi ', 'Rajshahi', 'Bagha', 'Arani', '6281', ''),
('\r\n1220', 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Bhabaniganj', '6250', ''),
('\r\n1221', 'Rajshahi ', 'Rajshahi', 'Bhabaniganj', 'Taharpur', '6251', ''),
('\r\n1222', 'Rajshahi ', 'Rajshahi', 'Charghat', 'Charghat', '6270', ''),
('\r\n1223', 'Rajshahi ', 'Rajshahi', 'Charghat', 'Sarda', '6271', ''),
('\r\n1224', 'Rajshahi ', 'Rajshahi', 'Durgapur', 'Durgapur', '6240', ''),
('\r\n1225', 'Rajshahi ', 'Rajshahi', 'Godagari', 'Godagari', '6290', ''),
('\r\n1226', 'Rajshahi ', 'Rajshahi', 'Godagari', 'Premtoli', '6291', ''),
('\r\n1227', 'Rajshahi ', 'Rajshahi', 'Khod Mohanpur', 'Khodmohanpur', '6220', ''),
('\r\n1228', 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Lalitganj', '6210', ''),
('\r\n1229', 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Rajshahi Sugar Mills', '6211', ''),
('\r\n1230', 'Rajshahi ', 'Rajshahi', 'Lalitganj', 'Shyampur', '6212', ''),
('\r\n1231', 'Rajshahi ', 'Rajshahi', 'Putia', 'Putia', '6260', ''),
('\r\n1232', 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Sadar', '6000', ''),
('\r\n1233', 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Ghuramara', '6100', ''),
('\r\n1234', 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Court', '6201', ''),
('\r\n1235', 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi Canttonment', '6202', ''),
('\r\n1236', 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Sapura', '6203', ''),
('\r\n1237', 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Kazla', '6204', ''),
('\r\n1238', 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Rajshahi University', '6205', ''),
('\r\n1239', 'Rajshahi ', 'Rajshahi', 'Rajshahi Sadar', 'Binodpur Bazar', '6206', ''),
('\r\n1240', 'Rajshahi ', 'Rajshahi', 'Tanor', 'Tanor', '6230', ''),
('\r\n1241', 'Rajshahi ', 'Chapinawabganj', 'Bholahat', 'Bholahat', '6330', ''),
('\r\n1242', 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Chapinawbganj Sadar', '6300', ''),
('\r\n1243', 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Rajarampur', '6301', ''),
('\r\n1244', 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Ramchandrapur', '6302', ''),
('\r\n1245', 'Rajshahi ', 'Chapinawabganj', 'Chapinawabganj Sadar', 'Amnura', '6303', ''),
('\r\n1246', 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Nachol', '6310', ''),
('\r\n1247', 'Rajshahi ', 'Chapinawabganj', 'Nachol', 'Mandumala', '6311', ''),
('\r\n1248', 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Rohanpur', '6320', ''),
('\r\n1249', 'Rajshahi ', 'Chapinawabganj', 'Rohanpur', 'Gomashtapur', '6321', ''),
('\r\n1250', 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Shibganj U.P.O', '6340', ''),
('\r\n1251', 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Kansart', '6341', ''),
('\r\n1252', 'Rajshahi ', 'Chapinawabganj', 'Shibganj U.P.O', 'Manaksha', '6342', ''),
('\r\n1253', 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Gopalpur U.P.O', '6420', ''),
('\r\n1254', 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Lalpur S.O', '6421', ''),
('\r\n1255', 'Rajshahi ', 'Natore', 'Gopalpur UPO', 'Abdulpur', '6422', ''),
('\r\n1256', 'Rajshahi ', 'Natore', 'Harua', 'Harua', '6430', ''),
('\r\n1257', 'Rajshahi ', 'Natore', 'Harua', 'Dayarampur', '6431', ''),
('\r\n1258', 'Rajshahi ', 'Natore', 'Harua', 'Baraigram', '6432', ''),
('\r\n1259', 'Rajshahi ', 'Natore', 'Hatgurudaspur', 'Hatgurudaspur', '6440', ''),
('\r\n1260', 'Rajshahi ', 'Natore', 'Laxman', 'Laxman', '6410', ''),
('\r\n1261', 'Rajshahi ', 'Natore', 'Natore Sadar', 'Natore Sadar', '6400', ''),
('\r\n1262', 'Rajshahi ', 'Natore', 'Natore Sadar', 'Digapatia', '6401', ''),
('\r\n1263', 'Rajshahi ', 'Natore', 'Natore Sadar', 'Baiddyabal Gharia', '6402', ''),
('\r\n1264', 'Rajshahi ', 'Natore', 'Natore Sadar', 'Madhnagar', '6403', ''),
('\r\n1265', 'Rajshahi ', 'Natore', 'Singra', 'Singra', '6450', ''),
('\r\n1266', 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Ahsanganj', '6596', ''),
('\r\n1267', 'Rajshahi ', 'Naogaon', 'Ahsanganj', 'Bandai', '6597', ''),
('\r\n1268', 'Rajshahi ', 'Naogaon', 'Badalgachhi', 'Badalgachhi', '6570', ''),
('\r\n1269', 'Rajshahi ', 'Naogaon', 'Dhamuirhat', 'Dhamuirhat', '6580', ''),
('\r\n1270', 'Rajshahi ', 'Naogaon', 'Mahadebpur', 'Mahadebpur', '6530', ''),
('\r\n1271', 'Rajshahi ', 'Naogaon', 'Naogaon Sadar', 'Naogaon Sadar', '6500', ''),
('\r\n1272', 'Rajshahi ', 'Naogaon', 'Niamatpur', 'Niamatpur', '6520', ''),
('\r\n1273', 'Rajshahi ', 'Naogaon', 'Nitpur', 'Nitpur', '6550', ''),
('\r\n1274', 'Rajshahi ', 'Naogaon', 'Nitpur', 'Porsa', '6551', ''),
('\r\n1275', 'Rajshahi ', 'Naogaon', 'Nitpur', 'Panguria', '6552', ''),
('\r\n1276', 'Rajshahi ', 'Naogaon', 'Patnitala', 'Patnitala', '6540', ''),
('\r\n1277', 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Prasadpur', '6510', ''),
('\r\n1278', 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Manda', '6511', ''),
('\r\n1279', 'Rajshahi ', 'Naogaon', 'Prasadpur', 'Balihar', '6512', ''),
('\r\n1280', 'Rajshahi ', 'Naogaon', 'Raninagar', 'Raninagar', '6590', ''),
('\r\n1281', 'Rajshahi ', 'Naogaon', 'Raninagar', 'Kashimpur', '6591', ''),
('\r\n1282', 'Rajshahi ', 'Naogaon', 'Sapahar', 'Sapahar', '6560', ''),
('\r\n1283', 'Rajshahi ', 'Naogaon', 'Sapahar', 'Moduhil', '6561', ''),
('\r\n1284', 'Rajshahi ', 'Pabna', 'Banwarinagar', 'Banwarinagar', '6650', ''),
('\r\n1285', 'Rajshahi ', 'Pabna', 'Bera', 'Bera', '6680', ''),
('\r\n1286', 'Rajshahi ', 'Pabna', 'Bera', 'Nakalia', '6681', ''),
('\r\n1287', 'Rajshahi ', 'Pabna', 'Bera', 'Kashinathpur', '6682', ''),
('\r\n1288', 'Rajshahi ', 'Pabna', 'Bera', 'Puran Bharenga', '6683', ''),
('\r\n1289', 'Rajshahi ', 'Pabna', 'Bhangura', 'Bhangura', '6640', ''),
('\r\n1290', 'Rajshahi ', 'Pabna', 'Chatmohar', 'Chatmohar', '6630', ''),
('\r\n1291', 'Rajshahi ', 'Pabna', 'Debottar', 'Debottar', '6610', ''),
('\r\n1292', 'Rajshahi ', 'Pabna', 'Ishwardi', 'Ishwardi', '6620', ''),
('\r\n1293', 'Rajshahi ', 'Pabna', 'Ishwardi', 'Dhapari', '6621', ''),
('\r\n1294', 'Rajshahi ', 'Pabna', 'Ishwardi', 'Pakshi', '6622', ''),
('\r\n1295', 'Rajshahi ', 'Pabna', 'Ishwardi', 'Rajapur', '6623', ''),
('\r\n1296', 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Pabna Sadar', '6600', ''),
('\r\n1297', 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Kaliko Cotton Mills', '6601', ''),
('\r\n1298', 'Rajshahi ', 'Pabna', 'Pabna Sadar', 'Hamayetpur', '6602', ''),
('\r\n1299', 'Rajshahi ', 'Pabna', 'Sathia', 'Sathia', '6670', ''),
('\r\n1300', 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sujanagar', '6660', ''),
('\r\n1301', 'Rajshahi ', 'Pabna', 'Sujanagar', 'Sagarkandi', '6661', ''),
('\r\n1302', 'Rajshahi ', 'Sirajganj', 'Baiddya Jam Toil', 'Baiddya Jam Toil', '6730', ''),
('\r\n1303', 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Belkuchi', '6740', ''),
('\r\n1304', 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sohagpur', '6741', ''),
('\r\n1305', 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Rajapur', '6742', ''),
('\r\n1306', 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Enayetpur', '6751', ''),
('\r\n1307', 'Rajshahi ', 'Sirajganj', 'Belkuchi', 'Sthal', '6752', ''),
('\r\n1308', 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Dhangora', '6720', ''),
('\r\n1309', 'Rajshahi ', 'Sirajganj', 'Dhangora', 'Malonga', '6721', ''),
('\r\n1310', 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Kazipur', '6710', ''),
('\r\n1311', 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Shuvgachha', '6711', ''),
('\r\n1312', 'Rajshahi ', 'Sirajganj', 'Kazipur', 'Gandail', '6712', ''),
('\r\n1313', 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Shahjadpur', '6770', ''),
('\r\n1314', 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Porjana', '6771', ''),
('\r\n1315', 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Jamirta', '6772', ''),
('\r\n1316', 'Rajshahi ', 'Sirajganj', 'Shahjadpur', 'Kaijuri', '6773', ''),
('\r\n1317', 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Sirajganj Sadar', '6700', ''),
('\r\n1318', 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Raipur', '6701', ''),
('\r\n1319', 'Rajshahi ', 'Sirajganj', 'Sirajganj Sadar', 'Rashidabad', '6702', ''),
('\r\n1320', 'Rajshahi ', 'Sirajganj', 'Tarash', 'Tarash', '6780', ''),
('\r\n1321', 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara', '6760', ''),
('\r\n1322', 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Ullapara R.S', '6761', ''),
('\r\n1323', 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Lahiri Mohanpur', '6762', ''),
('\r\n1324', 'Rajshahi ', 'Sirajganj', 'Ullapara', 'Salap', '6763', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `demo`
--
ALTER TABLE `demo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data`
--
ALTER TABLE `data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1325;
--
-- Database: `mbs_db`
--
CREATE DATABASE IF NOT EXISTS `mbs_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `mbs_db`;

-- --------------------------------------------------------

--
-- Table structure for table `balance_info`
--

CREATE TABLE `balance_info` (
  `id` int(11) NOT NULL,
  `customer_account_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL COMMENT '1: Deposite, 2: Withdrow, 3: Transfer',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: Pending , 1: Completed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `balance_info`
--

INSERT INTO `balance_info` (`id`, `customer_account_id`, `amount`, `type`, `status`) VALUES
(10, 2, 100, 1, 1),
(11, 2, 20, 1, 1),
(12, 2, 80, 1, 1),
(13, 2, 30, 1, 1),
(14, 2, 50, 1, 1),
(15, 2, 50, 2, 1),
(16, 2, 20, 2, 1),
(17, 9, 1222, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer_account_info`
--

CREATE TABLE `customer_account_info` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `account_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `balance` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customer_account_info`
--

INSERT INTO `customer_account_info` (`id`, `customer_id`, `account_no`, `balance`) VALUES
(1, 1, '125.103.1110001', 2),
(2, 4, '125.101.1110002', 218),
(9, 10, '110.112.345432', 1622),
(10, 10, '110.112.345411', 11201),
(11, 10, '125.101.345433', 0);

-- --------------------------------------------------------

--
-- Table structure for table `customer_info`
--

CREATE TABLE `customer_info` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `personal_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customer_info`
--

INSERT INTO `customer_info` (`id`, `customer_name`, `email`, `personal_code`, `password`) VALUES
(1, 'Admin User', 'admin@gmail.com', '10101010', '123456'),
(4, 'momit', 'momit.litu@gmail.com', '0413413', 'e10adc3949ba59abbe56e057f20f883e'),
(5, 'amotyher', 'contact@sma.tecdiary.org', '1232', 'f0feefcdc1b86fd94cf7ec3134698e53'),
(9, 'amotyher', 'dfg@sdf.vom', '12325', '4fe1404a724a763fdc4af3ac6f7bf79a'),
(10, 'chaki', 'kajolchaki@gmail.com', '111111', 'e10adc3949ba59abbe56e057f20f883e');

-- --------------------------------------------------------

--
-- Table structure for table `nominee`
--

CREATE TABLE `nominee` (
  `id` int(11) NOT NULL,
  `n_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `customer_id` int(11) NOT NULL,
  `relation` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  `account_number` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `nominee`
--

INSERT INTO `nominee` (`id`, `n_name`, `nid`, `customer_id`, `relation`, `priority`, `account_number`) VALUES
(1, 'Sazol', '1243567890', 1, 'Brother', 1, '125.103.1110001'),
(2, 'Rokeya', '124356745890', 1, 'mother', 2, '125.103.1110001'),
(5, 'Subodh chaki', '23456788734', 10, 'Father', 3, '110.112.345432'),
(10, 'Badol', '376494516237865', 10, 'Father', 3, '125.101.345433'),
(11, 'Tipu', '12345', 10, 'Friend', 3, '110.112.345411'),
(15, 'Himel', '212345678', 10, 'friend', 3, '125.101.345433');

-- --------------------------------------------------------

--
-- Table structure for table `transection_balance`
--

CREATE TABLE `transection_balance` (
  `id` int(11) NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `transection_balance`
--

INSERT INTO `transection_balance` (`id`, `from_account_id`, `to_account_id`, `amount`) VALUES
(3, 2, 1, 2),
(4, 9, 10, 100);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `balance_info`
--
ALTER TABLE `balance_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_balance_info_customer_account_info` (`customer_account_id`);

--
-- Indexes for table `customer_account_info`
--
ALTER TABLE `customer_account_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_no` (`account_no`),
  ADD KEY `FK_customer_account_info_customer_info` (`customer_id`);

--
-- Indexes for table `customer_info`
--
ALTER TABLE `customer_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `personal_code` (`personal_code`);

--
-- Indexes for table `nominee`
--
ALTER TABLE `nominee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transection_balance`
--
ALTER TABLE `transection_balance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_transection_history_customer_account_info` (`from_account_id`),
  ADD KEY `FK_transection_history_customer_account_info_2` (`to_account_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `balance_info`
--
ALTER TABLE `balance_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `customer_account_info`
--
ALTER TABLE `customer_account_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customer_info`
--
ALTER TABLE `customer_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `nominee`
--
ALTER TABLE `nominee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `transection_balance`
--
ALTER TABLE `transection_balance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `balance_info`
--
ALTER TABLE `balance_info`
  ADD CONSTRAINT `FK_balance_info_customer_account_info` FOREIGN KEY (`customer_account_id`) REFERENCES `customer_account_info` (`id`);

--
-- Constraints for table `customer_account_info`
--
ALTER TABLE `customer_account_info`
  ADD CONSTRAINT `FK_customer_account_info_customer_info` FOREIGN KEY (`customer_id`) REFERENCES `customer_info` (`id`);

--
-- Constraints for table `transection_balance`
--
ALTER TABLE `transection_balance`
  ADD CONSTRAINT `FK_transection_history_customer_account_info` FOREIGN KEY (`from_account_id`) REFERENCES `customer_account_info` (`id`),
  ADD CONSTRAINT `FK_transection_history_customer_account_info_2` FOREIGN KEY (`to_account_id`) REFERENCES `customer_account_info` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
