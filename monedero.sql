-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.5.0.5332
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para monedero
CREATE DATABASE IF NOT EXISTS `monedero` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;
USE `monedero`;

-- Volcando estructura para tabla monedero.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.auth_group: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.auth_group_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.auth_permission: ~32 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
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
	(25, 'Can add clientes', 7, 'add_clientes'),
	(26, 'Can change clientes', 7, 'change_clientes'),
	(27, 'Can delete clientes', 7, 'delete_clientes'),
	(28, 'Can view clientes', 7, 'view_clientes'),
	(29, 'Can add pago descuento', 8, 'add_pagodescuento'),
	(30, 'Can change pago descuento', 8, 'change_pagodescuento'),
	(31, 'Can delete pago descuento', 8, 'delete_pagodescuento'),
	(32, 'Can view pago descuento', 8, 'view_pagodescuento');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_spanish_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(254) COLLATE utf8_spanish_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.auth_user: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$120000$WTw8ckBJcHHW$W6CGPZkdPPJik2gUXeA4mPsA1eSVF6JnH5dGngl6nyo=', '2020-07-12 00:52:07.880799', 1, 'diego', '', '', 'jack12diego@gmail.com', 1, 1, '2020-07-12 00:27:50.006732');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.auth_user_groups: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.auth_user_user_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.clientes_clientes
CREATE TABLE IF NOT EXISTS `clientes_clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nombreCliente` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `apellidosCliente` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `porcentaje` int(10) unsigned NOT NULL,
  `saldoMonedero` double NOT NULL,
  `creacion` date NOT NULL,
  `modificacion` date NOT NULL,
  `estatus` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.clientes_clientes: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes_clientes` DISABLE KEYS */;
INSERT INTO `clientes_clientes` (`id`, `codigo`, `nombreCliente`, `apellidosCliente`, `telefono`, `porcentaje`, `saldoMonedero`, `creacion`, `modificacion`, `estatus`) VALUES
	(1, '123456789356', 'Pancrasio', 'Garcia', '2411009812', 5, 0, '2020-07-11', '2020-07-11', 1),
	(2, '987652346422', 'Carlos', 'Arias', '2411007654', 5, 0, '2020-07-11', '2020-07-11', 1),
	(3, '657847583928', 'Carlos', 'Montiel', '2411183678', 5, 0, '2020-07-13', '2020-07-13', 1),
	(4, '325434256728', 'Andres', 'Hernandez', '2411245174', 5, 0, '2020-07-13', '2020-07-13', 1),
	(5, '987878766567', 'Maricela', 'Goméz', '2254321245', 5, 0, '2020-07-13', '2020-07-13', 1),
	(6, '564372819074', 'Juan', 'Roldán', '2415671289', 5, 0, '2020-07-13', '2020-07-13', 1),
	(7, '546372126755', 'Dania', 'Carrillo', '1235652763', 5, 0, '2020-07-13', '2020-07-13', 1),
	(8, '126723890956', 'Diego', 'Arias', '2418765436', 5, 0, '2020-07-13', '2020-07-13', 1),
	(9, '890976875643', 'Evelyn', 'Luciano', '2413322654', 5, 0, '2020-07-13', '2020-07-13', 1),
	(10, '453278900187', 'Abigail', 'Castañeda', '2411781616', 5, 0, '2020-07-13', '2020-07-13', 1),
	(11, '121243562164', 'Yaritzi', 'López', '5522127684', 5, 0, '2020-07-13', '2020-07-13', 1),
	(12, '675433221109', 'Carmen', 'Huerta', '2411261289', 5, 0, '2020-07-13', '2020-07-13', 1);
/*!40000 ALTER TABLE `clientes_clientes` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.clientes_pagodescuento
CREATE TABLE IF NOT EXISTS `clientes_pagodescuento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folio` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fecha` date NOT NULL,
  `importeTotal` double NOT NULL,
  `porcentajePago` int(10) unsigned NOT NULL,
  `saldoClienteAnterior` double NOT NULL,
  `SaldoClienteFinal` double NOT NULL,
  `importeEfectivoTarjeta` double NOT NULL,
  `importeMonedeto` double NOT NULL,
  `cliente_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clientes_pagodescuen_cliente_id_4d87e544_fk_clientes_` (`cliente_id`),
  CONSTRAINT `clientes_pagodescuen_cliente_id_4d87e544_fk_clientes_` FOREIGN KEY (`cliente_id`) REFERENCES `clientes_clientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.clientes_pagodescuento: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes_pagodescuento` DISABLE KEYS */;
INSERT INTO `clientes_pagodescuento` (`id`, `folio`, `fecha`, `importeTotal`, `porcentajePago`, `saldoClienteAnterior`, `SaldoClienteFinal`, `importeEfectivoTarjeta`, `importeMonedeto`, `cliente_id`) VALUES
	(1, '12345678', '2020-07-11', 450, 5, 0, 0, 225, 0, 1);
/*!40000 ALTER TABLE `clientes_pagodescuento` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8_spanish_ci,
  `object_repr` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_spanish_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.django_admin_log: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2020-07-13 17:47:41.557686', '3', 'Carlos', 1, '[{"added": {}}]', 7, 1),
	(2, '2020-07-13 17:48:31.827207', '4', 'Andres', 1, '[{"added": {}}]', 7, 1),
	(3, '2020-07-13 17:49:03.171956', '5', 'Maricela', 1, '[{"added": {}}]', 7, 1),
	(4, '2020-07-13 17:49:31.910064', '6', 'Juan', 1, '[{"added": {}}]', 7, 1),
	(5, '2020-07-13 17:50:13.426510', '7', 'Dania', 1, '[{"added": {}}]', 7, 1),
	(6, '2020-07-13 17:52:55.873716', '8', 'Diego', 1, '[{"added": {}}]', 7, 1),
	(7, '2020-07-13 17:53:35.395902', '9', 'Evelyn', 1, '[{"added": {}}]', 7, 1),
	(8, '2020-07-13 17:54:15.457020', '10', 'Abigail', 1, '[{"added": {}}]', 7, 1),
	(9, '2020-07-13 17:55:01.486085', '11', 'Yaritzi', 1, '[{"added": {}}]', 7, 1),
	(10, '2020-07-13 17:55:54.149014', '12', 'Carmen', 1, '[{"added": {}}]', 7, 1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `model` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.django_content_type: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(7, 'clientes', 'clientes'),
	(8, 'clientes', 'pagodescuento'),
	(5, 'contenttypes', 'contenttype'),
	(6, 'sessions', 'session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.django_migrations: ~16 rows (aproximadamente)
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2020-07-12 00:23:16.019805'),
	(2, 'auth', '0001_initial', '2020-07-12 00:23:27.131015'),
	(3, 'admin', '0001_initial', '2020-07-12 00:23:30.487486'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2020-07-12 00:23:30.630628'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2020-07-12 00:23:30.738590'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2020-07-12 00:23:32.540949'),
	(7, 'auth', '0002_alter_permission_name_max_length', '2020-07-12 00:23:33.755184'),
	(8, 'auth', '0003_alter_user_email_max_length', '2020-07-12 00:23:34.668089'),
	(9, 'auth', '0004_alter_user_username_opts', '2020-07-12 00:23:34.741441'),
	(10, 'auth', '0005_alter_user_last_login_null', '2020-07-12 00:23:35.831703'),
	(11, 'auth', '0006_require_contenttypes_0002', '2020-07-12 00:23:35.892271'),
	(12, 'auth', '0007_alter_validators_add_error_messages', '2020-07-12 00:23:35.976587'),
	(13, 'auth', '0008_alter_user_username_max_length', '2020-07-12 00:23:36.936577'),
	(14, 'auth', '0009_alter_user_last_name_max_length', '2020-07-12 00:23:37.957675'),
	(15, 'clientes', '0001_initial', '2020-07-12 00:23:40.758072'),
	(16, 'sessions', '0001_initial', '2020-07-12 00:23:42.331235');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;

-- Volcando estructura para tabla monedero.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `session_data` longtext COLLATE utf8_spanish_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- Volcando datos para la tabla monedero.django_session: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('gxiw9fup1xn7i6bvsa7zfgmc5554xkz5', 'Y2IxMmMxNmMzYTUyMDc1NmE2NDhkZTk5OWRiMzk1MGNiNWU1NDE4ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxY2I2MTFjMmVhYjdjNDA1MmRiNWMwZDY4ZmFhMTE2MjVjNjViOGUwIn0=', '2020-07-26 00:52:07.944847');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
