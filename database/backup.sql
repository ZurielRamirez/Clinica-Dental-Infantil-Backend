-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: clinica_dental_db
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment_treatment`
--

DROP TABLE IF EXISTS `appointment_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_treatment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `appointment_id` bigint unsigned NOT NULL,
  `treatment_id` bigint unsigned NOT NULL,
  `cost` decimal(8,2) NOT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointment_treatment_appointment_id_foreign` (`appointment_id`),
  KEY `appointment_treatment_treatment_id_foreign` (`treatment_id`),
  CONSTRAINT `appointment_treatment_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_treatment_treatment_id_foreign` FOREIGN KEY (`treatment_id`) REFERENCES `treatments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_treatment`
--

LOCK TABLES `appointment_treatment` WRITE;
/*!40000 ALTER TABLE `appointment_treatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment_treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint unsigned NOT NULL,
  `dentist_id` bigint unsigned NOT NULL,
  `appointment_date` datetime NOT NULL,
  `status` enum('pending','confirmed','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `reminder_sent_at` timestamp NULL DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointments_patient_id_foreign` (`patient_id`),
  KEY `appointments_dentist_id_foreign` (`dentist_id`),
  CONSTRAINT `appointments_dentist_id_foreign` FOREIGN KEY (`dentist_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,1,2,'2026-07-17 08:12:06','pending',NULL,NULL,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(2,2,3,'2026-07-14 09:19:06','confirmed',NULL,'Seguimiento de tratamiento','2026-07-29 03:35:56','2026-07-29 03:35:56'),(3,3,4,'2026-08-12 11:50:33','completed',NULL,NULL,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(4,4,2,'2026-07-29 08:50:09','cancelled',NULL,'Revisión de rutina','2026-07-29 03:35:56','2026-07-29 03:35:56'),(5,5,3,'2026-07-18 00:59:00','pending',NULL,'Seguimiento de tratamiento','2026-07-29 03:35:56','2026-07-29 03:35:56'),(6,6,4,'2026-08-10 03:26:20','confirmed',NULL,'Revisión de rutina','2026-07-29 03:35:56','2026-07-29 03:35:56'),(7,7,2,'2026-08-08 19:05:55','completed',NULL,NULL,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(8,8,3,'2026-08-08 12:27:40','cancelled',NULL,'Primera consulta','2026-07-29 03:35:56','2026-07-29 03:35:56'),(9,9,4,'2026-07-17 16:26:32','pending',NULL,'Revisión de rutina','2026-07-29 03:35:56','2026-07-29 03:35:56'),(10,10,2,'2026-08-07 18:03:28','confirmed',NULL,'Seguimiento de tratamiento','2026-07-29 03:35:56','2026-07-29 03:35:56'),(11,11,3,'2026-08-06 03:06:31','completed',NULL,NULL,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(12,12,4,'2026-08-02 12:57:02','cancelled',NULL,'Control post-tratamiento','2026-07-29 03:35:56','2026-07-29 03:35:56'),(13,13,2,'2026-07-21 13:02:10','pending',NULL,'Primera consulta','2026-07-29 03:35:56','2026-07-29 03:35:56'),(14,14,3,'2026-07-14 15:31:26','confirmed',NULL,'Primera consulta','2026-07-29 03:35:56','2026-07-29 03:35:56');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_07_26_204621_create_roles_table',1),(5,'2026_07_26_204629_create_role_user_table',1),(6,'2026_07_26_204636_create_patients_table',1),(7,'2026_07_26_204644_create_treatments_table',1),(8,'2026_07_26_204651_create_appointments_table',1),(9,'2026_07_26_204703_create_appointment_treatment_table',1),(10,'2026_07_26_211901_create_personal_access_tokens_table',1),(11,'2026_07_29_074841_add_phone_to_users_table',1),(12,'2026_07_29_082002_add_reminder_sent_at_to_appointments_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tutor_id` bigint unsigned NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `allergies` text COLLATE utf8mb4_unicode_ci,
  `medical_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patients_tutor_id_foreign` (`tutor_id`),
  CONSTRAINT `patients_tutor_id_foreign` FOREIGN KEY (`tutor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,5,'Mateo','Perez','2018-05-14','Penicilina','Paciente colaborador','2026-07-29 03:35:56','2026-07-29 03:35:56'),(2,5,'Sofía','Perez','2020-09-21','Ninguna','Miedo a los ruidos fuertes','2026-07-29 03:35:56','2026-07-29 03:35:56'),(3,6,'Emiliano','Torres','2021-09-25','Penicilina','Primera visita','2026-07-29 03:35:56','2026-07-29 03:35:56'),(4,7,'Regina','Sánchez','2017-01-29','Penicilina','Requiere acompañamiento','2026-07-29 03:35:56','2026-07-29 03:35:56'),(5,8,'Santiago','Cruz','2023-12-18','Ninguna','Primera visita','2026-07-29 03:35:56','2026-07-29 03:35:56'),(6,9,'Valentina','Ruiz','2024-05-20','Penicilina','Requiere acompañamiento','2026-07-29 03:35:56','2026-07-29 03:35:56'),(7,10,'Diego','Martínez','2021-10-27','Ninguna','Paciente colaborador','2026-07-29 03:35:56','2026-07-29 03:35:56'),(8,11,'Ximena','Hernández','2019-05-13','Polen','Sin antecedentes relevantes','2026-07-29 03:35:56','2026-07-29 03:35:56'),(9,12,'Leonardo','Jiménez','2018-02-15','Polen','Requiere acompañamiento','2026-07-29 03:35:56','2026-07-29 03:35:56'),(10,13,'Camila','Morales','2023-09-20','Polen','Paciente colaborador','2026-07-29 03:35:56','2026-07-29 03:35:56'),(11,14,'Emilio','Vázquez','2019-06-08','Ninguna','Paciente colaborador','2026-07-29 03:35:56','2026-07-29 03:35:56'),(12,6,'Renata','López','2017-11-11','Ninguna','Requiere acompañamiento','2026-07-29 03:35:56','2026-07-29 03:35:56'),(13,7,'Mateo','González','2024-06-29','Ninguna','Primera visita','2026-07-29 03:35:56','2026-07-29 03:35:56'),(14,8,'Sofía','Ramírez','2015-10-16','Ninguna','Ansiedad leve ante procedimientos','2026-07-29 03:35:56','2026-07-29 03:35:56');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_user_user_id_foreign` (`user_id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` VALUES (1,1,1,NULL,NULL),(2,2,2,NULL,NULL),(3,3,2,NULL,NULL),(4,4,2,NULL,NULL),(5,5,3,NULL,NULL),(6,6,3,NULL,NULL),(7,7,3,NULL,NULL),(8,8,3,NULL,NULL),(9,9,3,NULL,NULL),(10,10,3,NULL,NULL),(11,11,3,NULL,NULL),(12,12,3,NULL,NULL),(13,13,3,NULL,NULL),(14,14,3,NULL,NULL);
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Administrador','2026-07-29 03:35:51','2026-07-29 03:35:51'),(2,'dentist','Odontopediatra','2026-07-29 03:35:51','2026-07-29 03:35:51'),(3,'tutor','Tutor / Padre','2026-07-29 03:35:51','2026-07-29 03:35:51');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatments`
--

DROP TABLE IF EXISTS `treatments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatments`
--

LOCK TABLES `treatments` WRITE;
/*!40000 ALTER TABLE `treatments` DISABLE KEYS */;
INSERT INTO `treatments` VALUES (1,'Limpieza Dental Infantil','Profilaxis y aplicación de flúor',500.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(2,'Resina Fotocurable','Restauración por caries',800.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(3,'Pulpotomía','Tratamiento pulpar para dientes de leche',1200.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(4,'Extracción Simple','Extracción de diente caduco',450.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(5,'Sellador de Fosetas','Prevención de caries en molares',350.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(6,'Consulta de Valoración','Revisión inicial y diagnóstico',300.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(7,'Aplicación de Flúor','Tratamiento preventivo tópico',250.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(8,'Corona Pediátrica','Corona de acero para dientes tratados',1500.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(9,'Pulpectomía','Tratamiento de conducto en dientes temporales',1400.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(10,'Mantenedor de Espacio','Prevención de mal oclusión tras extracción',1100.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(11,'Profilaxis con Flúor Barniz','Limpieza más protección con barniz fluorado',600.00,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(12,'Radiografía Dental','Estudio radiográfico de diagnóstico',200.00,'2026-07-29 03:35:56','2026-07-29 03:35:56');
/*!40000 ALTER TABLE `treatments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrador General','admin@clinicadental.com','+5219511234567',NULL,'$2y$12$B9tcFI5lJWBzXUY5HS6pjuR/7wXecCmWL52Pu09kXzQGsBMr46e.m',NULL,'2026-07-29 03:35:52','2026-07-29 03:35:52'),(2,'Dra. María González','dentista@clinicadental.com','+5219511234568',NULL,'$2y$12$l0gQj8meOcoiv/9P2a6miu/oBalo.fsEEu6a27U/HT5qZPS/XSvJ6',NULL,'2026-07-29 03:35:52','2026-07-29 03:35:52'),(3,'Dr. Carlos Ramírez','dentista2@clinicadental.com','+5219518325586',NULL,'$2y$12$tuP/6IYQWcqevOt5U/opturynA3zqxwMc50MKPfd09kokBLa0x88y',NULL,'2026-07-29 03:35:52','2026-07-29 03:35:52'),(4,'Dra. Fernanda López','dentista3@clinicadental.com','+5219511861378',NULL,'$2y$12$graijtrars3PyVcCdFZ8u.O.y0FTxmLHAZmYPm5TYM4kz7MVXr6Te',NULL,'2026-07-29 03:35:53','2026-07-29 03:35:53'),(5,'Juan Perez','tutor@gmail.com','+5219513928808',NULL,'$2y$12$yNDbXugClZprPbQ4hDn5he0y4Li4orlBWzbnTybFnVgoNh0BD.ueG',NULL,'2026-07-29 03:35:53','2026-07-29 03:35:53'),(6,'Ana Martínez','tutor2@gmail.com','+5219518682670',NULL,'$2y$12$43.JjtPJQ.HVb9C.vtWWCORkAJCSfg5tZr9pFoN9Bq82c2vwkNmnG',NULL,'2026-07-29 03:35:53','2026-07-29 03:35:53'),(7,'Luis Hernández','tutor3@gmail.com','+5219518689643',NULL,'$2y$12$1jvK9/WM88CaW.6qICKv/ekwcv8MG7QRdve67ry7JnhlBZyp21zRa',NULL,'2026-07-29 03:35:54','2026-07-29 03:35:54'),(8,'Karla Jiménez','tutor4@gmail.com','+5219513459641',NULL,'$2y$12$zpMkjBGRBBFuWfCZpzOahe6.OOCbDJjILOmUm9X2ofHEbLDpDtyFW',NULL,'2026-07-29 03:35:54','2026-07-29 03:35:54'),(9,'Roberto Cruz','tutor5@gmail.com','+5219519685090',NULL,'$2y$12$XKx3hfwN1vC/F1SwzdO/2ecc8xfirjhNNaCyWWlhEs1MOICDen9Gm',NULL,'2026-07-29 03:35:54','2026-07-29 03:35:54'),(10,'Patricia Morales','tutor6@gmail.com','+5219519020476',NULL,'$2y$12$fwO2djfSuW6sfbkebYHBKe6azaUe81ttGzJcFxPAdRLife8WNXnqa',NULL,'2026-07-29 03:35:55','2026-07-29 03:35:55'),(11,'Jorge Sánchez','tutor7@gmail.com','+5219516912344',NULL,'$2y$12$vOZQOsUYzM3ZwH7dlMZlHOVWval4AieNWgxmMdkCcjQNYb1510Cre',NULL,'2026-07-29 03:35:55','2026-07-29 03:35:55'),(12,'Daniela Torres','tutor8@gmail.com','+5219519699781',NULL,'$2y$12$E94df2BiNOfYex2o0CYk.uF2QdRhSffJoNbBJ2qvRph48XR0nK9EK',NULL,'2026-07-29 03:35:55','2026-07-29 03:35:55'),(13,'Miguel Ángel Ruiz','tutor9@gmail.com','+5219515099552',NULL,'$2y$12$GMLVLjPEIZkVixmnczOypuXrv4tR9TwjY.8uqPdePqjS3x2p7vD2C',NULL,'2026-07-29 03:35:56','2026-07-29 03:35:56'),(14,'Cynthia Vázquez','tutor10@gmail.com','+5219519339064',NULL,'$2y$12$yQpbp6PMoop/CEv5qNVyM.pSFhlO8wfIAyYiTKdpKNCSs1iljwA6y',NULL,'2026-07-29 03:35:56','2026-07-29 03:35:56');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-29  9:45:55
