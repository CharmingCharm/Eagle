-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2020-05-12 04:28:21
-- 服务器版本： 10.1.37-MariaDB
-- PHP 版本： 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `teamwork`
--

-- --------------------------------------------------------

--
-- 表的结构 `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `auth_permission`
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
(60, 'Can view invitation', 15, 'view_invitation');

-- --------------------------------------------------------

--
-- 表的结构 `course_course`
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
  `team_num` int(11) NOT NULL,
  `form_method` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `course_course`
--

INSERT INTO `course_course` (`id`, `name`, `begin_time`, `end_time`, `pic`, `visit`, `description`, `participation`, `team_num`, `form_method`) VALUES
(1, 'zqmdsbbbbbbbbbbb', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 3, 0, 0),
(2, 'zqmcccccccccc', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 7, 2, 0),
(3, 'zqmdddddddddd', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 1, 0, 0),
(4, 'zqmeeeeeeee', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 1, 0, 0),
(5, 'zqmfffffffff', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 1, 0, 0),
(6, 'zqmdsggggggggg', '2020-04-01 00:00:00.000000', '2020-04-02 00:00:00.000000', '1.jpg', 12, '12312321123', 1, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `course_course_member`
--

CREATE TABLE `course_course_member` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `course_course_member`
--

INSERT INTO `course_course_member` (`id`, `course_id`, `user_id`) VALUES
(7, 1, 1),
(1, 1, 2),
(15, 1, 8),
(14, 2, 1),
(2, 2, 2),
(9, 2, 3),
(10, 2, 4),
(11, 2, 5),
(12, 2, 6),
(13, 2, 7),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2);

-- --------------------------------------------------------

--
-- 表的结构 `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(9, 'course', 'course'),
(5, 'sessions', 'session'),
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
-- 表的结构 `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_migrations`
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
(36, 'course', '0006_course_form_method', '2020-05-12 02:25:01.578727');

-- --------------------------------------------------------

--
-- 表的结构 `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('brr08ikpm2rtk6wz8krcw63d5uu3qyba', 'MDYyZGFkMWVjZjU2N2YxOWM5OTNjMTk1OWI0ZDRiN2EyNWIxOGZkYjqABJWXAAAAAAAAAH2UKIwNX2F1dGhfdXNlcl9pZJSMATKUjBJfYXV0aF91c2VyX2JhY2tlbmSUjClkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZJSMD19hdXRoX3VzZXJfaGFzaJSMKDZiY2ZjZjRiNDA5NzA0NzNhY2E3NWIwMTEwN2Y1N2NlZDMyZTk4ZjSUdS4=', '2020-05-25 15:16:00.448806');

-- --------------------------------------------------------

--
-- 表的结构 `submission_submissioncontribution`
--

CREATE TABLE `submission_submissioncontribution` (
  `id` int(11) NOT NULL,
  `value` double NOT NULL,
  `member_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `submission_submissionitem`
--

CREATE TABLE `submission_submissionitem` (
  `id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `percentage` double NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `submission_submissionitem`
--

INSERT INTO `submission_submissionitem` (`id`, `title`, `percentage`, `course_id`) VALUES
(3, 'eeeee', 40, 1),
(5, 'qwqqwqwq', 10, 1),
(6, 'qwq', 30, 1),
(7, 'qeqeqe', 20, 1);

-- --------------------------------------------------------

--
-- 表的结构 `team_invitation`
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
-- 转存表中的数据 `team_invitation`
--

INSERT INTO `team_invitation` (`id`, `from_user`, `to_user`, `description`, `isAccept`, `course_id`) VALUES
(1, 4, 2, '123', 1, 2),
(2, 1, 2, 'It is pathway III', 2, 2);

-- --------------------------------------------------------

--
-- 表的结构 `team_leader`
--

CREATE TABLE `team_leader` (
  `id` int(11) NOT NULL,
  `bonus` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `team_team`
--

CREATE TABLE `team_team` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `course_id` int(11) NOT NULL,
  `leader` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `team_team`
--

INSERT INTO `team_team` (`id`, `name`, `course_id`, `leader`) VALUES
(4, 'Eagle', 1, 2),
(18, 'group0', 2, 0),
(19, 'group1', 2, 0);

-- --------------------------------------------------------

--
-- 表的结构 `team_team_member`
--

CREATE TABLE `team_team_member` (
  `id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `team_team_member`
--

INSERT INTO `team_team_member` (`id`, `team_id`, `user_id`) VALUES
(1, 4, 1),
(2, 4, 2),
(38, 18, 4),
(39, 18, 6),
(37, 18, 7),
(40, 19, 2),
(41, 19, 3),
(42, 19, 5);

-- --------------------------------------------------------

--
-- 表的结构 `team_vote`
--

CREATE TABLE `team_vote` (
  `id` int(11) NOT NULL,
  `vote_id` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `team` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `team_vote`
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
-- 表的结构 `user_student`
--

CREATE TABLE `user_student` (
  `id` int(11) NOT NULL,
  `studentID` varchar(20) NOT NULL,
  `GPA` double NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user_student`
--

INSERT INTO `user_student` (`id`, `studentID`, `GPA`, `user_id`) VALUES
(1, '1730026102', 1, 8);

-- --------------------------------------------------------

--
-- 表的结构 `user_teacher`
--

CREATE TABLE `user_teacher` (
  `id` int(11) NOT NULL,
  `staffID` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `user_user`
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
-- 转存表中的数据 `user_user`
--

INSERT INTO `user_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `field`, `truename`) VALUES
(1, 'pbkdf2_sha256$150000$hAU829ZVucLH$stMX/smg8yE+FdjDWJJmv5UKwpBxN29lyNBA3O/egsg=', '2020-05-11 14:58:21.822067', 1, 'tzm', '', '', '', 1, 1, '2020-04-30 04:15:58.009282', 'teacher', 'zqm'),
(2, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-11 15:16:00.414087', 0, '123', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(3, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-10 15:14:42.748663', 0, '124', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(4, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-09 14:44:15.723173', 0, '125', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(5, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-09 14:44:15.723173', 0, '126', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(6, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-09 14:44:15.723173', 0, '127', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(7, 'pbkdf2_sha256$150000$ctz83xTLE7dZ$iEP0z4fBBFuRFQypf4d1fuybQvA2UNRsSmzgujus5vI=', '2020-05-09 14:44:15.723173', 0, '128', '', '', '1220219614@qq.com', 0, 1, '2020-04-30 04:17:17.100308', 'student', 'zqm'),
(8, 'pbkdf2_sha256$150000$xsD0iDCPLufY$gnagYwbO/rY934XmxRznpywd/uIHmK1fbxZoiu1QkTY=', NULL, 0, '1234', '', '', '1220219614@qq.com', 0, 1, '2020-05-10 17:32:40.002014', 'student', '');

-- --------------------------------------------------------

--
-- 表的结构 `user_user_groups`
--

CREATE TABLE `user_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `user_user_user_permissions`
--

CREATE TABLE `user_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转储表的索引
--

--
-- 表的索引 `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- 表的索引 `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- 表的索引 `course_course`
--
ALTER TABLE `course_course`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `course_course_member`
--
ALTER TABLE `course_course_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_course_member_course_id_user_id_202017ca_uniq` (`course_id`,`user_id`),
  ADD KEY `course_course_member_user_id_57087271_fk_user_user_id` (`user_id`);

--
-- 表的索引 `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_user_user_id` (`user_id`);

--
-- 表的索引 `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- 表的索引 `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- 表的索引 `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_submissio_member_id_1ac854b2_fk_user_user` (`member_id`),
  ADD KEY `submission_submissio_submission_id_83d5a00b_fk_submissio` (`submission_id`);

--
-- 表的索引 `submission_submissionitem`
--
ALTER TABLE `submission_submissionitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_submissionitem_course_id_f804ab42_fk_course_course_id` (`course_id`);

--
-- 表的索引 `team_invitation`
--
ALTER TABLE `team_invitation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `team_invitation_course_id_800bb231_fk_course_course_id` (`course_id`);

--
-- 表的索引 `team_leader`
--
ALTER TABLE `team_leader`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- 表的索引 `team_team`
--
ALTER TABLE `team_team`
  ADD PRIMARY KEY (`id`),
  ADD KEY `team_team_course_id_78a5e67c_fk_course_course_id` (`course_id`);

--
-- 表的索引 `team_team_member`
--
ALTER TABLE `team_team_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_team_member_team_id_user_id_40bac298_uniq` (`team_id`,`user_id`),
  ADD KEY `team_team_member_user_id_ee13d3c4_fk_user_user_id` (`user_id`);

--
-- 表的索引 `team_vote`
--
ALTER TABLE `team_vote`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `user_student`
--
ALTER TABLE `user_student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- 表的索引 `user_teacher`
--
ALTER TABLE `user_teacher`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- 表的索引 `user_user`
--
ALTER TABLE `user_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 表的索引 `user_user_groups`
--
ALTER TABLE `user_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_user_groups_user_id_group_id_bb60391f_uniq` (`user_id`,`group_id`),
  ADD KEY `user_user_groups_group_id_c57f13c0_fk_auth_group_id` (`group_id`);

--
-- 表的索引 `user_user_user_permissions`
--
ALTER TABLE `user_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_user_user_permissions_user_id_permission_id_64f4d5b8_uniq` (`user_id`,`permission_id`),
  ADD KEY `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` (`permission_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- 使用表AUTO_INCREMENT `course_course`
--
ALTER TABLE `course_course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `course_course_member`
--
ALTER TABLE `course_course_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- 使用表AUTO_INCREMENT `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- 使用表AUTO_INCREMENT `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- 使用表AUTO_INCREMENT `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `submission_submissionitem`
--
ALTER TABLE `submission_submissionitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `team_invitation`
--
ALTER TABLE `team_invitation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `team_leader`
--
ALTER TABLE `team_leader`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `team_team`
--
ALTER TABLE `team_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- 使用表AUTO_INCREMENT `team_team_member`
--
ALTER TABLE `team_team_member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- 使用表AUTO_INCREMENT `team_vote`
--
ALTER TABLE `team_vote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `user_student`
--
ALTER TABLE `user_student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `user_teacher`
--
ALTER TABLE `user_teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_user`
--
ALTER TABLE `user_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `user_user_groups`
--
ALTER TABLE `user_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_user_user_permissions`
--
ALTER TABLE `user_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 限制导出的表
--

--
-- 限制表 `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- 限制表 `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- 限制表 `course_course_member`
--
ALTER TABLE `course_course_member`
  ADD CONSTRAINT `course_course_member_course_id_66dc926d_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`),
  ADD CONSTRAINT `course_course_member_user_id_57087271_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- 限制表 `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- 限制表 `submission_submissioncontribution`
--
ALTER TABLE `submission_submissioncontribution`
  ADD CONSTRAINT `submission_submissio_member_id_1ac854b2_fk_user_user` FOREIGN KEY (`member_id`) REFERENCES `user_user` (`id`),
  ADD CONSTRAINT `submission_submissio_submission_id_83d5a00b_fk_submissio` FOREIGN KEY (`submission_id`) REFERENCES `submission_submissionitem` (`id`);

--
-- 限制表 `submission_submissionitem`
--
ALTER TABLE `submission_submissionitem`
  ADD CONSTRAINT `submission_submissionitem_course_id_f804ab42_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`);

--
-- 限制表 `team_invitation`
--
ALTER TABLE `team_invitation`
  ADD CONSTRAINT `team_invitation_course_id_800bb231_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`);

--
-- 限制表 `team_leader`
--
ALTER TABLE `team_leader`
  ADD CONSTRAINT `team_leader_user_id_677a4953_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- 限制表 `team_team`
--
ALTER TABLE `team_team`
  ADD CONSTRAINT `team_team_course_id_78a5e67c_fk_course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`);

--
-- 限制表 `team_team_member`
--
ALTER TABLE `team_team_member`
  ADD CONSTRAINT `team_team_member_team_id_0822d0a5_fk_team_team_id` FOREIGN KEY (`team_id`) REFERENCES `team_team` (`id`),
  ADD CONSTRAINT `team_team_member_user_id_ee13d3c4_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- 限制表 `user_student`
--
ALTER TABLE `user_student`
  ADD CONSTRAINT `user_student_user_id_bf9c240f_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- 限制表 `user_teacher`
--
ALTER TABLE `user_teacher`
  ADD CONSTRAINT `user_teacher_user_id_8fe1696c_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- 限制表 `user_user_groups`
--
ALTER TABLE `user_user_groups`
  ADD CONSTRAINT `user_user_groups_group_id_c57f13c0_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `user_user_groups_user_id_13f9a20d_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);

--
-- 限制表 `user_user_user_permissions`
--
ALTER TABLE `user_user_user_permissions`
  ADD CONSTRAINT `user_user_user_permi_permission_id_ce49d4de_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `user_user_user_permissions_user_id_31782f58_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
