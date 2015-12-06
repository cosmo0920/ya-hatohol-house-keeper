-- MySQL dump 10.15  Distrib 10.0.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hatohol
-- ------------------------------------------------------
-- Server version	10.0.22-MariaDB-1~trusty-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_tables_version`
--

DROP TABLE IF EXISTS `_tables_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_tables_version` (
  `tables_id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`tables_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_list`
--

DROP TABLE IF EXISTS `access_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `host_group_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `server_id` (`server_id`),
  KEY `host_group_id` (`host_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `action_logs`
--

DROP TABLE IF EXISTS `action_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_logs` (
  `action_log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `starter_id` int(11) NOT NULL,
  `queuing_time` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT '0000-00-00 00:00:00',
  `exec_failure_code` int(11) NOT NULL DEFAULT '0',
  `exit_code` int(11) DEFAULT NULL,
  `server_id` int(11) NOT NULL,
  `event_id` varchar(255) NOT NULL,
  PRIMARY KEY (`action_log_id`),
  KEY `action_id` (`action_id`),
  KEY `status` (`status`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `exec_failure_code` (`exec_failure_code`),
  KEY `exit_code` (`exit_code`),
  KEY `server_id` (`server_id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) DEFAULT NULL,
  `host_id_in_server` varchar(255) DEFAULT NULL,
  `host_group_id` varchar(255) DEFAULT NULL,
  `trigger_id` varchar(255) DEFAULT NULL,
  `trigger_status` int(11) DEFAULT NULL,
  `trigger_severity` int(11) DEFAULT NULL,
  `trigger_severity_comp_type` int(11) DEFAULT NULL,
  `action_type` int(11) NOT NULL,
  `command` varchar(255) NOT NULL,
  `working_dir` varchar(255) NOT NULL,
  `timeout` int(11) NOT NULL,
  `owner_user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`action_id`),
  KEY `server_id` (`server_id`),
  KEY `host_id_in_server` (`host_id_in_server`),
  KEY `host_group_id` (`host_group_id`),
  KEY `trigger_id` (`trigger_id`),
  KEY `trigger_status` (`trigger_status`),
  KEY `trigger_severity` (`trigger_severity`),
  KEY `trigger_severity_comp_type` (`trigger_severity_comp_type`),
  KEY `owner_user_id` (`owner_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arm_plugins`
--

DROP TABLE IF EXISTS `arm_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arm_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `broker_url` varchar(4095) NOT NULL,
  `static_queue_addr` varchar(255) NOT NULL,
  `serverId` int(11) NOT NULL,
  `tls_certificate_path` varchar(4095) DEFAULT NULL,
  `tls_key_path` varchar(4095) DEFAULT NULL,
  `tls_ca_certificate_path` varchar(4095) DEFAULT NULL,
  `tls_enable_verify` int(1) DEFAULT '1',
  `uuid` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serverId` (`serverId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_incident_statuses`
--

DROP TABLE IF EXISTS `custom_incident_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_incident_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `CustomIncidentStatusCodeUniqId` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `unified_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL,
  `id` varchar(255) NOT NULL,
  `time_sec` int(11) NOT NULL,
  `time_ns` int(11) NOT NULL,
  `event_value` int(11) NOT NULL,
  `trigger_id` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `severity` int(11) NOT NULL,
  `global_host_id` bigint(20) unsigned NOT NULL,
  `host_id_in_server` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `brief` varchar(255) NOT NULL,
  `extended_info` varchar(32767) DEFAULT NULL,
  PRIMARY KEY (`unified_id`),
  KEY `id` (`id`),
  KEY `time_sec` (`time_sec`),
  KEY `trigger_id` (`trigger_id`),
  KEY `status` (`status`),
  KEY `severity` (`severity`),
  KEY `global_host_id` (`global_host_id`),
  KEY `host_id_in_server` (`host_id_in_server`),
  KEY `EventsId` (`server_id`,`id`),
  KEY `EventsTimeSequence` (`time_sec`,`time_ns`,`unified_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1279 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_access`
--

DROP TABLE IF EXISTS `host_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL,
  `ip_addr_or_fqdn` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `host_id` (`host_id`),
  KEY `ip_addr_or_fqdn` (`ip_addr_or_fqdn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_list`
--

DROP TABLE IF EXISTS `host_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hostgroup_list`
--

DROP TABLE IF EXISTS `hostgroup_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostgroup_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL,
  `id_in_server` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `HostgroupListUniqId` (`server_id`,`id_in_server`),
  KEY `id_in_server` (`id_in_server`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hostgroup_member`
--

DROP TABLE IF EXISTS `hostgroup_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostgroup_member` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL,
  `host_id_in_server` varchar(255) NOT NULL,
  `host_group_id` varchar(255) NOT NULL,
  `host_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `HostsHostgroupUniqId` (`server_id`,`host_id_in_server`,`host_group_id`),
  KEY `host_id_in_server` (`host_id_in_server`),
  KEY `host_group_id` (`host_group_id`),
  KEY `host_id` (`host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_trackers`
--

DROP TABLE IF EXISTS `incident_trackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_trackers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `base_url` varchar(255) NOT NULL,
  `project_id` varchar(255) NOT NULL,
  `tracker_id` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidents`
--

DROP TABLE IF EXISTS `incidents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidents` (
  `tracker_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `event_id` varchar(255) NOT NULL,
  `trigger_id` varchar(255) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `assignee` varchar(255) NOT NULL,
  `created_at_sec` bigint(20) unsigned NOT NULL,
  `created_at_ns` bigint(20) unsigned NOT NULL,
  `updated_at_sec` bigint(20) unsigned NOT NULL,
  `updated_at_ns` bigint(20) unsigned NOT NULL,
  `priority` varchar(255) NOT NULL,
  `done_ratio` int(11) NOT NULL,
  `unified_event_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `IncidentsIdentifier` (`tracker_id`,`identifier`),
  KEY `trigger_id` (`trigger_id`),
  KEY `IncidentsUnifiedEventId` (`unified_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `server_id` int(11) NOT NULL,
  `id` varchar(255) NOT NULL,
  `global_host_id` bigint(20) unsigned NOT NULL,
  `host_id_in_server` varchar(255) NOT NULL,
  `brief` varchar(255) NOT NULL,
  `last_value_time_sec` int(11) NOT NULL,
  `last_value_time_ns` int(11) NOT NULL,
  `last_value` varchar(255) NOT NULL,
  `prev_value` varchar(255) NOT NULL,
  `item_group_name` varchar(255) NOT NULL,
  `value_type` int(11) NOT NULL,
  `unit` varchar(255) NOT NULL,
  UNIQUE KEY `ItemsUniqId` (`server_id`,`id`),
  KEY `id` (`id`),
  KEY `global_host_id` (`global_host_id`),
  KEY `host_id_in_server` (`host_id_in_server`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `last_info`
--

DROP TABLE IF EXISTS `last_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `last_info` (
  `last_info_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_type` int(11) DEFAULT NULL,
  `value` varchar(32767) DEFAULT NULL,
  `server_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`last_info_id`),
  UNIQUE KEY `LastUniqId` (`data_type`,`server_id`),
  KEY `data_type` (`data_type`),
  KEY `server_id` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_host_def`
--

DROP TABLE IF EXISTS `server_host_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_host_def` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned DEFAULT NULL,
  `server_id` int(11) DEFAULT NULL,
  `host_id_in_server` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `HostServerDefIdx` (`server_id`,`host_id_in_server`),
  KEY `host_id` (`host_id`),
  KEY `server_id` (`server_id`),
  KEY `host_id_in_server` (`host_id_in_server`),
  KEY `name` (`name`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_status`
--

DROP TABLE IF EXISTS `server_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_status` (
  `id` int(11) NOT NULL,
  `nvps` double(15,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_types`
--

DROP TABLE IF EXISTS `server_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_types` (
  `type` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parameters` varchar(32767) NOT NULL,
  `plugin_path` varchar(2048) NOT NULL,
  `plugin_sql_version` int(11) NOT NULL,
  `plugin_enabled` int(1) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  UNIQUE KEY `ServerTypeUniqId` (`type`,`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `polling_interval_sec` int(11) NOT NULL,
  `retry_interval_sec` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `db_name` varchar(255) NOT NULL,
  `base_url` varchar(2047) DEFAULT NULL,
  `extended_info` varchar(32767) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `severity_ranks`
--

DROP TABLE IF EXISTS `severity_ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `severity_ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL,
  `color` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `as_important` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `SeverityRanksUniqId` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `database_dir` varchar(255) NOT NULL DEFAULT '',
  `enable_face_mysql` int(11) NOT NULL,
  `face_rest_port` int(11) NOT NULL DEFAULT '0',
  `enable_copy_on_demand` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `triggers`
--

DROP TABLE IF EXISTS `triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triggers` (
  `server_id` int(11) NOT NULL,
  `id` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `severity` int(11) NOT NULL,
  `last_change_time_sec` int(11) NOT NULL,
  `last_change_time_ns` int(11) NOT NULL,
  `global_host_id` bigint(20) unsigned NOT NULL,
  `host_id_in_server` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `brief` varchar(255) NOT NULL,
  `extended_info` varchar(32767) DEFAULT NULL,
  `validity` int(11) NOT NULL DEFAULT '1',
  UNIQUE KEY `TrigUniqId` (`server_id`,`id`),
  KEY `id` (`id`),
  KEY `status` (`status`),
  KEY `severity` (`severity`),
  KEY `global_host_id` (`global_host_id`),
  KEY `host_id_in_server` (`host_id_in_server`),
  KEY `validity` (`validity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `flags` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `flags` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vm_list`
--

DROP TABLE IF EXISTS `vm_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` bigint(20) unsigned NOT NULL,
  `hypervisor_host_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `host_id` (`host_id`),
  KEY `hypervisor_host_id` (`hypervisor_host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-06 14:01:46
