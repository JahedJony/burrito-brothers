-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 16, 2019 at 12:12 PM
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
-- Database: `burritobrothers_db`
--

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
('1000004', 'biplob', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 1, NULL, NULL, '1000002'),
('1000005', 'No one', 'e10adc3949ba59abbe56e057f20f883e', 'General', 0, 1, NULL, NULL, '1000001');

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
(37, 'Banner2', 'Makeup kit', 'images/banner/Mac Structured Cake.jpg', 1),
(38, 'sdfaswe', 'sdfgh', '/images/banner/1574791806moumit.jpg', 1),
(39, 'sdfas', 'dsfg', '/images/banner/1574793260moumit.jpg', 1);

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
(25, '0001', 'Bakary', NULL, 'images/category/img53.png', 1),
(26, '0002', 'Burger', NULL, 'images/category/img68.png', 1),
(27, '0003', 'Pizza', NULL, 'images/category/img75.png', 1),
(28, '0004', 'Noodlses', NULL, 'images/category/img67.png', 1),
(29, '0005', 'Pasta', NULL, 'images/category/img66.png', 1),
(30, '0006', 'Fry Item', NULL, 'images/category/img63.png', 1),
(31, '0007', 'Lunch', NULL, 'images/category/1575967379img53.png', 1);

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
(11, 'Nazmul', 'Nazmul Ahsan', '25f9e794323b453885f5181f1b624d0b', 'Dhaka', '0000-00-00', '', '01613313666', 'it@nafisagroup.com', NULL, 0),
(12, 'mmmmomit', 'mmmmomit', 'e10adc3949ba59abbe56e057f20f883e', '', '0000-00-00', '', '0198034045', 'm.k@gmail.com', NULL, 1),
(13, 'Walk In Customer', NULL, NULL, 'no address', '0000-00-00', 'images/no_image.png', '456456464', '', '', 1),
(14, 'POS Customer', NULL, NULL, 'dfgdgdfg', '0000-00-00', 'images/no_image.png', '45645646', '', '', 1),
(15, 'chaki', NULL, NULL, '622, West shawrapara, mirpur', '2017-02-07', 'images/no_image.png', '234', '', '', 1),
(16, 'chaki', NULL, NULL, '622, West shawrapara, mirpur', '2019-12-10', 'images/no_image.png', '234', '', '', 1);

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
(58, 'cake', 23, '38.jpg'),
(59, 'sdfas', 21, 'moumit.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` int(11) DEFAULT NULL,
  `company_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `website_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `website_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `web_admin_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `web_admin_contact` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_longitude` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `store_latitude` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `store_contact` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_incharge_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `company_logo` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `yelp_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fb_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tweeter_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `instagram_url` varchar(300) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `meta_description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `meta_keywards` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `currency` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_symbol` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `decimal_placement` tinyint(1) DEFAULT '2' COMMENT '2decimal',
  `tax_enable` tinyint(1) DEFAULT '0' COMMENT '1:enabled, 0:disable',
  `minimum_order_amount` double(10,2) DEFAULT NULL,
  `takeout` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `delivery` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `dinein` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `card_payment` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `cash_payment` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `loyelty_payment` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `payment_card_visa` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `payment_card_master` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `payment_card_amex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `payment_card_discover` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:enabled, 0:disable',
  `point_reserve_value` int(11) NOT NULL COMMENT 'point reserve value(_$=1point)',
  `redeem_value` int(11) NOT NULL COMMENT 'point financial value(_point=1$)',
  `tax_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1:flat, 0:percentage',
  `tax_amount` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `company_name`, `website_title`, `website_url`, `web_admin_email`, `web_admin_contact`, `store_name`, `store_address`, `store_longitude`, `store_latitude`, `store_contact`, `store_incharge_name`, `company_logo`, `yelp_url`, `fb_url`, `tweeter_url`, `instagram_url`, `meta_description`, `meta_keywards`, `currency`, `currency_symbol`, `decimal_placement`, `tax_enable`, `minimum_order_amount`, `takeout`, `delivery`, `dinein`, `card_payment`, `cash_payment`, `loyelty_payment`, `payment_card_visa`, `payment_card_master`, `payment_card_amex`, `payment_card_discover`, `point_reserve_value`, `redeem_value`, `tax_type`, `tax_amount`) VALUES
(1, 'Burrito Brothers', 'Burrito Brothers', 'http://burritobrothers.test/', 'burritobrothers@gmail.net', '12345', 'Burrito Brothers', '622, West shawrapara\r\nmirpur', '12.23', '13.123', '12345', 'kajol', 'images/banner/burritoLogo.png', 'http://burritobrothers.test/', 'http://burritobrothers.test/', 'http://burritobrothers.test/', 'http://burritobrothers.test/', 'You can use a standard JS for..in loop - you don\'t need jQuery, though it has you covered too with its $.each() method. Either way gives you access to the property names and their corresponding values. Given you\'ve got nested objects you will probably want nested for..in or $.each() loops.\r\nYou don\'t make it at all clear what format your output should be, but here\'s a simple example that at least shows how to get the pieces you need:', 'food, pizza, takeout, group', 'USD', '$', 3, 0, 1.00, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 10, 10, 0, 0);

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
  `size_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `photo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredient`
--

INSERT INTO `ingredient` (`id`, `code`, `name`, `size_id`, `price`, `photo`) VALUES
(4, '10002', 'Eggs', 6, 15, 'images/ingredient/download.jpeg'),
(7, '10005', 'Milk', 8, 20, 'images/ingredient/milk.jpeg'),
(11, '10009', 'Butter', 6, 25, 'images/ingredient/butter.jpeg'),
(15, '10013', 'Cheese', 5, 50, 'images/ingredient/cheese.jpeg'),
(16, '10014', 'Chocolate', 25, 80, 'images/ingredient/chocolete.jpeg'),
(17, '10015', 'Dark Chocolate', 25, 100, 'images/ingredient/dark chocolere.jpeg'),
(24, '10022', 'Chicken', 24, 40, 'images/ingredient/1576496500chicken slice.jpeg'),
(26, '10024', 'Vegetable', 25, 20, 'images/ingredient/vegetable.jpeg'),
(29, '10001', 'Beef', 5, 100, 'images/ingredient/beef.jpeg'),
(39, '344', 'Suger', 5, 222, 'images/ingredient/suger.jpeg'),
(40, '1234', 'Musrum', 3, 20, 'images/ingredient/musroom.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
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
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `name`, `code`, `tags`, `details`, `short_description`, `category_id`, `brand_name`, `availability`, `sell_from_stock`, `feature_image`) VALUES
(1, 'Pestry', '00001', '', 'dfgdfg', NULL, 25, NULL, 1, 0, ''),
(2, 'Plain Cake', '0002', '', 'good test', NULL, 25, NULL, 1, 0, ''),
(3, 'Product A', '101', '', 'hjhj khjkhjh', NULL, 26, NULL, 1, 0, ''),
(4, 'AAAA', '2100', '', 'sd', NULL, 25, NULL, 1, 0, ''),
(5, 'Bowl Rice', '000023', '', 'rice', NULL, 31, NULL, 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `item_image`
--

CREATE TABLE `item_image` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_image` varchar(55) NOT NULL,
  `is_featured` tinyint(1) DEFAULT '0' COMMENT '1:featured, 0 not '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_image`
--

INSERT INTO `item_image` (`id`, `item_id`, `item_image`, `is_featured`) VALUES
(1, 1, '15723716584.jpg', 0),
(2, 2, '15733204197.jpg', 0),
(3, 5, 'chicken slice.jpeg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `item_ingredient`
--

CREATE TABLE `item_ingredient` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_ingredient`
--

INSERT INTO `item_ingredient` (`id`, `item_id`, `size_id`, `price`, `ingredient_id`) VALUES
(58, 5, 0, 0, 7),
(59, 5, 0, 0, 15),
(60, 5, 0, 0, 17),
(64, 3, 0, 0, 4),
(65, 3, 0, 0, 15),
(66, 3, 0, 0, 16),
(67, 2, 0, 0, 4),
(68, 2, 0, 0, 7),
(69, 2, 0, 0, 8),
(70, 2, 0, 0, 11),
(71, 2, 0, 0, 15),
(72, 2, 0, 0, 16),
(73, 2, 0, 0, 17),
(74, 2, 0, 0, 24),
(75, 2, 0, 0, 26),
(76, 2, 0, 0, 29);

-- --------------------------------------------------------

--
-- Table structure for table `item_rate`
--

CREATE TABLE `item_rate` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `production_rate` float(10,2) NOT NULL,
  `rate` float(10,2) NOT NULL,
  `discount_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: flat_rate; 2:percentage_rate',
  `discount_amount` float(10,2) NOT NULL,
  `discounted_rate` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_rate`
--

INSERT INTO `item_rate` (`id`, `item_id`, `size_id`, `unit_id`, `stock_quantity`, `production_rate`, `rate`, `discount_type`, `discount_amount`, `discounted_rate`) VALUES
(25, 4, 1, 3, 6, 875.00, 950.00, 1, 5.00, 875.00),
(27, 5, 1, 3, 2, 120.00, 150.00, 1, 0.00, 150.00),
(30, 3, 1, 3, 8, 0.00, 100.00, 1, 50.00, 50.00),
(31, 3, 14, 3, 9, 0.00, 100.00, 2, 10.00, 10.00),
(34, 2, 1, 3, 5, 120.00, 150.00, 1, 0.00, 150.00),
(35, 1, 7, 3, 2, 1510.00, 1720.00, 1, 0.00, 1720.00);

-- --------------------------------------------------------

--
-- Table structure for table `item_review`
--

CREATE TABLE `item_review` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `review_details` text,
  `review_point` int(1) NOT NULL,
  `review_by_name` varchar(200) NOT NULL,
  `review_by_email` varchar(200) NOT NULL,
  `review_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `item_stock`
--

CREATE TABLE `item_stock` (
  `id` int(11) NOT NULL,
  `item_rate_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `note` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_stock`
--

INSERT INTO `item_stock` (`id`, `item_rate_id`, `date`, `quantity`, `note`) VALUES
(1, 8, '2019-11-20', 5, 'item added'),
(2, 7, '2019-11-21', 33, 'item added'),
(3, 8, '2019-11-13', 6, 'item added'),
(4, 7, '2019-11-20', 33, 'item added'),
(5, 8, '2019-11-13', 6, 'item added'),
(6, 7, '2019-11-20', 33, 'item added'),
(7, 8, '2019-11-13', -6, 'item damaged'),
(8, 7, '2019-11-20', 33, 'item added'),
(9, 9, '2019-11-13', 3, 'item added'),
(10, 9, '2019-11-12', 22, 'item added'),
(25, 8, '2019-11-14', 33, 'sdf'),
(26, 7, '2019-11-22', 2, 'update'),
(27, 9, '2019-11-21', 10, 'item receive from shopno'),
(28, 12, '2019-11-21', -12, 'item receive from shopno'),
(29, 16, '2019-11-21', 2, 'add item'),
(30, 13, '2019-11-21', 2, 'add item'),
(31, 12, '2019-11-21', 3, 'add item');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `product_rate_id` int(11) NOT NULL,
  `details` text,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1.read, 0:unread',
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `view_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `product_rate_id`, `details`, `status`, `date_time`, `view_time`) VALUES
(5417, 9, 'Add <b>Plain Cake >>Small</b> in Stock.', 1, '2019-11-26 10:25:38', NULL),
(5419, 7, 'Add <b>Pestry >>500 gm</b> in Stock.', 0, '2019-11-26 10:26:35', NULL),
(5420, 9, 'Add <b>Plain Cake >>Small</b> in Stock.', 0, '2019-11-26 11:28:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `item_rate` float(8,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:active,  2: canceled '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `item_id`, `size_id`, `unit_id`, `quantity`, `item_rate`, `status`) VALUES
(83, 30, 1, 7, 3, 1, 1720.00, 1);

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
(30, 14, '2019-11-10 19:21:09', '2019-11-10 12:00:00', 3, NULL, 3, NULL, 50.00, 0.00, 8680.00, 3470.00, 0.00, '', 'dfgdfg', 3, 2, '2019-11-10 08:28:14', '2019-11-10 12:59:24', 2, 3, '4544545', 'INV111900001'),
(31, 5, '2019-12-07 13:14:57', '2019-12-07 12:00:00', 3, NULL, 3, NULL, 0.00, 0.00, 1720.00, 0.00, 0.00, '', '', 1, 2, '2019-12-07 01:18:30', NULL, 1, 3, '', 'INV121900002'),
(32, 15, '2019-12-07 14:22:54', '2019-12-07 12:00:00', 1, NULL, 1, 1111, 0.00, 0.00, 2595.00, 0.00, 0.00, '', '', 1, 1, NULL, NULL, 1, 3, '', 'INV121900003');

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
(22, '10021', '4 kg'),
(23, '10022', '100 mg'),
(24, '10023', '100 gm'),
(25, '10024', '50 gm ');

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
(1, 'Kilogram', 'KG', 2, 'mul', 1000.00, NULL, 1),
(2, 'Gram', 'gm', 1, 'sub', 1000.00, NULL, 1),
(3, 'Pices', 'Pcs', NULL, NULL, 0.00, NULL, 1),
(4, 'Dozen', 'Dzn', 3, 'mul', 12.00, NULL, 1),
(5, 'Liter', 'Ltr', NULL, 'mul', 0.00, NULL, 1),
(6, 'Mililiter', 'ml', 5, 'div', 1000.00, NULL, 1),
(7, 'box', 'bx', 0, 'div', 0.00, NULL, 1),
(8, 'Slice', 'slc', NULL, 'mul', NULL, NULL, 1),
(9, 'Pounds', 'lb', NULL, NULL, NULL, NULL, 1),
(10, 'Mili gram', 'mg', NULL, NULL, NULL, 'none', 1);

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
(24, 'Sells man', 0),
(25, 'chef', 0);

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
(12, 24, '1000004', 1),
(13, 21, '1000005', 0),
(14, 24, '1000005', 1),
(15, 25, '1000001', 0),
(16, 25, '1000002', 0),
(17, 25, '1000003', 0),
(18, 25, '1000004', 0),
(19, 25, '1000005', 0);

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
(682, 24, 102, 0),
(683, 21, 103, 0),
(684, 24, 103, 0),
(685, 25, 10, 0),
(686, 25, 11, 0),
(687, 25, 12, 0),
(688, 25, 13, 0),
(689, 25, 14, 0),
(690, 25, 15, 0),
(691, 25, 16, 0),
(692, 25, 43, 0),
(693, 25, 44, 0),
(694, 25, 45, 0),
(695, 25, 50, 0),
(696, 25, 51, 0),
(697, 25, 52, 0),
(698, 25, 53, 0),
(699, 25, 54, 0),
(700, 25, 55, 0),
(701, 25, 56, 0),
(702, 25, 57, 0),
(703, 25, 58, 0),
(704, 25, 59, 0),
(705, 25, 60, 0),
(706, 25, 61, 0),
(707, 25, 62, 0),
(708, 25, 63, 0),
(709, 25, 64, 0),
(710, 25, 65, 0),
(711, 25, 66, 0),
(712, 25, 67, 0),
(713, 25, 68, 0),
(714, 25, 69, 0),
(715, 25, 74, 0),
(716, 25, 75, 0),
(717, 25, 76, 0),
(718, 25, 77, 0),
(719, 25, 78, 0),
(720, 25, 79, 0),
(721, 25, 80, 0),
(722, 25, 81, 0),
(723, 25, 82, 0),
(724, 25, 83, 0),
(725, 25, 84, 0),
(726, 25, 85, 0),
(727, 25, 86, 0),
(728, 25, 87, 0),
(729, 25, 98, 0),
(730, 25, 99, 0),
(731, 25, 100, 0),
(732, 25, 101, 0),
(733, 25, 102, 0),
(734, 25, 103, 0);

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
('1000001', 'Momit', 'Software Engineer', '', '', '', 'images/employee/moumit.jpg', '01737151125', 'shofiqueshahin@gmail.com', 'B+', '201800001', 1, 'aaaaaaaaaa'),
('1000002', 'kajol kumar chaki', 'software engineer ', '', '', '23489', 'images/employee/DA90208.jpg', '01757808214', 'kajolchaki@gmail.com', 'o+', NULL, 1, 'none'),
('1000003', 'jahed', 'Chef', '', '', '345678', 'images/employee/558.jpg', '32456', 'sfho@dsaf.dsf', 'A-', NULL, 1, ''),
('1000004', 'biplob', 'Store Keeper', '622, West shawrapara, mirpur', '', '2345', '', '21345', 'kumar@mail.com', 'A-', NULL, 1, 'sf'),
('1000005', 'No one', 'sells man', '', '', '123456', 'images/employee/1576491314Mithu PP.jpg', '2345466', 'kumar@mail.com', 'A-', NULL, 0, 'none');

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
(102, 'Stock Grid', 3, 0),
(103, 'user Grid', 1, 0);

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
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `item_image`
--
ALTER TABLE `item_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_ingredient`
--
ALTER TABLE `item_ingredient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_rate`
--
ALTER TABLE `item_rate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_review`
--
ALTER TABLE `item_review`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_stock`
--
ALTER TABLE `item_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_master`
--
ALTER TABLE `order_master`
  ADD PRIMARY KEY (`order_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `cupons`
--
ALTER TABLE `cupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customer_infos`
--
ALTER TABLE `customer_infos`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `image_album`
--
ALTER TABLE `image_album`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `item_image`
--
ALTER TABLE `item_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `item_ingredient`
--
ALTER TABLE `item_ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `item_rate`
--
ALTER TABLE `item_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `item_review`
--
ALTER TABLE `item_review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item_stock`
--
ALTER TABLE `item_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `order_master`
--
ALTER TABLE `order_master`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `size`
--
ALTER TABLE `size`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user_group_member`
--
ALTER TABLE `user_group_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `user_group_permission`
--
ALTER TABLE `user_group_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=735;

--
-- AUTO_INCREMENT for table `web_actions`
--
ALTER TABLE `web_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

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
-- Constraints for table `web_menu`
--
ALTER TABLE `web_menu`
  ADD CONSTRAINT `FK_web_menu_web_menu` FOREIGN KEY (`parent_menu_id`) REFERENCES `web_menu` (`id`);

--
-- Constraints for table `web_notice`
--
ALTER TABLE `web_notice`
  ADD CONSTRAINT `FK1_poosted_by` FOREIGN KEY (`posted_by`) REFERENCES `user_infos` (`emp_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
