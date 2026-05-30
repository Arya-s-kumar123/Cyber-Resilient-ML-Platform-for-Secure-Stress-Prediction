-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2026 at 07:35 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stress_resilient`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add district', 7, 'add_district'),
(26, 'Can change district', 7, 'change_district'),
(27, 'Can delete district', 7, 'delete_district'),
(28, 'Can view district', 7, 'view_district'),
(29, 'Can add login', 8, 'add_login'),
(30, 'Can change login', 8, 'change_login'),
(31, 'Can delete login', 8, 'delete_login'),
(32, 'Can view login', 8, 'view_login'),
(33, 'Can add medical speciality', 9, 'add_medicalspeciality'),
(34, 'Can change medical speciality', 9, 'change_medicalspeciality'),
(35, 'Can delete medical speciality', 9, 'delete_medicalspeciality'),
(36, 'Can view medical speciality', 9, 'view_medicalspeciality'),
(37, 'Can add state', 10, 'add_state'),
(38, 'Can change state', 10, 'change_state'),
(39, 'Can delete state', 10, 'delete_state'),
(40, 'Can view state', 10, 'view_state'),
(41, 'Can add doctor', 11, 'add_doctor'),
(42, 'Can change doctor', 11, 'change_doctor'),
(43, 'Can delete doctor', 11, 'delete_doctor'),
(44, 'Can view doctor', 11, 'view_doctor'),
(45, 'Can add patient', 12, 'add_patient'),
(46, 'Can change patient', 12, 'change_patient'),
(47, 'Can delete patient', 12, 'delete_patient'),
(48, 'Can view patient', 12, 'view_patient'),
(49, 'Can add appointment', 13, 'add_appointment'),
(50, 'Can change appointment', 13, 'change_appointment'),
(51, 'Can delete appointment', 13, 'delete_appointment'),
(52, 'Can view appointment', 13, 'view_appointment'),
(53, 'Can add prescription', 14, 'add_prescription'),
(54, 'Can change prescription', 14, 'change_prescription'),
(55, 'Can delete prescription', 14, 'delete_prescription'),
(56, 'Can view prescription', 14, 'view_prescription'),
(57, 'Can add stress detection', 15, 'add_stressdetection'),
(58, 'Can change stress detection', 15, 'change_stressdetection'),
(59, 'Can delete stress detection', 15, 'delete_stressdetection'),
(60, 'Can view stress detection', 15, 'view_stressdetection'),
(61, 'Can add complaint', 16, 'add_complaint'),
(62, 'Can change complaint', 16, 'change_complaint'),
(63, 'Can delete complaint', 16, 'delete_complaint'),
(64, 'Can view complaint', 16, 'view_complaint'),
(65, 'Can add feedback', 17, 'add_feedback'),
(66, 'Can change feedback', 17, 'change_feedback'),
(67, 'Can delete feedback', 17, 'delete_feedback'),
(68, 'Can view feedback', 17, 'view_feedback'),
(69, 'Can add model results', 18, 'add_modelresults'),
(70, 'Can change model results', 18, 'change_modelresults'),
(71, 'Can delete model results', 18, 'delete_modelresults'),
(72, 'Can view model results', 18, 'view_modelresults'),
(73, 'Can add leave days', 19, 'add_leavedays'),
(74, 'Can change leave days', 19, 'change_leavedays'),
(75, 'Can delete leave days', 19, 'delete_leavedays'),
(76, 'Can view leave days', 19, 'view_leavedays'),
(77, 'Can add leave', 20, 'add_leave'),
(78, 'Can change leave', 20, 'change_leave'),
(79, 'Can delete leave', 20, 'delete_leave'),
(80, 'Can view leave', 20, 'view_leave');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$ayfQqZxhPLRFh1j6IyZCmI$RCzySmK4icmt/JpaBPZfEQfjzmxo+y5tDNXjQ1+R0Sc=', NULL, 1, 'admin', '', '', '', 1, 1, '2026-03-16 06:19:49.477823');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(13, 'myapp', 'appointment'),
(16, 'myapp', 'complaint'),
(7, 'myapp', 'district'),
(11, 'myapp', 'doctor'),
(17, 'myapp', 'feedback'),
(20, 'myapp', 'leave'),
(19, 'myapp', 'leavedays'),
(8, 'myapp', 'login'),
(9, 'myapp', 'medicalspeciality'),
(18, 'myapp', 'modelresults'),
(12, 'myapp', 'patient'),
(14, 'myapp', 'prescription'),
(10, 'myapp', 'state'),
(15, 'myapp', 'stressdetection'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-03-16 06:19:24.461575'),
(2, 'auth', '0001_initial', '2026-03-16 06:19:25.275293'),
(3, 'admin', '0001_initial', '2026-03-16 06:19:25.525357'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-03-16 06:19:25.540978'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-03-16 06:19:25.556606'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-03-16 06:19:25.664461'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-03-16 06:19:25.774817'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-03-16 06:19:25.790450'),
(9, 'auth', '0004_alter_user_username_opts', '2026-03-16 06:19:25.806282'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-03-16 06:19:25.868769'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-03-16 06:19:25.884390'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-03-16 06:19:25.884390'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-03-16 06:19:25.900015'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-03-16 06:19:25.930248'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-03-16 06:19:25.946952'),
(16, 'auth', '0011_update_proxy_permissions', '2026-03-16 06:19:25.946952'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-03-16 06:19:25.978200'),
(18, 'myapp', '0001_initial', '2026-03-16 06:19:27.196159'),
(19, 'sessions', '0001_initial', '2026-03-16 06:19:27.257516'),
(20, 'myapp', '0002_alter_doctor_photo', '2026-03-16 07:26:31.790629'),
(21, 'myapp', '0003_appointment_appointment_time', '2026-03-16 09:25:15.244322'),
(22, 'myapp', '0004_complaint', '2026-03-17 05:36:13.989708'),
(23, 'myapp', '0005_feedback', '2026-03-17 05:47:02.786883'),
(24, 'myapp', '0006_modelresults', '2026-03-18 23:45:06.910072'),
(25, 'myapp', '0007_stressdetection_age_stressdetection_alcohol_and_more', '2026-03-19 00:58:55.661447'),
(26, 'myapp', '0008_doctor_proof', '2026-03-25 06:12:50.948183'),
(27, 'myapp', '0009_leave_leavedays', '2026-03-25 07:49:52.548911'),
(28, 'myapp', '0010_doctor_consultation_end_doctor_consultation_start', '2026-03-25 09:51:51.443942');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('tt40azhiqfyd45z7bbb96o910ur269qc', '.eJyrVkrJS8xNVbJSSiwqzTM0MlbSUSrOyU_PTFGyMtJRSslPLskviscQAPNqAV3DE9I:1w5St2:Ss_gcfrg6VwpWM60o9w_wvuFhZovWFYyAmv9ab4GUos', '2026-04-08 18:23:24.817851');

-- --------------------------------------------------------

--
-- Table structure for table `model_results`
--

CREATE TABLE `model_results` (
  `id` int(11) NOT NULL,
  `accuracy` double DEFAULT NULL,
  `precision_score` double DEFAULT NULL,
  `recall_score` double DEFAULT NULL,
  `f1_score` double DEFAULT NULL,
  `report` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `model_results`
--

INSERT INTO `model_results` (`id`, `accuracy`, `precision_score`, `recall_score`, `f1_score`, `report`) VALUES
(1, 0.7677419354838709, 0.7762193682065791, 0.7677419354838709, 0.7654174811478535, '              precision    recall  f1-score   support\n\n           0       0.85      0.83      0.84        69\n           1       0.79      0.54      0.64        28\n           2       0.68      0.81      0.74        58\n    accuracy                           0.77       155\n   macro avg       0.77      0.72      0.74       155\nweighted avg       0.78      0.77      0.77       155\n');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_appointment`
--

CREATE TABLE `tbl_appointment` (
  `appointment_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(50) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_time` time(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_appointment`
--

INSERT INTO `tbl_appointment` (`appointment_id`, `appointment_date`, `created_at`, `status`, `doctor_id`, `patient_id`, `appointment_time`) VALUES
(2, '2026-03-25', '2026-03-16 09:31:14.408415', 'Approved', 2, 2, '10:00:00.000000'),
(3, '2026-03-16', '2026-03-16 09:54:32.372793', 'Approved', 2, 1, '16:00:00.000000'),
(4, '2026-03-20', '2026-03-18 23:55:30.962808', 'Pending', 2, 1, '10:00:00.000000'),
(5, '2026-03-19', '2026-03-18 23:55:56.978976', 'Approved', 2, 1, '09:00:00.000000'),
(6, '2026-03-19', '2026-03-18 23:56:24.364014', 'Approved', 2, 1, '11:00:00.000000'),
(7, '2026-03-19', '2026-03-18 23:56:50.266527', 'Approved', 2, 1, '12:00:00.000000'),
(8, '2026-04-26', '2026-03-25 11:17:41.483570', 'Pending', 3, 1, '11:15:00.000000'),
(9, '2026-04-28', '2026-03-25 11:19:54.178368', 'Pending', 3, 1, '11:15:00.000000'),
(10, '2026-04-01', '2026-03-25 12:57:16.709040', 'Cancelled', 2, 1, '13:45:00.000000'),
(11, '2026-03-31', '2026-03-25 18:15:09.166373', 'Pending', 2, 1, '12:45:00.000000'),
(12, '2026-03-30', '2026-03-25 18:16:24.101595', 'Pending', 2, 1, '12:00:00.000000'),
(13, '2026-03-30', '2026-03-25 18:16:55.465788', 'Pending', 2, 1, '12:15:00.000000'),
(14, '2026-03-30', '2026-03-25 18:17:25.467180', 'Pending', 3, 1, '09:00:00.000000'),
(15, '2026-03-30', '2026-03-25 18:18:27.795761', 'Pending', 2, 1, '12:30:00.000000');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_complaint`
--

CREATE TABLE `tbl_complaint` (
  `complaint_id` int(11) NOT NULL,
  `complaint` longtext NOT NULL,
  `reply` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_complaint`
--

INSERT INTO `tbl_complaint` (`complaint_id`, `complaint`, `reply`, `status`, `created_at`, `patient_id`) VALUES
(1, 'I had to wait for a long time even after booking an appointment. Please improve time management.', 'ok', 'Replied', '2026-03-17 05:41:23.050834', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district`
--

CREATE TABLE `tbl_district` (
  `district_id` int(11) NOT NULL,
  `district` varchar(50) NOT NULL,
  `state_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_district`
--

INSERT INTO `tbl_district` (`district_id`, `district`, `state_id`) VALUES
(1, 'Thiruvananthapuram', 1),
(2, 'Kollam', 1),
(3, 'Pathanamthitta', 1),
(4, 'Alappuzha', 1),
(5, 'Kottayam', 1),
(6, 'Idukki', 1),
(7, 'Ernakulam', 1),
(8, 'Thrissur', 1),
(9, 'Palakkad', 1),
(10, 'Malappuram', 1),
(11, 'Kozhikode', 1),
(12, 'Wayanad', 1),
(13, 'Kannur', 1),
(15, 'Kasaragod', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_doctor`
--

CREATE TABLE `tbl_doctor` (
  `doctor_id` int(11) NOT NULL,
  `doctor_first_name` varchar(50) NOT NULL,
  `doctor_last_name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` bigint(20) NOT NULL,
  `place` varchar(50) NOT NULL,
  `qualification` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `district_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `medical_speciality_id` int(11) NOT NULL,
  `proof` varchar(100) NOT NULL,
  `consultation_end` time(6) DEFAULT NULL,
  `consultation_start` time(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_doctor`
--

INSERT INTO `tbl_doctor` (`doctor_id`, `doctor_first_name`, `doctor_last_name`, `address`, `email`, `phone_number`, `place`, `qualification`, `photo`, `district_id`, `login_id`, `medical_speciality_id`, `proof`, `consultation_end`, `consultation_start`) VALUES
(2, 'Arun', 'Kumar', 'Arunima Villa', 'phebaebenezer@gmail.com', 9654145203, 'Pathanamthitta', 'MBBS, MD Psychiatry', 'doctor_photos/1..jpg', 3, 2, 5, 'doctor_proofs/Demo_Report.pdf', '19:00:00.000000', '12:00:00.000000'),
(3, 'Anoop', ' Chandran', 'Anoop Villa', 'phebaebenezer@gmail.com\n	', 8976543456, 'Pathanamthtta', 'MBBS', 'doctor_photos/5..jpg', 3, 6, 1, 'doctor_proofs/Demo_Report.pdf', '17:00:00.000000', '09:00:00.000000'),
(4, 'Deepa', 'Chnadran', 'Deepa Villa', 'deepa@gmail.com', 8956321245, 'Ktm', 'MBBS', 'doctor_photos/3._Rz4zQ8w.jpg', 3, 8, 4, 'doctor_proofs/Demo_Report_lWvUyK6.pdf', '17:00:00.000000', '09:00:00.000000');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_feedback`
--

CREATE TABLE `tbl_feedback` (
  `feedback_id` int(11) NOT NULL,
  `feedback` longtext NOT NULL,
  `reply` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_feedback`
--

INSERT INTO `tbl_feedback` (`feedback_id`, `feedback`, `reply`, `status`, `created_at`, `patient_id`) VALUES
(1, 'Nice', NULL, 'Pending', '2026-03-17 05:51:42.592862', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leave`
--

CREATE TABLE `tbl_leave` (
  `leave_id` int(11) NOT NULL,
  `leave_type` varchar(50) DEFAULT NULL,
  `reason` longtext DEFAULT NULL,
  `leave_status` varchar(50) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `doctor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_leave`
--

INSERT INTO `tbl_leave` (`leave_id`, `leave_type`, `reason`, `leave_status`, `start_date`, `end_date`, `created_at`, `doctor_id`) VALUES
(1, 'Sick Leave', 'Health Issues', 'Approved', '2026-03-26', '2026-03-28', '2026-03-25 07:56:08.166617', 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leave_days`
--

CREATE TABLE `tbl_leave_days` (
  `leave_days_id` int(11) NOT NULL,
  `leave_date` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `leave_days_status` varchar(50) NOT NULL,
  `leave_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_leave_days`
--

INSERT INTO `tbl_leave_days` (`leave_days_id`, `leave_date`, `created_at`, `leave_days_status`, `leave_id`) VALUES
(1, '2026-03-26', '2026-03-25 07:56:08.180361', 'Approved', 1),
(2, '2026-03-27', '2026-03-25 07:56:08.196954', 'Approved', 1),
(3, '2026-03-28', '2026-03-25 07:56:08.200989', 'Approved', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_login`
--

CREATE TABLE `tbl_login` (
  `login_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` longtext NOT NULL,
  `Usertype` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_login`
--

INSERT INTO `tbl_login` (`login_id`, `username`, `password`, `Usertype`, `status`) VALUES
(2, 'arun123', 'arun@1234', 'Doctor', 'Approved'),
(3, 'gayathri12', 'gayathri@123', 'Patient', 'Approved'),
(4, 'malavika12', 'malavika@123', 'Patient', 'Approved'),
(6, 'anoop1234', 'anoop1234', 'Doctor', 'Approved'),
(8, 'deepa123', 'deepa123', 'Doctor', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_medical_speciality`
--

CREATE TABLE `tbl_medical_speciality` (
  `medical_speciality_id` int(11) NOT NULL,
  `speciality` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_medical_speciality`
--

INSERT INTO `tbl_medical_speciality` (`medical_speciality_id`, `speciality`) VALUES
(1, 'Neurology'),
(2, 'ENT (Ear, Nose, Throat)'),
(3, 'General Medicine'),
(4, 'Mental Health Specialist'),
(5, 'Psychiatry');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_patient`
--

CREATE TABLE `tbl_patient` (
  `patient_id` int(11) NOT NULL,
  `patient_name` varchar(50) NOT NULL,
  `phone_number` bigint(20) NOT NULL,
  `address` longtext NOT NULL,
  `place` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `district_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_patient`
--

INSERT INTO `tbl_patient` (`patient_id`, `patient_name`, `phone_number`, `address`, `place`, `dob`, `created_at`, `district_id`, `login_id`) VALUES
(1, 'Gayathri M', 8954123647, 'Gayathri villa', 'Pathanamthitta', '2000-02-16', '2026-03-16 07:33:58.049303', 3, 3),
(2, 'Malavika ', 9632021478, 'malavika villa', 'kozhencherry', '1999-01-14', '2026-03-16 09:22:23.779172', 3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prescription`
--

CREATE TABLE `tbl_prescription` (
  `prescription_id` int(11) NOT NULL,
  `visiting_date` date NOT NULL,
  `symptoms` longtext NOT NULL,
  `medicine` longtext NOT NULL,
  `uses` longtext NOT NULL,
  `details` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `appointment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_prescription`
--

INSERT INTO `tbl_prescription` (`prescription_id`, `visiting_date`, `symptoms`, `medicine`, `uses`, `details`, `created_at`, `appointment_id`) VALUES
(1, '2026-03-20', 'gAAAAABpu1W852MjsbHVyDNozkUH3-wwML7AW1PhFAGZsvr4mN-tFHF1QpBH2GXuX_rwGTve6RGpDQQfStkHneEgxdXsW6ZVPvpIIGGfjtMQud9tdKe36qs=', 'gAAAAABpu1W8vlZ4iBQw06cYuSeq-Vf6M1Etw4CivJDH-1oQWbc7iEmApozXYAel-xNQ_xXl7KVacXiIumJ6CPzixUd9Jp--sek1eF5RD_2EHXuc_iz4BpaDHnSXZRpTyMcL44JtCxu7', 'gAAAAABpu1W8gphDiU9iYIwgj2jvULeOZamwX6UR5MExX7qMpumexD0TM7IYTFmDeW7uTCvrUPWfTsvQdobOb9KzpR0RY7F9hmqmlNLSRjzUwAB5i-qP8L24CwQGQxRPZYLMFOeIUbvt', 'gAAAAABpu1W8VHjawCHKgyQjcspO_FKs2hdf9aOK67e4Agq1guxci4bAEEM2uXH9VZOWUpsbA1ljKhuLzsTXDiErn5_-9JWa1WaMQmOKSE9gq4Shpc7UNbI=', '2026-03-19 01:47:40.107251', 5);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_state`
--

CREATE TABLE `tbl_state` (
  `state_id` int(11) NOT NULL,
  `state` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_state`
--

INSERT INTO `tbl_state` (`state_id`, `state`) VALUES
(1, 'Kerala');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_stress_detection`
--

CREATE TABLE `tbl_stress_detection` (
  `prediction_id` int(11) NOT NULL,
  `rf_prediction` longtext NOT NULL,
  `confidence_score` double NOT NULL,
  `prediction_date` datetime(6) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `age` longtext NOT NULL,
  `alcohol` longtext NOT NULL,
  `bed_time` longtext NOT NULL,
  `bp` longtext NOT NULL,
  `caffeine` longtext NOT NULL,
  `cholesterol` longtext NOT NULL,
  `exercise` longtext NOT NULL,
  `gender` longtext NOT NULL,
  `marital_status` longtext NOT NULL,
  `meditation` longtext NOT NULL,
  `occupation` longtext NOT NULL,
  `physical_activity` longtext NOT NULL,
  `screen_time` longtext NOT NULL,
  `sleep_duration` longtext NOT NULL,
  `sleep_quality` longtext NOT NULL,
  `smoking` longtext NOT NULL,
  `social` longtext NOT NULL,
  `sugar` longtext NOT NULL,
  `travel_time` longtext NOT NULL,
  `wake_time` longtext NOT NULL,
  `work_hours` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_stress_detection`
--

INSERT INTO `tbl_stress_detection` (`prediction_id`, `rf_prediction`, `confidence_score`, `prediction_date`, `appointment_id`, `age`, `alcohol`, `bed_time`, `bp`, `caffeine`, `cholesterol`, `exercise`, `gender`, `marital_status`, `meditation`, `occupation`, `physical_activity`, `screen_time`, `sleep_duration`, `sleep_quality`, `smoking`, `social`, `sugar`, `travel_time`, `wake_time`, `work_hours`) VALUES
(1, 'gAAAAABpu1XDBl90b2TlGAZpkopg4eEF7S2YuZx1QjsW5f00bzWOyDrhJvRTx9GbjdN8kct1rEVXAUQVgYijUvIUJBbSAij5rg==', 0.57, '2026-03-19 01:47:47.885354', 5, 'gAAAAABpu1XDNh4Yj0vrlxd5MnHNVm6STcZaKCT2rMKv3JXMO9e6cw8J5zG1JkiQfxdNsn03KoDhYJW9qEroGQJTSgJIXd2d-w==', 'gAAAAABpu1XD1biKVqZstx76JrFh_qfMwxZlN4rKRukyWOnWbaayZnmoqmgxE5m6ELX8HgkA7HJSwFyTNAfS8uSDo-AKHMew-g==', 'gAAAAABpu1XDypfm5xsTuNTb7Zep837I1_VKPI7STwUsRG26gDIDNp8ynFZ7DjAdNpfobq-Jm1JjE2y_uI53GYgpsj_SaZswhg==', 'gAAAAABpu1XDOmAK-IHDQVgqnoVuWGVBBT5S-B_fjJrtIUyUr4LAdDo21AGvWdNZw3A4WBZuhWTUp9fvkAk-qivaxlzMPIdDxg==', 'gAAAAABpu1XDbdCkhee2VVYOCCDEMo1G7jaAQyu28c5NccKmxLP-WofHaNxd1D4IAIjVkOkVWHLr-Gio_Xhz0vywzNEWeJNp8Q==', 'gAAAAABpu1XD9LC5DY4QkYYUlxgaPOYZxX30SF0izYLHI19WFaYpDGyeOnX54OnVwDKz3x1pDV0GrfgT0p2fOlmf-eNsPL2rtQ==', 'gAAAAABpu1XDt3vDNKCkHJKd2_Wf8BL_setIQ8h-uDE9BONkNg3NvoOsEVa1Gcr2jENWotraOlqTddSK-XXN7h2rr1COEvdF1gH57dDFoLUn7zQojhlmbUU=', 'gAAAAABpu1XDWhSHNBZloeuTxu2cl5t6wSdMJjBmLkqiTOzPvzEVerqUewQeZsEskOX9unOUIftkUkNQ0C2WS9rDpq4SNnAbuA==', 'gAAAAABpu1XDxQUTekyDctQDVL7Xsxv7QkLAJXmUTevvWFPrdHdoM-B4H9NH3v2Azya3KDToAJ9ouZX9x5hz-Zby2g7oW9_auQ==', 'gAAAAABpu1XDU-V_EnxGAfuimr1Z6eqDcWGyFU_-0OFWmA-YsglUpJDNoEsJzuKBHh6Hhv2mRUPz164YA2kSZB2WO8fx3zGqfQ==', 'gAAAAABpu1XDShZS5nSRxfEj4HoJDzD01ElGZdNw7vjQezBobJyPNKMpxMtCu6bZMrcDomswpkwX0Zryttp3SmDJqSGi36_fncKGztaUQkLKc0BXY90Prnw=', 'gAAAAABpu1XDvhej9aI3ZoEE8LgFEiDvRrzSUCUFSHt33vT2mFUVRH04zkFYGUvghzu9zjxNRcNLHU14YLVH8x7uDah2rfWO_Q==', 'gAAAAABpu1XD4j7YO-fiK3XfR5A8T7k3ENDVaqERMI_QXagE8KcPS_ATaRWKQRhj6C0GxPoxWo4kajkIm1J6e2RYbnGkibeRew==', 'gAAAAABpu1XDGwbxXzZCuer7UcP86DalVCfd6-1gzJI0lMAVtDnamiRqb5HpBaC64DZVLTxcbIJCtZaiAtoyRKiHs_d_5E740A==', 'gAAAAABpu1XDBAkBpG3a1MTGlpLM6AJJKWJPVMMXh2uSzFO1gj3McdRStt1P-eualIPfph3mLb3X-4-1uikypytwwPC3Jq1Nlw==', 'gAAAAABpu1XDk9ghaHRQjC9sglfZVqN7OBALfX8GdPcSpuC_Ckun0WqHLkQ6ZOrm54SMdifinTROQsK2_KpfUWZw1ZBZnlAw6A==', 'gAAAAABpu1XDSEssAXuAqme9rUhuP9uHbNHkh3vp-DkTaZgXTSMsoBBkd2rumxSJlls-3LuMMkB7l1lVIVh4SdgMe6MyJiL8-Q==', 'gAAAAABpu1XDoZPuZgSgyrtYlIXjfHk_e_TbeqShPsCuyq1rTmqw9ByJGUtrmt8S-Izvz26lEmsdoWJnpiqk574Rtz9tF0GUdg==', 'gAAAAABpu1XDMRKjk2vspCqgQP3MmVBbX554aDv3HfsHHWhv5CqXQhctgadiNC5OcwRupW7mziHs0GHd7ZQAB5KtOOsqLDPMEg==', 'gAAAAABpu1XDdsakQkCiAKhibhOB-5H3Gj0jJ0N70Y5oFYgyEgocd3qHTAuaKBpeaSP3_6BTs-jUSJaayCynhyyC9lbPZMiZAg==', 'gAAAAABpu1XDww2ntsTj-9fsgqn8WQkPHsb14OtG1QD76hUgxa27eqK5pVSH1T5NuOGbK03Gzwdu0bNyDD2gxLo_LjXI-o0-9w=='),
(2, 'gAAAAABpu1XMgh3H8WrRNjUHu1A1a2hOw48tn_S8oj0IsfJx5emdEccwwD-dOc2Nes_LOLrGEMMpyCI5E4oqcTNi3qT-1wz5EQ==', 0.56, '2026-03-19 01:47:56.539454', 6, 'gAAAAABpu1XMbuAl9Tr96yVGHu_4twG8OCo7jf0wEBFuoKtGUwXUPD-XQCjsLI0oz5XmnynlscDOcHvS734Hf5lSBXvIcPE58Q==', 'gAAAAABpu1XM6vfEvSJscwBk2JOzxX6gvXjo8ob3A8_syQmtUiusnrUT1KQyI4CmtsdefrqwpD18fvKarsnGmxXL83138jmoYg==', 'gAAAAABpu1XMNk-BJcZLx3Vm-FOYgb2m17ZMkLKMUMFpT78eaKG3Jfa1u1moQh9-vOpo8Hj7NHoARvHGC2NyiBwYqikTQ1pBgw==', 'gAAAAABpu1XMi0IO1YfOKfz-Kf0H1lTuxFTm8DZPUGOSa5n6O-oNh53N8tSyj35Q5RxWBTTbg49f0YTCizoqD9IEroF9H6X39w==', 'gAAAAABpu1XMKLD2afUV-R5ZDZ7kYSi0hYHrmSlz7Vji8k4h--1XYFYlJL9pdpL-qSCJvueLGMlrh5Ge3Dy1Ze50vE7vE4Skcw==', 'gAAAAABpu1XMgrf-UDzzA0hOiWybHIVtqgcaQeMQV3uMdXFefffSGvgtVHRPF0PsJ_gNRlRsW2IxwWvjEuO9lB3DiG3xIWFDdg==', 'gAAAAABpu1XMtL7in-3ZEMm7gwrSm6WMRy_obToVa0f62WduWVUcns6b31ryMiuVEu63WYo5fPQjD27rx1jn-O6-q3oRdCeTzw==', 'gAAAAABpu1XM8igym27LHDHZVh8z55y7HFiysnvRPt296AfAwmdrni7Pw84YhAY9W0s9wZ8APjh_aNhw4sI8x5L4LGFVmFo1ZQ==', 'gAAAAABpu1XMWiVgZUPQAw7OD2yxMx8tYIKHwAlQTuAWosi2wkuKP_9-WQhkT8NEnM3tcQosxA3g24FHMWzROM2sAELBwK_P8Q==', 'gAAAAABpu1XM_UgXngQ1LOqK6yHWBlFdl9cdBd19tAuTyPb0eFAKEmpnJZ7A45hCaQjo1ysF-sbhX6_lt3ButKMpMlVlKEQucw==', 'gAAAAABpu1XMGNvs2whYlKQxuMXWR-qWVIed1-K0RpaDBZagKfVck6prAaflWMvt76IXD1AJI3uNs41uDwaygUOmN4JSOxcegg==', 'gAAAAABpu1XMmvwynpJ5BmSeGgABngwyIf1uzATka2Zvqk6VBVuifGJgBsRaMKqaRB7aZHJe0ws05lxwTMF8wsn90BjN40PRgA==', 'gAAAAABpu1XMLkM6QBpL7KmVJaXgqn-akoxMipBjeDsM6L4_t2Ger-zPZ6YNoHWTdUtbN5I-5wjfG4qBkJs3EfvosxDMSCvCXQ==', 'gAAAAABpu1XMm7f9kjmTcKcDvvScCTRJsGRtTQ8P99A4RFauV1PvfqBzmTzK1ZLkP1vzU9OQ7qRqg8BEOYl-di6BEB0vLWltIQ==', 'gAAAAABpu1XMJIOMVlMbDm_EUVqf7Y8lDvMkJg991yVuGG8SEIzhO-WHe0QtEG2YlJIIwNNLJPxWKE2Lc6o8m1Lw-XJqQhXN1g==', 'gAAAAABpu1XM6Ua0umSRpPslfI1L4Gdt-y2fBDPFUJto0VFE4ZcGsJbnf5GagtRr8eq8dC779MTLZF35tGlBwCu1As_RvsGGoA==', 'gAAAAABpu1XMsJeVpp-WXhUGQdxUYEPsaKU70fQvfCNI_-v6yudW-O0oZG5sPlQptxq_dcpEW0qHrBOWT7x1PKDjryW7HI7Dhw==', 'gAAAAABpu1XMq1PYiIQ66ZKYu2sGPyNP2liBfnk2n7WSnXkR5seLNzd_4mewVK9qhEVXHRWQEEKvpPK331LyV-wo_UOSHwtpYw==', 'gAAAAABpu1XMCXJTKh0UAtJybYLGTobWLJjbZoOa9zjB4F_17bzYPImtsod3aHlyg1jDSniylFq0eByftEQO62EufdVEifzJPA==', 'gAAAAABpu1XMb5gYOdHUlY6jFIvhuBseVvlFvl5Co5PzD1gUua_6LcMHYomOPVXNPMJGVyzM-DPHtU__vGZiVJr-U2-RsrIPhQ==', 'gAAAAABpu1XMQO8CGHXr90ptwQFqUAlABdiUgbihGEbgdse_jaxCxnPuggqLGJaKHojrdqBvot2LyaV-RiUGF0aLgAOj-SEf6Q=='),
(3, 'gAAAAABpxCrAq_I15K5pi35MjriNdGuwT1BvAI6OYhTDVk6i-VtEvdNY-Y9U0sJzn19WVuvjZWtVfKx-ttjYOrmejC9Q_55kzA==', 0.53, '2026-03-25 18:34:40.693469', 2, 'gAAAAABpxCrA7SLvfVLBqDxbjRFTXUSlm9vC-SB0wLjrTKZSb437PRiofjgLiODDgcC399W5dz-G3RCAeQgRX8jNWImlNu6QkQ==', 'gAAAAABpxCrA6FEGsl_qetbXnlvVQWVDYEbYCKJZQpOdBaXFQ2R3mlwUr68rTlfu13ZiFAiFyX5jnVTVIa_ULt_h5Bn2Ucq_gA==', 'gAAAAABpxCrAuraQef-9pglFRWS-Xaf_3DU3bWInMQaz-_abwy_H1KK-e8PB4-KpTLTFO83HlEbJlEdQWNJfuc7jt8Q-ocPZwg==', 'gAAAAABpxCrA7eLXB6IQqMBU6KTyBc6nKj2_nNBpq5kCivRcmhl5cRvAWwpH2qNXzwNYXgtzVBtPvKMFKDL-owTWM1gcs1WKIA==', 'gAAAAABpxCrAA6HAniAsN94u6VMGGh6T2TJpbQjswZD7msODwzNjMH-l7DPMqCsH8qYZfS8XWBK1G7NkVbJ7gayBR46-WP87fA==', 'gAAAAABpxCrAOiHNai18uzmU_TPQHO31pfWY4H_SAqBYCfGrpxyRnjizjlVYFO7GDNZwfkdpd1EwBSHj2eHKkp7hlcaNJIA4yA==', 'gAAAAABpxCrA0Zu-_yANNPFJyrfhQMuca6IzniwHOVb4Fixf4pv0pzIUIH1foPsK-fjZ56W2X8BYa01pnNSQPefUD-2wf6vT5A==', 'gAAAAABpxCrAMxrwGBopIdhPb6jegH_XWvqFkSe_qKtHbQR3ufuBWMpBrcmuDsr8xqJ7-0g2hGpnV_eNTwbz3A84AcoNqMWSWg==', 'gAAAAABpxCrAiwyYxv-3-KNf8EvpJGm0KtTomOoAcydCeH58JELfwOr_aeyKu_wLegIiVa0QkUIJXleF5ZFkC_DpCE-8bWAqrw==', 'gAAAAABpxCrA_d6hhQ_atLrBDhHXV4NcZRyrWAogtawyBp3uuUj4-djRD_XjFGxhu34GKcdQNedQgjKXejuE2Z8Zw07hvsd3fw==', 'gAAAAABpxCrAWJmDNYnwY7LejOyBkNmEUSnLNA_pe5vxRBy0yXYC4lGlSbZrntiCGfTbClZqgWCiAyfJXF3dw1WmUQKdqjm_Jg==', 'gAAAAABpxCrAy48GRcRPRnIX3h9gKeCPuHjfWBzEWkkEV-_CpBlxYRttf4giSkrbbG4I4LDisY93xjSrYhnsQj8LVGJea4V1aA==', 'gAAAAABpxCrAYi-XkRKZ8cUCJdXPjazdSuZSKTwV16L_DHCG0lSEiwNJWW0Lb516o3NCDWKmYxm2IMDjLh1K3DbsAski_mkOEw==', 'gAAAAABpxCrA-WlA3E408vbEKrX3_R4yVOthFG_stKwKazkYhhQgTiZJFy4xLH8f3FRNckIOgDtI55kizOua6E8tAWMl5u-qnA==', 'gAAAAABpxCrAN7-2RF95HJNKj61pNQMjeoeA7JJl6OYhxkoNAyPApgadwBIdfzjXRYe-D_plrC14JB4FeDT6I5e-BiHmB7KurA==', 'gAAAAABpxCrA3zsXk1mhEUq0oAapOOAEd9KEkihQpvzuI0BSeKR6l8aOT-brYIWJp8xVwzq1vupfgIuTg3oZi7VF4K81yo5zig==', 'gAAAAABpxCrATdAr3Mzp3fIE-Z2jtEbBXwo2I22Zd9G2BOZg7kWeuaTGO_c56jSDTjDeqPat2-qMwIcQYAqmde9T7UjXQjkdFQ==', 'gAAAAABpxCrAphVgRwe4zSbGbKLLv2ro5r60F10Wo64RvvQmj0EcvJBClq6LZ9tNkg164slcC5iLyFZ9dY_OyQOXRckuDTsHJQ==', 'gAAAAABpxCrADBWQRL14jLzM3G_CvF-PyPUt2xeinrg-UQcFhCmBUZzwNzMK1IuQEG-x_MbyqIY1areyL7aR9JRtw0jKyvzrFg==', 'gAAAAABpxCrAWRk0fXcz837kvv3BIucJVPgETIkCIveX-N3fbGE1H4f_qi4IDFkFxM3xLUvF579BjhPf1GJJGSLmZki84TQVUw==', 'gAAAAABpxCrAPur17s6IkC2gVsYFHLYYmYfOhDByLjn7icVfvl7SdcoU9W9ii2n7JjIVSSiLzfNTmekzoJzth5r9plUZfyCjMQ==');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `model_results`
--
ALTER TABLE `model_results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_appointment`
--
ALTER TABLE `tbl_appointment`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `tbl_appointment_doctor_id_6cf9cfb4_fk_tbl_doctor_doctor_id` (`doctor_id`),
  ADD KEY `tbl_appointment_patient_id_38986c1a_fk_tbl_patient_patient_id` (`patient_id`);

--
-- Indexes for table `tbl_complaint`
--
ALTER TABLE `tbl_complaint`
  ADD PRIMARY KEY (`complaint_id`),
  ADD KEY `tbl_complaint_patient_id_db97cb08_fk_tbl_patient_patient_id` (`patient_id`);

--
-- Indexes for table `tbl_district`
--
ALTER TABLE `tbl_district`
  ADD PRIMARY KEY (`district_id`),
  ADD KEY `tbl_district_state_id_d62f4398_fk_tbl_state_state_id` (`state_id`);

--
-- Indexes for table `tbl_doctor`
--
ALTER TABLE `tbl_doctor`
  ADD PRIMARY KEY (`doctor_id`),
  ADD KEY `tbl_doctor_district_id_78e6ccec_fk_tbl_district_district_id` (`district_id`),
  ADD KEY `tbl_doctor_login_id_7a977e8f_fk_tbl_login_login_id` (`login_id`),
  ADD KEY `tbl_doctor_medical_speciality_i_c29bafff_fk_tbl_medic` (`medical_speciality_id`);

--
-- Indexes for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `tbl_feedback_patient_id_b05fd51a_fk_tbl_patient_patient_id` (`patient_id`);

--
-- Indexes for table `tbl_leave`
--
ALTER TABLE `tbl_leave`
  ADD PRIMARY KEY (`leave_id`),
  ADD KEY `tbl_leave_doctor_id_5ae8418e_fk_tbl_doctor_doctor_id` (`doctor_id`);

--
-- Indexes for table `tbl_leave_days`
--
ALTER TABLE `tbl_leave_days`
  ADD PRIMARY KEY (`leave_days_id`),
  ADD KEY `tbl_leave_days_leave_id_b2e4815c_fk_tbl_leave_leave_id` (`leave_id`);

--
-- Indexes for table `tbl_login`
--
ALTER TABLE `tbl_login`
  ADD PRIMARY KEY (`login_id`);

--
-- Indexes for table `tbl_medical_speciality`
--
ALTER TABLE `tbl_medical_speciality`
  ADD PRIMARY KEY (`medical_speciality_id`);

--
-- Indexes for table `tbl_patient`
--
ALTER TABLE `tbl_patient`
  ADD PRIMARY KEY (`patient_id`),
  ADD KEY `tbl_patient_district_id_e041150e_fk_tbl_district_district_id` (`district_id`),
  ADD KEY `tbl_patient_login_id_f930270a_fk_tbl_login_login_id` (`login_id`);

--
-- Indexes for table `tbl_prescription`
--
ALTER TABLE `tbl_prescription`
  ADD PRIMARY KEY (`prescription_id`),
  ADD KEY `tbl_prescription_appointment_id_f7b8015b_fk_tbl_appoi` (`appointment_id`);

--
-- Indexes for table `tbl_state`
--
ALTER TABLE `tbl_state`
  ADD PRIMARY KEY (`state_id`);

--
-- Indexes for table `tbl_stress_detection`
--
ALTER TABLE `tbl_stress_detection`
  ADD PRIMARY KEY (`prediction_id`),
  ADD KEY `tbl_stress_detection_appointment_id_34402f3f_fk_tbl_appoi` (`appointment_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `model_results`
--
ALTER TABLE `model_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_appointment`
--
ALTER TABLE `tbl_appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_complaint`
--
ALTER TABLE `tbl_complaint`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_district`
--
ALTER TABLE `tbl_district`
  MODIFY `district_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_doctor`
--
ALTER TABLE `tbl_doctor`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_leave`
--
ALTER TABLE `tbl_leave`
  MODIFY `leave_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_leave_days`
--
ALTER TABLE `tbl_leave_days`
  MODIFY `leave_days_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_login`
--
ALTER TABLE `tbl_login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_medical_speciality`
--
ALTER TABLE `tbl_medical_speciality`
  MODIFY `medical_speciality_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_patient`
--
ALTER TABLE `tbl_patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_prescription`
--
ALTER TABLE `tbl_prescription`
  MODIFY `prescription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_state`
--
ALTER TABLE `tbl_state`
  MODIFY `state_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_stress_detection`
--
ALTER TABLE `tbl_stress_detection`
  MODIFY `prediction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `tbl_appointment`
--
ALTER TABLE `tbl_appointment`
  ADD CONSTRAINT `tbl_appointment_doctor_id_6cf9cfb4_fk_tbl_doctor_doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `tbl_doctor` (`doctor_id`),
  ADD CONSTRAINT `tbl_appointment_patient_id_38986c1a_fk_tbl_patient_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `tbl_patient` (`patient_id`);

--
-- Constraints for table `tbl_complaint`
--
ALTER TABLE `tbl_complaint`
  ADD CONSTRAINT `tbl_complaint_patient_id_db97cb08_fk_tbl_patient_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `tbl_patient` (`patient_id`);

--
-- Constraints for table `tbl_district`
--
ALTER TABLE `tbl_district`
  ADD CONSTRAINT `tbl_district_state_id_d62f4398_fk_tbl_state_state_id` FOREIGN KEY (`state_id`) REFERENCES `tbl_state` (`state_id`);

--
-- Constraints for table `tbl_doctor`
--
ALTER TABLE `tbl_doctor`
  ADD CONSTRAINT `tbl_doctor_district_id_78e6ccec_fk_tbl_district_district_id` FOREIGN KEY (`district_id`) REFERENCES `tbl_district` (`district_id`),
  ADD CONSTRAINT `tbl_doctor_login_id_7a977e8f_fk_tbl_login_login_id` FOREIGN KEY (`login_id`) REFERENCES `tbl_login` (`login_id`),
  ADD CONSTRAINT `tbl_doctor_medical_speciality_i_c29bafff_fk_tbl_medic` FOREIGN KEY (`medical_speciality_id`) REFERENCES `tbl_medical_speciality` (`medical_speciality_id`);

--
-- Constraints for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  ADD CONSTRAINT `tbl_feedback_patient_id_b05fd51a_fk_tbl_patient_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `tbl_patient` (`patient_id`);

--
-- Constraints for table `tbl_leave`
--
ALTER TABLE `tbl_leave`
  ADD CONSTRAINT `tbl_leave_doctor_id_5ae8418e_fk_tbl_doctor_doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `tbl_doctor` (`doctor_id`);

--
-- Constraints for table `tbl_leave_days`
--
ALTER TABLE `tbl_leave_days`
  ADD CONSTRAINT `tbl_leave_days_leave_id_b2e4815c_fk_tbl_leave_leave_id` FOREIGN KEY (`leave_id`) REFERENCES `tbl_leave` (`leave_id`);

--
-- Constraints for table `tbl_patient`
--
ALTER TABLE `tbl_patient`
  ADD CONSTRAINT `tbl_patient_district_id_e041150e_fk_tbl_district_district_id` FOREIGN KEY (`district_id`) REFERENCES `tbl_district` (`district_id`),
  ADD CONSTRAINT `tbl_patient_login_id_f930270a_fk_tbl_login_login_id` FOREIGN KEY (`login_id`) REFERENCES `tbl_login` (`login_id`);

--
-- Constraints for table `tbl_prescription`
--
ALTER TABLE `tbl_prescription`
  ADD CONSTRAINT `tbl_prescription_appointment_id_f7b8015b_fk_tbl_appoi` FOREIGN KEY (`appointment_id`) REFERENCES `tbl_appointment` (`appointment_id`);

--
-- Constraints for table `tbl_stress_detection`
--
ALTER TABLE `tbl_stress_detection`
  ADD CONSTRAINT `tbl_stress_detection_appointment_id_34402f3f_fk_tbl_appoi` FOREIGN KEY (`appointment_id`) REFERENCES `tbl_appointment` (`appointment_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
