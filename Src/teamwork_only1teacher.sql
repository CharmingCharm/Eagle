-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2020 at 10:29 AM
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
(37, 'Can add export file', 10, 'add_exportfile'),
(38, 'Can change export file', 10, 'change_exportfile'),
(39, 'Can delete export file', 10, 'delete_exportfile'),
(40, 'Can view export file', 10, 'view_exportfile'),
(41, 'Can add leader assessment', 11, 'add_leaderassessment'),
(42, 'Can change leader assessment', 11, 'change_leaderassessment'),
(43, 'Can delete leader assessment', 11, 'delete_leaderassessment'),
(44, 'Can view leader assessment', 11, 'view_leaderassessment'),
(45, 'Can add submission contribution', 12, 'add_submissioncontribution'),
(46, 'Can change submission contribution', 12, 'change_submissioncontribution'),
(47, 'Can delete submission contribution', 12, 'delete_submissioncontribution'),
(48, 'Can view submission contribution', 12, 'view_submissioncontribution'),
(49, 'Can add submission item', 13, 'add_submissionitem'),
(50, 'Can change submission item', 13, 'change_submissionitem'),
(51, 'Can delete submission item', 13, 'delete_submissionitem'),
(52, 'Can view submission item', 13, 'view_submissionitem'),
(53, 'Can add invitation', 14, 'add_invitation'),
(54, 'Can change invitation', 14, 'change_invitation'),
(55, 'Can delete invitation', 14, 'delete_invitation'),
(56, 'Can view invitation', 14, 'view_invitation'),
(57, 'Can add leader', 15, 'add_leader'),
(58, 'Can change leader', 15, 'change_leader'),
(59, 'Can delete leader', 15, 'delete_leader'),
(60, 'Can view leader', 15, 'view_leader'),
(61, 'Can add vote', 16, 'add_vote'),
(62, 'Can change vote', 16, 'change_vote'),
(63, 'Can delete vote', 16, 'delete_vote'),
(64, 'Can view vote', 16, 'view_vote'),
(65, 'Can add team', 17, 'add_team'),
(66, 'Can change team', 17, 'change_team'),
(67, 'Can delete team', 17, 'delete_team'),
(68, 'Can view team', 17, 'view_team');

-- --------------------------------------------------------

--
-- Table structure for table `course_course`
--

CREATE TABLE `course_course` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `begin_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `form_method` int(11) NOT NULL,
  `participation` int(11) NOT NULL,
  `team_size_1` int(11) NOT NULL,
  `team_number_1` int(11) NOT NULL,
  `team_size_2` int(11) NOT NULL,
  `team_number_2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `course_course`
--

INSERT INTO `course_course` (`id`, `name`, `begin_time`, `end_time`, `form_method`, `participation`, `team_size_1`, `team_number_1`, `team_size_2`, `team_number_2`) VALUES
(1, 'Software Development III', '2020-04-01 00:00:00.000000', '2020-04-03 00:00:00.000000', 0, 1, 0, 0, 0, 0),
(2, 'Discrete Structure', '2020-04-01 00:00:00.000000', '2020-04-03 00:00:00.000000', 0, 1, 0, 0, 0, 0),
(3, 'Math III', '2020-04-01 00:00:00.000000', '2020-04-03 00:00:00.000000', 0, 1, 0, 0, 0, 0),
(4, 'Chinese culture', '2020-04-01 00:00:00.000000', '2020-04-03 00:00:00.000000', 0, 1, 0, 0, 0, 0),
(5, 'English I', '2020-04-01 00:00:00.000000', '2020-04-03 00:00:00.000000', 0, 1, 0, 0, 0, 0),
(6, 'American culture', '2020-04-01 00:00:00.000000', '2020-04-03 00:00:00.000000', 0, 1, 0, 0, 0, 0),
(7, 'Existentialism', '2020-04-01 00:00:00.000000', '2020-04-03 00:00:00.000000', 0, 0, 0, 0, 0, 0);

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
(1, 1, 1),
(13, 2, 1),
(14, 3, 1),
(15, 4, 1),
(16, 5, 1),
(17, 6, 1);

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
(10, 'course', 'exportfile'),
(5, 'sessions', 'session'),
(11, 'submission', 'leaderassessment'),
(12, 'submission', 'submissioncontribution'),
(13, 'submission', 'submissionitem'),
(14, 'team', 'invitation'),
(15, 'team', 'leader'),
(17, 'team', 'team'),
(16, 'team', 'vote'),
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
(1, 'contenttypes', '0001_initial', '2020-05-14 17:01:26.898404'),
(2, 'contenttypes', '0002_remove_content_type_name', '2020-05-14 17:01:26.974202'),
(3, 'auth', '0001_initial', '2020-05-14 17:01:27.052006'),
(4, 'auth', '0002_alter_permission_name_max_length', '2020-05-14 17:01:27.292429'),
(5, 'auth', '0003_alter_user_email_max_length', '2020-05-14 17:01:27.301405'),
(6, 'auth', '0004_alter_user_username_opts', '2020-05-14 17:01:27.308410'),
(7, 'auth', '0005_alter_user_last_login_null', '2020-05-14 17:01:27.317362'),
(8, 'auth', '0006_require_contenttypes_0002', '2020-05-14 17:01:27.322348'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2020-05-14 17:01:27.330327'),
(10, 'auth', '0008_alter_user_username_max_length', '2020-05-14 17:01:27.338306'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2020-05-14 17:01:27.348280'),
(12, 'auth', '0010_alter_group_name_max_length', '2020-05-14 17:01:27.401138'),
(13, 'auth', '0011_update_proxy_permissions', '2020-05-14 17:01:27.411111'),
(14, 'user', '0001_initial', '2020-05-14 17:01:27.544789'),
(15, 'admin', '0001_initial', '2020-05-14 17:01:27.856995'),
(16, 'admin', '0002_logentry_remove_auto_add', '2020-05-14 17:01:27.948751'),
(17, 'admin', '0003_logentry_add_action_flag_choices', '2020-05-14 17:01:27.962715'),
(18, 'course', '0001_initial', '2020-05-14 17:01:28.023577'),
(19, 'course', '0002_auto_20200515_0101', '2020-05-14 17:01:28.180132'),
(20, 'sessions', '0001_initial', '2020-05-14 17:01:28.353670'),
(21, 'team', '0001_initial', '2020-05-14 17:01:28.463406'),
(22, 'submission', '0001_initial', '2020-05-14 17:01:28.581773'),
(23, 'submission', '0002_auto_20200515_0101', '2020-05-14 17:01:28.809029'),
(24, 'team', '0002_auto_20200515_0101', '2020-05-14 17:01:29.187239'),
(25, 'course', '0003_auto_20200515_0220', '2020-05-14 18:20:49.521863'),
(26, 'submission', '0003_auto_20200515_0248', '2020-05-14 18:48:45.553943'),
(27, 'team', '0003_team_avg_gpa', '2020-05-19 02:14:33.600089'),
(28, 'team', '0004_team_isingpa', '2020-05-19 02:14:33.636300');

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
('aqbd7w75cenxb79o64mt1fpd1midxhj5', 'NmM3NDZjNjE2ZGIzYjNiOTUzMTBiMDBkNjU4MjI1MDZkOWUxYjQ2ZDqABJWXAAAAAAAAAH2UKIwNX2F1dGhfdXNlcl9pZJSMATGUjBJfYXV0aF91c2VyX2JhY2tlbmSUjClkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZJSMD19hdXRoX3VzZXJfaGFzaJSMKGY3ZjUxNjZjMDhiMDM5YzJmMDQyNjM4YTVkMTI2M2M5OGU5YWE0NjCUdS4=', '2020-06-02 02:23:58.649770'),
('g4k8uucrhgdolyt3qnt3p9muif60hfd1', 'ZjA5NjUwZjFhYTAwNTQ5NmIyZDliNTFhMGZiYjY4NGFmZjMyODYxYTqABJWtAAAAAAAAAH2UKIwNX2F1dGhfdXNlcl9pZJSMATGUjBJfYXV0aF91c2VyX2JhY2tlbmSUjClkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZJSMD19hdXRoX3VzZXJfaGFzaJSMKDU0MmQyZjQyMTJkYzRkMmYzOWYzZjA4MTg1NmJhN2M5MzI3MmQ5MDSUjAxJc0NhbGN1bGF0ZTGUjAR0cnVllHUu', '2020-05-28 20:47:28.316533'),
('smxhclw5000n9bdiiv58qak2zahfa2ig', 'YjhjMDY2NTY0YTIwYTc4NmNjMjdkMjJmNTIwNjg4NjZkNGI0ZTg2NzqABJWtAAAAAAAAAH2UKIwNX2F1dGhfdXNlcl9pZJSMATGUjBJfYXV0aF91c2VyX2JhY2tlbmSUjClkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZJSMD19hdXRoX3VzZXJfaGFzaJSMKGY3ZjUxNjZjMDhiMDM5YzJmMDQyNjM4YTVkMTI2M2M5OGU5YWE0NjCUjAxJc0NhbGN1bGF0ZTGUjAR0cnVllHUu', '2020-06-02 08:27:17.004664');

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

-- --------------------------------------------------------

--
-- Table structure for table `submission_submissioncontribution`
--

CREATE TABLE `submission_submissioncontribution` (
  `id` int(11) NOT NULL,
  `value` double NOT NULL,
  `member_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `isFinishAssess` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `submission_submissionitem`
--

CREATE TABLE `submission_submissionitem` (
  `id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `percentage` double NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `submission_submissionitem`
--

INSERT INTO `submission_submissionitem` (`id`, `title`, `percentage`, `course_id`) VALUES
(1, 'Software Requirement Specification', 10, 1),
(2, 'Software Detail Specification', 15, 1),
(3, 'Architecture design', 15, 1),
(4, 'Group discussion', 5, 1),
(5, 'Meeting Minutes', 15, 1),
(6, 'Group project code', 30, 1),
(7, 'Question List', 10, 1),
(8, 'Group writing', 25, 2),
(9, 'Discussion', 15, 2),
(10, 'Presentation', 30, 2),
(11, 'Final report', 30, 2);

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
  `leader` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `avg_GPA` double NOT NULL,
  `isInGPA` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `team_team_member`
--

CREATE TABLE `team_team_member` (
  `id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `team_vote`
--

CREATE TABLE `team_vote` (
  `id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `vote_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Table structure for table `user_teacher`
--

CREATE TABLE `user_teacher` (
  `id` int(11) NOT NULL,
  `staffID` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_teacher`
--

INSERT INTO `user_teacher` (`id`, `staffID`, `user_id`) VALUES
(1, '1111', 1);

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
(1, 'pbkdf2_sha256$150000$faiUQryjSxXj$gok3w48eAd9uu8I56WMJNAcbngozVbKY1kw+wOfKnM0=', '2020-05-19 08:17:05.405007', 1, 'judy', '', '', 'judy@qq.com', 1, 1, '2020-05-14 17:01:50.612746', 'teacher', 'Judy');

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
  ADD KEY `course_exportfile_student_id_cefd3fab_fk_user_user_id` (`student_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_leaderassessment_team_id_668ed25f_fk_team_team_id` (`team_id`);

--
-- Indexes for table `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_submissio_member_id_1ac854b2_fk_user_user` (`member_id`),
  ADD KEY `submission_submissio_submission_id_83d5a00b_fk_submissio` (`submission_id`),
  ADD KEY `submission_submissio_team_id_e470d6b5_fk_team_team` (`team_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `course_exportfile`
--
ALTER TABLE `course_exportfile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `submission_leaderassessment`
--
ALTER TABLE `submission_leaderassessment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `submission_submissionitem`
--
ALTER TABLE `submission_submissionitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `team_invitation`
--
ALTER TABLE `team_invitation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_leader`
--
ALTER TABLE `team_leader`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_team`
--
ALTER TABLE `team_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `team_team_member`
--
ALTER TABLE `team_team_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `team_vote`
--
ALTER TABLE `team_vote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_student`
--
ALTER TABLE `user_student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_teacher`
--
ALTER TABLE `user_teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_user`
--
ALTER TABLE `user_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
-- Constraints for table `submission_leaderassessment`
--
ALTER TABLE `submission_leaderassessment`
  ADD CONSTRAINT `submission_leaderassessment_team_id_668ed25f_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`);

--
-- Constraints for table `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  ADD CONSTRAINT `submission_submissio_member_id_1ac854b2_fk_user_user` FOREIGN KEY (`member_id`) REFERENCES `user_user` (`id`),
  ADD CONSTRAINT `submission_submissio_submission_id_83d5a00b_fk_submissio` FOREIGN KEY (`submission_id`) REFERENCES `submission_submissionitem` (`id`),
  ADD CONSTRAINT `submission_submissio_team_id_e470d6b5_fk_team_team` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`);

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
