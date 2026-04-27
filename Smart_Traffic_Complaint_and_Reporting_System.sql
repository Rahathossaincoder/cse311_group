-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 10, 2026 at 11:15 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12
CREATE DATABASE IF NOT EXISTS smart_traffic_complaint_and_reporting_system
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE smart_traffic_complaint_and_reporting_system;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Smart_Traffic_Complaint_and_Reporting_System`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admins`
--

CREATE TABLE `Admins` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `account_status` varchar(50) DEFAULT 'Active',
  `access_level` varchar(50) DEFAULT NULL,
  `office_location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Admins`
--

INSERT INTO `Admins` (`admin_id`, `admin_name`, `email`, `phone`, `password`, `department`, `designation`, `joining_date`, `last_login`, `account_status`, `access_level`, `office_location`) VALUES
(1, 'Tanzila Noor', 'tanzila.noor@traffic.gov.bd', '01820000001', 'Tanzila@123', 'Traffic Control', 'Senior Officer', '2025-01-15', '2026-04-09 03:00:00', 'Active', 'High', 'Dhaka HQ'),
(2, 'Amanullah Shah', 'amanullah.shah@traffic.gov.bd', '01820000002', 'Amanullah@123', 'Traffic Control', 'Inspector', '2025-03-10', '2026-04-09 04:00:00', 'Active', 'Medium', 'Chittagong Office'),
(3, 'Shirin Akter', 'shirin.akter@traffic.gov.bd', '01820000003', 'Shirin@123', 'Traffic Control', 'Officer', '2025-04-01', '2026-04-09 05:00:00', 'Active', 'Low', 'Sylhet Office'),
(4, 'Mahfuz Rahman', 'mahfuz.rahman@traffic.gov.bd', '01820000004', 'Mahfuz@123', 'Traffic Control', 'Supervisor', '2025-05-12', '2026-04-09 06:00:00', 'Active', 'High', 'Dhaka HQ'),
(5, 'Nabila Chowdhury', 'nabila.chowdhury@traffic.gov.bd', '01820000005', 'Nabila@123', 'Traffic Control', 'Assistant Inspector', '2025-06-20', '2026-04-09 07:00:00', 'Active', 'Medium', 'Rajshahi Office'),
(6, 'Rafiq Hasan', 'rafiq.hasan@traffic.gov.bd', '01820000006', 'Rafiq@123', 'Traffic Control', 'Officer', '2025-07-15', '2026-04-09 08:00:00', 'Inactive', 'Low', 'Khulna Office'),
(7, 'Sadia Islam', 'sadia.islam@traffic.gov.bd', '01820000007', 'Sadia@123', 'Traffic Control', 'Inspector', '2025-08-10', '2026-04-09 09:00:00', 'Active', 'Medium', 'Dhaka HQ'),
(8, 'Imran Hossain', 'imran.hossain@traffic.gov.bd', '01820000008', 'Imran@123', 'Traffic Control', 'Senior Officer', '2025-09-05', '2026-04-09 10:00:00', 'Active', 'High', 'Chittagong Office'),
(9, 'Farzana Rahman', 'farzana.rahman@traffic.gov.bd', '01820000009', 'Farzana@123', 'Traffic Control', 'Supervisor', '2025-10-01', '2026-04-09 11:00:00', 'Active', 'High', 'Dhaka HQ'),
(10, 'Tanvir Alam', 'tanvir.alam@traffic.gov.bd', '01820000010', 'Tanvir@123', 'Traffic Control', 'Officer', '2025-11-12', '2026-04-09 12:00:00', 'Suspended', 'Low', 'Sylhet Office'),
(11, 'Shamima Akter', 'shamima.akter@traffic.gov.bd', '01820000011', 'Shamima@123', 'Traffic Control', 'Inspector', '2025-12-01', '2026-04-09 13:00:00', 'Active', 'Medium', 'Dhaka HQ'),
(12, 'Mahmudul Hasan', 'mahmudul.hasan@traffic.gov.bd', '01820000012', 'Mahmudul@123', 'Traffic Control', 'Senior Officer', '2026-01-10', '2026-04-09 14:00:00', 'Active', 'High', 'Rajshahi Office'),
(13, 'Rokeya Sultana', 'rokeya.sultana@traffic.gov.bd', '01820000013', 'Rokeya@123', 'Traffic Control', 'Assistant Inspector', '2026-02-05', '2026-04-09 15:00:00', 'Active', 'Medium', 'Khulna Office'),
(14, 'Ashraful Alam', 'ashraful.alam@traffic.gov.bd', '01820000014', 'Ashraful@123', 'Traffic Control', 'Officer', '2026-02-20', '2026-04-09 16:00:00', 'Inactive', 'Low', 'Dhaka HQ'),
(15, 'Samira Khan', 'samira.khan@traffic.gov.bd', '01820000015', 'Samira@123', 'Traffic Control', 'Supervisor', '2026-03-01', '2026-04-09 17:00:00', 'Active', 'High', 'Chittagong Office'),
(16, 'John Smith', 'john.smith@traffic.gov.bd', '01820000016', 'John@123', 'Traffic Control', 'Inspector', '2026-03-15', '2026-04-10 02:00:00', 'Active', 'Medium', 'Dhaka HQ'),
(17, 'Emily Johnson', 'emily.johnson@traffic.gov.bd', '01820000017', 'Emily@123', 'Traffic Control', 'Officer', '2026-03-20', '2026-04-10 03:00:00', 'Active', 'Low', 'Sylhet Office'),
(18, 'David Lee', 'david.lee@traffic.gov.bd', '01820000018', 'David@123', 'Traffic Control', 'Senior Officer', '2026-03-25', '2026-04-10 04:00:00', 'Active', 'High', 'Dhaka HQ'),
(19, 'Sophia Brown', 'sophia.brown@traffic.gov.bd', '01820000019', 'Sophia@123', 'Traffic Control', 'Supervisor', '2026-03-30', '2026-04-10 05:00:00', 'Active', 'High', 'Chittagong Office'),
(20, 'Michael Clark', 'michael.clark@traffic.gov.bd', '01820000020', 'Michael@123', 'Traffic Control', 'Inspector', '2026-04-01', '2026-04-10 06:00:00', 'Active', 'Medium', 'Dhaka HQ'),
(21, 'Olivia Davis', 'olivia.davis@traffic.gov.bd', '01820000021', 'Olivia@123', 'Traffic Control', 'Assistant Inspector', '2026-04-02', '2026-04-10 07:00:00', 'Active', 'Medium', 'Rajshahi Office'),
(22, 'Daniel Wilson', 'daniel.wilson@traffic.gov.bd', '01820000022', 'Daniel@123', 'Traffic Control', 'Officer', '2026-04-03', '2026-04-10 08:00:00', 'Active', 'Low', 'Khulna Office'),
(23, 'Emma Martinez', 'emma.martinez@traffic.gov.bd', '01820000023', 'Emma@123', 'Traffic Control', 'Supervisor', '2026-04-04', '2026-04-10 09:00:00', 'Active', 'High', 'Dhaka HQ'),
(24, 'James Taylor', 'james.taylor@traffic.gov.bd', '01820000024', 'James@123', 'Traffic Control', 'Inspector', '2026-04-05', '2026-04-10 10:00:00', 'Active', 'Medium', 'Chittagong Office'),
(25, 'Isabella Thomas', 'isabella.thomas@traffic.gov.bd', '01820000025', 'Isabella@123', 'Traffic Control', 'Officer', '2026-04-06', '2026-04-10 11:00:00', 'Inactive', 'Low', 'Sylhet Office'),
(26, 'Henry White', 'henry.white@traffic.gov.bd', '01820000026', 'Henry@123', 'Traffic Control', 'Senior Officer', '2026-04-07', '2026-04-10 12:00:00', 'Active', 'High', 'Dhaka HQ'),
(27, 'Charlotte Harris', 'charlotte.harris@traffic.gov.bd', '01820000027', 'Charlotte@123', 'Traffic Control', 'Supervisor', '2026-04-08', '2026-04-10 13:00:00', 'Active', 'High', 'Chittagong Office'),
(28, 'Alexander Young', 'alex.young@traffic.gov.bd', '01820000028', 'Alex@123', 'Traffic Control', 'Inspector', '2026-04-09', '2026-04-10 14:00:00', 'Active', 'Medium', 'Dhaka HQ'),
(29, 'Amelia King', 'amelia.king@traffic.gov.bd', '01820000029', 'Amelia@123', 'Traffic Control', 'Officer', '2026-04-10', '2026-04-10 15:00:00', 'Active', 'Low', 'Rajshahi Office'),
(30, 'Benjamin Scott', 'benjamin.scott@traffic.gov.bd', '01820000030', 'Ben@123', 'Traffic Control', 'Supervisor', '2026-04-11', '2026-04-10 16:00:00', 'Active', 'High', 'Khulna Office'),
(31, 'Mia Adams', 'mia.adams@traffic.gov.bd', '01820000031', 'Mia@123', 'Traffic Control', 'Inspector', '2026-04-12', '2026-04-10 17:00:00', 'Active', 'Medium', 'Dhaka HQ'),
(32, 'William Baker', 'william.baker@traffic.gov.bd', '01820000032', 'William@123', 'Traffic Control', 'Officer', '2026-04-13', '2026-04-11 02:00:00', 'Suspended', 'Low', 'Sylhet Office'),
(33, 'Evelyn Carter', 'evelyn.carter@traffic.gov.bd', '01820000033', 'Evelyn@123', 'Traffic Control', 'Senior Officer', '2026-04-14', '2026-04-11 03:00:00', 'Active', 'High', 'Dhaka HQ'),
(34, 'Lucas Perez', 'lucas.perez@traffic.gov.bd', '01820000034', 'Lucas@123', 'Traffic Control', 'Supervisor', '2026-04-15', '2026-04-11 04:00:00', 'Active', 'High', 'Chittagong Office'),
(35, 'Grace Rivera', 'grace.rivera@traffic.gov.bd', '01820000035', 'Grace@123', 'Traffic Control', 'Inspector', '2026-04-16', '2026-04-11 05:00:00', 'Active', 'Medium', 'Dhaka HQ'),
(36, 'Noor Hossain', 'noor.hossain@traffic.gov.bd', '01820000036', 'Noor@123', 'Traffic Control', 'Officer', '2026-04-17', '2026-04-11 06:00:00', 'Active', 'Low', 'Rajshahi Office'),
(37, 'Fatema Akter', 'fatema.akter@traffic.gov.bd', '01820000037', 'Fatema@123', 'Traffic Control', 'Supervisor', '2026-04-18', '2026-04-11 07:00:00', 'Active', 'High', 'Khulna Office'),
(38, 'Shahidul Islam', 'shahidul.islam@traffic.gov.bd', '01820000038', 'Shahidul@123', 'Traffic Control', 'Inspector', '2026-04-19', '2026-04-11 08:00:00', 'Active', 'Medium', 'Dhaka HQ'),
(39, 'Nusrat Chowdhury', 'nusrat.chowdhury@traffic.gov.bd', '01820000039', 'Nusrat@123', 'Traffic Control', 'Officer', '2026-04-20', '2026-04-11 09:00:00', 'Inactive', 'Low', 'Sylhet Office'),
(40, 'Hasan Mahmud', 'hasan.mahmud@traffic.gov.bd', '01820000040', 'Hasan@123', 'Traffic Control', 'Senior Officer', '2026-04-21', '2026-04-11 10:00:00', 'Active', 'High', 'Dhaka HQ');

-- --------------------------------------------------------

--
-- Table structure for table `Attachments`
--

CREATE TABLE `Attachments` (
  `attachment_id` int(11) NOT NULL,
  `complaint_id` int(11) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `uploaded_by` varchar(100) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_status` varchar(50) DEFAULT NULL,
  `verification_status` varchar(50) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Attachments`
--

INSERT INTO `Attachments` (`attachment_id`, `complaint_id`, `file_name`, `file_type`, `file_size`, `upload_date`, `uploaded_by`, `file_path`, `file_status`, `verification_status`, `remarks`, `last_updated`) VALUES
(1, 1, 'parking_photo1.jpg', 'image', 245, '2026-01-01 18:00:00', '3', '/uploads/complaints/1/parking_photo1.jpg', 'Active', 'Verified', 'Clear evidence of illegal parking', '2026-01-02 18:00:00'),
(2, 1, 'parking_video1.mp4', 'video', 15200, '2026-01-01 18:00:00', '3', '/uploads/complaints/1/parking_video1.mp4', 'Active', 'Pending', 'Video needs admin review', '2026-01-02 18:00:00'),
(3, 2, 'garbage_dump2.jpg', 'image', 310, '2026-01-03 18:00:00', '5', '/uploads/complaints/2/garbage_dump2.jpg', 'Active', 'Verified', 'Garbage pile confirmed', '2026-01-04 18:00:00'),
(4, 3, 'signal_issue3.jpg', 'image', 280, '2026-01-04 18:00:00', '7', '/uploads/complaints/3/signal_issue3.jpg', 'Active', 'Verified', 'Broken traffic light visible', '2026-01-05 18:00:00'),
(5, 4, 'noise_pollution4.mp3', 'audio', 5200, '2026-01-05 18:00:00', '9', '/uploads/complaints/4/noise_pollution4.mp3', 'Active', 'Pending', 'Audio recording of loudspeakers', '2026-01-06 18:00:00'),
(6, 5, 'billboard5.jpg', 'image', 295, '2026-01-06 18:00:00', '11', '/uploads/complaints/5/billboard5.jpg', 'Active', 'Rejected', 'Blurry image, not usable', '2026-01-07 18:00:00'),
(7, 6, 'vendor6.jpg', 'image', 260, '2026-01-07 18:00:00', '13', '/uploads/complaints/6/vendor6.jpg', 'Active', 'Verified', 'Street vendor blocking road', '2026-01-08 18:00:00'),
(8, 7, 'accident7.jpg', 'image', 340, '2026-01-08 18:00:00', '15', '/uploads/complaints/7/accident7.jpg', 'Active', 'Verified', 'Accident scene documented', '2026-01-09 18:00:00'),
(9, 8, 'garbage8.jpg', 'image', 300, '2026-01-09 18:00:00', '17', '/uploads/complaints/8/garbage8.jpg', 'Active', 'Verified', 'Overflowing garbage bin', '2026-01-10 18:00:00'),
(10, 9, 'signal9.jpg', 'image', 275, '2026-01-10 18:00:00', '19', '/uploads/complaints/9/signal9.jpg', 'Active', 'Pending', 'Signal malfunction evidence', '2026-01-11 18:00:00'),
(11, 10, 'noise10.mp3', 'audio', 4800, '2026-01-11 18:00:00', '21', '/uploads/complaints/10/noise10.mp3', 'Active', 'Verified', 'Noise complaint audio evidence', '2026-01-12 18:00:00'),
(12, 11, 'billboard11.jpg', 'image', 310, '2026-01-12 18:00:00', '23', '/uploads/complaints/11/billboard11.jpg', 'Active', 'Pending', 'Unauthorized billboard photo', '2026-01-13 18:00:00'),
(13, 12, 'vendor12.jpg', 'image', 290, '2026-01-13 18:00:00', '25', '/uploads/complaints/12/vendor12.jpg', 'Active', 'Verified', 'Street vendor blocking traffic', '2026-01-14 18:00:00'),
(14, 13, 'accident13.jpg', 'image', 350, '2026-01-14 18:00:00', '27', '/uploads/complaints/13/accident13.jpg', 'Active', 'Verified', 'Accident scene photo', '2026-01-15 18:00:00'),
(15, 14, 'garbage14.jpg', 'image', 305, '2026-01-15 18:00:00', '29', '/uploads/complaints/14/garbage14.jpg', 'Active', 'Verified', 'Garbage pile near road', '2026-01-16 18:00:00'),
(16, 15, 'signal15.jpg', 'image', 280, '2026-01-16 18:00:00', '31', '/uploads/complaints/15/signal15.jpg', 'Active', 'Pending', 'Traffic signal malfunction evidence', '2026-01-17 18:00:00'),
(17, 16, 'noise16.mp3', 'audio', 5100, '2026-01-17 18:00:00', '33', '/uploads/complaints/16/noise16.mp3', 'Active', 'Verified', 'Noise pollution recording', '2026-01-18 18:00:00'),
(18, 17, 'billboard17.jpg', 'image', 295, '2026-01-18 18:00:00', '35', '/uploads/complaints/17/billboard17.jpg', 'Active', 'Verified', 'Illegal billboard photo', '2026-01-19 18:00:00'),
(19, 18, 'vendor18.jpg', 'image', 270, '2026-01-19 18:00:00', '37', '/uploads/complaints/18/vendor18.jpg', 'Active', 'Pending', 'Street vendor evidence', '2026-01-20 18:00:00'),
(20, 19, 'accident19.jpg', 'image', 360, '2026-01-20 18:00:00', '39', '/uploads/complaints/19/accident19.jpg', 'Active', 'Verified', 'Accident documentation', '2026-01-21 18:00:00'),
(21, 20, 'garbage20.jpg', 'image', 300, '2026-01-21 18:00:00', '1', '/uploads/complaints/20/garbage20.jpg', 'Active', 'Verified', 'Overflowing garbage bin', '2026-01-22 18:00:00'),
(22, 21, 'signal21.jpg', 'image', 275, '2026-01-22 18:00:00', '2', '/uploads/complaints/21/signal21.jpg', 'Active', 'Pending', 'Signal malfunction photo', '2026-01-23 18:00:00'),
(23, 22, 'noise22.mp3', 'audio', 4900, '2026-01-23 18:00:00', '4', '/uploads/complaints/22/noise22.mp3', 'Active', 'Verified', 'Noise complaint audio', '2026-01-24 18:00:00'),
(24, 23, 'billboard23.jpg', 'image', 310, '2026-01-24 18:00:00', '6', '/uploads/complaints/23/billboard23.jpg', 'Active', 'Verified', 'Unauthorized billboard', '2026-01-25 18:00:00'),
(25, 24, 'vendor24.jpg', 'image', 285, '2026-01-25 18:00:00', '8', '/uploads/complaints/24/vendor24.jpg', 'Active', 'Pending', 'Street vendor blocking road', '2026-01-26 18:00:00'),
(26, 25, 'accident25.jpg', 'image', 355, '2026-01-26 18:00:00', '10', '/uploads/complaints/25/accident25.jpg', 'Active', 'Verified', 'Accident photo evidence', '2026-01-27 18:00:00'),
(27, 26, 'garbage26.jpg', 'image', 310, '2026-01-27 18:00:00', '12', '/uploads/complaints/26/garbage26.jpg', 'Active', 'Verified', 'Garbage dump photo', '2026-01-28 18:00:00'),
(28, 27, 'signal27.jpg', 'image', 280, '2026-01-28 18:00:00', '14', '/uploads/complaints/27/signal27.jpg', 'Active', 'Pending', 'Traffic signal issue', '2026-01-29 18:00:00'),
(29, 28, 'noise28.mp3', 'audio', 5000, '2026-01-29 18:00:00', '16', '/uploads/complaints/28/noise28.mp3', 'Active', 'Verified', 'Noise pollution evidence', '2026-01-30 18:00:00'),
(30, 29, 'billboard29.jpg', 'image', 300, '2026-01-30 18:00:00', '18', '/uploads/complaints/29/billboard29.jpg', 'Active', 'Verified', 'Illegal billboard', '2026-01-31 18:00:00'),
(31, 30, 'vendor30.jpg', 'image', 275, '2026-01-31 18:00:00', '20', '/uploads/complaints/30/vendor30.jpg', 'Active', 'Pending', 'Street vendor photo', '2026-02-01 18:00:00'),
(32, 31, 'accident31.jpg', 'image', 365, '2026-02-01 18:00:00', '22', '/uploads/complaints/31/accident31.jpg', 'Active', 'Verified', 'Accident documentation', '2026-02-02 18:00:00'),
(33, 32, 'garbage32.jpg', 'image', 315, '2026-02-02 18:00:00', '24', '/uploads/complaints/32/garbage32.jpg', 'Active', 'Verified', 'Garbage pile evidence', '2026-02-03 18:00:00'),
(34, 33, 'signal33.jpg', 'image', 285, '2026-02-03 18:00:00', '26', '/uploads/complaints/33/signal33.jpg', 'Active', 'Pending', 'Signal malfunction photo', '2026-02-04 18:00:00'),
(35, 34, 'noise34.mp3', 'audio', 4950, '2026-02-04 18:00:00', '28', '/uploads/complaints/34/noise34.mp3', 'Active', 'Verified', 'Noise complaint audio', '2026-02-05 18:00:00'),
(36, 35, 'billboard35.jpg', 'image', 305, '2026-02-05 18:00:00', '30', '/uploads/complaints/35/billboard35.jpg', 'Active', 'Verified', 'Unauthorized billboard', '2026-02-06 18:00:00'),
(37, 36, 'vendor36.jpg', 'image', 290, '2026-02-06 18:00:00', '32', '/uploads/complaints/36/vendor36.jpg', 'Active', 'Pending', 'Street vendor blocking road', '2026-02-07 18:00:00'),
(38, 37, 'accident37.jpg', 'image', 370, '2026-02-07 18:00:00', '34', '/uploads/complaints/37/accident37.jpg', 'Active', 'Verified', 'Accident photo evidence', '2026-02-08 18:00:00'),
(39, 38, 'garbage38.jpg', 'image', 320, '2026-02-08 18:00:00', '36', '/uploads/complaints/38/garbage38.jpg', 'Active', 'Verified', 'Garbage dump photo', '2026-02-09 18:00:00'),
(40, 39, 'signal39.jpg', 'image', 290, '2026-02-09 18:00:00', '38', '/uploads/complaints/39/signal39.jpg', 'Active', 'Pending', 'Traffic signal issue', '2026-02-10 18:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `Complaints`
--

CREATE TABLE `Complaints` (
  `complaint_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `description` text NOT NULL,
  `priority_level` varchar(50) DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `evidence_file` varchar(255) DEFAULT NULL,
  `resolution_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Complaints`
--

INSERT INTO `Complaints` (`complaint_id`, `user_id`, `category_id`, `location_id`, `description`, `priority_level`, `submission_date`, `last_updated`, `status_id`, `admin_id`, `evidence_file`, `resolution_note`) VALUES
(1, 1, 3, 5, 'Illegal parking blocking school entrance', 'High', '2026-01-01', '2026-01-01 18:00:00', 1, 2, '/evidence/parking1.jpg', 'Pending review by admin'),
(2, 2, 4, 8, 'Street vendor encroaching pedestrian walkway', 'Medium', '2026-01-02', '2026-01-02 18:00:00', 2, 3, '/evidence/vendor2.jpg', 'Investigation ongoing'),
(3, 3, 2, 6, 'Broken traffic signal at busy intersection', 'High', '2026-01-03', '2026-01-03 18:00:00', 3, 4, '/evidence/signal3.jpg', 'Signal repaired successfully'),
(4, 4, 5, 9, 'Unauthorized billboard causing distraction', 'Medium', '2026-01-04', '2026-01-04 18:00:00', 4, 5, '/evidence/billboard4.jpg', 'Closed due to insufficient evidence'),
(5, 5, 1, 7, 'Garbage dumping near bus stop', 'Low', '2026-01-05', '2026-01-05 18:00:00', 5, 6, '/evidence/garbage5.jpg', 'Complaint rejected as invalid'),
(6, 6, 3, 10, 'Accident site not cleared promptly', 'High', '2026-01-06', '2026-01-06 18:00:00', 6, 7, '/evidence/accident6.jpg', 'Escalated to senior admin'),
(7, 7, 6, 11, 'Noise pollution from roadside garage', 'Medium', '2026-01-07', '2026-01-07 18:00:00', 7, 8, '/evidence/noise7.mp3', 'Awaiting user evidence'),
(8, 8, 2, 12, 'Traffic congestion due to illegal U-turns', 'High', '2026-01-08', '2026-01-08 18:00:00', 8, 9, '/evidence/congestion8.jpg', 'Under detailed review'),
(9, 9, 4, 13, 'Street hawkers blocking cycle lane', 'Medium', '2026-01-09', '2026-01-09 18:00:00', 9, 10, '/evidence/hawkers9.jpg', 'Forwarded to maintenance'),
(10, 10, 5, 14, 'Unauthorized roadside garage causing obstruction', 'Low', '2026-01-10', '2026-01-10 18:00:00', 10, 11, '/evidence/garage10.jpg', 'Deferred due to workload'),
(11, 11, 1, 15, 'Garbage pile-up near hospital zone', 'High', '2026-01-11', '2026-01-11 18:00:00', 11, 12, '/evidence/garbage11.jpg', 'Awaiting assignment'),
(12, 12, 3, 16, 'Illegal parking in residential area', 'Medium', '2026-01-12', '2026-01-12 18:00:00', 12, 13, '/evidence/parking12.jpg', 'Assigned to admin'),
(13, 13, 2, 17, 'Traffic signal malfunction at market square', 'High', '2026-01-13', '2026-01-13 18:00:00', 13, 14, '/evidence/signal13.jpg', 'Investigation started'),
(14, 14, 4, 18, 'Street vendor blocking pedestrian crossing', 'Medium', '2026-01-14', '2026-01-14 18:00:00', 14, 15, '/evidence/vendor14.jpg', 'Evidence collected'),
(15, 15, 5, 19, 'Unauthorized billboard near school zone', 'High', '2026-01-15', '2026-01-15 18:00:00', 15, 1, '/evidence/billboard15.jpg', 'Verification pending'),
(16, 16, 6, 20, 'Noise pollution from construction site', 'Medium', '2026-01-16', '2026-01-16 18:00:00', 16, 2, '/evidence/noise16.mp3', 'Evidence verified'),
(17, 17, 1, 21, 'Garbage dumping in residential lane', 'High', '2026-01-17', '2026-01-17 18:00:00', 17, 3, '/evidence/garbage17.jpg', 'Action scheduled'),
(18, 18, 2, 22, 'Traffic congestion due to broken signal', 'High', '2026-01-18', '2026-01-18 18:00:00', 18, 4, '/evidence/signal18.jpg', 'Action taken'),
(19, 19, 3, 23, 'Illegal parking near hospital gate', 'Medium', '2026-01-19', '2026-01-19 18:00:00', 19, 5, '/evidence/parking19.jpg', 'Awaiting user response'),
(20, 20, 4, 24, 'Street hawkers blocking bus stop', 'Medium', '2026-01-20', '2026-01-20 18:00:00', 20, 6, '/evidence/hawkers20.jpg', 'User responded'),
(21, 21, 5, 25, 'Unauthorized billboard near traffic signal', 'High', '2026-01-21', '2026-01-21 18:00:00', 21, 7, '/evidence/billboard21.jpg', 'Awaiting approval'),
(22, 22, 6, 26, 'Noise pollution from roadside vendors', 'Medium', '2026-01-22', '2026-01-22 18:00:00', 22, 8, '/evidence/noise22.mp3', 'Approved'),
(23, 23, 1, 27, 'Garbage pile-up near school zone', 'Low', '2026-01-23', '2026-01-23 18:00:00', 23, 9, '/evidence/garbage23.jpg', 'Rejected by admin'),
(24, 24, 2, 28, 'Traffic signal malfunction at highway', 'High', '2026-01-24', '2026-01-24 18:00:00', 24, 10, '/evidence/signal24.jpg', 'Reopened'),
(25, 25, 3, 29, 'Illegal parking in market area', 'Medium', '2026-01-25', '2026-01-25 18:00:00', 25, 11, '/evidence/parking25.jpg', 'Transferred'),
(26, 26, 4, 30, 'Street vendor blocking cycle lane', 'Low', '2026-01-26', '2026-01-26 18:00:00', 26, 12, '/evidence/vendor26.jpg', 'On hold'),
(27, 27, 5, 31, 'Unauthorized billboard near residential zone', 'Medium', '2026-01-27', '2026-01-27 18:00:00', 27, 13, '/evidence/billboard27.jpg', 'Awaiting inspection'),
(28, 28, 6, 32, 'Noise pollution from roadside garage', 'High', '2026-01-28', '2026-01-28 18:00:00', 28, 14, '/evidence/noise28.mp3', 'Inspection completed'),
(29, 29, 1, 33, 'Garbage dumping near pedestrian crossing', 'Medium', '2026-01-29', '2026-01-29 18:00:00', 29, 15, '/evidence/garbage29.jpg', 'Awaiting report'),
(30, 30, 2, 34, 'Traffic congestion due to illegal parking', 'High', '2026-01-30', '2026-01-30 18:00:00', 30, 1, '/evidence/congestion30.jpg', 'Report submitted'),
(31, 31, 3, 35, 'Illegal parking near bus depot', 'Medium', '2026-02-01', '2026-02-01 18:00:00', 31, 2, '/evidence/parking31.jpg', 'Awaiting resolution note'),
(32, 32, 4, 36, 'Street hawkers blocking hospital gate', 'High', '2026-02-02', '2026-02-02 18:00:00', 32, 3, '/evidence/hawkers32.jpg', 'Resolution note added'),
(33, 33, 5, 37, 'Unauthorized billboard near highway', 'Medium', '2026-02-03', '2026-02-03 18:00:00', 33, 4, '/evidence/billboard33.jpg', 'Awaiting closure'),
(34, 34, 6, 38, 'Noise pollution from construction site', 'High', '2026-02-04', '2026-02-04 18:00:00', 34, 4, '/evidence/noise34.mp3', 'Closure confirmed by admin'),
(35, 35, 1, 39, 'Garbage dumping near residential playground', 'Medium', '2026-02-05', '2026-02-05 18:00:00', 35, 5, '/evidence/garbage35.jpg', 'Archived after resolution'),
(36, 36, 2, 40, 'Traffic signal malfunction at busy junction', 'High', '2026-02-06', '2026-02-06 18:00:00', 36, 6, '/evidence/signal36.jpg', 'Follow-up scheduled with complainant'),
(37, 37, 3, 1, 'Illegal parking blocking fire exit', 'High', '2026-02-07', '2026-02-07 18:00:00', 37, 7, '/evidence/parking37.jpg', 'Follow-up completed successfully'),
(38, 38, 4, 2, 'Street hawkers obstructing hospital entrance', 'Medium', '2026-02-08', '2026-02-08 18:00:00', 38, 8, '/evidence/hawkers38.jpg', 'Awaiting feedback from complainant'),
(39, 39, 5, 3, 'Unauthorized billboard near school zone', 'High', '2026-02-09', '2026-02-09 18:00:00', 39, 9, '/evidence/billboard39.jpg', 'Feedback received and recorded'),
(40, 40, 6, 4, 'Noise pollution from roadside workshop', 'Low', '2026-02-10', '2026-02-10 18:00:00', 40, 10, '/evidence/noise40.mp3', 'Case closed and archived');

-- --------------------------------------------------------

--
-- Table structure for table `Complaint_Categories`
--

CREATE TABLE `Complaint_Categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `priority_level` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `category_code` varchar(50) DEFAULT NULL,
  `category_type` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Complaint_Categories`
--

INSERT INTO `Complaint_Categories` (`category_id`, `category_name`, `description`, `created_date`, `updated_date`, `status`, `priority_level`, `department`, `category_code`, `category_type`, `created_by`, `remarks`) VALUES
(1, 'Illegal Parking', 'Vehicles parked in unauthorized or restricted areas', '2026-01-01', '2026-01-02', 'Active', 'High', 'Traffic Control', 'CAT001', 'Violation', 'SystemAdmin', 'Frequent issue in city centers'),
(2, 'Traffic Signal Issue', 'Malfunctioning or broken traffic lights at intersections', '2026-01-02', '2026-01-03', 'Active', 'Medium', 'Traffic Control', 'CAT002', 'Infrastructure', 'SystemAdmin', 'Reported mostly during monsoon'),
(3, 'Road Accident', 'Accidents caused by reckless or negligent driving', '2026-01-03', '2026-01-04', 'Active', 'High', 'Traffic Control', 'CAT003', 'Incident', 'SystemAdmin', 'Requires immediate response'),
(4, 'Street Light Issue', 'Street lights not functioning or damaged', '2026-01-04', '2026-01-05', 'Active', 'Low', 'City Maintenance', 'CAT004', 'Infrastructure', 'SystemAdmin', 'Forwarded to city maintenance'),
(5, 'Overloaded Vehicle', 'Vehicles carrying excess load beyond legal limits', '2026-01-05', '2026-01-06', 'Active', 'High', 'Traffic Control', 'CAT005', 'Violation', 'SystemAdmin', 'Common with trucks'),
(6, 'Jaywalking', 'Pedestrians crossing roads illegally or dangerously', '2026-01-06', '2026-01-07', 'Active', 'Medium', 'Traffic Control', 'CAT006', 'Violation', 'SystemAdmin', 'Awareness campaign needed'),
(7, 'Unauthorized Rickshaw Stand', 'Rickshaw stands blocking traffic flow', '2026-01-07', '2026-01-08', 'Active', 'High', 'Traffic Control', 'CAT007', 'Violation', 'SystemAdmin', 'Frequent in market areas'),
(8, 'Noise Pollution', 'Excessive honking or vehicle noise disturbing residents', '2026-01-08', '2026-01-09', 'Active', 'Low', 'Traffic Control', 'CAT008', 'Violation', 'SystemAdmin', 'Requires awareness drives'),
(9, 'Street Vendors', 'Vendors occupying footpaths or roads illegally', '2026-01-09', '2026-01-10', 'Active', 'Medium', 'City Maintenance', 'CAT009', 'Encroachment', 'SystemAdmin', 'Relocation required'),
(10, 'Broken Divider', 'Damaged road dividers causing accidents', '2026-01-10', '2026-01-11', 'Active', 'High', 'City Maintenance', 'CAT010', 'Infrastructure', 'SystemAdmin', 'Repair scheduled'),
(11, 'Illegal Bus Stop', 'Unauthorized bus stops creating congestion', '2026-01-11', '2026-01-12', 'Active', 'Medium', 'Traffic Control', 'CAT011', 'Violation', 'SystemAdmin', 'Removal required'),
(12, 'Blocked Drainage', 'Drainage blocked causing waterlogging on roads', '2026-01-12', '2026-01-13', 'Active', 'High', 'City Maintenance', 'CAT012', 'Infrastructure', 'SystemAdmin', 'Forwarded to drainage dept'),
(13, 'Speeding Vehicles', 'Vehicles exceeding speed limits in sensitive zones', '2026-01-13', '2026-01-14', 'Active', 'High', 'Traffic Control', 'CAT013', 'Violation', 'SystemAdmin', 'Speed breakers suggested'),
(14, 'Illegal Billboard', 'Billboards obstructing driver visibility', '2026-01-14', '2026-01-15', 'Active', 'Low', 'City Maintenance', 'CAT014', 'Encroachment', 'SystemAdmin', 'Billboard removal required'),
(15, 'Taxi Misconduct', 'Taxi drivers refusing passengers or overcharging', '2026-01-15', '2026-01-16', 'Active', 'Medium', 'Traffic Control', 'CAT015', 'Violation', 'SystemAdmin', 'Penalties imposed'),
(16, 'Unauthorized Fuel Station', 'Illegal fuel stations operating without permits', '2026-01-16', '2026-01-17', 'Active', 'High', 'Traffic Control', 'CAT016', 'Violation', 'SystemAdmin', 'Immediate closure required'),
(17, 'Encroachment on Road', 'Structures or shops encroaching on public roads', '2026-01-17', '2026-01-18', 'Active', 'High', 'City Maintenance', 'CAT017', 'Encroachment', 'SystemAdmin', 'Clearance drive needed'),
(18, 'Cycle Lane Obstruction', 'Cycle lanes blocked by cars or vendors', '2026-01-18', '2026-01-19', 'Active', 'Medium', 'Traffic Control', 'CAT018', 'Violation', 'SystemAdmin', 'Cars fined'),
(19, 'Hospital Zone Parking', 'Illegal parking near hospitals blocking access', '2026-01-19', '2026-01-20', 'Active', 'High', 'Traffic Control', 'CAT019', 'Violation', 'SystemAdmin', 'Strict enforcement required'),
(20, 'Unauthorized Construction', 'Construction activities blocking roadways', '2026-01-20', '2026-01-21', 'Active', 'High', 'City Maintenance', 'CAT020', 'Encroachment', 'SystemAdmin', 'Construction stopped'),
(21, 'Garbage Dumping', 'Garbage dumped on roadside or intersections', '2026-01-21', '2026-01-22', 'Active', 'Low', 'City Maintenance', 'CAT021', 'Violation', 'SystemAdmin', 'Cleaned by municipal workers'),
(22, 'Illegal Auto Stand', 'Unauthorized auto stands creating congestion', '2026-01-22', '2026-01-23', 'Active', 'Medium', 'Traffic Control', 'CAT022', 'Violation', 'SystemAdmin', 'Stand removed'),
(23, 'Unauthorized Hawkers', 'Hawkers occupying bridges or public spaces', '2026-01-23', '2026-01-24', 'Active', 'Low', 'City Maintenance', 'CAT023', 'Encroachment', 'SystemAdmin', 'Relocated'),
(24, 'School Zone Parking', 'Illegal parking in school zones', '2026-01-24', '2026-01-25', 'Active', 'High', 'Traffic Control', 'CAT024', 'Violation', 'SystemAdmin', 'Parking cleared'),
(25, 'Broken Pedestrian Crossing', 'Damaged pedestrian crossings causing risk', '2026-01-25', '2026-01-26', 'Active', 'Medium', 'City Maintenance', 'CAT025', 'Infrastructure', 'SystemAdmin', 'Repair scheduled'),
(26, 'Unauthorized Bus Depot', 'Illegal bus depots operating without permits', '2026-01-26', '2026-01-27', 'Active', 'High', 'Traffic Control', 'CAT026', 'Violation', 'SystemAdmin', 'Depot closed'),
(27, 'Illegal Taxi Stand', 'Unauthorized taxi stands blocking traffic', '2026-01-27', '2026-01-28', 'Active', 'Medium', 'Traffic Control', 'CAT027', 'Violation', 'SystemAdmin', 'Stand removed'),
(28, 'Footpath Encroachment', 'Encroachment on pedestrian footpaths', '2026-01-28', '2026-01-29', 'Active', 'High', 'City Maintenance', 'CAT028', 'Encroachment', 'SystemAdmin', 'Cleared'),
(29, 'Market Zone Parking', 'Illegal parking near markets', '2026-01-29', '2026-01-30', 'Active', 'High', 'Traffic Control', 'CAT029', 'Violation', 'SystemAdmin', 'Parking cleared'),
(30, 'Unauthorized Billboard', 'Billboards without permits', '2026-01-30', '2026-01-31', 'Active', 'Low', 'City Maintenance', 'CAT030', 'Encroachment', 'SystemAdmin', 'Removed'),
(31, 'Illegal Bus Stop', 'Unauthorized bus stops creating congestion', '2026-02-01', '2026-02-02', 'Active', 'Medium', 'Traffic Control', 'CAT031', 'Violation', 'SystemAdmin', 'Stop removed'),
(32, 'Construction Blocking Road', 'Unauthorized construction blocking roadways', '2026-02-02', '2026-02-03', 'Active', 'High', 'City Maintenance', 'CAT032', 'Encroachment', 'SystemAdmin', 'Stopped'),
(33, 'Residential Parking Violation', 'Illegal parking in residential areas', '2026-02-03', '2026-02-04', 'Active', 'Medium', 'Traffic Control', 'CAT033', 'Violation', 'SystemAdmin', 'Stopped'),
(34, 'Unauthorized Vendors', 'Vendors occupying roadside illegally', '2026-02-04', '2026-02-05', 'Active', 'Low', 'City Maintenance', 'CAT034', 'Encroachment', 'SystemAdmin', 'Relocated to designated market'),
(35, 'Illegal Fuel Station', 'Fuel stations operating without permits', '2026-02-05', '2026-02-06', 'Active', 'High', 'Traffic Control', 'CAT035', 'Violation', 'SystemAdmin', 'Immediate closure required'),
(36, 'Bus Parking Violation', 'Unauthorized bus parking near stadiums', '2026-02-06', '2026-02-07', 'Active', 'High', 'Traffic Control', 'CAT036', 'Violation', 'SystemAdmin', 'Parking cleared'),
(37, 'Street Vendor Obstruction', 'Vendors blocking pedestrian crossings', '2026-02-07', '2026-02-08', 'Active', 'Medium', 'City Maintenance', 'CAT037', 'Encroachment', 'SystemAdmin', 'Vendors relocated'),
(38, 'Illegal Billboard', 'Billboards near traffic signals obstructing view', '2026-02-08', '2026-02-09', 'Active', 'Low', 'City Maintenance', 'CAT038', 'Encroachment', 'SystemAdmin', 'Removed by city authority'),
(39, 'Motorcycle Racing', 'Reckless motorcycle racing at night', '2026-02-09', '2026-02-10', 'Active', 'High', 'Traffic Control', 'CAT039', 'Incident', 'SystemAdmin', 'Police patrol increased'),
(40, 'Garbage Dumping', 'Garbage dumped on busy intersections', '2026-02-10', '2026-02-11', 'Active', 'Medium', 'City Maintenance', 'CAT040', 'Violation', 'SystemAdmin', 'Cleaned by municipal workers');

-- --------------------------------------------------------

--
-- Table structure for table `Complaint_History`
--

CREATE TABLE `Complaint_History` (
  `history_id` int(11) NOT NULL,
  `complaint_id` int(11) NOT NULL,
  `old_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `changed_by` varchar(100) DEFAULT NULL,
  `change_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `remarks` text DEFAULT NULL,
  `update_source` varchar(100) DEFAULT NULL,
  `priority_change` varchar(50) DEFAULT NULL,
  `assigned_admin` int(11) DEFAULT NULL,
  `resolution_time` varchar(50) DEFAULT NULL,
  `status_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Complaint_History`
--

INSERT INTO `Complaint_History` (`history_id`, `complaint_id`, `old_status`, `new_status`, `changed_by`, `change_date`, `remarks`, `update_source`, `priority_change`, `assigned_admin`, `resolution_time`, `status_note`) VALUES
(1, 1, 'Pending', 'In Progress', '2', '2026-01-01 18:00:00', 'Admin started investigation', 'Admin', 'None', 2, NULL, 'Investigation initiated'),
(2, 1, 'In Progress', 'Resolved', '2', '2026-01-03 18:00:00', 'Complaint resolved successfully', 'System', 'None', 2, '2 days', 'Resolved with evidence verified'),
(3, 2, 'Pending', 'Rejected', '4', '2026-01-04 18:00:00', 'Insufficient evidence provided', 'Admin', 'None', 4, NULL, 'Rejected due to lack of proof'),
(4, 3, 'Pending', 'In Progress', '6', '2026-01-05 18:00:00', 'Signal issue under review', 'Admin', 'None', 6, NULL, 'Assigned to traffic department'),
(5, 3, 'In Progress', 'Resolved', '6', '2026-01-07 18:00:00', 'Signal repaired', 'System', 'None', 6, '2 days', 'Resolved successfully'),
(6, 4, 'Pending', 'In Progress', '8', '2026-01-06 18:00:00', 'Noise complaint verified', 'Admin', 'Low→High', 8, NULL, 'Priority escalated'),
(7, 4, 'In Progress', 'Resolved', '8', '2026-01-08 18:00:00', 'Noise reduced after intervention', 'System', 'None', 8, '2 days', 'Resolved with community cooperation'),
(8, 5, 'Pending', 'Rejected', '10', '2026-01-07 18:00:00', 'Complaint invalid', 'Admin', 'None', 10, NULL, 'Rejected after review'),
(9, 6, 'Pending', 'In Progress', '12', '2026-01-08 18:00:00', 'Vendor issue under investigation', 'Admin', 'None', 12, NULL, 'Investigation started'),
(10, 6, 'In Progress', 'Escalated', '12', '2026-01-09 18:00:00', 'Escalated to senior admin', 'Admin', 'None', 14, NULL, 'Escalated due to severity'),
(11, 7, 'Pending', 'In Progress', '14', '2026-01-10 18:00:00', 'Accident case assigned', 'Admin', 'High→Low', 14, NULL, 'Priority adjusted'),
(12, 7, 'In Progress', 'Resolved', '14', '2026-01-12 18:00:00', 'Accident cleared', 'System', 'None', 14, '2 days', 'Resolved successfully'),
(13, 8, 'Pending', 'In Progress', '16', '2026-01-11 18:00:00', 'Garbage issue verified', 'Admin', 'None', 16, NULL, 'Assigned to sanitation'),
(14, 8, 'In Progress', 'Resolved', '16', '2026-01-13 18:00:00', 'Garbage removed', 'System', 'None', 16, '2 days', 'Resolved successfully'),
(15, 9, 'Pending', 'In Progress', '18', '2026-01-12 18:00:00', 'Signal malfunction confirmed', 'Admin', 'None', 18, NULL, 'Investigation started'),
(16, 9, 'In Progress', 'Resolved', '18', '2026-01-14 18:00:00', 'Signal repaired', 'System', 'None', 18, '2 days', 'Resolved successfully'),
(17, 10, 'Pending', 'In Progress', '20', '2026-01-13 18:00:00', 'Noise complaint reviewed', 'Admin', 'None', 20, NULL, 'Investigation started'),
(18, 10, 'In Progress', 'Resolved', '20', '2026-01-15 18:00:00', 'Noise reduced', 'System', 'None', 20, '2 days', 'Resolved successfully'),
(19, 11, 'Pending', 'In Progress', '22', '2026-01-14 18:00:00', 'Billboard issue verified', 'Admin', 'None', 22, NULL, 'Assigned to department'),
(20, 11, 'In Progress', 'Resolved', '22', '2026-01-16 18:00:00', 'Billboard removed', 'System', 'None', 22, '2 days', 'Resolved successfully'),
(21, 12, 'Pending', 'In Progress', '24', '2026-01-15 18:00:00', 'Vendor issue under review', 'Admin', 'None', 24, NULL, 'Investigation started'),
(22, 12, 'In Progress', 'Resolved', '24', '2026-01-17 18:00:00', 'Vendor relocated', 'System', 'None', 24, '2 days', 'Resolved successfully'),
(23, 13, 'Pending', 'In Progress', '26', '2026-01-16 18:00:00', 'Accident case assigned', 'Admin', 'None', 26, NULL, 'Investigation started'),
(24, 13, 'In Progress', 'Resolved', '26', '2026-01-18 18:00:00', 'Accident cleared', 'System', 'None', 26, '2 days', 'Resolved successfully'),
(25, 14, 'Pending', 'In Progress', '28', '2026-01-17 18:00:00', 'Garbage issue verified', 'Admin', 'None', 28, NULL, 'Assigned to sanitation'),
(26, 14, 'In Progress', 'Resolved', '28', '2026-01-19 18:00:00', 'Garbage removed', 'System', 'None', 28, '2 days', 'Resolved successfully'),
(27, 15, 'Pending', 'In Progress', '30', '2026-01-18 18:00:00', 'Signal malfunction confirmed', 'Admin', 'None', 30, NULL, 'Investigation started'),
(28, 15, 'In Progress', 'Resolved', '30', '2026-01-20 18:00:00', 'Signal repaired', 'System', 'None', 30, '2 days', 'Resolved successfully'),
(29, 16, 'Pending', 'In Progress', '32', '2026-01-19 18:00:00', 'Noise complaint reviewed', 'Admin', 'None', 32, NULL, 'Investigation started'),
(30, 16, 'In Progress', 'Resolved', '32', '2026-01-21 18:00:00', 'Noise reduced', 'System', 'None', 32, '2 days', 'Resolved successfully'),
(31, 17, 'Pending', 'In Progress', '34', '2026-01-20 18:00:00', 'Billboard issue verified', 'Admin', 'None', 34, NULL, 'Assigned to department'),
(32, 17, 'In Progress', 'Resolved', '34', '2026-01-22 18:00:00', 'Billboard removed', 'System', 'None', 34, '2 days', 'Resolved successfully'),
(33, 18, 'Pending', 'In Progress', '36', '2026-01-21 18:00:00', 'Vendor issue under review', 'Admin', 'None', 36, NULL, 'Investigation started'),
(34, 18, 'In Progress', 'Resolved', '36', '2026-01-23 18:00:00', 'Vendor relocated', 'System', 'None', 36, '2 days', 'Resolved successfully'),
(35, 19, 'Pending', 'In Progress', '38', '2026-01-22 18:00:00', 'Accident case assigned', 'Admin', 'None', 38, NULL, 'Investigation started'),
(36, 19, 'In Progress', 'Resolved', '38', '2026-01-24 18:00:00', 'Accident cleared', 'System', 'None', 38, '2 days', 'Resolved successfully'),
(37, 20, 'Pending', 'In Progress', '40', '2026-01-23 18:00:00', 'Garbage issue verified', 'Admin', 'None', 40, NULL, 'Assigned to sanitation'),
(38, 20, 'In Progress', 'Resolved', '40', '2026-01-25 18:00:00', 'Garbage removed', 'System', 'None', 40, '2 days', 'Resolved successfully'),
(39, 21, 'Pending', 'In Progress', '2', '2026-01-24 18:00:00', 'Signal malfunction confirmed', 'Admin', 'None', 2, NULL, 'Investigation started'),
(40, 21, 'In Progress', 'Resolved', '2', '2026-01-26 18:00:00', 'Signal repaired', 'System', 'None', 2, '2 days', 'Resolved successfully');

-- --------------------------------------------------------

--
-- Table structure for table `Complaint_Status`
--

CREATE TABLE `Complaint_Status` (
  `status_id` int(11) NOT NULL,
  `status_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `status_level` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `status_code` varchar(50) DEFAULT NULL,
  `handled_by` int(11) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT NULL,
  `status_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Complaint_Status`
--

INSERT INTO `Complaint_Status` (`status_id`, `status_name`, `description`, `created_date`, `updated_date`, `status_level`, `is_active`, `status_code`, `handled_by`, `remarks`, `last_modified`, `status_type`) VALUES
(1, 'Pending Review', 'Complaint submitted but not yet reviewed', '2026-01-01', '2026-01-02', 'Medium', 1, 'STS001', 1, 'Awaiting admin assignment', '2026-01-01 18:00:00', 'Initial'),
(2, 'In Progress', 'Complaint is currently being investigated', '2026-01-02', '2026-01-03', 'High', 1, 'STS002', 2, 'Investigation ongoing', '2026-01-02 18:00:00', 'Process'),
(3, 'Resolved', 'Complaint has been resolved successfully', '2026-01-03', '2026-01-04', 'High', 1, 'STS003', 3, 'Resolution note added', '2026-01-03 18:00:00', 'Final'),
(4, 'Closed', 'Complaint closed without resolution', '2026-01-04', '2026-01-05', 'Low', 0, 'STS004', 4, 'Closed due to insufficient evidence', '2026-01-04 18:00:00', 'Final'),
(5, 'Rejected', 'Complaint rejected due to invalid details', '2026-01-05', '2026-01-06', 'Low', 0, 'STS005', 5, 'Invalid complaint', '2026-01-05 18:00:00', 'Final'),
(6, 'Escalated', 'Complaint escalated to higher authority', '2026-01-06', '2026-01-07', 'High', 1, 'STS006', 6, 'Escalated to senior admin', '2026-01-06 18:00:00', 'Process'),
(7, 'Awaiting Evidence', 'Complaint requires additional evidence', '2026-01-07', '2026-01-08', 'Medium', 1, 'STS007', 7, 'Evidence requested from user', '2026-01-07 18:00:00', 'Initial'),
(8, 'Under Review', 'Complaint under detailed review', '2026-01-08', '2026-01-09', 'Medium', 1, 'STS008', 8, 'Review in progress', '2026-01-08 18:00:00', 'Process'),
(9, 'Forwarded', 'Complaint forwarded to another department', '2026-01-09', '2026-01-10', 'Medium', 1, 'STS009', 9, 'Forwarded to maintenance', '2026-01-09 18:00:00', 'Process'),
(10, 'Deferred', 'Complaint deferred for later action', '2026-01-10', '2026-01-11', 'Low', 0, 'STS010', 10, 'Deferred due to workload', '2026-01-10 18:00:00', 'Process'),
(11, 'Awaiting Assignment', 'Complaint waiting to be assigned to an admin', '2026-01-11', '2026-01-12', 'Medium', 1, 'STS011', 11, 'Pending admin allocation', '2026-01-11 18:00:00', 'Initial'),
(12, 'Assigned', 'Complaint assigned to an admin for review', '2026-01-12', '2026-01-13', 'Medium', 1, 'STS012', 12, 'Admin assigned', '2026-01-12 18:00:00', 'Process'),
(13, 'Investigation Started', 'Admin has started investigating the complaint', '2026-01-13', '2026-01-14', 'High', 1, 'STS013', 13, 'Investigation ongoing', '2026-01-13 18:00:00', 'Process'),
(14, 'Evidence Collected', 'Evidence has been collected for the complaint', '2026-01-14', '2026-01-15', 'High', 1, 'STS014', 14, 'Evidence attached', '2026-01-14 18:00:00', 'Process'),
(15, 'Verification Pending', 'Complaint evidence pending verification', '2026-01-15', '2026-01-16', 'Medium', 1, 'STS015', 15, 'Verification required', '2026-01-15 18:00:00', 'Process'),
(16, 'Verified', 'Complaint evidence verified successfully', '2026-01-16', '2026-01-17', 'High', 1, 'STS016', 1, 'Evidence verified', '2026-01-16 18:00:00', 'Process'),
(17, 'Action Scheduled', 'Action scheduled to resolve complaint', '2026-01-17', '2026-01-18', 'High', 1, 'STS017', 2, 'Resolution scheduled', '2026-01-17 18:00:00', 'Process'),
(18, 'Action Taken', 'Action taken to resolve complaint', '2026-01-18', '2026-01-19', 'High', 1, 'STS018', 3, 'Action completed', '2026-01-18 18:00:00', 'Final'),
(19, 'Awaiting User Response', 'Waiting for complainant to respond', '2026-01-19', '2026-01-20', 'Medium', 1, 'STS019', 4, 'User response pending', '2026-01-19 18:00:00', 'Process'),
(20, 'User Responded', 'Complainant has responded with details', '2026-01-20', '2026-01-21', 'Medium', 1, 'STS020', 5, 'User response received', '2026-01-20 18:00:00', 'Process'),
(21, 'Awaiting Approval', 'Complaint resolution awaiting approval', '2026-01-21', '2026-01-22', 'Medium', 1, 'STS021', 6, 'Approval pending', '2026-01-21 18:00:00', 'Process'),
(22, 'Approved', 'Complaint resolution approved', '2026-01-22', '2026-01-23', 'High', 1, 'STS022', 7, 'Resolution approved', '2026-01-22 18:00:00', 'Final'),
(23, 'Rejected by Admin', 'Complaint rejected by admin after review', '2026-01-23', '2026-01-24', 'Low', 0, 'STS023', 8, 'Rejected after review', '2026-01-23 18:00:00', 'Final'),
(24, 'Reopened', 'Complaint reopened after closure', '2026-01-24', '2026-01-25', 'High', 1, 'STS024', 9, 'Reopened for further action', '2026-01-24 18:00:00', 'Process'),
(25, 'Transferred', 'Complaint transferred to another department', '2026-01-25', '2026-01-26', 'Medium', 1, 'STS025', 10, 'Transferred to maintenance', '2026-01-25 18:00:00', 'Process'),
(26, 'On Hold', 'Complaint put on hold temporarily', '2026-01-26', '2026-01-27', 'Low', 0, 'STS026', 11, 'On hold due to resource constraints', '2026-01-26 18:00:00', 'Process'),
(27, 'Awaiting Inspection', 'Complaint awaiting physical inspection', '2026-01-27', '2026-01-28', 'Medium', 1, 'STS027', 12, 'Inspection scheduled', '2026-01-27 18:00:00', 'Process'),
(28, 'Inspection Completed', 'Physical inspection completed', '2026-01-28', '2026-01-29', 'High', 1, 'STS028', 13, 'Inspection report filed', '2026-01-28 18:00:00', 'Process'),
(29, 'Awaiting Report', 'Complaint awaiting final report', '2026-01-29', '2026-01-30', 'Medium', 1, 'STS029', 14, 'Report pending', '2026-01-29 18:00:00', 'Process'),
(30, 'Report Submitted', 'Final report submitted for complaint', '2026-01-30', '2026-01-31', 'High', 1, 'STS030', 15, 'Report submitted', '2026-01-30 18:00:00', 'Final'),
(31, 'Awaiting Resolution Note', 'Resolution note pending entry', '2026-02-01', '2026-02-02', 'Medium', 1, 'STS031', 1, 'Resolution note pending', '2026-02-01 18:00:00', 'Process'),
(32, 'Resolution Note Added', 'Resolution note added to complaint', '2026-02-02', '2026-02-03', 'High', 1, 'STS032', 2, 'Resolution note attached', '2026-02-02 18:00:00', 'Final'),
(33, 'Awaiting Closure', 'Complaint awaiting closure confirmation', '2026-02-03', '2026-02-04', 'Medium', 1, 'STS033', 3, 'Closure pending', '2026-02-03 18:00:00', 'Process'),
(34, 'Closure Confirmed', 'Complaint closure confirmed', '2026-02-04', '2026-02-05', 'High', 1, 'STS034', 4, 'Closure confirmed by admin', '2026-02-04 18:00:00', 'Final'),
(35, 'Archived', 'Complaint archived for record keeping', '2026-02-05', '2026-02-06', 'Low', 0, 'STS035', 5, 'Archived after resolution', '2026-02-05 18:00:00', 'Final'),
(36, 'Follow-up Scheduled', 'Follow-up scheduled for complaint', '2026-02-06', '2026-02-07', 'Medium', 1, 'STS036', 6, 'Follow-up scheduled with complainant', '2026-02-06 18:00:00', 'Process'),
(37, 'Follow-up Completed', 'Follow-up completed successfully', '2026-02-07', '2026-02-08', 'High', 1, 'STS037', 7, 'Follow-up done and recorded', '2026-02-07 18:00:00', 'Final'),
(38, 'Awaiting Feedback', 'Awaiting feedback from complainant', '2026-02-08', '2026-02-09', 'Medium', 1, 'STS038', 8, 'Feedback pending from user', '2026-02-08 18:00:00', 'Process'),
(39, 'Feedback Received', 'Feedback received from complainant', '2026-02-09', '2026-02-10', 'High', 1, 'STS039', 9, 'Feedback recorded successfully', '2026-02-09 18:00:00', 'Final'),
(40, 'Case Closed', 'Complaint case closed permanently', '2026-02-10', '2026-02-11', 'Low', 0, 'STS040', 10, 'Case closed and archived', '2026-02-10 18:00:00', 'Final');

-- --------------------------------------------------------

--
-- Table structure for table `Locations`
--

CREATE TABLE `Locations` (
  `location_id` int(11) NOT NULL,
  `road_name` varchar(100) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `traffic_zone` varchar(100) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `updated_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Locations`
--

INSERT INTO `Locations` (`location_id`, `road_name`, `area`, `district`, `city`, `postal_code`, `landmark`, `latitude`, `longitude`, `traffic_zone`, `created_date`, `updated_date`) VALUES
(1, 'Progoti Sarani', 'Bashundhara R/A', 'Dhaka', 'Dhaka', '1229', 'Bashundhara City Mall', 23.815100, 90.426500, 'Zone A', '2026-01-01', '2026-01-02'),
(2, 'Mirpur Road', 'Dhanmondi', 'Dhaka', 'Dhaka', '1209', 'Dhanmondi Lake', 23.746500, 90.373000, 'Zone B', '2026-01-02', '2026-01-03'),
(3, 'Begum Rokeya Avenue', 'Mirpur', 'Dhaka', 'Dhaka', '1216', 'Mirpur Stadium', 23.806000, 90.368600, 'Zone C', '2026-01-03', '2026-01-04'),
(4, 'Banani Road 11', 'Banani', 'Dhaka', 'Dhaka', '1213', 'Banani Super Market', 23.790500, 90.407000, 'Zone A', '2026-01-04', '2026-01-05'),
(5, 'Airport Road', 'Uttara', 'Dhaka', 'Dhaka', '1230', 'Hazrat Shahjalal Airport', 23.843000, 90.397800, 'Zone D', '2026-01-05', '2026-01-06'),
(6, 'Mohakhali Bus Terminal Road', 'Mohakhali', 'Dhaka', 'Dhaka', '1212', 'Mohakhali Bus Terminal', 23.780000, 90.400000, 'Zone B', '2026-01-06', '2026-01-07'),
(7, 'Gulshan Avenue', 'Gulshan', 'Dhaka', 'Dhaka', '1212', 'Gulshan Circle 2', 23.792500, 90.416000, 'Zone A', '2026-01-07', '2026-01-08'),
(8, 'Khilgaon Taltola Road', 'Khilgaon', 'Dhaka', 'Dhaka', '1219', 'Taltola Market', 23.750000, 90.420000, 'Zone C', '2026-01-08', '2026-01-09'),
(9, 'Motijheel Road', 'Motijheel', 'Dhaka', 'Dhaka', '1000', 'Motijheel Commercial Area', 23.732000, 90.417000, 'Zone D', '2026-01-09', '2026-01-10'),
(10, 'Shyamoli Ring Road', 'Shyamoli', 'Dhaka', 'Dhaka', '1207', 'Shyamoli Square', 23.774000, 90.365000, 'Zone B', '2026-01-10', '2026-01-11'),
(11, 'Tejgaon Industrial Road', 'Tejgaon', 'Dhaka', 'Dhaka', '1208', 'Tejgaon Industrial Area', 23.760000, 90.400000, 'Zone C', '2026-01-11', '2026-01-12'),
(12, 'Farmgate Road', 'Farmgate', 'Dhaka', 'Dhaka', '1215', 'Farmgate Foot Over Bridge', 23.752000, 90.392000, 'Zone A', '2026-01-12', '2026-01-13'),
(13, 'Malibagh Road', 'Malibagh', 'Dhaka', 'Dhaka', '1217', 'Malibagh Rail Crossing', 23.750500, 90.412000, 'Zone B', '2026-01-13', '2026-01-14'),
(14, 'Rampura Road', 'Rampura', 'Dhaka', 'Dhaka', '1219', 'Rampura TV Center', 23.763000, 90.423000, 'Zone C', '2026-01-14', '2026-01-15'),
(15, 'Azimpur Road', 'Azimpur', 'Dhaka', 'Dhaka', '1205', 'Azimpur Graveyard', 23.728000, 90.388000, 'Zone D', '2026-01-15', '2026-01-16'),
(16, 'Kawran Bazar Road', 'Kawran Bazar', 'Dhaka', 'Dhaka', '1215', 'Kawran Bazar Market', 23.752500, 90.393500, 'Zone A', '2026-01-16', '2026-01-17'),
(17, 'Paltan Road', 'Paltan', 'Dhaka', 'Dhaka', '1000', 'Paltan Maidan', 23.732500, 90.412500, 'Zone B', '2026-01-17', '2026-01-18'),
(18, 'New Market Road', 'New Market', 'Dhaka', 'Dhaka', '1205', 'New Market Shopping Complex', 23.738000, 90.385000, 'Zone C', '2026-01-18', '2026-01-19'),
(19, 'Kallyanpur Road', 'Kallyanpur', 'Dhaka', 'Dhaka', '1216', 'Kallyanpur Bus Stand', 23.790000, 90.365000, 'Zone D', '2026-01-19', '2026-01-20'),
(20, 'Mohammadpur Road', 'Mohammadpur', 'Dhaka', 'Dhaka', '1207', 'Mohammadpur Town Hall', 23.770000, 90.365000, 'Zone A', '2026-01-20', '2026-01-21'),
(21, 'Baridhara Road', 'Baridhara', 'Dhaka', 'Dhaka', '1212', 'Baridhara Diplomatic Zone', 23.810000, 90.420000, 'Zone B', '2026-01-21', '2026-01-22'),
(22, 'Elephant Road', 'New Market', 'Dhaka', 'Dhaka', '1205', 'Elephant Road Market', 23.738500, 90.385500, 'Zone C', '2026-01-22', '2026-01-23'),
(23, 'Panthapath Road', 'Panthapath', 'Dhaka', 'Dhaka', '1215', 'Bashundhara City Shopping Mall', 23.752800, 90.392500, 'Zone A', '2026-01-23', '2026-01-24'),
(24, 'Shahbagh Road', 'Shahbagh', 'Dhaka', 'Dhaka', '1000', 'National Museum', 23.738000, 90.395000, 'Zone D', '2026-01-24', '2026-01-25'),
(25, 'Hatirjheel Road', 'Hatirjheel', 'Dhaka', 'Dhaka', '1217', 'Hatirjheel Lake', 23.750000, 90.410000, 'Zone B', '2026-01-25', '2026-01-26'),
(26, 'Shantinagar Road', 'Shantinagar', 'Dhaka', 'Dhaka', '1217', 'Shantinagar Market', 23.740000, 90.415000, 'Zone C', '2026-01-26', '2026-01-27'),
(27, 'Kakrail Road', 'Kakrail', 'Dhaka', 'Dhaka', '1217', 'Kakrail Mosque', 23.735000, 90.415000, 'Zone A', '2026-01-27', '2026-01-28'),
(28, 'Malibagh Chowdhury Road', 'Malibagh', 'Dhaka', 'Dhaka', '1217', 'Malibagh Super Market', 23.750800, 90.412500, 'Zone B', '2026-01-28', '2026-01-29'),
(29, 'Kuril Road', 'Kuril', 'Dhaka', 'Dhaka', '1229', 'Kuril Flyover', 23.820000, 90.425000, 'Zone C', '2026-01-29', '2026-01-30'),
(30, 'Badda Road', 'Badda', 'Dhaka', 'Dhaka', '1212', 'Badda General Hospital', 23.780000, 90.420000, 'Zone D', '2026-01-30', '2026-01-31'),
(31, 'Shahjadpur Road', 'Shahjadpur', 'Dhaka', 'Dhaka', '1212', 'Shahjadpur Market', 23.785000, 90.425000, 'Zone A', '2026-02-01', '2026-02-02'),
(32, 'Rampura Bridge Road', 'Rampura', 'Dhaka', 'Dhaka', '1219', 'Rampura Bridge', 23.763500, 90.423500, 'Zone B', '2026-02-02', '2026-02-03'),
(33, 'Banasree Main Road', 'Banasree', 'Dhaka', 'Dhaka', '1219', 'Banasree Residential Area', 23.750000, 90.430000, 'Zone C', '2026-02-03', '2026-02-04'),
(34, 'Demra Road', 'Demra', 'Dhaka', 'Dhaka', '1360', 'Demra Industrial Area', 23.710000, 90.480000, 'Zone D', '2026-02-04', '2026-02-05'),
(35, 'Jatrabari Road', 'Jatrabari', 'Dhaka', 'Dhaka', '1362', 'Jatrabari Intersection', 23.710500, 90.450000, 'Zone A', '2026-02-05', '2026-02-06'),
(36, 'Keraniganj Road', 'Keraniganj', 'Dhaka', 'Dhaka', '1310', 'Keraniganj Town', 23.700000, 90.370000, 'Zone B', '2026-02-06', '2026-02-07'),
(37, 'Savar Road', 'Savar', 'Dhaka', 'Dhaka', '1340', 'Savar Cantonment', 23.850000, 90.270000, 'Zone C', '2026-02-07', '2026-02-08'),
(38, 'Gazipur Road', 'Gazipur', 'Dhaka', 'Dhaka', '1700', 'Gazipur Chowrasta', 23.920000, 90.390000, 'Zone D', '2026-02-08', '2026-02-09'),
(39, 'Narayanganj Road', 'Narayanganj', 'Dhaka', 'Dhaka', '1400', 'Narayanganj Port', 23.620000, 90.500000, 'Zone A', '2026-02-09', '2026-02-10'),
(40, 'Gopibagh Road', 'Gopibagh', 'Dhaka', 'Dhaka', '1000', 'Gopibagh Playground', 23.725000, 90.420000, 'Zone D', '2026-02-10', '2026-02-11');

-- --------------------------------------------------------

--
-- Table structure for table `Login_Logs`
--

CREATE TABLE `Login_Logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `login_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `logout_time` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `device_type` varchar(100) DEFAULT NULL,
  `browser` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `login_status` varchar(50) DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT 0,
  `security_flag` varchar(50) DEFAULT NULL,
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Login_Logs`
--

INSERT INTO `Login_Logs` (`log_id`, `user_id`, `login_time`, `logout_time`, `ip_address`, `device_type`, `browser`, `location`, `login_status`, `failed_attempts`, `security_flag`, `remarks`) VALUES
(1, 1, '2026-01-02 02:15:00', '2026-01-02 03:00:00', '192.168.1.10', 'Windows PC', 'Chrome', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(2, 2, '2026-01-02 03:30:00', '2026-01-02 04:10:00', '192.168.1.11', 'Android Phone', 'Chrome Mobile', 'Dhaka', 'Success', 0, 'None', 'Mobile login'),
(3, 3, '2026-01-02 04:00:00', '2026-01-02 04:45:00', '192.168.1.12', 'iPhone', 'Safari Mobile', 'Dhaka', 'Success', 0, 'None', 'iOS login'),
(4, 4, '2026-01-02 05:00:00', '2026-01-02 05:30:00', '192.168.1.13', 'Windows Laptop', 'Edge', 'Dhaka', 'Failed', 2, 'Suspicious', 'Incorrect password attempts'),
(5, 5, '2026-01-02 06:00:00', '2026-01-02 06:50:00', '192.168.1.14', 'MacBook', 'Safari', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(6, 6, '2026-01-02 07:00:00', '2026-01-02 07:40:00', '192.168.1.15', 'Android Tablet', 'Chrome Mobile', 'Dhaka', 'Success', 0, 'None', 'Tablet login'),
(7, 7, '2026-01-02 08:00:00', '2026-01-02 08:30:00', '192.168.1.16', 'Windows PC', 'Firefox', 'Dhaka', 'Failed', 3, 'Suspicious', 'Multiple failed attempts'),
(8, 8, '2026-01-02 09:00:00', '2026-01-02 09:50:00', '192.168.1.17', 'iPhone', 'Safari Mobile', 'Dhaka', 'Success', 0, 'None', 'iOS login'),
(9, 9, '2026-01-02 10:00:00', '2026-01-02 10:45:00', '192.168.1.18', 'Windows Laptop', 'Chrome', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(10, 10, '2026-01-02 11:00:00', '2026-01-02 11:30:00', '192.168.1.19', 'MacBook', 'Safari', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(11, 11, '2026-01-03 02:20:00', '2026-01-03 03:00:00', '192.168.1.20', 'Windows PC', 'Edge', 'Dhaka', 'Success', 0, 'None', 'Morning login'),
(12, 12, '2026-01-03 03:10:00', '2026-01-03 03:50:00', '192.168.1.21', 'Android Phone', 'Chrome Mobile', 'Dhaka', 'Success', 0, 'None', 'Mobile login'),
(13, 13, '2026-01-03 04:00:00', '2026-01-03 04:30:00', '192.168.1.22', 'iPhone', 'Safari Mobile', 'Dhaka', 'Failed', 1, 'Suspicious', 'Wrong password'),
(14, 14, '2026-01-03 05:00:00', '2026-01-03 05:40:00', '192.168.1.23', 'Windows Laptop', 'Firefox', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(15, 15, '2026-01-03 06:00:00', '2026-01-03 06:30:00', '192.168.1.24', 'MacBook', 'Safari', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(16, 16, '2026-01-03 07:00:00', '2026-01-03 07:50:00', '192.168.1.25', 'Android Tablet', 'Chrome Mobile', 'Dhaka', 'Success', 0, 'None', 'Tablet login'),
(17, 17, '2026-01-03 08:00:00', '2026-01-03 08:30:00', '192.168.1.26', 'Windows PC', 'Edge', 'Dhaka', 'Failed', 2, 'Suspicious', 'Failed attempts'),
(18, 18, '2026-01-03 09:00:00', '2026-01-03 09:40:00', '192.168.1.27', 'iPhone', 'Safari Mobile', 'Dhaka', 'Success', 0, 'None', 'iOS login'),
(19, 19, '2026-01-03 10:00:00', '2026-01-03 10:50:00', '192.168.1.28', 'Windows Laptop', 'Chrome', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(20, 20, '2026-01-03 11:00:00', '2026-01-03 11:30:00', '192.168.1.29', 'MacBook', 'Safari', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(21, 21, '2026-01-04 02:15:00', '2026-01-04 03:00:00', '192.168.1.30', 'Windows PC', 'Chrome', 'Dhaka', 'Success', 0, 'None', 'Morning login'),
(22, 22, '2026-01-04 03:20:00', '2026-01-04 03:50:00', '192.168.1.31', 'Android Phone', 'Chrome Mobile', 'Dhaka', 'Success', 0, 'None', 'Mobile login'),
(23, 23, '2026-01-04 04:00:00', '2026-01-04 04:40:00', '192.168.1.32', 'iPhone', 'Safari Mobile', 'Dhaka', 'Success', 0, 'None', 'iOS login'),
(24, 24, '2026-01-04 05:00:00', '2026-01-04 05:30:00', '192.168.1.33', 'Windows Laptop', 'Edge', 'Dhaka', 'Failed', 3, 'Suspicious', 'Multiple failed attempts'),
(25, 25, '2026-01-04 06:00:00', '2026-01-04 06:50:00', '192.168.1.34', 'MacBook', 'Safari', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(26, 26, '2026-01-04 07:00:00', '2026-01-04 07:40:00', '192.168.1.35', 'Android Tablet', 'Chrome Mobile', 'Dhaka', 'Success', 0, 'None', 'Tablet login'),
(27, 27, '2026-01-04 08:00:00', '2026-01-04 08:30:00', '192.168.1.36', 'Windows PC', 'Firefox', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(28, 28, '2026-01-04 09:00:00', '2026-01-04 09:50:00', '192.168.1.37', 'iPhone', 'Safari Mobile', 'Dhaka', 'Success', 0, 'None', 'iOS login'),
(29, 29, '2026-01-04 10:00:00', '2026-01-04 10:45:00', '192.168.1.38', 'Windows Laptop', 'Chrome', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(30, 30, '2026-01-04 11:00:00', '2026-01-04 11:30:00', '192.168.1.39', 'MacBook', 'Safari', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(31, 31, '2026-01-05 02:10:00', '2026-01-05 02:50:00', '192.168.1.40', 'Windows PC', 'Edge', 'Dhaka', 'Success', 0, 'None', 'Morning login'),
(32, 32, '2026-01-05 03:20:00', '2026-01-05 03:50:00', '192.168.1.41', 'Android Phone', 'Chrome Mobile', 'Dhaka', 'Success', 0, 'None', 'Mobile login'),
(33, 33, '2026-01-05 04:00:00', '2026-01-05 04:30:00', '192.168.1.42', 'iPhone', 'Safari Mobile', 'Dhaka', 'Failed', 2, 'Suspicious', 'Wrong password attempts'),
(34, 34, '2026-01-05 05:00:00', '2026-01-05 05:40:00', '192.168.1.43', 'Windows Laptop', 'Firefox', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(35, 35, '2026-01-05 06:00:00', '2026-01-05 06:30:00', '192.168.1.44', 'MacBook', 'Safari', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(36, 36, '2026-01-05 07:00:00', '2026-01-05 07:50:00', '192.168.1.45', 'Android Tablet', 'Chrome Mobile', 'Dhaka', 'Success', 0, 'None', 'Tablet login'),
(37, 37, '2026-01-05 08:00:00', '2026-01-05 08:30:00', '192.168.1.46', 'Windows PC', 'Edge', 'Dhaka', 'Failed', 3, 'Suspicious', 'Multiple failed attempts'),
(38, 38, '2026-01-05 09:00:00', '2026-01-05 09:40:00', '192.168.1.47', 'iPhone', 'Safari Mobile', 'Dhaka', 'Success', 0, 'None', 'iOS login'),
(39, 39, '2026-01-05 10:00:00', '2026-01-05 10:50:00', '192.168.1.48', 'Windows Laptop', 'Chrome', 'Dhaka', 'Success', 0, 'None', 'Normal login'),
(40, 40, '2026-01-05 11:00:00', '2026-01-05 11:30:00', '192.168.1.49', 'MacBook', 'Safari', 'Dhaka', 'Success', 0, 'None', 'Normal login');

-- --------------------------------------------------------

--
-- Table structure for table `Notifications`
--

CREATE TABLE `Notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `complaint_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `notification_type` varchar(50) DEFAULT NULL,
  `sent_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_status` varchar(20) NOT NULL,
  `delivery_status` varchar(20) NOT NULL,
  `priority` varchar(20) NOT NULL,
  `channel` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Notifications`
--

INSERT INTO `Notifications` (`notification_id`, `user_id`, `complaint_id`, `message`, `notification_type`, `sent_date`, `read_status`, `delivery_status`, `priority`, `channel`, `created_by`, `remarks`) VALUES
(1, 3, 1, 'Your complaint #1 has been received.', 'Complaint Update', '2026-01-01 18:00:00', 'Unread', 'Delivered', 'Normal', 'Email', 'System', 'Initial acknowledgement'),
(2, 5, 2, 'Complaint #2 assigned to admin.', 'Assignment', '2026-01-02 18:00:00', 'Read', 'Delivered', 'High', 'SMS', 'System', 'Admin assignment notification'),
(3, 7, 3, 'Complaint #3 status changed to In Progress.', 'Status Change', '2026-01-03 18:00:00', 'Unread', 'Delivered', 'Normal', 'App', 'System', 'Status update'),
(4, 9, 4, 'Complaint #4 requires additional evidence.', 'Request', '2026-01-04 18:00:00', 'Read', 'Delivered', 'High', 'Email', 'Admin', 'Evidence request'),
(5, 11, 5, 'Complaint #5 has been resolved.', 'Resolution', '2026-01-05 18:00:00', 'Unread', 'Delivered', 'Normal', 'App', 'System', 'Resolution notification'),
(6, 13, 6, 'Complaint #6 escalated to senior admin.', 'Escalation', '2026-01-06 18:00:00', 'Read', 'Delivered', 'High', 'SMS', 'System', 'Escalation notice'),
(7, 15, 7, 'Complaint #7 closed successfully.', 'Closure', '2026-01-07 18:00:00', 'Unread', 'Delivered', 'Normal', 'Email', 'System', 'Closure confirmation'),
(8, 17, 8, 'Complaint #8 pending verification.', 'Verification', '2026-01-08 18:00:00', 'Read', 'Delivered', 'Normal', 'App', 'System', 'Verification update'),
(9, 19, 9, 'Complaint #9 requires admin review.', 'Request', '2026-01-09 18:00:00', 'Unread', 'Delivered', 'High', 'SMS', 'Admin', 'Review request'),
(10, 21, 10, 'Complaint #10 resolved and closed.', 'Resolution', '2026-01-10 18:00:00', 'Read', 'Delivered', 'Normal', 'Email', 'System', 'Resolution notice'),
(11, 23, 11, 'Complaint #11 has been received.', 'Complaint Update', '2026-01-11 18:00:00', 'Unread', 'Delivered', 'Normal', 'App', 'System', 'Acknowledgement'),
(12, 25, 12, 'Complaint #12 assigned to admin.', 'Assignment', '2026-01-12 18:00:00', 'Read', 'Delivered', 'High', 'SMS', 'System', 'Assignment notice'),
(13, 27, 13, 'Complaint #13 status changed to In Progress.', 'Status Change', '2026-01-13 18:00:00', 'Unread', 'Delivered', 'Normal', 'Email', 'System', 'Status update'),
(14, 29, 14, 'Complaint #14 requires additional evidence.', 'Request', '2026-01-14 18:00:00', 'Read', 'Delivered', 'High', 'App', 'Admin', 'Evidence request'),
(15, 31, 15, 'Complaint #15 has been resolved.', 'Resolution', '2026-01-15 18:00:00', 'Unread', 'Delivered', 'Normal', 'SMS', 'System', 'Resolution notification'),
(16, 33, 16, 'Complaint #16 escalated to senior admin.', 'Escalation', '2026-01-16 18:00:00', 'Read', 'Delivered', 'High', 'Email', 'System', 'Escalation notice'),
(17, 35, 17, 'Complaint #17 closed successfully.', 'Closure', '2026-01-17 18:00:00', 'Unread', 'Delivered', 'Normal', 'App', 'System', 'Closure confirmation'),
(18, 37, 18, 'Complaint #18 pending verification.', 'Verification', '2026-01-18 18:00:00', 'Read', 'Delivered', 'Normal', 'SMS', 'System', 'Verification update'),
(19, 39, 19, 'Complaint #19 requires admin review.', 'Request', '2026-01-19 18:00:00', 'Unread', 'Delivered', 'High', 'Email', 'Admin', 'Review request'),
(20, 1, 20, 'Complaint #20 resolved and closed.', 'Resolution', '2026-01-20 18:00:00', 'Read', 'Delivered', 'Normal', 'App', 'System', 'Resolution notice'),
(21, 2, 21, 'Complaint #21 has been received.', 'Complaint Update', '2026-01-21 18:00:00', 'Unread', 'Delivered', 'Normal', 'Email', 'System', 'Acknowledgement'),
(22, 4, 22, 'Complaint #22 assigned to admin.', 'Assignment', '2026-01-22 18:00:00', 'Read', 'Delivered', 'High', 'App', 'System', 'Assignment notice'),
(23, 6, 23, 'Complaint #23 status changed to In Progress.', 'Status Change', '2026-01-23 18:00:00', 'Unread', 'Delivered', 'Normal', 'SMS', 'System', 'Status update'),
(24, 8, 24, 'Complaint #24 requires additional evidence.', 'Request', '2026-01-24 18:00:00', 'Read', 'Delivered', 'High', 'Email', 'Admin', 'Evidence request'),
(25, 10, 25, 'Complaint #25 has been resolved.', 'Resolution', '2026-01-25 18:00:00', 'Unread', 'Delivered', 'Normal', 'App', 'System', 'Resolution notification'),
(26, 12, 26, 'Complaint #26 escalated to senior admin.', 'Escalation', '2026-01-26 18:00:00', 'Read', 'Delivered', 'High', 'SMS', 'System', 'Escalation notice'),
(27, 14, 27, 'Complaint #27 closed successfully.', 'Closure', '2026-01-27 18:00:00', 'Unread', 'Delivered', 'Normal', 'Email', 'System', 'Closure confirmation'),
(28, 16, 28, 'Complaint #28 pending verification.', 'Verification', '2026-01-28 18:00:00', 'Read', 'Delivered', 'Normal', 'App', 'System', 'Verification update'),
(29, 18, 29, 'Complaint #29 requires admin review.', 'Request', '2026-01-29 18:00:00', 'Unread', 'Delivered', 'High', 'SMS', 'Admin', 'Review request'),
(30, 20, 30, 'Complaint #30 resolved and closed.', 'Resolution', '2026-01-30 18:00:00', 'Read', 'Delivered', 'Normal', 'Email', 'System', 'Resolution notice'),
(31, 22, 31, 'Complaint #31 has been received.', 'Complaint Update', '2026-01-31 18:00:00', 'Unread', 'Delivered', 'Normal', 'App', 'System', 'Acknowledgement'),
(32, 24, 32, 'Complaint #32 assigned to admin.', 'Assignment', '2026-02-01 18:00:00', 'Read', 'Delivered', 'High', 'SMS', 'System', 'Assignment notice'),
(33, 26, 33, 'Complaint #33 status changed to In Progress.', 'Status Change', '2026-02-02 18:00:00', 'Unread', 'Delivered', 'Normal', 'Email', 'System', 'Status update'),
(34, 28, 34, 'Complaint #34 requires additional evidence.', 'Request', '2026-02-03 18:00:00', 'Read', 'Delivered', 'High', 'App', 'Admin', 'Evidence request'),
(35, 30, 35, 'Complaint #35 has been resolved.', 'Resolution', '2026-02-04 18:00:00', 'Unread', 'Delivered', 'Normal', 'SMS', 'System', 'Resolution notification'),
(36, 32, 36, 'Complaint #36 escalated to senior admin.', 'Escalation', '2026-02-05 18:00:00', 'Read', 'Delivered', 'High', 'Email', 'System', 'Escalation notice'),
(37, 34, 37, 'Complaint #37 closed successfully.', 'Closure', '2026-02-06 18:00:00', 'Unread', 'Delivered', 'Normal', 'App', 'System', 'Closure confirmation'),
(38, 36, 38, 'Complaint #38 pending verification.', 'Verification', '2026-02-07 18:00:00', 'Read', 'Delivered', 'Normal', 'SMS', 'System', 'Verification update'),
(39, 38, 39, 'Complaint #39 requires admin review.', 'Request', '2026-02-08 18:00:00', 'Unread', 'Delivered', 'High', 'Email', 'Admin', 'Review request'),
(40, 40, 40, 'Complaint #40 resolved and closed.', 'Resolution', '2026-02-09 18:00:00', 'Read', 'Delivered', 'Normal', 'App', 'System', 'Resolution notice');

-- --------------------------------------------------------

--
-- Table structure for table `Reports`
--

CREATE TABLE `Reports` (
  `report_id` int(11) NOT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `report_type` varchar(100) DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `generated_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_complaints` int(11) DEFAULT NULL,
  `resolved_complaints` int(11) DEFAULT NULL,
  `pending_complaints` int(11) DEFAULT NULL,
  `location_filter` varchar(100) DEFAULT NULL,
  `category_filter` varchar(100) DEFAULT NULL,
  `report_file` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Reports`
--

INSERT INTO `Reports` (`report_id`, `report_title`, `report_type`, `generated_by`, `generated_date`, `total_complaints`, `resolved_complaints`, `pending_complaints`, `location_filter`, `category_filter`, `report_file`, `remarks`) VALUES
(1, 'Monthly Complaint Summary - January', 'Summary', 1, '2026-01-30 18:00:00', 120, 95, 25, 'Dhaka', 'All', '/reports/jan_summary.pdf', 'Monthly overview'),
(2, 'High Priority Complaints Report', 'Priority', 2, '2026-01-31 18:00:00', 40, 30, 10, 'Dhaka', 'Road Safety', '/reports/high_priority.pdf', 'Focus on urgent cases'),
(3, 'Resolved Complaints Analysis', 'Analysis', 3, '2026-02-01 18:00:00', 200, 180, 20, 'Dhaka', 'All', '/reports/resolved_analysis.pdf', 'Resolution trends'),
(4, 'Pending Complaints Report', 'Status', 4, '2026-02-02 18:00:00', 60, 0, 60, 'Dhaka', 'Sanitation', '/reports/pending_sanitation.pdf', 'Pending sanitation issues'),
(5, 'Traffic Signal Complaints', 'Category', 5, '2026-02-03 18:00:00', 35, 25, 10, 'Dhaka', 'Signal Maintenance', '/reports/signal_complaints.pdf', 'Signal malfunction cases'),
(6, 'Noise Pollution Complaints', 'Category', 6, '2026-02-04 18:00:00', 50, 40, 10, 'Dhaka', 'Noise Control', '/reports/noise_complaints.pdf', 'Noise-related cases'),
(7, 'Garbage Complaints Report', 'Category', 7, '2026-02-05 18:00:00', 70, 55, 15, 'Dhaka', 'Sanitation', '/reports/garbage_complaints.pdf', 'Garbage pile issues'),
(8, 'Accident Complaints Report', 'Category', 8, '2026-02-06 18:00:00', 25, 20, 5, 'Dhaka', 'Accident Response', '/reports/accident_complaints.pdf', 'Accident cases'),
(9, 'Billboard Complaints Report', 'Category', 9, '2026-02-07 18:00:00', 15, 10, 5, 'Dhaka', 'Billboard Regulation', '/reports/billboard_complaints.pdf', 'Unauthorized billboards'),
(10, 'Vendor Complaints Report', 'Category', 10, '2026-02-08 18:00:00', 30, 25, 5, 'Dhaka', 'Vendor Regulation', '/reports/vendor_complaints.pdf', 'Street vendor issues'),
(11, 'Weekly Complaint Summary - Week 1', 'Summary', 11, '2026-01-06 18:00:00', 45, 35, 10, 'Dhaka', 'All', '/reports/week1_summary.pdf', 'Weekly overview'),
(12, 'Weekly Complaint Summary - Week 2', 'Summary', 12, '2026-01-13 18:00:00', 50, 40, 10, 'Dhaka', 'All', '/reports/week2_summary.pdf', 'Weekly overview'),
(13, 'Weekly Complaint Summary - Week 3', 'Summary', 13, '2026-01-20 18:00:00', 55, 45, 10, 'Dhaka', 'All', '/reports/week3_summary.pdf', 'Weekly overview'),
(14, 'Weekly Complaint Summary - Week 4', 'Summary', 14, '2026-01-27 18:00:00', 60, 50, 10, 'Dhaka', 'All', '/reports/week4_summary.pdf', 'Weekly overview'),
(15, 'Complaint Trends Report', 'Analysis', 15, '2026-02-09 18:00:00', 300, 250, 50, 'Dhaka', 'All', '/reports/trends.pdf', 'Complaint trends analysis'),
(16, 'Department Performance Report', 'Performance', 16, '2026-02-10 18:00:00', 200, 180, 20, 'Dhaka', 'All', '/reports/performance.pdf', 'Department efficiency'),
(17, 'Complaint Resolution Time Report', 'Analysis', 17, '2026-02-11 18:00:00', 150, 140, 10, 'Dhaka', 'All', '/reports/resolution_time.pdf', 'Resolution time analysis'),
(18, 'Escalated Complaints Report', 'Priority', 18, '2026-02-12 18:00:00', 20, 15, 5, 'Dhaka', 'All', '/reports/escalated.pdf', 'Escalated cases'),
(19, 'Complaint Distribution by Location', 'Analysis', 19, '2026-02-13 18:00:00', 250, 220, 30, 'Dhaka', 'All', '/reports/location_distribution.pdf', 'Location-based distribution'),
(20, 'Complaint Distribution by Category', 'Analysis', 20, '2026-02-14 18:00:00', 260, 230, 30, 'Dhaka', 'All', '/reports/category_distribution.pdf', 'Category-based distribution'),
(21, 'Monthly Complaint Summary - February', 'Summary', 21, '2026-02-27 18:00:00', 130, 110, 20, 'Dhaka', 'All', '/reports/feb_summary.pdf', 'Monthly overview'),
(22, 'High Priority Complaints Report - Feb', 'Priority', 22, '2026-02-19 18:00:00', 45, 35, 10, 'Dhaka', 'Road Safety', '/reports/high_priority_feb.pdf', 'Urgent cases'),
(23, 'Resolved Complaints Analysis - Feb', 'Analysis', 23, '2026-02-20 18:00:00', 210, 190, 20, 'Dhaka', 'All', '/reports/resolved_feb.pdf', 'Resolution trends'),
(24, 'Pending Complaints Report - Feb', 'Status', 24, '2026-02-21 18:00:00', 65, 0, 65, 'Dhaka', 'Sanitation', '/reports/pending_feb.pdf', 'Pending sanitation issues'),
(25, 'Traffic Signal Complaints - Feb', 'Category', 25, '2026-02-22 18:00:00', 40, 30, 10, 'Dhaka', 'Signal Maintenance', '/reports/signal_feb.pdf', 'Signal malfunction cases'),
(26, 'Noise Pollution Complaints - Feb', 'Category', 26, '2026-02-23 18:00:00', 55, 45, 10, 'Dhaka', 'Noise Control', '/reports/noise_feb.pdf', 'Noise-related cases'),
(27, 'Garbage Complaints Report - Feb', 'Category', 27, '2026-02-24 18:00:00', 75, 60, 15, 'Dhaka', 'Sanitation', '/reports/garbage_feb.pdf', 'Garbage pile issues'),
(28, 'Accident Complaints Report - Feb', 'Category', 28, '2026-02-25 18:00:00', 28, 23, 5, 'Dhaka', 'Accident Response', '/reports/accident_feb.pdf', 'Accident cases'),
(29, 'Billboard Complaints Report - Feb', 'Category', 29, '2026-02-26 18:00:00', 18, 13, 5, 'Dhaka', 'Billboard Regulation', '/reports/billboard_feb.pdf', 'Unauthorized billboards'),
(30, 'Vendor Complaints Report - Feb', 'Category', 30, '2026-02-27 18:00:00', 32, 27, 5, 'Dhaka', 'Vendor Regulation', '/reports/vendor_feb.pdf', 'Street vendor issues'),
(31, 'Quarterly Complaint Summary - Q1', 'Summary', 31, '2026-03-30 18:00:00', 400, 350, 50, 'Dhaka', 'All', '/reports/q1_summary.pdf', 'Quarterly overview'),
(32, 'High Priority Complaints Report - Q1', 'Priority', 32, '2026-03-19 18:00:00', 60, 45, 15, 'Dhaka', 'Road Safety', '/reports/high_priority_q1.pdf', 'Urgent cases'),
(33, 'Resolved Complaints Analysis - Q1', 'Analysis', 33, '2026-03-20 18:00:00', 300, 270, 30, 'Dhaka', 'All', '/reports/resolved_q1.pdf', 'Resolution trends'),
(34, 'Pending Complaints Report - Q1', 'Status', 34, '2026-03-21 18:00:00', 80, 0, 80, 'Dhaka', 'Sanitation', '/reports/pending_q1.pdf', 'Pending sanitation issues'),
(35, 'Traffic Signal Complaints - Q1', 'Category', 35, '2026-03-22 18:00:00', 50, 40, 10, 'Dhaka', 'Signal Maintenance', '/reports/signal_q1.pdf', 'Signal malfunction cases'),
(36, 'Noise Pollution Complaints - Q1', 'Category', 36, '2026-03-23 18:00:00', 65, 55, 10, 'Dhaka', 'Noise Control', '/reports/noise_q1.pdf', 'Noise-related cases in Q1'),
(37, 'Garbage Complaints Report - Q1', 'Category', 37, '2026-03-24 18:00:00', 85, 70, 15, 'Dhaka', 'Sanitation', '/reports/garbage_q1.pdf', 'Garbage pile issues in Q1'),
(38, 'Accident Complaints Report - Q1', 'Category', 38, '2026-03-25 18:00:00', 32, 27, 5, 'Dhaka', 'Accident Response', '/reports/accident_q1.pdf', 'Accident cases in Q1'),
(39, 'Billboard Complaints Report - Q1', 'Category', 39, '2026-03-26 18:00:00', 20, 15, 5, 'Dhaka', 'Billboard Regulation', '/reports/billboard_q1.pdf', 'Unauthorized billboards in Q1'),
(40, 'Vendor Complaints Report - Q1', 'Category', 40, '2026-03-27 18:00:00', 35, 30, 5, 'Dhaka', 'Vendor Regulation', '/reports/vendor_q1.pdf', 'Street vendor issues in Q1');

-- --------------------------------------------------------

--
-- Table structure for table `Traffic_Departments`
--

CREATE TABLE `Traffic_Departments` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `office_address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `head_of_department` varchar(100) DEFAULT NULL,
  `staff_count` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `department_code` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Traffic_Departments`
--

INSERT INTO `Traffic_Departments` (`department_id`, `department_name`, `city`, `office_address`, `phone_number`, `email`, `head_of_department`, `staff_count`, `created_date`, `updated_date`, `department_code`, `status`) VALUES
(1, 'Road Safety Department', 'Dhaka', '123 Main Road, Dhaka', '01710000001', 'roadsafety@traffic.gov.bd', 'Abdul Karim', 120, '2025-12-01', '2026-01-02', 'RSD001', 'Active'),
(2, 'Signal Maintenance Unit', 'Dhaka', '45 Signal Ave, Dhaka', '01710000002', 'signals@traffic.gov.bd', 'Farhana Rahman', 80, '2025-12-02', '2026-01-03', 'SMU002', 'Active'),
(3, 'Parking Enforcement Division', 'Dhaka', '78 Parking St, Dhaka', '01710000003', 'parking@traffic.gov.bd', 'Jahangir Alam', 60, '2025-12-03', '2026-01-04', 'PED003', 'Active'),
(4, 'Noise Control Unit', 'Dhaka', '12 Sound Rd, Dhaka', '01710000004', 'noise@traffic.gov.bd', 'Shamima Akter', 40, '2025-12-04', '2026-01-05', 'NCU004', 'Active'),
(5, 'Sanitation & Waste Dept', 'Dhaka', '56 Clean St, Dhaka', '01710000005', 'sanitation@traffic.gov.bd', 'Rafiqul Islam', 150, '2025-12-05', '2026-01-06', 'SWD005', 'Active'),
(6, 'Accident Response Unit', 'Dhaka', '89 Rescue Rd, Dhaka', '01710000006', 'accidents@traffic.gov.bd', 'Nasrin Jahan', 200, '2025-12-06', '2026-01-07', 'ARU006', 'Active'),
(7, 'Billboard Regulation Dept', 'Dhaka', '34 Ad Rd, Dhaka', '01710000007', 'billboards@traffic.gov.bd', 'Mahmud Hasan', 55, '2025-12-07', '2026-01-08', 'BRD007', 'Active'),
(8, 'Vendor Regulation Unit', 'Dhaka', '22 Market Rd, Dhaka', '01710000008', 'vendors@traffic.gov.bd', 'Salma Khatun', 70, '2025-12-08', '2026-01-09', 'VRU008', 'Active'),
(9, 'Traffic Monitoring Center', 'Dhaka', '101 Control Rd, Dhaka', '01710000009', 'monitoring@traffic.gov.bd', 'Imran Hossain', 90, '2025-12-09', '2026-01-10', 'TMC009', 'Active'),
(10, 'Highway Patrol Division', 'Dhaka', '150 Highway Rd, Dhaka', '01710000010', 'highway@traffic.gov.bd', 'Sharmin Akter', 180, '2025-12-10', '2026-01-11', 'HPD010', 'Active'),
(11, 'Bridge Safety Unit', 'Dhaka', '12 Bridge Rd, Dhaka', '01710000011', 'bridge@traffic.gov.bd', 'Kamal Uddin', 65, '2025-12-11', '2026-01-12', 'BSU011', 'Active'),
(12, 'Cyclist Safety Division', 'Dhaka', '33 Cycle Rd, Dhaka', '01710000012', 'cycling@traffic.gov.bd', 'Razia Sultana', 50, '2025-12-12', '2026-01-13', 'CSD012', 'Active'),
(13, 'Pedestrian Safety Unit', 'Dhaka', '44 Walk Rd, Dhaka', '01710000013', 'pedestrian@traffic.gov.bd', 'Shahidul Islam', 75, '2025-12-13', '2026-01-14', 'PSU013', 'Active'),
(14, 'Public Transport Division', 'Dhaka', '55 Bus Rd, Dhaka', '01710000014', 'transport@traffic.gov.bd', 'Mita Rahman', 130, '2025-12-14', '2026-01-15', 'PTD014', 'Active'),
(15, 'Emergency Response Unit', 'Dhaka', '66 Emergency Rd, Dhaka', '01710000015', 'emergency@traffic.gov.bd', 'Anwar Hossain', 160, '2025-12-15', '2026-01-16', 'ERU015', 'Active'),
(16, 'Traffic Education Dept', 'Dhaka', '77 School Rd, Dhaka', '01710000016', 'education@traffic.gov.bd', 'Shahina Begum', 45, '2025-12-16', '2026-01-17', 'TED016', 'Active'),
(17, 'Vehicle Inspection Unit', 'Dhaka', '88 Check Rd, Dhaka', '01710000017', 'inspection@traffic.gov.bd', 'Rashed Khan', 95, '2025-12-17', '2026-01-18', 'VIU017', 'Active'),
(18, 'Traffic Research Center', 'Dhaka', '99 Research Rd, Dhaka', '01710000018', 'research@traffic.gov.bd', 'Nusrat Jahan', 35, '2025-12-18', '2026-01-19', 'TRC018', 'Active'),
(19, 'Urban Planning Dept', 'Dhaka', '111 Plan Rd, Dhaka', '01710000019', 'planning@traffic.gov.bd', 'Tanvir Ahmed', 140, '2025-12-19', '2026-01-20', 'UPD019', 'Active'),
(20, 'Traffic Enforcement Unit', 'Dhaka', '121 Law Rd, Dhaka', '01710000020', 'enforcement@traffic.gov.bd', 'Shirin Akter', 110, '2025-12-20', '2026-01-21', 'TEU020', 'Active'),
(21, 'Road Construction Dept', 'Dhaka', '131 Build Rd, Dhaka', '01710000021', 'construction@traffic.gov.bd', 'Habib Ullah', 200, '2025-12-21', '2026-01-22', 'RCD021', 'Active'),
(22, 'Traffic Signal Audit Unit', 'Dhaka', '141 Audit Rd, Dhaka', '01710000022', 'audit@traffic.gov.bd', 'Sadia Rahman', 55, '2025-12-22', '2026-01-23', 'TSAU022', 'Active'),
(23, 'Environmental Safety Dept', 'Dhaka', '151 Green Rd, Dhaka', '01710000023', 'environment@traffic.gov.bd', 'Mizanur Rahman', 70, '2025-12-23', '2026-01-24', 'ESD023', 'Active'),
(24, 'Traffic Complaint Desk', 'Dhaka', '161 Desk Rd, Dhaka', '01710000024', 'complaints@traffic.gov.bd', 'Parveen Akter', 30, '2025-12-24', '2026-01-25', 'TCD024', 'Active'),
(25, 'Highway Safety Unit', 'Dhaka', '171 Highway Rd, Dhaka', '01710000025', 'highwaysafety@traffic.gov.bd', 'Shafiqul Islam', 85, '2025-12-25', '2026-01-26', 'HSU025', 'Active'),
(26, 'Traffic Data Center', 'Dhaka', '181 Data Rd, Dhaka', '01710000026', 'data@traffic.gov.bd', 'Lamia Sultana', 40, '2025-12-26', '2026-01-27', 'TDC026', 'Active'),
(27, 'Accident Prevention Unit', 'Dhaka', '191 Safety Rd, Dhaka', '01710000027', 'prevention@traffic.gov.bd', 'Ashraf Ali', 100, '2025-12-27', '2026-01-28', 'APU027', 'Active'),
(28, 'Traffic Awareness Dept', 'Dhaka', '201 Awareness Rd, Dhaka', '01710000028', 'awareness@traffic.gov.bd', 'Shamima Sultana', 60, '2025-12-28', '2026-01-29', 'TAD028', 'Active'),
(29, 'Urban Traffic Control Unit', 'Dhaka', '211 Control Rd, Dhaka', '01710000029', 'urbancontrol@traffic.gov.bd', 'Iqbal Hossain', 150, '2025-12-29', '2026-01-30', 'TAD029', 'Active'),
(30, 'Traffic Research & Analysis Unit', 'Dhaka', '221 Research Rd, Dhaka', '01710000030', 'analysis@traffic.gov.bd', 'Mehnaz Rahman', 85, '2025-12-30', '2026-01-31', 'TRAU030', 'Active'),
(31, 'Traffic Safety Audit Dept', 'Dhaka', '231 Safety Rd, Dhaka', '01710000031', 'safety@traffic.gov.bd', 'Shafqat Hossain', 60, '2025-12-31', '2026-02-01', 'TSAD031', 'Active'),
(32, 'Urban Mobility Division', 'Dhaka', '241 Mobility Rd, Dhaka', '01710000032', 'mobility@traffic.gov.bd', 'Laila Akter', 95, '2026-01-01', '2026-02-02', 'UMD032', 'Active'),
(33, 'Traffic Law Enforcement Unit', 'Dhaka', '251 Law Rd, Dhaka', '01710000033', 'law@traffic.gov.bd', 'Hasan Mahmud', 110, '2026-01-02', '2026-02-03', 'TLEU033', 'Active'),
(34, 'Public Awareness & Training Dept', 'Dhaka', '261 Awareness Rd, Dhaka', '01710000034', 'training@traffic.gov.bd', 'Shamima Sultana', 70, '2026-01-03', '2026-02-04', 'PATD034', 'Active'),
(35, 'Emergency Traffic Control Unit', 'Dhaka', '271 Emergency Rd, Dhaka', '01710000035', 'emergencycontrol@traffic.gov.bd', 'Iqbal Hossain', 150, '2026-01-04', '2026-02-05', 'ETCU035', 'Active'),
(36, 'Traffic Infrastructure Dept', 'Dhaka', '281 Infra Rd, Dhaka', '01710000036', 'infrastructure@traffic.gov.bd', 'Rumana Akter', 200, '2026-01-05', '2026-02-06', 'TID036', 'Active'),
(37, 'Traffic Complaint Review Board', 'Dhaka', '291 Review Rd, Dhaka', '01710000037', 'review@traffic.gov.bd', 'Mahfuz Alam', 40, '2026-01-06', '2026-02-07', 'TCRB037', 'Active'),
(38, 'Traffic Technology Unit', 'Dhaka', '301 Tech Rd, Dhaka', '01710000038', 'tech@traffic.gov.bd', 'Nadia Hasan', 65, '2026-01-07', '2026-02-08', 'TTU038', 'Active'),
(39, 'Traffic Policy & Planning Dept', 'Dhaka', '311 Policy Rd, Dhaka', '01710000039', 'policy@traffic.gov.bd', 'Shahriar Kabir', 90, '2026-01-08', '2026-02-09', 'TPPD039', 'Active'),
(40, 'Traffic Operations Center', 'Dhaka', '321 Ops Rd, Dhaka', '01710000040', 'operations@traffic.gov.bd', 'Farzana Akter', 120, '2026-01-09', '2026-02-10', 'TOC040', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `account_status` varchar(50) DEFAULT 'Active',
  `profile_photo` varchar(255) DEFAULT NULL,
  `user_role` varchar(50) DEFAULT 'Citizen'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_id`, `full_name`, `email`, `phone_number`, `password`, `address`, `city`, `registration_date`, `last_login`, `account_status`, `profile_photo`, `user_role`) VALUES
(1, 'Rahim Uddin', 'rahim.uddin@example.com', '01710000001', 'Rahim@123', 'Bashundhara R/A', 'Dhaka', '2026-04-01', '2026-04-09 04:15:00', 'Active', '/photos/rahim.jpg', 'Citizen'),
(2, 'Karim Hossain', 'karim.hossain@example.com', '01710000002', 'Karim@123', 'Dhanmondi', 'Dhaka', '2026-04-02', '2026-04-09 05:20:00', 'Active', '/photos/karim.jpg', 'Citizen'),
(3, 'Shafiqul Islam', 'shafiq.islam@example.com', '01710000003', 'Shafiq@123', 'Mirpur', 'Dhaka', '2026-04-03', '2026-04-08 03:00:00', 'Inactive', '/photos/shafiq.jpg', 'Citizen'),
(4, 'Nusrat Jahan', 'nusrat.jahan@example.com', '01710000004', 'Nusrat@123', 'Banani', 'Dhaka', '2026-04-04', '2026-04-09 08:30:00', 'Active', '/photos/nusrat.jpg', 'Citizen'),
(5, 'Mehedi Hasan', 'mehedi.hasan@example.com', '01710000005', 'Mehedi@123', 'Uttara', 'Dhaka', '2026-04-05', '2026-04-07 10:45:00', 'Active', '/photos/mehedi.jpg', 'Citizen'),
(6, 'Farzana Akter', 'farzana.akter@example.com', '01710000006', 'Farzana@123', 'Mohakhali', 'Dhaka', '2026-04-06', '2026-04-09 12:10:00', 'Active', '/photos/farzana.jpg', 'Citizen'),
(7, 'Tanvir Ahmed', 'tanvir.ahmed@example.com', '01710000007', 'Tanvir@123', 'Gulshan', 'Dhaka', '2026-04-07', '2026-04-08 14:00:00', 'Suspended', '/photos/tanvir.jpg', 'Citizen'),
(8, 'Sadia Rahman', 'sadia.rahman@example.com', '01710000008', 'Sadia@123', 'Khilgaon', 'Dhaka', '2026-04-08', '2026-04-09 15:15:00', 'Active', '/photos/sadia.jpg', 'Citizen'),
(9, 'Imran Chowdhury', 'imran.chowdhury@example.com', '01710000009', 'Imran@123', 'Motijheel', 'Dhaka', '2026-04-09', '2026-04-09 16:00:00', 'Active', '/photos/imran.jpg', 'Citizen'),
(10, 'Ayesha Siddiqua', 'ayesha.siddiqua@example.com', '01710000010', 'Ayesha@123', 'Shyamoli', 'Dhaka', '2026-04-10', '2026-04-09 17:30:00', 'Active', '/photos/ayesha.jpg', 'Citizen'),
(11, 'Rashedul Karim', 'rashed.karim@example.com', '01710000011', 'Rashed@123', 'Tejgaon', 'Dhaka', '2026-04-11', '2026-04-10 02:00:00', 'Active', '/photos/rashed.jpg', 'Citizen'),
(12, 'Mariam Begum', 'mariam.begum@example.com', '01710000012', 'Mariam@123', 'Farmgate', 'Dhaka', '2026-04-12', '2026-04-10 03:15:00', 'Inactive', '/photos/mariam.jpg', 'Citizen'),
(13, 'Jamil Khan', 'jamil.khan@example.com', '01710000013', 'Jamil@123', 'Malibagh', 'Dhaka', '2026-04-13', '2026-04-10 04:30:00', 'Active', '/photos/jamil.jpg', 'Citizen'),
(14, 'Sultana Parvin', 'sultana.parvin@example.com', '01710000014', 'Sultana@123', 'Rampura', 'Dhaka', '2026-04-14', '2026-04-10 05:45:00', 'Active', '/photos/sultana.jpg', 'Citizen'),
(15, 'Anwar Hossain', 'anwar.hossain@example.com', '01710000015', 'Anwar@123', 'Azimpur', 'Dhaka', '2026-04-15', '2026-04-10 06:00:00', 'Active', '/photos/anwar.jpg', 'Citizen'),
(16, 'Shamima Akter', 'shamima.akter@example.com', '01710000016', 'Shamima@123', 'Kawran Bazar', 'Dhaka', '2026-04-16', '2026-04-10 07:15:00', 'Suspended', '/photos/shamima.jpg', 'Citizen'),
(17, 'Mahmudul Hasan', 'mahmud.hasan@example.com', '01710000017', 'Mahmud@123', 'Paltan', 'Dhaka', '2026-04-17', '2026-04-10 08:30:00', 'Active', '/photos/mahmud.jpg', 'Citizen'),
(18, 'Rokeya Sultana', 'rokeya.sultana@example.com', '01710000018', 'Rokeya@123', 'New Market', 'Dhaka', '2026-04-18', '2026-04-10 09:45:00', 'Active', '/photos/rokeya.jpg', 'Citizen'),
(19, 'Ashraful Alam', 'ashraf.alam@example.com', '01710000019', 'Ashraf@123', 'Kallyanpur', 'Dhaka', '2026-04-19', '2026-04-10 10:00:00', 'Inactive', '/photos/ashraf.jpg', 'Citizen'),
(20, 'Samira Khan', 'samira.khan@example.com', '01710000020', 'Samira@123', 'Mohammadpur', 'Dhaka', '2026-04-20', '2026-04-10 11:15:00', 'Active', '/photos/samira.jpg', 'Citizen'),
(21, 'John Smith', 'john.smith@example.com', '01710000021', 'John@123', 'Baridhara', 'Dhaka', '2026-04-21', '2026-04-10 12:30:00', 'Active', '/photos/john.jpg', 'Citizen'),
(22, 'Emily Johnson', 'emily.johnson@example.com', '01710000022', 'Emily@123', 'Banani', 'Dhaka', '2026-04-22', '2026-04-10 13:45:00', 'Active', '/photos/emily.jpg', 'Citizen'),
(23, 'David Lee', 'david.lee@example.com', '01710000023', 'David@123', 'Gulshan', 'Dhaka', '2026-04-23', '2026-04-10 14:00:00', 'Active', '/photos/david.jpg', 'Citizen'),
(24, 'Sophia Brown', 'sophia.brown@example.com', '01710000024', 'Sophia@123', 'Uttara', 'Dhaka', '2026-04-24', '2026-04-10 15:15:00', 'Active', '/photos/sophia.jpg', 'Citizen'),
(25, 'Michael Clark', 'michael.clark@example.com', '01710000025', 'Michael@123', 'Mirpur', 'Dhaka', '2026-04-25', '2026-04-10 16:30:00', 'Inactive', '/photos/michael.jpg', 'Citizen'),
(26, 'Olivia Davis', 'olivia.davis@example.com', '01710000026', 'Olivia@123', 'Shyamoli', 'Dhaka', '2026-04-26', '2026-04-10 17:45:00', 'Active', '/photos/olivia.jpg', 'Citizen'),
(27, 'Daniel Wilson', 'daniel.wilson@example.com', '01710000027', 'Daniel@123', 'Khilgaon', 'Dhaka', '2026-04-27', '2026-04-10 17:50:00', 'Active', '/photos/wilson.jpg', 'Citizen'),
(28, 'Nabila Chowdhury', 'nabila.chowdhury@example.com', '01710000041', 'Nabila@123', 'Shantinagar', 'Dhaka', '2026-05-11', '2026-05-11 03:30:00', 'Active', '/photos/nabila.jpg', 'Citizen'),
(29, 'James Taylor', 'james.taylor@example.com', '01710000029', 'James@123', 'Rampura', 'Dhaka', '2026-04-29', '2026-04-11 04:00:00', 'Active', '/photos/james.jpg', 'Citizen'),
(30, 'Isabella Thomas', 'isabella.thomas@example.com', '01710000030', 'Isabella@123', 'Azimpur', 'Dhaka', '2026-04-30', '2026-04-11 05:15:00', 'Active', '/photos/isabella.jpg', 'Citizen'),
(31, 'Henry White', 'henry.white@example.com', '01710000031', 'Henry@123', 'Farmgate', 'Dhaka', '2026-05-01', '2026-04-11 06:30:00', 'Inactive', '/photos/henry.jpg', 'Citizen'),
(32, 'Charlotte Harris', 'charlotte.harris@example.com', '01710000032', 'Charlotte@123', 'Malibagh', 'Dhaka', '2026-05-02', '2026-04-11 07:45:00', 'Active', '/photos/charlotte.jpg', 'Citizen'),
(33, 'Alexander Young', 'alex.young@example.com', '01710000033', 'Alex@123', 'Tejgaon', 'Dhaka', '2026-05-03', '2026-04-11 09:00:00', 'Active', '/photos/alex.jpg', 'Citizen'),
(34, 'Amelia King', 'amelia.king@example.com', '01710000034', 'Amelia@123', 'New Market', 'Dhaka', '2026-05-04', '2026-04-11 10:15:00', 'Active', '/photos/amelia.jpg', 'Citizen'),
(35, 'Benjamin Scott', 'benjamin.scott@example.com', '01710000035', 'Ben@123', 'Kawran Bazar', 'Dhaka', '2026-05-05', '2026-04-11 11:30:00', 'Active', '/photos/ben.jpg', 'Citizen'),
(36, 'Mia Adams', 'mia.adams@example.com', '01710000036', 'Mia@123', 'Mohammadpur', 'Dhaka', '2026-05-06', '2026-04-11 12:45:00', 'Active', '/photos/mia.jpg', 'Citizen'),
(37, 'William Baker', 'william.baker@example.com', '01710000037', 'William@123', 'Kallyanpur', 'Dhaka', '2026-05-07', '2026-04-11 14:00:00', 'Suspended', '/photos/william.jpg', 'Citizen'),
(38, 'Evelyn Carter', 'evelyn.carter@example.com', '01710000038', 'Evelyn@123', 'Baridhara', 'Dhaka', '2026-05-08', '2026-04-11 15:15:00', 'Active', '/photos/evelyn.jpg', 'Citizen'),
(39, 'Lucas Perez', 'lucas.perez@example.com', '01710000039', 'Lucas@123', 'Banani', 'Dhaka', '2026-05-09', '2026-04-11 16:30:00', 'Active', '/photos/lucas.jpg', 'Citizen'),
(40, 'Grace Rivera', 'grace.rivera@example.com', '01710000040', 'Grace@123', 'Gulshan', 'Dhaka', '2026-05-10', '2026-04-11 17:45:00', 'Active', '/photos/grace.jpg', 'Citizen');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admins`
--
ALTER TABLE `Admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `Attachments`
--
ALTER TABLE `Attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `complaint_id` (`complaint_id`);

--
-- Indexes for table `Complaints`
--
ALTER TABLE `Complaints`
  ADD PRIMARY KEY (`complaint_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `location_id` (`location_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `Complaint_Categories`
--
ALTER TABLE `Complaint_Categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `Complaint_History`
--
ALTER TABLE `Complaint_History`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `complaint_id` (`complaint_id`),
  ADD KEY `assigned_admin` (`assigned_admin`);

--
-- Indexes for table `Complaint_Status`
--
ALTER TABLE `Complaint_Status`
  ADD PRIMARY KEY (`status_id`),
  ADD KEY `handled_by` (`handled_by`);

--
-- Indexes for table `Locations`
--
ALTER TABLE `Locations`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `Login_Logs`
--
ALTER TABLE `Login_Logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Notifications`
--
ALTER TABLE `Notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `complaint_id` (`complaint_id`);

--
-- Indexes for table `Reports`
--
ALTER TABLE `Reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `generated_by` (`generated_by`);

--
-- Indexes for table `Traffic_Departments`
--
ALTER TABLE `Traffic_Departments`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admins`
--
ALTER TABLE `Admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Attachments`
--
ALTER TABLE `Attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Complaints`
--
ALTER TABLE `Complaints`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Complaint_Categories`
--
ALTER TABLE `Complaint_Categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `Complaint_History`
--
ALTER TABLE `Complaint_History`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Complaint_Status`
--
ALTER TABLE `Complaint_Status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Locations`
--
ALTER TABLE `Locations`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Login_Logs`
--
ALTER TABLE `Login_Logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Notifications`
--
ALTER TABLE `Notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Reports`
--
ALTER TABLE `Reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Traffic_Departments`
--
ALTER TABLE `Traffic_Departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Attachments`
--
ALTER TABLE `Attachments`
  ADD CONSTRAINT `Attachments_ibfk_1` FOREIGN KEY (`complaint_id`) REFERENCES `Complaints` (`complaint_id`);

--
-- Constraints for table `Complaints`
--
ALTER TABLE `Complaints`
  ADD CONSTRAINT `Complaints_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  ADD CONSTRAINT `Complaints_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `Complaint_Categories` (`category_id`),
  ADD CONSTRAINT `Complaints_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `Locations` (`location_id`),
  ADD CONSTRAINT `Complaints_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `Complaint_Status` (`status_id`),
  ADD CONSTRAINT `Complaints_ibfk_5` FOREIGN KEY (`admin_id`) REFERENCES `Admins` (`admin_id`);

--
-- Constraints for table `Complaint_History`
--
ALTER TABLE `Complaint_History`
  ADD CONSTRAINT `Complaint_History_ibfk_1` FOREIGN KEY (`complaint_id`) REFERENCES `Complaints` (`complaint_id`),
  ADD CONSTRAINT `Complaint_History_ibfk_2` FOREIGN KEY (`assigned_admin`) REFERENCES `Admins` (`admin_id`);

--
-- Constraints for table `Complaint_Status`
--
ALTER TABLE `Complaint_Status`
  ADD CONSTRAINT `Complaint_Status_ibfk_1` FOREIGN KEY (`handled_by`) REFERENCES `Admins` (`admin_id`);

--
-- Constraints for table `Login_Logs`
--
ALTER TABLE `Login_Logs`
  ADD CONSTRAINT `Login_Logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `Notifications`
--
ALTER TABLE `Notifications`
  ADD CONSTRAINT `Notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  ADD CONSTRAINT `Notifications_ibfk_2` FOREIGN KEY (`complaint_id`) REFERENCES `Complaints` (`complaint_id`);

--
-- Constraints for table `Reports`
--
ALTER TABLE `Reports`
  ADD CONSTRAINT `Reports_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `Admins` (`admin_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
