-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2020 at 12:35 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `teamwork`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add teacher', 7, 'add_teacher'),
(26, 'Can change teacher', 7, 'change_teacher'),
(27, 'Can delete teacher', 7, 'delete_teacher'),
(28, 'Can view teacher', 7, 'view_teacher'),
(29, 'Can add student', 8, 'add_student'),
(30, 'Can change student', 8, 'change_student'),
(31, 'Can delete student', 8, 'delete_student'),
(32, 'Can view student', 8, 'view_student'),
(33, 'Can add course', 9, 'add_course'),
(34, 'Can change course', 9, 'change_course'),
(35, 'Can delete course', 9, 'delete_course'),
(36, 'Can view course', 9, 'view_course'),
(37, 'Can add submission contribution', 10, 'add_submissioncontribution'),
(38, 'Can change submission contribution', 10, 'change_submissioncontribution'),
(39, 'Can delete submission contribution', 10, 'delete_submissioncontribution'),
(40, 'Can view submission contribution', 10, 'view_submissioncontribution'),
(41, 'Can add submission item', 11, 'add_submissionitem'),
(42, 'Can change submission item', 11, 'change_submissionitem'),
(43, 'Can delete submission item', 11, 'delete_submissionitem'),
(44, 'Can view submission item', 11, 'view_submissionitem'),
(45, 'Can add leader', 12, 'add_leader'),
(46, 'Can change leader', 12, 'change_leader'),
(47, 'Can delete leader', 12, 'delete_leader'),
(48, 'Can view leader', 12, 'view_leader'),
(49, 'Can add team', 13, 'add_team'),
(50, 'Can change team', 13, 'change_team'),
(51, 'Can delete team', 13, 'delete_team'),
(52, 'Can view team', 13, 'view_team'),
(53, 'Can add vote', 14, 'add_vote'),
(54, 'Can change vote', 14, 'change_vote'),
(55, 'Can delete vote', 14, 'delete_vote'),
(56, 'Can view vote', 14, 'view_vote'),
(57, 'Can add invitation', 15, 'add_invitation'),
(58, 'Can change invitation', 15, 'change_invitation'),
(59, 'Can delete invitation', 15, 'delete_invitation'),
(60, 'Can view invitation', 15, 'view_invitation'),
(61, 'Can add leader assessment', 16, 'add_leaderassessment'),
(62, 'Can change leader assessment', 16, 'change_leaderassessment'),
(63, 'Can delete leader assessment', 16, 'delete_leaderassessment'),
(64, 'Can view leader assessment', 16, 'view_leaderassessment'),
(65, 'Can add export file', 17, 'add_exportfile'),
(66, 'Can change export file', 17, 'change_exportfile'),
(67, 'Can delete export file', 17, 'delete_exportfile'),
(68, 'Can view export file', 17, 'view_exportfile');

-- --------------------------------------------------------

--
-- Table structure for table `course_course`
--

CREATE TABLE `course_course` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `begin_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `pic` varchar(64) NOT NULL,
  `visit` int(11) NOT NULL,
  `description` varchar(256) NOT NULL,
  `participation` int(11) NOT NULL,
  `form_method` int(11) NOT NULL,
  `team_number_1` int(11) NOT NULL,
  `team_number_2` int(11) NOT NULL,
  `team_size_1` int(11) NOT NULL,
  `team_size_2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `course_course`
--

INSERT INTO `course_course` (`id`, `name`, `begin_time`, `end_time`, `pic`, `visit`, `description`, `participation`, `form_method`, `team_number_1`, `team_number_2`, `team_size_1`, `team_size_2`) VALUES
(1, 'zqmdsbbbbbbbbbbb', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 15, 1, 2, 1, 5, 4),
(2, 'zqmcccccccccc', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 19, 2, 0, 0, 0, 0),
(3, 'zqmdddddddddd', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 1, 0, 0, 0, 0, 0),
(4, 'zqmeeeeeeee', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 1, 0, 0, 0, 0, 0),
(5, 'zqmfffffffff', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 1, 0, 0, 0, 0, 0),
(6, 'zqmdsggggggggg', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 1, 0, 0, 0, 0, 0),
(7, 'zqmdjflsajfs', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 14, 3, 6, 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `course_course_member`
--

CREATE TABLE `course_course_member` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `course_course_member`
--

INSERT INTO `course_course_member` (`id`, `course_id`, `user_id`) VALUES
(7, 1, 1),
(1, 1, 2),
(15, 1, 8),
(28, 1, 9),
(29, 1, 10),
(30, 1, 11),
(31, 1, 12),
(32, 1, 13),
(33, 1, 14),
(34, 1, 15),
(35, 1, 16),
(36, 1, 17),
(37, 1, 18),
(38, 1, 19),
(39, 1, 20),
(14, 2, 1),
(2, 2, 2),
(9, 2, 3),
(10, 2, 4),
(11, 2, 5),
(12, 2, 6),
(13, 2, 7),
(16, 2, 9),
(17, 2, 10),
(18, 2, 11),
(19, 2, 12),
(20, 2, 13),
(21, 2, 14),
(22, 2, 15),
(23, 2, 16),
(24, 2, 17),
(25, 2, 18),
(26, 2, 19),
(27, 2, 20),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(40, 7, 1),
(41, 7, 9),
(42, 7, 10),
(43, 7, 11),
(44, 7, 12),
(45, 7, 13),
(46, 7, 14),
(47, 7, 15),
(48, 7, 16),
(49, 7, 17),
(50, 7, 18),
(51, 7, 19),
(52, 7, 20),
(53, 7, 21);

-- --------------------------------------------------------

--
-- Table structure for table `course_exportfile`
--

CREATE TABLE `course_exportfile` (
  `id` int(11) NOT NULL,
  `contribution` double NOT NULL,
  `bonus` double NOT NULL,
  `course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `course_exportfile`
--

INSERT INTO `course_exportfile` (`id`, `contribution`, `bonus`, `course_id`, `student_id`) VALUES
(4, -1, -1, 2, 2),
(5, -1, -1, 2, 3),
(6, -1, -1, 2, 4),
(7, -1, -1, 2, 5),
(8, -1, -1, 2, 6),
(9, -1, -1, 2, 7),
(10, -1, -1, 2, 2),
(11, -1, -1, 2, 3),
(12, -1, -1, 2, 4),
(13, -1, -1, 2, 5),
(14, -1, -1, 2, 6),
(15, -1, -1, 2, 7),
(16, -1, -1, 2, 2),
(17, -1, -1, 2, 3),
(18, -1, -1, 2, 4),
(19, -1, -1, 2, 5),
(20, -1, -1, 2, 6),
(21, -1, -1, 2, 7),
(22, -1, -1, 2, 2),
(23, -1, -1, 2, 3),
(24, -1, -1, 2, 4),
(25, -1, -1, 2, 5),
(26, -1, -1, 2, 6),
(27, -1, -1, 2, 7),
(28, -1, -1, 2, 2),
(29, -1, -1, 2, 3),
(30, -1, -1, 2, 4),
(31, -1, -1, 2, 5),
(32, -1, -1, 2, 6),
(33, -1, -1, 2, 7),
(34, -1, -1, 2, 2),
(35, -1, -1, 2, 3),
(36, -1, -1, 2, 4),
(37, -1, -1, 2, 5),
(38, -1, -1, 2, 6),
(39, -1, -1, 2, 7),
(40, -1, -1, 2, 2),
(41, -1, -1, 2, 3),
(42, -1, -1, 2, 4),
(43, -1, -1, 2, 5),
(44, -1, -1, 2, 6),
(45, -1, -1, 2, 7),
(46, -1, -1, 2, 2),
(47, -1, -1, 2, 3),
(48, -1, -1, 2, 4),
(49, -1, -1, 2, 5),
(50, -1, -1, 2, 6),
(51, -1, -1, 2, 7),
(52, -1, -1, 2, 2),
(53, -1, -1, 2, 3),
(54, -1, -1, 2, 4),
(55, -1, -1, 2, 5),
(56, -1, -1, 2, 6),
(57, -1, -1, 2, 7),
(58, -1, -1, 2, 2),
(59, -1, -1, 2, 3),
(60, -1, -1, 2, 4),
(61, -1, -1, 2, 5),
(62, -1, -1, 2, 6),
(63, -1, -1, 2, 7);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(9, 'course', 'course'),
(17, 'course', 'exportfile'),
(5, 'sessions', 'session'),
(16, 'submission', 'leaderassessment'),
(10, 'submission', 'submissioncontribution'),
(11, 'submission', 'submissionitem'),
(15, 'team', 'invitation'),
(12, 'team', 'leader'),
(13, 'team', 'team'),
(14, 'team', 'vote'),
(8, 'user', 'student'),
(7, 'user', 'teacher'),
(6, 'user', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2020-04-30 04:14:02.167317'),
(2, 'contenttypes', '0002_remove_content_type_name', '2020-04-30 04:14:02.390103'),
(3, 'auth', '0001_initial', '2020-04-30 04:14:02.529974'),
(4, 'auth', '0002_alter_permission_name_max_length', '2020-04-30 04:14:03.178428'),
(5, 'auth', '0003_alter_user_email_max_length', '2020-04-30 04:14:03.189837'),
(6, 'auth', '0004_alter_user_username_opts', '2020-04-30 04:14:03.202237'),
(7, 'auth', '0005_alter_user_last_login_null', '2020-04-30 04:14:03.212156'),
(8, 'auth', '0006_require_contenttypes_0002', '2020-04-30 04:14:03.220093'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2020-04-30 04:14:03.231500'),
(10, 'auth', '0008_alter_user_username_max_length', '2020-04-30 04:14:03.242909'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2020-04-30 04:14:03.253820'),
(12, 'auth', '0010_alter_group_name_max_length', '2020-04-30 04:14:03.500411'),
(13, 'auth', '0011_update_proxy_permissions', '2020-04-30 04:14:03.520226'),
(14, 'user', '0001_initial', '2020-04-30 04:14:03.922201'),
(15, 'admin', '0001_initial', '2020-04-30 04:14:04.906906'),
(16, 'admin', '0002_logentry_remove_auto_add', '2020-04-30 04:14:05.180307'),
(17, 'admin', '0003_logentry_add_action_flag_choices', '2020-04-30 04:14:05.198194'),
(18, 'course', '0001_initial', '2020-04-30 04:14:05.260437'),
(19, 'course', '0002_course_member', '2020-04-30 04:14:05.332828'),
(20, 'sessions', '0001_initial', '2020-04-30 04:14:05.879576'),
(21, 'submission', '0001_initial', '2020-04-30 04:14:06.016995'),
(22, 'submission', '0002_auto_20200430_1213', '2020-04-30 04:14:06.521107'),
(23, 'team', '0001_initial', '2020-04-30 04:14:06.965241'),
(24, 'team', '0002_auto_20200430_1213', '2020-04-30 04:14:07.135061'),
(25, 'course', '0003_course_participation', '2020-04-30 07:21:58.697948'),
(26, 'team', '0003_auto_20200505_1341', '2020-05-05 05:42:16.318450'),
(27, 'team', '0004_auto_20200505_1342', '2020-05-05 05:42:17.263262'),
(28, 'user', '0002_auto_20200505_1358', '2020-05-05 05:58:45.157631'),
(29, 'team', '0005_auto_20200505_1359', '2020-05-05 05:59:26.304717'),
(30, 'team', '0006_remove_team_leader', '2020-05-05 06:13:13.705878'),
(31, 'team', '0007_auto_20200505_1824', '2020-05-05 10:24:59.865983'),
(32, 'team', '0008_auto_20200505_1833', '2020-05-05 10:33:13.414668'),
(33, 'course', '0004_course_team_num', '2020-05-10 13:54:04.033146'),
(34, 'team', '0009_invitation', '2020-05-10 20:22:52.072264'),
(35, 'course', '0005_remove_course_form_method', '2020-05-12 02:24:19.822414'),
(36, 'course', '0006_course_form_method', '2020-05-12 02:25:01.578727'),
(37, 'submission', '0003_leaderassessment', '2020-05-12 04:13:43.155531'),
(38, 'submission', '0004_submissionitem_isfinishassess', '2020-05-12 05:22:00.439385'),
(39, 'submission', '0005_submissioncontribution_team', '2020-05-12 06:33:41.790369'),
(40, 'course', '0007_exportfile', '2020-05-12 14:14:26.662835'),
(41, 'submission', '0006_leaderassessment_team', '2020-05-12 14:14:27.256418'),
(42, 'course', '0008_auto_20200512_2252', '2020-05-12 14:53:36.412919'),
(43, 'course', '0009_auto_20200512_2300', '2020-05-12 15:01:06.525641'),
(44, 'team', '0010_team_size', '2020-05-12 15:01:06.761221');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('ejpvg03snbzbpjwnibcb3mi9yx13xnkw', 'OGZhZmZjMTllNmUyYTZmYTYxMjViOTE2NWI3YmNmMTQxYjY3ZThkZDqABJWXAAAAAAAAAH2UKIwNX2F1dGhfdXNlcl9pZJSMATGUjBJfYXV0aF91c2VyX2JhY2tlbmSUjClkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZJSMD19hdXRoX3VzZXJfaGFzaJSMKDY5NjAwMmQ5Zjc2NjExZDlmMzQ5NDVjNzRhZTk1ZjdjYmUyZjljMTWUdS4=', '2020-05-29 10:34:51.972046'),
('x8k1w1rda733lgec3vigltq8mxw710qn', 'OGZhZmZjMTllNmUyYTZmYTYxMjViOTE2NWI3YmNmMTQxYjY3ZThkZDqABJWXAAAAAAAAAH2UKIwNX2F1dGhfdXNlcl9pZJSMATGUjBJfYXV0aF91c2VyX2JhY2tlbmSUjClkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZJSMD19hdXRoX3VzZXJfaGFzaJSMKDY5NjAwMmQ5Zjc2NjExZDlmMzQ5NDVjNzRhZTk1ZjdjYmUyZjljMTWUdS4=', '2020-05-26 14:09:59.452264'),
('xr78oojrxdxtjgxfn5w9162uuk3wp9aj', 'ODI0ZTliZWVmNzI3YTlkZTRkZWIwNGM3ZmE0NTM2M2I5ODA2MzQ1NDqABJWXAAAAAAAAAH2UKIwNX2F1dGhfdXNlcl9pZJSMATOUjBJfYXV0aF91c2VyX2JhY2tlbmSUjClkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZJSMD19hdXRoX3VzZXJfaGFzaJSMKDZiY2ZjZjRiNDA5NzA0NzNhY2E3NWIwMTEwN2Y1N2NlZDMyZTk4ZjSUdS4=', '2020-05-26 04:37:51.762601');

-- --------------------------------------------------------

--
-- Table structure for table `submission_leaderassessment`
--

CREATE TABLE `submission_leaderassessment` (
  `id` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `leader` int(11) NOT NULL,
  `mark` double NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `submission_leaderassessment`
--

INSERT INTO `submission_leaderassessment` (`id`, `member`, `leader`, `mark`, `team_id`) VALUES
(1, 2, 3, -2, 2),
(2, 4, 2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `submission_submissioncontribution`
--

CREATE TABLE `submission_submissioncontribution` (
  `id` int(11) NOT NULL,
  `value` double NOT NULL,
  `member_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `submission_submissioncontribution`
--

INSERT INTO `submission_submissioncontribution` (`id`, `value`, `member_id`, `submission_id`, `team_id`) VALUES
(4, 1, 2, 8, 21),
(5, 0.67, 4, 8, 21),
(6, 0.33, 5, 8, 21),
(7, 1, 1, 3, 4),
(8, 1, 2, 3, 4),
(9, 1, 1, 3, 4),
(10, 1, 2, 3, 4),
(11, 1, 1, 3, 4),
(12, 1, 2, 3, 4),
(13, 1, 1, 3, 4),
(14, 1, 2, 3, 4),
(15, 1, 1, 3, 4),
(16, 1, 2, 3, 4),
(17, 1, 1, 3, 4),
(18, 1, 2, 3, 4),
(19, 1, 1, 3, 4),
(20, 1, 2, 3, 4),
(21, 1, 1, 3, 4),
(22, 1, 2, 3, 4),
(23, 1, 1, 5, 4),
(24, 1, 2, 5, 4),
(25, 1, 1, 6, 4),
(26, 1, 2, 6, 4),
(27, 1, 1, 7, 4),
(28, 1, 2, 7, 4);

-- --------------------------------------------------------

--
-- Table structure for table `submission_submissionitem`
--

CREATE TABLE `submission_submissionitem` (
  `id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `percentage` double NOT NULL,
  `course_id` int(11) NOT NULL,
  `isFinishAssess` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `submission_submissionitem`
--

INSERT INTO `submission_submissionitem` (`id`, `title`, `percentage`, `course_id`, `isFinishAssess`) VALUES
(3, 'eeeee', 40, 1, 1),
(5, 'qwqqwqwq', 10, 1, 1),
(6, 'qwq', 30, 1, 1),
(7, 'qeqeqe', 20, 1, 1),
(8, 'eeeee', 40, 2, 0),
(9, 'qwqqwqwq', 10, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `team_invitation`
--

CREATE TABLE `team_invitation` (
  `id` int(11) NOT NULL,
  `from_user` int(11) NOT NULL,
  `to_user` int(11) NOT NULL,
  `description` varchar(128) NOT NULL,
  `isAccept` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `team_invitation`
--

INSERT INTO `team_invitation` (`id`, `from_user`, `to_user`, `description`, `isAccept`, `course_id`) VALUES
(1, 4, 2, '123', 1, 2),
(2, 1, 2, 'It is pathway III', 2, 2),
(6, 20, 19, 'Idiot help!!', 0, 1),
(7, 20, 17, 'xixixii', 2, 1),
(8, 16, 17, 'lala', 1, 1),
(10, 20, 8, 'jjLin! help!!!', 1, 1),
(11, 20, 10, 'Jeremy! Help!!', 1, 1),
(12, 20, 12, 'Avery! Help!!', 1, 1),
(13, 20, 13, 'Tony! Help!!', 2, 1),
(14, 20, 9, 'Eve! Help!!', 2, 1),
(15, 17, 9, 'Eve! Help!!', 0, 1),
(16, 17, 11, '', 1, 1),
(17, 17, 13, 'Tony! Help!!', 2, 1),
(18, 17, 14, 'Rose! Help!!!', 1, 1),
(19, 17, 15, 'Coco! Help!!', 2, 1),
(20, 9, 2, 'help! zqm!!', 1, 1),
(21, 9, 13, 'HelpTony!', 1, 1),
(22, 9, 15, 'Help! coco!', 1, 1),
(23, 9, 18, 'Help! Ricky!', 1, 1),
(24, 17, 18, 'Help! Ricky!!', 2, 1),
(25, 20, 19, 'Idiot help!!', 1, 7),
(26, 20, 16, 'Jason! Help!!', 2, 7),
(27, 16, 9, 'help', 1, 7),
(28, 10, 17, 'help', 1, 7),
(29, 11, 12, 'help', 1, 7),
(30, 15, 14, 'help', 1, 7),
(31, 18, 13, 'help', 2, 7),
(32, 20, 19, '', 1, 7),
(33, 18, 17, '', 1, 7),
(34, 16, 15, '', 1, 7),
(35, 14, 13, '', 1, 7),
(36, 12, 11, '', 1, 7),
(37, 10, 9, '', 1, 7),
(38, 20, 19, '', 1, 7),
(39, 18, 17, '', 1, 7),
(40, 15, 16, '', 1, 7),
(41, 14, 13, '', 1, 7),
(42, 12, 11, '', 1, 7),
(43, 9, 10, '', 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `team_leader`
--

CREATE TABLE `team_leader` (
  `id` int(11) NOT NULL,
  `bonus` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `team_team`
--

CREATE TABLE `team_team` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `course_id` int(11) NOT NULL,
  `leader` int(11) NOT NULL,
  `size` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `team_team`
--

INSERT INTO `team_team` (`id`, `name`, `course_id`, `leader`, `size`) VALUES
(21, 'group0', 2, 2, 0),
(22, 'group1', 2, 0, 0),
(25, 'group 0', 1, 0, 5),
(27, 'group 1', 1, 0, 4),
(28, 'group 2', 1, 0, 5),
(52, 'small_group 0', 7, 0, 2),
(53, 'small_group 1', 7, 0, 2),
(54, 'small_group 2', 7, 0, 2),
(55, 'small_group 3', 7, 0, 2),
(56, 'small_group 4', 7, 0, 2),
(57, 'small_group 5', 7, 0, 2),
(58, 'small_group 6', 7, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `team_team_member`
--

CREATE TABLE `team_team_member` (
  `id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `team_team_member`
--

INSERT INTO `team_team_member` (`id`, `team_id`, `user_id`) VALUES
(44, 21, 2),
(45, 21, 4),
(43, 21, 5),
(48, 22, 3),
(47, 22, 6),
(46, 22, 7),
(59, 25, 8),
(60, 25, 10),
(61, 25, 12),
(54, 25, 19),
(53, 25, 20),
(63, 27, 11),
(64, 27, 14),
(57, 27, 16),
(58, 27, 17),
(66, 28, 2),
(65, 28, 9),
(68, 28, 13),
(67, 28, 15),
(69, 28, 18),
(119, 52, 19),
(118, 52, 20),
(121, 53, 17),
(120, 53, 18),
(122, 54, 15),
(123, 54, 16),
(125, 55, 13),
(124, 55, 14),
(127, 56, 11),
(126, 56, 12),
(128, 57, 9),
(129, 57, 10),
(130, 58, 21);

-- --------------------------------------------------------

--
-- Table structure for table `team_vote`
--

CREATE TABLE `team_vote` (
  `id` int(11) NOT NULL,
  `vote_id` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `team` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `team_vote`
--

INSERT INTO `team_vote` (`id`, `vote_id`, `member`, `team`) VALUES
(5, 0, 2, 4),
(6, 0, 2, 4),
(7, 2, 2, 4),
(8, 2, 2, 4),
(9, 2, 2, 4),
(10, 2, 2, 4),
(11, 2, 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `user_student`
--

CREATE TABLE `user_student` (
  `id` int(11) NOT NULL,
  `studentID` varchar(20) NOT NULL,
  `GPA` double NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_student`
--

INSERT INTO `user_student` (`id`, `studentID`, `GPA`, `user_id`) VALUES
(1, '1730026102', 1, 8),
(2, 'n135', 3.08, 9),
(3, 'n789', 3.57, 10),
(4, 'm456', 3.36, 11),
(5, 'm123', 3.6, 12),
(6, 'l123135', 3.19, 13),
(7, 'l712389', 3.31, 14),
(8, 'l45426', 2.64, 15),
(9, 'l12323', 2.89, 16),
(10, '135', 3.55, 17),
(11, '789', 3.23, 18),
(12, '456', 3.97, 19),
(13, '129', 4, 20),
(14, '233333333', 3.23, 21);

-- --------------------------------------------------------

--
-- Table structure for table `user_teacher`
--

CREATE TABLE `user_teacher` (
  `id` int(11) NOT NULL,
  `staffID` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_user`
--

CREATE TABLE `user_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `field` varchar(20) NOT NULL,
  `truename` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_user`
--

INSERT INTO `user_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `field`, `truename`) VALUES
(1, 'pbkdf2_sha256$150000$hAU829ZVucLH$stMX/smg8yE+FdjDWJJmv5UKwpBxN29lyNBA3O/egsg=', '2020-05-15 10:34:51.966054', 1, 'tzm', '', '', '', 1, 1, '2020-04-30 04:15:58.009282', 'teacher', 'zqm'),
(2, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-14 14:09:59.718794', 0, '123', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(3, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-12 13:14:28.635074', 0, '124', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(4, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-12 13:14:43.193717', 0, '125', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(5, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-09 14:44:15.723173', 0, '126', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(6, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-09 14:44:15.723173', 0, '127', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(7, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-09 14:44:15.723173', 0, '128', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(8, 'pbkdf2_sha256$150000$xsD0iDCPLufY$gnagYwbO/rY934XmxRznpywd/uIHmK1fbxZoiu1QkTY=', '2020-05-14 13:58:14.745250', 0, '1234', '', '', '1220219614@qq.com', 0, 1, '2020-05-10 17:32:40.002014', 'student', 'jjLin'),
(9, 'pbkdf2_sha256$150000$HuOSDEKhaL44$FarJpGqfFwvPJeJtyMKNS06FoPgpsv7mmGjESck88do=', '2020-05-15 10:34:32.890740', 0, 'n135', '', '', 'n135@qq.com', 0, 1, '2020-05-14 09:16:00.866125', 'student', 'Eve'),
(10, 'pbkdf2_sha256$150000$yNbBwzgclyQY$h+xzYZ24JtlK1l1eDjvRLxX1rdmhJLrg7IxN2zUOP08=', '2020-05-15 10:34:42.369089', 0, 'n789', '', '', 'n789@qq.com', 0, 1, '2020-05-14 09:16:00.978612', 'student', 'Jeremy'),
(11, 'pbkdf2_sha256$150000$J9V4rdKo4O3Q$0cfENQ4UDD4u0YJ44r8UBDvErIgvmclXHeeywS3fC+M=', '2020-05-15 10:34:19.499945', 0, 'm456', '', '', 'm456@qq.com', 0, 1, '2020-05-14 09:16:01.085676', 'student', 'Jessica'),
(12, 'pbkdf2_sha256$150000$On5lUPWh87XZ$igr3GeGOjsNJQ5CcpU972ct7T6Hjz1Yaq1LRSjlk2p4=', '2020-05-15 10:34:06.545329', 0, 'm123', '', '', 'm123@qq.com', 0, 1, '2020-05-14 09:16:01.184974', 'student', 'Avery'),
(13, 'pbkdf2_sha256$150000$iFH6ieJB9H5i$Pexvah0gfMozhTaxVU/FVRt3pWf4nzmI6SCXTGE3IQg=', '2020-05-15 10:33:57.901070', 0, 'l123135', '', '', 'l123135@qq.com', 0, 1, '2020-05-14 09:16:01.288123', 'student', 'Tony'),
(14, 'pbkdf2_sha256$150000$UDcqJBTwywy4$jcAVKZrdpJ1TeePSYgJiO+tcJ8rEDeM9gtMs4IZXVJA=', '2020-05-15 10:33:46.557709', 0, 'l712389', '', '', 'l712389@qq.com', 0, 1, '2020-05-14 09:16:01.386772', 'student', 'Rose'),
(15, 'pbkdf2_sha256$150000$Pn9nNk4KWtG2$fEeqLHt86NxldRJaLN9RvCMCOQTmIZD16ZKWQ/Za/WI=', '2020-05-15 10:33:18.227735', 0, 'l45426', '', '', 'l45426@qq.com', 0, 1, '2020-05-14 09:16:01.501095', 'student', 'Coco'),
(16, 'pbkdf2_sha256$150000$jSHOXPY82l0o$uDAlOIYccOtoPvnA2SzviMHXu+Dx/NzO7/i2gM9ifWA=', '2020-05-15 10:33:30.797999', 0, 'l12323', '', '', 'l12323@qq.com', 0, 1, '2020-05-14 09:16:01.608588', 'student', 'Jason'),
(17, 'pbkdf2_sha256$150000$Ks291EQ0ObQY$b6344H3RV7LfxSNlvytWRI2xlYnsVt8AyYv7dM61hd0=', '2020-05-15 10:33:01.850188', 0, '135', '', '', '135@qq.com', 0, 1, '2020-05-14 09:16:01.716038', 'student', 'Scott'),
(18, 'pbkdf2_sha256$150000$zToRE17s9Ubs$nrSi1OaSKL3Ks8XpJtfOZVoUFeimc0d1TRNXJsOGmVQ=', '2020-05-15 10:32:53.495053', 0, '789', '', '', '789@qq.com', 0, 1, '2020-05-14 09:16:01.810690', 'student', 'Ricky'),
(19, 'pbkdf2_sha256$150000$RL8zF7KTrrgI$g4v4P3YQ6BRTDrLMf22qtmjZoBLGZu4aEQt9SQLFDmE=', '2020-05-15 10:32:31.147648', 0, '456', '', '', '456@qq.com', 0, 1, '2020-05-14 09:16:01.907715', 'student', 'Elliot'),
(20, 'pbkdf2_sha256$150000$I8Vbw5X8FnlD$ETgI1ztmOw9RSQy26LCIdeHdUwMC3DsHbW2oxhZhOCU=', '2020-05-15 10:32:16.657233', 0, '129', '', '', '129@qq.com', 0, 1, '2020-05-14 09:16:02.005668', 'student', 'Charm'),
(21, 'pbkdf2_sha256$150000$iKutDuhEvZoK$odWCD7s8FJbCLaHsUh0r3AAXdHlj/MU5FkbNG5Sdd1U=', NULL, 0, '2333333', '', '', '2333333@qq.com', 0, 1, '2020-05-15 03:32:06.979388', 'student', 'ruarua');

-- --------------------------------------------------------

--
-- Table structure for table `user_user_groups`
--

CREATE TABLE `user_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_user_user_permissions`
--

CREATE TABLE `user_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Indexes for table `course_course`
--
ALTER TABLE `course_course`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_course_member`
--
ALTER TABLE `course_course_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_course_member_course_id_user_id_202017ca_uniq` (`course_id`,`user_id`),
  ADD KEY `course_course_member_user_id_57087271_fk_user_user_id` (`user_id`);

--
-- Indexes for table `course_exportfile`
--
ALTER TABLE `course_exportfile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_exportfile_course_id_08b47a00_fk_course_course_id` (`course_id`),
  ADD KEY `course_exportfile_student_id_cefd3fab` (`student_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_user_user_id` (`user_id`);

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
-- Indexes for table `submission_leaderassessment`
--
ALTER TABLE `submission_leaderassessment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_submissio_member_id_1ac854b2_fk_user_user` (`member_id`),
  ADD KEY `submission_submissio_submission_id_83d5a00b_fk_submissio` (`submission_id`);

--
-- Indexes for table `submission_submissionitem`
--
ALTER TABLE `submission_submissionitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_submissionitem_course_id_f804ab42_fk_course_course_id` (`course_id`);

--
-- Indexes for table `team_invitation`
--
ALTER TABLE `team_invitation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `team_invitation_course_id_800bb231_fk_course_course_id` (`course_id`);

--
-- Indexes for table `team_leader`
--
ALTER TABLE `team_leader`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `team_team`
--
ALTER TABLE `team_team`
  ADD PRIMARY KEY (`id`),
  ADD KEY `team_team_course_id_78a5e67c_fk_course_course_id` (`course_id`);

--
-- Indexes for table `team_team_member`
--
ALTER TABLE `team_team_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_team_member_team_id_user_id_40bac298_uniq` (`team_id`,`user_id`),
  ADD KEY `team_team_member_user_id_ee13d3c4_fk_user_user_id` (`user_id`);

--
-- Indexes for table `team_vote`
--
ALTER TABLE `team_vote`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_student`
--
ALTER TABLE `user_student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_teacher`
--
ALTER TABLE `user_teacher`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_user`
--
ALTER TABLE `user_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_user_groups`
--
ALTER TABLE `user_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_user_groups_user_id_group_id_bb60391f_uniq` (`user_id`,`group_id`),
  ADD KEY `user_user_groups_group_id_c57f13c0_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `user_user_user_permissions`
--
ALTER TABLE `user_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_user_user_permissions_user_id_permission_id_64f4d5b8_uniq` (`user_id`,`permission_id`),
  ADD KEY `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` (`permission_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `course_course`
--
ALTER TABLE `course_course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `course_course_member`
--
ALTER TABLE `course_course_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `course_exportfile`
--
ALTER TABLE `course_exportfile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `submission_leaderassessment`
--
ALTER TABLE `submission_leaderassessment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `submission_submissionitem`
--
ALTER TABLE `submission_submissionitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `team_invitation`
--
ALTER TABLE `team_invitation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `team_leader`
--
ALTER TABLE `team_leader`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_team`
--
ALTER TABLE `team_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `team_team_member`
--
ALTER TABLE `team_team_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `team_vote`
--
ALTER TABLE `team_vote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_student`
--
ALTER TABLE `user_student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `user_teacher`
--
ALTER TABLE `user_teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_user`
--
ALTER TABLE `user_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_user_groups`
--
ALTER TABLE `user_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_user_user_permissions`
--
ALTER TABLE `user_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `course_course_member`
--
ALTER TABLE `course_course_member`
  ADD CONSTRAINT `course_course_member_course_id_66dc926d_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`),
  ADD CONSTRAINT `course_course_member_user_id_57087271_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- Constraints for table `course_exportfile`
--
ALTER TABLE `course_exportfile`
  ADD CONSTRAINT `course_exportfile_course_id_08b47a00_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`),
  ADD CONSTRAINT `course_exportfile_student_id_cefd3fab_fk_user_user_id` FOREIGN KEY (`student_id`) REFERENCES `user_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- Constraints for table `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  ADD CONSTRAINT `submission_submissio_member_id_1ac854b2_fk_user_user` FOREIGN KEY (`member_id`) REFERENCES `user_user` (`id`),
  ADD CONSTRAINT `submission_submissio_submission_id_83d5a00b_fk_submissio` FOREIGN KEY (`submission_id`) REFERENCES `submission_submissionitem` (`id`);

--
-- Constraints for table `submission_submissionitem`
--
ALTER TABLE `submission_submissionitem`
  ADD CONSTRAINT `submission_submissionitem_course_id_f804ab42_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`);

--
-- Constraints for table `team_invitation`
--
ALTER TABLE `team_invitation`
  ADD CONSTRAINT `team_invitation_course_id_800bb231_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`);

--
-- Constraints for table `team_leader`
--
ALTER TABLE `team_leader`
  ADD CONSTRAINT `team_leader_user_id_677a4953_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- Constraints for table `team_team`
--
ALTER TABLE `team_team`
  ADD CONSTRAINT `team_team_course_id_78a5e67c_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`);

--
-- Constraints for table `team_team_member`
--
ALTER TABLE `team_team_member`
  ADD CONSTRAINT `team_team_member_team_id_0822d0a5_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`),
  ADD CONSTRAINT `team_team_member_user_id_ee13d3c4_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- Constraints for table `user_student`
--
ALTER TABLE `user_student`
  ADD CONSTRAINT `user_student_user_id_bf9c240f_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- Constraints for table `user_teacher`
--
ALTER TABLE `user_teacher`
  ADD CONSTRAINT `user_teacher_user_id_8fe1696c_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- Constraints for table `user_user_groups`
--
ALTER TABLE `user_user_groups`
  ADD CONSTRAINT `user_user_groups_group_id_c57f13c0_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `user_user_groups_user_id_13f9a20d_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- Constraints for table `user_user_user_permissions`
--
ALTER TABLE `user_user_user_permissions`
  ADD CONSTRAINT `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `user_user_user_permissions_user_id_31782f58_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
