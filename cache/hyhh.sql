-- MySQL dump 10.13  Distrib 5.6.28, for Linux (x86_64)
--
-- Host: localhost    Database: hyhh
-- ------------------------------------------------------
-- Server version	5.6.28-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `us_data_field_role_permission`
--

DROP TABLE IF EXISTS `us_data_field_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_data_field_role_permission` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'Entity Type',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '复数排序',
  `field_role_permission_permission` varchar(128) NOT NULL DEFAULT '' COMMENT '权限名称',
  `field_role_permission_data` longblob COMMENT '权限序列化数据',
  PRIMARY KEY (`entity_type`,`entity_id`,`delta`),
  KEY `entity_type_id` (`entity_type`,`entity_id`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_data_field_role_permission`
--

LOCK TABLES `us_data_field_role_permission` WRITE;
/*!40000 ALTER TABLE `us_data_field_role_permission` DISABLE KEYS */;
INSERT INTO `us_data_field_role_permission` VALUES ('role',1,0,'/admin/hotnews/search','a:6:{s:5:\"title\";s:12:\"信息列表\";s:11:\"description\";s:12:\"信息列表\";s:6:\"module\";s:7:\"hotnews\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,1,'/admin/hotnews/add','a:6:{s:5:\"title\";s:12:\"新增信息\";s:11:\"description\";s:12:\"新增信息\";s:6:\"module\";s:7:\"hotnews\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,2,'/admin/wechat/user','a:6:{s:5:\"title\";s:12:\"会员列表\";s:11:\"description\";s:12:\"更新地区\";s:6:\"module\";s:6:\"wechat\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,3,'/admin/wechat/message','a:6:{s:5:\"title\";s:12:\"留言消息\";s:11:\"description\";s:12:\"留言消息\";s:6:\"module\";s:6:\"wechat\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,4,'/admin/wechat/setting','a:6:{s:5:\"title\";s:12:\"应用配置\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:6:\"wechat\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,5,'/admin/user/search','a:6:{s:5:\"title\";s:12:\"用户列表\";s:11:\"description\";s:12:\"用户列表\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,6,'/admin/user/add','a:6:{s:5:\"title\";s:12:\"添加用户\";s:11:\"description\";s:12:\"添加用户\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"2\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,7,'/admin/user/edit','a:6:{s:5:\"title\";s:12:\"编辑用户\";s:11:\"description\";s:12:\"编辑用户\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"3\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,8,'/admin/role/search','a:6:{s:5:\"title\";s:12:\"角色列表\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,9,'/admin/role/add','a:6:{s:5:\"title\";s:12:\"添加角色\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,10,'/admin/role/edit','a:6:{s:5:\"title\";s:12:\"编辑角色\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,0,'/admin/hotnews/search','a:6:{s:5:\"title\";s:12:\"信息列表\";s:11:\"description\";s:12:\"信息列表\";s:6:\"module\";s:7:\"hotnews\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,1,'/admin/hotnews/add','a:6:{s:5:\"title\";s:12:\"新增信息\";s:11:\"description\";s:12:\"新增信息\";s:6:\"module\";s:7:\"hotnews\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,2,'/admin/wechat/user','a:6:{s:5:\"title\";s:12:\"会员列表\";s:11:\"description\";s:12:\"更新地区\";s:6:\"module\";s:6:\"wechat\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,3,'/admin/wechat/message','a:6:{s:5:\"title\";s:12:\"留言消息\";s:11:\"description\";s:12:\"留言消息\";s:6:\"module\";s:6:\"wechat\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,4,'/admin/wechat/setting','a:6:{s:5:\"title\";s:12:\"应用配置\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:6:\"wechat\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,5,'/admin/user/search','a:6:{s:5:\"title\";s:12:\"用户列表\";s:11:\"description\";s:12:\"用户列表\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,6,'/admin/user/add','a:6:{s:5:\"title\";s:12:\"添加用户\";s:11:\"description\";s:12:\"添加用户\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"2\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,7,'/admin/user/edit','a:6:{s:5:\"title\";s:12:\"编辑用户\";s:11:\"description\";s:12:\"编辑用户\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"3\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,8,'/admin/role/search','a:6:{s:5:\"title\";s:12:\"角色列表\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,9,'/admin/role/add','a:6:{s:5:\"title\";s:12:\"添加角色\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,10,'/admin/role/edit','a:6:{s:5:\"title\";s:12:\"编辑角色\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}');
/*!40000 ALTER TABLE `us_data_field_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_field_config`
--

DROP TABLE IF EXISTS `us_field_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_field_config` (
  `id` int(10) unsigned NOT NULL COMMENT '自增主键',
  `entity_type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Entity Type',
  `field_name` varchar(128) NOT NULL DEFAULT '' COMMENT '字段名称',
  `data` longblob NOT NULL COMMENT '字段信息',
  `active` tinyint(1) NOT NULL COMMENT '是否启用',
  `locked` tinyint(1) NOT NULL COMMENT '是否锁定',
  PRIMARY KEY (`id`),
  KEY `entity_type` (`entity_type`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='字段配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_field_config`
--

LOCK TABLES `us_field_config` WRITE;
/*!40000 ALTER TABLE `us_field_config` DISABLE KEYS */;
INSERT INTO `us_field_config` VALUES (1,'role','field_role_permission','a:1:{s:7:\"columns\";a:2:{s:10:\"permission\";a:7:{s:11:\"description\";s:12:\"权限名称\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"data\";a:7:{s:11:\"description\";s:21:\"权限序列化数据\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0);
/*!40000 ALTER TABLE `us_field_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_hongbao`
--

DROP TABLE IF EXISTS `us_hongbao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_hongbao` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `relate_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联ID',
  `listid` varchar(50) NOT NULL COMMENT '微信单号',
  `billno` varchar(50) NOT NULL DEFAULT '' COMMENT '单号',
  `username` varchar(64) NOT NULL DEFAULT '' COMMENT '微信称呼',
  `headimgurl` varchar(255) NOT NULL DEFAULT '' COMMENT '微信头像',
  `wid` int(10) NOT NULL DEFAULT '0' COMMENT '微信用户内部ID',
  `openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信用户Openid',
  `amount` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '红包金额',
  `status` int(10) NOT NULL DEFAULT '0' COMMENT '0待发送,1发送成功,2用户已拆红包',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `wid` (`wid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信抽奖红包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_hongbao`
--

LOCK TABLES `us_hongbao` WRITE;
/*!40000 ALTER TABLE `us_hongbao` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_hongbao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_lottery`
--

DROP TABLE IF EXISTS `us_lottery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_lottery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `wid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '微信用户',
  `play_date` char(8) NOT NULL DEFAULT '' COMMENT '抽奖日期',
  `openid` varchar(128) NOT NULL DEFAULT '' COMMENT '微信Openid',
  `username` varchar(64) NOT NULL DEFAULT '' COMMENT '微信称呼',
  `headimgurl` varchar(255) NOT NULL DEFAULT '' COMMENT '微信头像',
  `level` int(4) NOT NULL DEFAULT '0' COMMENT '抽中等级',
  `amount` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '抽中金额',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '游戏得分',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT '0未中奖,1中奖未领取,2已领取,3发送成功,4发送失败,5处理中',
  `is_read` int(4) NOT NULL DEFAULT '0' COMMENT '1为已读',
  `remark` text COMMENT '信息',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_wid_play_date` (`wid`,`play_date`),
  KEY `idx_level` (`level`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_lottery`
--

LOCK TABLES `us_lottery` WRITE;
/*!40000 ALTER TABLE `us_lottery` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_lottery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_relation_user_roles`
--

DROP TABLE IF EXISTS `us_relation_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_relation_user_roles` (
  `uid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`uid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_relation_user_roles`
--

LOCK TABLES `us_relation_user_roles` WRITE;
/*!40000 ALTER TABLE `us_relation_user_roles` DISABLE KEYS */;
INSERT INTO `us_relation_user_roles` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `us_relation_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_roles`
--

DROP TABLE IF EXISTS `us_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_roles` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色rid',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '角色名称',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  PRIMARY KEY (`rid`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_roles`
--

LOCK TABLES `us_roles` WRITE;
/*!40000 ALTER TABLE `us_roles` DISABLE KEYS */;
INSERT INTO `us_roles` VALUES (1,'系统管理员',1),(2,'测试人员',2);
/*!40000 ALTER TABLE `us_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_shake`
--

DROP TABLE IF EXISTS `us_shake`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_shake` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(255) DEFAULT '' COMMENT '标题',
  `summary` varchar(255) DEFAULT '' COMMENT '摘要',
  `preview` varchar(255) DEFAULT '' COMMENT '图片',
  `opentime` int(10) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `timeout` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '游戏总时间',
  `status` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '0删除,1未开始,2进行中,3结束',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='摇一摇游戏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_shake`
--

LOCK TABLES `us_shake` WRITE;
/*!40000 ALTER TABLE `us_shake` DISABLE KEYS */;
INSERT INTO `us_shake` VALUES (1,'瑞好年会疯狂摇大奖：2/15/2016 16:43','开始游戏','',1455525787,30,3,1455525783,1455525783),(2,'瑞好年会疯狂摇大奖：2/15/2016 16:45','开始游戏','',1455525922,30,3,1455525918,1455525918);
/*!40000 ALTER TABLE `us_shake` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_shake_score`
--

DROP TABLE IF EXISTS `us_shake_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_shake_score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `shake_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动ID',
  `wid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `username` varchar(64) DEFAULT '' COMMENT '用户名',
  `headimgurl` varchar(255) DEFAULT '' COMMENT '头像',
  `score` int(10) DEFAULT '0' COMMENT '得分',
  `status` int(10) DEFAULT '1' COMMENT '1有效,0无效',
  `created` int(10) DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_shake_id_score` (`shake_id`,`status`,`score`),
  KEY `idx_shake_id_wid` (`shake_id`,`wid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='摇一摇记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_shake_score`
--

LOCK TABLES `us_shake_score` WRITE;
/*!40000 ALTER TABLE `us_shake_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_shake_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_snake`
--

DROP TABLE IF EXISTS `us_snake`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_snake` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `wid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '微信用户',
  `play_date` char(8) NOT NULL COMMENT '玩游戏日期',
  `play_times` int(4) NOT NULL DEFAULT '0' COMMENT '已玩次数',
  `present_times` int(4) NOT NULL DEFAULT '0' COMMENT '赠送次数',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天最高分',
  `last_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后得分',
  `is_share` int(1) NOT NULL DEFAULT '0' COMMENT '默认0未分享,1为分享',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_wid_play_date` (`wid`,`play_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='贪吃蛇游戏记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_snake`
--

LOCK TABLES `us_snake` WRITE;
/*!40000 ALTER TABLE `us_snake` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_snake` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_snake_score`
--

DROP TABLE IF EXISTS `us_snake_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_snake_score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `wid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户',
  `score` int(10) unsigned DEFAULT '0' COMMENT '得分',
  `ip` varchar(50) DEFAULT '' COMMENT 'ip',
  `token` varchar(50) DEFAULT '' COMMENT 'token',
  `play_date` varchar(8) DEFAULT '' COMMENT '日期',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `wid` (`wid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='贪吃蛇游戏分数记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_snake_score`
--

LOCK TABLES `us_snake_score` WRITE;
/*!40000 ALTER TABLE `us_snake_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_snake_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_snake_token`
--

DROP TABLE IF EXISTS `us_snake_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_snake_token` (
  `wid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '微信用户',
  `token` varchar(32) NOT NULL DEFAULT '' COMMENT '令牌',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发令时间',
  `is_deleted` int(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否失效 1为失效',
  PRIMARY KEY (`wid`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='贪吃蛇游戏令牌';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_snake_token`
--

LOCK TABLES `us_snake_token` WRITE;
/*!40000 ALTER TABLE `us_snake_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_snake_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_snake_top`
--

DROP TABLE IF EXISTS `us_snake_top`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_snake_top` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `wid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '微信用户',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最高得分',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `wid` (`wid`),
  KEY `score` (`score`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='贪吃蛇游戏排行榜';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_snake_top`
--

LOCK TABLES `us_snake_top` WRITE;
/*!40000 ALTER TABLE `us_snake_top` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_snake_top` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_user`
--

DROP TABLE IF EXISTS `us_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'UID',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT 'username',
  `password` varchar(128) NOT NULL DEFAULT '' COMMENT 'password',
  `uuid` varchar(64) NOT NULL DEFAULT '' COMMENT '唯一uuid',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '显示昵称',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `sex` enum('M','F','U') NOT NULL DEFAULT 'U' COMMENT '性别',
  `status` int(4) NOT NULL DEFAULT '1' COMMENT '状态 1正常,2锁定',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `accessed` int(10) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_user`
--

LOCK TABLES `us_user` WRITE;
/*!40000 ALTER TABLE `us_user` DISABLE KEYS */;
INSERT INTO `us_user` VALUES (1,'root','$S$376cd8a9046782aa8208396d47aaf067faeb5a8ce0379cf1af372d40fc01c','root','15221816172','root','','M',1,1415939223,0,1497879337),(2,'test','$S$431e767eac635914b12466212aecc6f2ba54209b4039dd1e0317e17553d5a','fb4b91ec-6ea3-4fd9-8302-2d4b777abec4','15221816172','test','','M',1,1497873328,1497873328,1497879328);
/*!40000 ALTER TABLE `us_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_variables`
--

DROP TABLE IF EXISTS `us_variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_variables` (
  `name` varchar(128) NOT NULL,
  `value` longtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='variables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_variables`
--

LOCK TABLES `us_variables` WRITE;
/*!40000 ALTER TABLE `us_variables` DISABLE KEYS */;
INSERT INTO `us_variables` VALUES ('wechat_access_token0','a:2:{s:5:\"token\";s:117:\"zczlsPigKm_nnplY1m8qUdWONqXgnmqMVKMl1OxrYKQ5aJjW7OOInVhNpG0H0N2k-f8fYRGWtt-zM7-JNmvkvID10hWExMFbALPgZxZU5s4ZRLgABAQIC\";s:7:\"expired\";i:1453278026;}'),('wxconfig','a:10:{s:4:\"type\";s:1:\"2\";s:4:\"name\";s:4:\"URMS\";s:5:\"appid\";s:18:\"wx41d5b159f1724cd3\";s:9:\"appsecret\";s:32:\"9de4177d4255989b6c22aef90c0db256\";s:5:\"token\";s:16:\"berule_urm_token\";s:6:\"aeskey\";s:43:\"xcJxWQOUKZ4IaN0l96dj9S3BSeOSO0futzM34jiV4Pb\";s:11:\"callbackurl\";s:29:\"http://www.urms.cn/api/wechat\";s:6:\"mch_id\";s:0:\"\";s:7:\"pay_key\";s:0:\"\";s:7:\"options\";a:1:{s:4:\"menu\";s:809:\"{\r\n     \"button\":[\r\n     {	\r\n            \"type\":\"view\",\r\n            \"name\":\"解决方案\",\r\n            \"url\":\"http://www.berule.com\"\r\n      },\r\n      {\r\n           \"name\":\"微信测试\",\r\n           \"sub_button\":[\r\n           {	\r\n               \"type\":\"view\",\r\n               \"name\":\"微站官网\",\r\n               \"url\":\"http://www.berule.com\"\r\n            },\r\n            {\r\n               \"type\":\"view\",\r\n               \"name\":\"游戏试玩\",\r\n               \"url\":\"http://www.berule.com\"\r\n            },\r\n            {\r\n               \"type\":\"view\",\r\n               \"name\":\"活动发布\",\r\n               \"url\":\"http://www.berule.com\"\r\n            }]\r\n       },\r\n       {	\r\n            \"type\":\"view\",\r\n            \"name\":\"关于我们\",\r\n            \"url\":\"http://www.berule.com\"\r\n       }\r\n       ]\r\n }\";}}'),('wx_user_refresh_token','s:32:\"107465343ae2ef736fd7c27e6951c07f\";');
/*!40000 ALTER TABLE `us_variables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_wx_app_info`
--

DROP TABLE IF EXISTS `us_wx_app_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_wx_app_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `wx_app_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '微信应用ID',
  `name` varchar(50) DEFAULT '0' COMMENT '应用名称',
  `image` varchar(255) DEFAULT '0' COMMENT '应用Logo',
  `status` int(10) DEFAULT '0' COMMENT '状态1正常 0停用',
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_wx_app_id_status` (`wx_app_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信应用';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_wx_app_info`
--

LOCK TABLES `us_wx_app_info` WRITE;
/*!40000 ALTER TABLE `us_wx_app_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_wx_app_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_wx_token`
--

DROP TABLE IF EXISTS `us_wx_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_wx_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `wx_app_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '企业号应用id',
  `access_token` varchar(512) NOT NULL DEFAULT '0' COMMENT 'access_token',
  `expires_at` int(10) NOT NULL DEFAULT '0' COMMENT '有效截止时间',
  PRIMARY KEY (`id`),
  KEY `idx_wx_app_id` (`wx_app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信应用access_token';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_wx_token`
--

LOCK TABLES `us_wx_token` WRITE;
/*!40000 ALTER TABLE `us_wx_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `us_wx_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `us_wxuser`
--

DROP TABLE IF EXISTS `us_wxuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `us_wxuser` (
  `wid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'wid',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT 'username',
  `openid` varchar(64) NOT NULL DEFAULT '' COMMENT 'openid',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT 'nickname',
  `password` varchar(128) DEFAULT '' COMMENT 'password',
  `unionid` varchar(64) DEFAULT '' COMMENT '唯一unionid',
  `phone` varchar(64) DEFAULT '' COMMENT '手机',
  `city` varchar(20) DEFAULT '' COMMENT '城市',
  `province` varchar(20) DEFAULT '' COMMENT '省份',
  `country` varchar(20) DEFAULT '' COMMENT '国家',
  `headimgurl` varchar(500) DEFAULT '' COMMENT '头像',
  `language` varchar(50) DEFAULT '' COMMENT '用户使用语言',
  `sex` int(4) NOT NULL DEFAULT '0' COMMENT '性别 1男性,2女性,0未知',
  `lng` float(10,7) DEFAULT '0.0000000' COMMENT '经度',
  `lat` float(10,7) DEFAULT '0.0000000' COMMENT '纬度',
  `zoom` float(10,7) DEFAULT '0.0000000' COMMENT '精度',
  `subscribe` int(4) NOT NULL DEFAULT '0' COMMENT '状态0未知,1关注,2取消关注',
  `subscribe_time` int(10) NOT NULL DEFAULT '0' COMMENT '关注时间',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `accessed` int(10) NOT NULL DEFAULT '0' COMMENT '最后打开时间',
  PRIMARY KEY (`wid`),
  UNIQUE KEY `openid` (`openid`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='微信关注用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_wxuser`
--

LOCK TABLES `us_wxuser` WRITE;
/*!40000 ALTER TABLE `us_wxuser` DISABLE KEYS */;
INSERT INTO `us_wxuser` VALUES (1,'肖棨晟-美洛舒适家','oMAPGjmLRgxLcFbipgz_2xMuVJ1k','肖棨晟-美洛舒适家','','','','江北','重庆','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8UicJ6iaxgIu4psPXrnHJZt1JvwWYSwCSkeSdpnMcaSwsyQUeXpoU2waUm2R2xLa7ZcAh1NGsC0PraA/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447395622,1453270959,1453270959,1453270959),(2,'机智的小君','oMAPGjtvZFdsfyh8dro92CbbxsWQ','机智的小君','','','','保定','河北','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8UDXIDKDicVAyqMxhIU9GL9w3ic0yxMf5zStzCcO2BoHqAq4lxice3G3oVkTbyteNAqEE56gYm1p8l5A/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1416971881,1453270959,1453270959,1453270959),(3,'Murphy','oMAPGjitN9TPD60LVkj3YzrC_e78','Murphy','','','','徐汇','上海','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XrFjjEzJJRh9csX2fLOFHxU1JmyEO25PSsPYwbAueznm8QTadrXuS7Lyyryyxkzz4icsMGKegQk4Q/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1446628842,1453270959,1453270959,1453270959),(4,'雷波','oMAPGjk39xvn4n1osn1splTr_E5I','雷波','','','','','河北','中国','http://wx.qlogo.cn/mmopen/Q3auHgzwzM6sz0PSvV0mGVoyt8WhlibarF5rmazAyiaXdYibZeqaP8WOth7E2ZeiaQBCoeQUF6s6wIghb3S76kQOiaQ77yZeqJ0LicFX87kFsVaEY/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447206242,1453270959,1453270959,1453270959),(5,'雨下的天空','oMAPGjln_5lcr7QqJ9cjL970iK9I','雨下的天空','','','','上饶','江西','中国','http://wx.qlogo.cn/mmopen/PiajxSqBRaELrM9VoPF2MSkmENmhATWibdnwzjSHZp8uXwGx4s9skicZUY5eg9Y4LpbvBB1Ron5eaCA501SCXMKLA/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447212470,1453270960,1453270960,1453270960),(6,'刘淑粉','oMAPGjttILegtbC8qj3O6gprlznc','刘淑粉','','','','许昌','河南','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLBIb9OibdWiacGAl3gTRukuBPuBVdxatib80ehrs4FZeFxYB6NNXL1Y7FibowR6HdXEp4abRugSUEetiaA/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447204078,1453270960,1453270960,1453270960),(7,'Rebekah','oMAPGjnoLMi28EMpNtInnTi5VEws','Rebekah','','','','保定','河北','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8Vvur0lhhy7ofxicKBI36IllvLDibQKtAJUiaq1EZCFbTuhfwJDtyUibUzzHeaYbicgEXdj0WXPia3LEhOA/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1417270350,1453270960,1453270960,1453270960),(8,'向东流','oMAPGjoqfV3DjkJu7z03C34If2Jo','向东流','','','','保定','河北','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLCEk78NvxqJsVodXXTzdFq6v4Wrbib5nKRMgMqe18lv5ibY6hXzzMZyeUDZglyA0KdfdQ3oKRicIcBsg/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1419305855,1453270960,1453270960,1453270960),(9,'你','oMAPGjr1TERa_hAKt-Fuxa1eumlE','你','','','','','','泽西岛','http://wx.qlogo.cn/mmopen/ajNVdqHZLLC2QFCib7naaMicMaZHe8bHK2CfF6gv1iabXU70DekmOvicIcSypC2rCaxfTiaIMvJRlNghC5W03n3BjnA/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447591818,1453270960,1453270960,1453270960),(10,' Marc','oMAPGjpwbTUr8p9si0GYJ8qAIjDI',' Marc','','','','迈阿密','佛罗里达','美国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLCLUdicS4U2aGWvz5GhUT5ia9OFkDJnSicOlWU4bFpQRukKtFib8zbzfZRqBBSwmlj6XHV9fqIzuDpAxQ/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1446629001,1453270961,1453270961,1453270961),(11,'see','oMAPGjiXz8qbFRB9o5dyICXis7o8','see','','','','南阳','河南','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLByqQgviauC20MdAyBicMXn8w4icEfYRXYVwZ3Q1FraknXkicus6A8O9H7dL6pMgjJYu5WbibP8vxUvL4Q/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447205204,1453270961,1453270961,1453270961),(12,'遺忘的季節','oMAPGjpROLMbdRw-pdiHrp_BZuOs','遺忘的季節','','','','湛江','广东','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicdjZPMNyWmARvkcLMcpStfuJZEqseoMIClVxBibTQRnNX05hU6eicceuZX2w57UvSNxQf8oVD1AuPV0Q6VIyJ3tEM/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1446629291,1453270961,1453270961,1453270961),(13,'范','oMAPGjo_owNtLmkBeavjYN8L2dPM','范','','','','黄浦','上海','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLBNXZdwXlriaSjOo4ld4jgndTzZnquoNtZaKrDbeg2oAq4LGVmDkAibjoyEsSLvtlicic7BsZ9hnRMK8w/0','zh_CN',0,0.0000000,0.0000000,0.0000000,1,1446645448,1453270961,1453270961,1453270961),(14,'Kevin??罗','oMAPGjtju0eXTqWVNnlawHVwJtNA','Kevin??罗','','','','闵行','上海','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLAYsibWZ7pmb2VWmzD5b5Vm268KSvaibeXQyC5pfmjicwrUbXmJiaxtLiaLXic9CjZT58S2erPwTUn0n3Pg/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1446630091,1453270962,1453270962,1453270962),(15,'鹿鸣','oMAPGjlnScTILTA2bNzQQ1vyIuOE','鹿鸣','','','','','','','http://wx.qlogo.cn/mmopen/PiajxSqBRaEKpiahggp9OicfGTw28JNZtAvKoya6nl9BJImZt4TUlG1BeMMCibz3yBxoqRhUrsyibgxFbM3ytjcoqpg/0','zh_CN',0,0.0000000,0.0000000,0.0000000,1,1447208776,1453270962,1453270962,1453270962),(16,'补课刚回家','oMAPGjpjGTuBOVkv7wL29hEcCf7I','补课刚回家','','','','江门','广东','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLBc0RIukmeorj2C9iaokESHFicfqCKamYvkadd9FfqTiczFea1ictfa31U0u4iaqaRldeibvWHRUeJoZAGQ/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447393481,1453270962,1453270962,1453270962),(17,' Allen ','oMAPGjn76OIws9wrhCa2Sc8kUCW4',' Allen ','','','','','上海','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8VcAib3bia6s1x5icXJz8EAvG1DyZhFamsoRdf6n6F6dGJUyy3Uxv0PW3dQkUgmXVB6n6GowibJA2Skbw/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447393818,1453270962,1453270962,1453270962),(18,'晏娟','oMAPGjrG37b3DRwLQXvE1pdOoR5w','晏娟','','','','武汉','湖北','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO3KtnYibwzTG3dAkcajhSibibn0icsMwEdR5jzDRFMFqUUCQBtrWZrKTmpFic0onomSskwEsuEnB2gqbicQ/0','zh_CN',0,0.0000000,0.0000000,0.0000000,1,1447211294,1453270962,1453270962,1453270962),(19,'小可','oMAPGjnwxgftmWrPieRgyGyydIqU','小可','','','','洛阳','河南','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicdehhITxDlYIHgFSduu2GaEYDdgh0qicxhic50Gk6Is7pVs1yibwvcxve9yDVPuF5kL7mEiafHZEaugjw/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447212819,1453270963,1453270963,1453270963),(20,'za','oMAPGjszG3y1XbU6r7CHRcJJlttU','za','','','','芜湖','安徽','中国','http://wx.qlogo.cn/mmopen/PiajxSqBRaEJCJbicLTdgQeNoMU0NttMmtSd5aRAnGDd7jwoRbHEPwtn2ff7pnNTic51MyLwopnbxJwps8tA7PNHA/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447209445,1453270963,1453270963,1453270963),(21,'sam wilson （卫森）','oMAPGjpnWYNo7iRk7bldnEpLadrc','sam wilson （卫森）','','','','南京','江苏','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO2icBUIWW6CVt0icv2qNH0UMG9GS4aaWVFjibvgoOqv4cXnYC66PnjbicKZqPXejAseLPibBoiag2Ng76b7hkkUWO7vGia/0','en',1,0.0000000,0.0000000,0.0000000,1,1446801300,1453270963,1453270963,1453270963),(22,'A采暖有难题，找我没问题1383914036','oMAPGjoYW0Q7MekLm1FL0Tlss-FY','A采暖有难题，找我没问题1383914036','','','','焦作','河南','中国','http://wx.qlogo.cn/mmopen/PiajxSqBRaEL5UDONlvDNTOar6JW51mAWicyMjkVODJmHdY4I3z3wRjvuFb7c5bJcC61Jc40keluAPticxKC15QSb7oic6YylK7MVL2SR8aFpYQ/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447206154,1453270963,1453270963,1453270963),(23,'鱼','oMAPGjn17ALMtmi8oRQW-Bmjk0oA','鱼','','','','哈尔滨','黑龙江','中国','http://wx.qlogo.cn/mmopen/PiajxSqBRaEKBpefbPPreEf6iabTW9CoGFa0LNDPTickgt1FpwuIB3TmuqSgJhL3qPP6XyUFEaibict7VgZ6XlVXPAw/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447055102,1453270963,1453270963,1453270963),(24,'loveqzhi','oMAPGjpTGlGIF8sUdbPpVi_Mb0CM','loveqzhi','','','','浦东新区','上海','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XepH0A95h54SyoGIXeF3XUBQmWHuL5Sgolm2UibJbD4ibpUUIMXCGbVjYMOXExShrJkys1ox4cIFMw/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447128896,1453270964,1453270964,1453270964),(25,'罗丹汐 ?','oMAPGjmzAvkByH0wNL3MJ0YiyATc','罗丹汐 ?','','','','','重庆','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLBBwhlh2vpichJtxDascOIiaTaNMzyyHXUiblYnZQ7wTF3d7lQI8AucgYTqJ58KHJalo4dyBibN0v0iaHQ/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447396015,1453270964,1453270964,1453270964),(26,'赵法猛','oMAPGjuK_3IZgpUh8YsFAy5MrPYA','赵法猛','','','','济南','山东','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLAOtNJjRn920e26kjia39KFPzbnUK3ia9ELffNiafOibicc5pIsJ0swia4VzUibe8QTE9A230ycpS19bibv5g/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447211088,1453270964,1453270964,1453270964),(27,'Soll、小夕     ‍微信超級會員','oMAPGjuU47-DDmz5q9p6zZnR6b5A','Soll、小夕     ‍微信超級會員','','','','驻马店','河南','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8W8pxM7jia8MznKypraclFmmrkqialGqsIp3jwDibEQOOcFBIelGhVnzwovicgsuBgRvicSQicicnZ3HIa6A/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447398670,1453270964,1453270964,1453270964),(28,'海燕','oMAPGjiIScmO_OzaikJPdjtsyn8k','海燕','','','','长沙','湖南','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRrmJ5LGbIUOwowaE8uZ4jbDOI15oibJy84ZkNaGBeWSsGrdtZWXF0FR7U50oYNjW0HqoAu3p5sB33esWIzxgj2f/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447250226,1453270965,1453270965,1453270965),(29,'Francesco','oMAPGjozLAj04edGI6rxBlnqo2Ac','Francesco','','','','','上海','中国','http://wx.qlogo.cn/mmopen/PiajxSqBRaEKwArXjsn0WXibibviaIOhzQaRiaYxgo7niaibzZZZxuxia1kHZkhUagasmQ1xyAIsdLMvlkOVzuicnjR8EIg/0','it',1,0.0000000,0.0000000,0.0000000,1,1447062747,1453270965,1453270965,1453270965),(30,'张军梅','oMAPGjnat58g6Bi4Vrk8l7ddSWx0','张军梅','','','','徐汇','上海','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO3dztgYWSvGah8icb9OYeg4sszeciaEhe4QWMmHnEVaENo7Vth1aM1Gd5dPHkKrqo3PiasLmicbDPVLtQ/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447028657,1453270965,1453270965,1453270965),(31,'王永乐','oMAPGjgsp0FT3HqXf_ZDu4PAV2wk','王永乐','','','','青岛','山东','中国','http://wx.qlogo.cn/mmopen/Q3auHgzwzM5RDeb3JeLT4XejLdyM4wBVtW6wISnBwdKqcytoq3c7LV09Bd210sAN1BWRZmD5lW8aCoDMBj5YDg/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447060947,1453270965,1453270965,1453270965),(32,'王冬艳','oMAPGjnWbEyQCC-aH-nLwlzkM-ss','王冬艳','','','','','','','http://wx.qlogo.cn/mmopen/INk4JvWfe8VhI6bbvlZiapgvyp7AxuoQct5NqzwDFyf1QPz0Cph5vSpEBn7EVzGwQRicicpj0ia67k1xZFrOzTDADg/0','zh_CN',0,0.0000000,0.0000000,0.0000000,1,1417137868,1453270965,1453270965,1453270965),(33,'A米粒儿','oMAPGjr-pzLFyS7-4ahkt0Yc5KFQ','A米粒儿','','','','郑州','河南','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XKHH691pOnv83Z8xCTucaKsUdYqM11LmDjsDt7N2n7OfL8o3VSpet0QLBLGg6OCFQHVFaTibniakJw/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447507375,1453270966,1453270966,1453270966),(34,'毛浩','oMAPGjsPvDUuiZFTNX0V6xfSKpYo','毛浩','','','','奉节','重庆','中国','http://wx.qlogo.cn/mmopen/PiajxSqBRaEK35hlVN5HoCvhV8SJfAnTicrG71akqfGrDAj8RxicfZdw946WyPVWNauIV0sZZ58k4ZDUDwAxfollw/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447395798,1453270966,1453270966,1453270966),(35,'土豆是我的最爱','oMAPGjgjs5nL_GcrPXWL6g8X7I4A','土豆是我的最爱','','','','保定','河北','中国','http://wx.qlogo.cn/mmopen/ajNVdqHZLLC0sTa7FEIpp0G8QN1hX0nwtyg37ZlovlY00hEW0ocPlVj2dg9EPbrzQ5H11zsnbayOuSyxVibk6Zg/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1419292810,1453270966,1453270966,1453270966),(36,'冰凌泡沫','oMAPGjhsSXj9JisonFUFhP4x7S2Q','冰凌泡沫','','','','杭州','浙江','中国','http://wx.qlogo.cn/mmopen/PiajxSqBRaEIaSe4X0Pu0icbYhluaGkuuE78SkmfPeqZeb4vh8pAmxdbr7b6NhvBr9QDZ4Xic0oTgTGkAX3zCAMOA/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447205541,1453270966,1453270966,1453270966),(37,'余双双—绿羽17705819180','oMAPGjsuRHwCAMEJr2XJE92Sawjg','余双双—绿羽17705819180','','','','松江','上海','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnSibOv0mgDKiaQylIJibrA1wK67F6q4AGXbnwVjWELKW4P7GU3D5U9u8hO7C9pcdwIrNxZURKU4HzdIbNuAWA7s5Jz/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447393671,1453270966,1453270966,1453270966),(38,'张小妮','oMAPGjsyUQLJVbMQ8wtfgBxG_Ojs','张小妮','','','','许昌','河南','中国','http://wx.qlogo.cn/mmopen/3V8OmPwsqZIOoVh6f5r2eRYPhKibJtaKB1moxDHIdzAeicnFjgX3jm5gWEQWLfuIiajm1QF4AVKM2cMsTXesjPL2zcg1xfhV3iay/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447204388,1453270967,1453270967,1453270967),(39,'nicole','oMAPGjmQ-RaeD4C7qGDyiAUw1um4','nicole','','','','苏州','江苏','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhU0oMDyPpJ4acqGSXjwC1eKYIYRV6OB4gxOcdIb4KyduptiamjqwATjJb1RY6zlZGVFFZ7zvVqp6A/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1446631837,1453270967,1453270967,1453270967),(40,'A德国瑞好地暖，军星地暖','oMAPGjvs1GO8fTyyISBYIfvOVD1g','A德国瑞好地暖，军星地暖','','','','郑州','河南','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5XEJeUW9qqJ9GGAm95MQicicyf9ndoATciaB5kBt5oM38lZict5ib7wZS3ugJM9mDS4zR95SgeqTNe2Bu/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447211176,1453270967,1453270967,1453270967),(41,'独钓寒江 ..','oMAPGjtrHy-8CKWZi7IX6EzQBOU4','独钓寒江 ..','','','','郑州','河南','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsGktW3goXONNa5oSTvFsDDdv4yzJe56k1Dic3T0mIiboG6jUicx5OPeiaO6JP4j8NLCAGrDD1hTpYz8W/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447213264,1453270968,1453270968,1453270968),(42,'唐金平','oMAPGjsbQvzMsc1fRAiwQBvpXF64','唐金平','','','','长春','吉林','中国','http://wx.qlogo.cn/mmopen/3V8OmPwsqZIOoVh6f5r2ebaDXxM0xfX0fOrkqUzcNTWzLGRIoic7OC4Vo1PRbHZvZKpVvT0wXbOXQn3QvJFtWV4F1M7P5HgrK/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1446630600,1453270968,1453270968,1453270968),(43,'曾帮连-美洛舒适家','oMAPGjparENc4EC4PK1gjLUfEZCI','曾帮连-美洛舒适家','','','','渝北','重庆','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnTfZoNkWUnspSD8rK1xPdg00nFclulAfwchu2GqVLFt6nZYFCr3CwYIbibJ4MibtHYtAW8wpKWyqrG6vEhWHOgusY/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447399056,1453270968,1453270968,1453270968),(44,'绿野仙踪','oMAPGjvKvGy8wJ9oAIC6GdAdBKSk','绿野仙踪','','','','苏州','江苏','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhcNciadialWNOxPAhl2YibgGCjNfU6f2yyo4aibZ72jXZ10XpLzRRecZLzgyfYc7GRqyWfbymyGo4DAf/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1446632972,1453270968,1453270968,1453270968),(45,'Nils Wagner','oMAPGjqmzUEa4xGwYtnjAT7qQc4Q','Nils Wagner','','','','','','','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsKvquBOwe6rnAuvGo2icDILmV9FMqHbgqicAUp7Ff88TE6ID0DIguibJgAGl68rC8iaSAKBbP3LFgn1b/0','en',0,0.0000000,0.0000000,0.0000000,1,1446714534,1453270968,1453270968,1453270968),(46,'小林','oMAPGjsJonhkcVSFVsm6Ywnob6to','小林','','','','','','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5V20YBhEFVTVv4dibrDAXpQ48VNn22q3sPWZwXGseJic3ATrfDWA353faSHKry4lvBIKHL3vVNF8lF/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447057507,1453270969,1453270969,1453270969),(47,'大金全效中央空调    杨波','oMAPGjhRcZo2eMx6BwK5YJRgtiPM','大金全效中央空调    杨波','','','','绍兴','浙江','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhX1fmmje4EbuibxeGCIZicAxrKhsFlx2yFfkSaRNBwgoknkU1ZWdd2B6HWJd1FHiaInicLVXhoa9F5EV/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447396433,1453270969,1453270969,1453270969),(48,'Lch','oMAPGjv3HN0zMlJ-BkLGJ53PAI_M','Lch','','','','武汉','湖北','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsFChlPGAYeCeHqPymJBxibfpbw3fOsy6XicRSI9966Gte2SFKFicbNicYMQtLJeEYo6qCD8y2oDhXCCf/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1433989506,1453270969,1453270969,1453270969),(49,'EileenTang(鄧伊琳)','oMAPGjrRLaSCrZUv2n-K9QEvSB-I','EileenTang(鄧伊琳)','','','','杨浦','上海','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XOdicmZibOWP7YnBoZV8ggnT4RZc6W8NUvibvocWT3gbOgmkf78QqcPtUTkVE7guuuRibLqlAINwbcu3ZFa3YkGnwk/0','en',2,0.0000000,0.0000000,0.0000000,1,1446798538,1453270969,1453270969,1453270969),(50,'小皮猪@丰扬舒适家','oMAPGjmIg3r-wt6i9pyO9G2TGz4k','小皮猪@丰扬舒适家','','','','','','赞比亚','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhYFChABF1FVibs6gwZTicTEYZiaUGRctEicacISDPueAq4xOnCwr1Dtr0zQDpic9pl1SklWCRVaq6qaNb/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447202406,1453270969,1453270969,1453270969),(51,'summersnow0218','oMAPGjqiPZfxZuWIVjFwG5Jc6IFA','summersnow0218','','','','静安','上海','中国','http://wx.qlogo.cn/mmopen/Q3auHgzwzM4H36nvru16ZsH1vVxzOKMZlWVOfg7vZvEATh4Bdvad6iay2iaM5cz07R2lIOBQFQJcTf9Fj9MP41E8kfPzKyQxRHng0Txz5eFjs/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1446802161,1453270970,1453270970,1453270970),(52,'红星','oMAPGjrqLnMlcO3N_6LWrnuV74yo','红星','','','','锦州','辽宁','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5Z1VIXnEhue6GJjDIjOGyFf2lVtHtuUEibL7WuF9QSfsWcibbSDEIehyqayQLKEBTAwo4trFvht01v/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447114737,1453270970,1453270970,1453270970),(53,'亚特尔地源科技东方城颐和湾李鑫','oMAPGjtjTaIsPocy5-y4od7FGHgI','亚特尔地源科技东方城颐和湾李鑫','','','','苏州','江苏','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO01ExOicSRiaDLm1RgicFicwW8ELXSzlvvCobuPnuU9PGyJwlScazaz76jibCHHwCichoIavxYyV34b2OaX6nibgQRicROB/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447209245,1453270970,1453270970,1453270970),(54,'Wlsvip','oMAPGjsStBwcoaYQa2xCEpBU8dgo','Wlsvip','','','','','','','http://wx.qlogo.cn/mmopen/3V8OmPwsqZIOoVh6f5r2eaUtOrn4BIKBiaxfbubQCe4O4UxqxH0U3iaS2zn3drQCfDUfbBkj8Pza70sEtCtas82ibhuqpuIoNhB/0','zh_CN',0,0.0000000,0.0000000,0.0000000,1,1415871707,1453270970,1453270970,1453270970),(55,'擎天冷暖','oMAPGjvJh8A3rMa3JMoZSdyVHrgY','擎天冷暖','','','','芜湖','安徽','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhdh4wJicjPZPX1JKjlw9Qw0t5c6o87WxvkhXdib77796vSZKOYLdbyUTtF331oPIwyAXNFzRonseuC/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447209587,1453270971,1453270971,1453270971),(56,'A-刘大辉','oMAPGjk8uRG0bj5U3pORE8mOZK9E','A-刘大辉','','','','江北','重庆','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5YRD4KJiacFajibHQgxPsdgGSicWP6M2ghufgOnRTfT2ALy3zxslibVicQ9FxeHowLWhbw3XhV3cx1JR7/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447401655,1453270971,1453270971,1453270971),(57,'ymx虾虾','oMAPGjlZFXwH5P-UnoBdLfagRQrQ','ymx虾虾','','','','合肥','安徽','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XOdicmZibOWP7UflevD4auib3bFGhZZvocFHzJlbHA7AeWkhajYMhib8HiaEfhpJQFGkeeIibWG7sHfak6skHa4Aupve/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1446629137,1453270971,1453270971,1453270971),(58,'你我他','oMAPGjg-apvRFx7gPhqvC35Mkcqw','你我他','','','','保定','河北','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5SicQFJUpcum7CZPh4YE7icuzqUMXwez6I219sCIPsricMCWYvSBECDT1f9yUPdQwWsEQbfWD0FhPv9/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1416743360,1453270971,1453270971,1453270971),(59,'湖北来福暖通设备有限公司刘涛','oMAPGjoIofLRRsu5T7TdGuZt1Fx8','湖北来福暖通设备有限公司刘涛','','','','十堰','湖北','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRZNkwQHibOcC9ISy1rYGKh3V0LjE1V2B26VLDgiaGWnpeuf1yKYzpEZ8ziaFQ0iadkRicecDic3x3RnEF47sqPEvHgby/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447202985,1453270971,1453270971,1453270971),(60,'傻小子','oMAPGjiaxjn1L6VvMAz46vtyEMgA','傻小子','','','','烟台','山东','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XOdicmZibOWP7atibfjgoYmLia3gaxMxWeXJLoRTrmWtwV2jRD2Xlnc8COJt3FrX7ianzvMM6IQv12okjsJicIXNXkibs/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447402763,1453270972,1453270972,1453270972),(61,'私人定制.纯手工雕刻.木立方卫浴','oMAPGjiChfZd9zTopRD78r6HCVN8','私人定制.纯手工雕刻.木立方卫浴','','','','许昌','河南','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsITicdQd13y2lpibHMKhLF9zOtlicHPGV4OxjEfU0q9F2mbGc5k1sg8cTUJjlF4ONOzFJXOibBmQTGpQ/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447400122,1453270972,1453270972,1453270972),(62,'禹州木立方卫浴专卖店刘高峰','oMAPGjkD9x6DBmv7wb0A0Sxyqya0','禹州木立方卫浴专卖店刘高峰','','','','许昌','河南','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5fG96kg18fGV7gM75JoJhX9I5aqAAoS1Cw3C2UknGDKeicHVniaopTyIclsia8HMse6kCXjEvCmlBuG/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447401272,1453270972,1453270972,1453270972),(63,'朵儿','oMAPGjhzblTcrTkMDOEyCEDmdcOE','朵儿','','','','','巴黎','法国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5W3J7iasEFQBvYq2T8GPRsczAtsOYF1AxN4sAxAgF65AO3IIuyMC4Yg4clvviaichr8bjQLlOB5o69W/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447592201,1453270972,1453270972,1453270972),(64,'康普楼宇陈林杰','oMAPGjk-tvU2-LlfGMkg-PPJHCIQ','康普楼宇陈林杰','','','','温州','浙江','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicfMZCt0htkpnNrgXYSul7KxPubHEv2iaibUzIhdvPyK3o0cFRxNQ4rkdbZ6zRU6hq8iaflUgo4hGt29AFevBcicAHm5/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447209876,1453270972,1453270972,1453270972),(65,'唐小倩_Tina','oMAPGjg3iILf6KmXgZ_GvGp_b54Y','唐小倩_Tina','','','','苏州','江苏','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5SraiceSoR6VKr8prF4xXwsk75TF2icKq7WzZUKzHAF9blHst0e4gvJMiamWib8FUHiaficVM9HPw2siccs/0','en',2,0.0000000,0.0000000,0.0000000,1,1446630414,1453270973,1453270973,1453270973),(66,'chenxingan','oMAPGjpgk7aVnpzi5QsO-NlHYdm0','chenxingan','','','','南京','江苏','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsFb0Jw6FEJ70zgw3qHj6RiaxybO7F2P7KB316q1HYf0BGlebg6VsictC5lYVjPmh02hrXap0XB8uld/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447209890,1453270973,1453270973,1453270973),(67,'三脚猫软智慧=林景明','oMAPGjpFIod2iIh1JFD8KMIExv3A','三脚猫软智慧=林景明','','','','黄浦','上海','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO2gRssiaRGLZiaBtt5TlBAbHGOA19KbTEytrb010ZFRk3ociawaqVyWFHOPdNIt9tr41XCg2z2387uCJYsOZgc9gkh/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1439787552,1453270973,1453270973,1453270973),(68,'直深','oMAPGjtA6JiGysXciLetel8--0v0','直深','','','','金华','浙江','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsPBz5GxN7tpSjEknFjuUAkoVKSHt2xDz7ibVte76r1WqYRdF0uzuBYP3a6JiamOYsZQRJLh0dtkjKn/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447213200,1453270973,1453270973,1453270973),(69,'剧中人','oMAPGjjIPNuYCBWrUWxX3LVqI304','剧中人','','','','杨浦','上海','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5beicgVjS4hFS7sJTgSXASbibrwFKniaW3VibLKVIMiblI8I3ptoPoBrdQVIGE9YFgYOghsZsAfBHTH52/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1445415475,1453270974,1453270974,1453270974),(70,'真寶兒','oMAPGjowWiaZPyExL1d_WYaJooVw','真寶兒','','','','济南','山东','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XOdicmZibOWP7ZGH7KKqLiah8iaicOe6TlEH71bp5HibeibfzaRrKRndpyqcS3P4qJrLGibcK1ZrXNITa8F4z5UrqO8TOg/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447202974,1453270974,1453270974,1453270974),(71,'徐浩','oMAPGjv3zjxARgHaiQKXKSwEVObE','徐浩','','','','嘉定','上海','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsDbTFNVWZGmdwlQoIIHica8oydqTsm5rsgKcdgsJ7OTyCJ9Z1ahIyrZRSaESNnPvKygsUmkyWiba8Q/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1446631947,1453270974,1453270974,1453270974),(72,'程晶晶?','oMAPGjoo1Przb4_T1b0rFrwuO8rk','程晶晶?','','','','黄冈','湖北','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8VSDrRbb1E38DsEfsRtbKBAOibiaviaO51vPibpDibN4iaePM5o3St7fBsn8KibqCiaDYLxGE4kSUHIyib594licDiaQUjmdTgUvRjFGszXPY/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447204190,1453270974,1453270974,1453270974),(73,'心底星','oMAPGjk3h5uLAug6EaEWeChEqW-w','心底星','','','','乌鲁木齐','新疆','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnStQhQyGOGaqmOazwz7LrJFNP8ZnzmGff2V2F2qPdLicxArFLzJ0RhNibdG8qf3AibiasoV1ibxjbCExpgD0vN5M5zSh/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1417698255,1453270974,1453270974,1453270974),(74,'eling','oMAPGjoVV7Co_98vqyyb2JmhACI4','eling','','','','浦东新区','上海','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsLT7fwq9j5s16euZjOxH0GrYmGjOuMOicGicVWLOxoe6dEWrUzLCIwLyl5wbkQuZSUogIZgWmgoeH9/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1446628998,1453270975,1453270975,1453270975),(75,'lily','oMAPGjlgjqOz_dUXJ6GecXfGGA7c','lily','','','','青浦','上海','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0VBxUJA6SvPeGtWPzJ6VwFLzJpuCib8sLmsHB4Ee8XobgAcChjuC9UWR5f7fo1K1MYNwP8TsR3jC1GWMjgKfTnW/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447068574,1453270975,1453270975,1453270975),(76,'⭐️⭐️⭐️','oMAPGjtZNCX_tfNzOpv5-FSZNlF8','⭐️⭐️⭐️','','','','金华','浙江','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicchNKJm0UVSdz8TWaW3LYBr2LlYzo7GbyIKiceQIyvERvZUAj2Ow1gaMXDXEIuHibFHBgiacTdyIE3ibD3fBQ4eu1LG/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1449937322,1453270975,1453270975,1453270975),(77,'子文陈','oMAPGjrZ6XRFxnrZiEyaOXpuC-1U','子文陈','','','','嘉定','上海','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5YKY12sOy0ZEtyntGUBD2BWPqMFLknCM2KP0qLibulIulnEevxZjMM6VWLoiadboycYudTpME1ohag/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1446544682,1453270975,1453270975,1453270975),(78,'独白','oMAPGjgOXklaFKKIJEatIAM6MqYU','独白','','','','洛阳','河南','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5UdibV7Y2ekia17SGkNRibo6zJBibicEF14ZI15DnvN7LML9u24YvicvZEFuKOAeWb1BgLHy0ycuFImH6p/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447212817,1453270975,1453270975,1453270975),(79,'AAAA鸿兴暖通-张奕明','oMAPGjmyaszA0oCDiIgkMQ6g7K1E','AAAA鸿兴暖通-张奕明','','','','郑州','河南','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5YcJz38CzdrGkr1qVhdeLT4WvzOPBpRoVYDoaS4AKqnyw70nEOdN7FbicJChrSOdntFDEhWvswGKd/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447210408,1453270976,1453270976,1453270976),(80,' 暖之郎张炎  15994066877','oMAPGjsyTFHK2mnZymd263W-Jg0M',' 暖之郎张炎  15994066877','','','','许昌','河南','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XOdicmZibOWP7eo6q98LQpmiaZXva2pTdxL9tb7KTqqvsAWkMHZhHnZ4lXQZfO4gKic5BRnTcwCINGgHqwAcEOQPqI/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447205582,1453270976,1453270976,1453270976),(81,'湘君','oMAPGjhw7Bl2FCim9_Joh520MvPw','湘君','','','','杭州','浙江','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhZvEgQ88UxX0GTQc0WjD8Taxaytp4h0FtajvT4Uc9Usdbkg2ole6vy6oreuJqEvVZCGynxfySgZj/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447403785,1453270976,1453270976,1453270976),(82,'美洛舒适家地暖小钟','oMAPGjlQNG_2I-CzCa9Jj2wpx46Y','美洛舒适家地暖小钟','','','','梁平','重庆','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRMhCY4AE45dTDYfafBRspld9qrN0kAgibZiamOuRWyJHtx4XaaenCW6byVvnxUUdvybLf1hQzgRsNuurEmW1oeM9/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447396840,1453270976,1453270976,1453270976),(83,'Jane Wang','oMAPGjmkVmheG7clEEf7V_uAgdqU','Jane Wang','','','','','江苏','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLheW0LhVVib9f2dQmehvaccRbrQl5jHGgSPkoUibJ11a3cGhcicRibn4Z9hEx4zTl6sribwh7gVaxDcYiaZ/0','zh_CN',0,0.0000000,0.0000000,0.0000000,1,1446628838,1453270976,1453270976,1453270976),(84,'雷才华 Mark','oMAPGjjd6TpAYGLDpGVMROphlilg','雷才华 Mark','','','','苏州','江苏','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5UAQiaMY0AfK4iaMKvicDYqOOh101ib6iaia48zAVYpazViapIBxvaYfR1iapT18YicaBGJicqpmdlQ7y6PFQU/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1446631710,1453270977,1453270977,1453270977),(85,'AAAAA新密德国瑞好地暖','oMAPGjn-cwELXeZWcHeejvUnMzfE','AAAAA新密德国瑞好地暖','','','','','','安道尔','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhc259M6KSL9vsIKeTTarc3KibMfr1J0HZdnyCkibnSCLIxQnibQdJh1TehbBib1y9N9oBYunWQ3nElq1/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447590022,1453270977,1453270977,1453270977),(86,'小小年纪','oMAPGjk_3btOpZAVsLmGwCuIgRQs','小小年纪','','','','江津','重庆','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsPvTNzOPM7RXSbl5dTIV6bRxbWhDnMINICwmfVZcLIiaksgiayEWAeKqDPyJlmbFNj0SswK8PiaUvgt/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447396763,1453270977,1453270977,1453270977),(87,'英国BAXl供暖','oMAPGjqU_BCDUMmazS868YeKRO_o','英国BAXl供暖','','','','武汉','湖北','中国','http://wx.qlogo.cn/mmopen/INk4JvWfe8XOdicmZibOWP7SLMXzSTfsV1PeTggiajFt7y3uYaRpQnlGvG3IufiaPLM3DVmE6qnia8eAFt1FfYpCvsmtpFsoe9iccM/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1447205311,1453270977,1453270977,1453270977),(88,'✨英♛雄✨','oMAPGjlAaz5hC84uFEO5X82zX7WM','✨英♛雄✨','','','','九龙坡','重庆','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO17UmxcRBZ6CuhYQOY7icT3sK1846FHKHD4PFvav6TxK0q7SKtjAQcBtSicfrAhgoTPnJSg1L1CLKsb4QoOKCoHEk/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447399105,1453270978,1453270978,1453270978),(89,'康普供暖•余振云','oMAPGjva23_lCiWCbP6j39gkzD40','康普供暖•余振云','','','','温州','浙江','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhUwxYXXqgWPSfdtsqGib7oX1GHdwkXrib70icibxflHqhLo8zwiceYxhot5jKzZgohtA6GBAQXPBwiaZGj/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447209711,1453270978,1453270978,1453270978),(90,'Chris ? ฏ๎๎๎๎╯','oMAPGjky9bUnoh4M650eXwh2zKeU','Chris ? ฏ๎๎๎๎╯','','','','','','百慕大','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsNmwzDic5pyciaqayf2CvibwyBBUMfQHqgBrqNvzlrLXkjicPhOLvRcSiceru4zlYe0mVGBglzGzAgIZm/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1414402120,1453270978,1453270978,1453270978),(91,'同样的中央空调地暖我们可以更节能','oMAPGjnwW20j6zO93fpFndjQWkC4','同样的中央空调地暖我们可以更节能','','','','','','','http://wx.qlogo.cn/mmopen/ajNVdqHZLLD2UlTfqhTsiaIRDx648Ew5Y5w1Pia9jgjk1UNcKNEB62QicKUql6auoJqOpnicPR8uicsicSIDtLXqK7JQbWbm4uC2fFdTFAKic6UczA/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447208714,1453270978,1453270978,1453270978),(92,'滁州擎天冷暖','oMAPGjvjNn6edcfj2xy6nQgxNcYA','滁州擎天冷暖','','','','滁州','安徽','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicejGHqeib02Q90EiblWlaZNH21sr47eAPBl0EFyWASb3vyrgGTQEBbuLlc717DPlp1QAXT8uw8tCia3cDjVpBAwQfp/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447205696,1453270978,1453270978,1453270978),(93,'李安磊 (Alex)','oMAPGjmnrhmJ-ZJmuL_2eN1ntWSI','李安磊 (Alex)','','','','纽约市','纽约','美国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5YUyJ8MibAPtBXicVo6Ip2cYrRvtf1X8lxJpJ2jlfOFtLCsRkq0l7bibDIJ5pDVricNI2uKKYibmtzCba/0','en',1,0.0000000,0.0000000,0.0000000,1,1446629002,1453270979,1453270979,1453270979),(94,'幽谷醉客','oMAPGjpdkYlbQDi-JEKHS8wwWUbw','幽谷醉客','','','','南京','江苏','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5dd6rUnKP40pauYFQ5z2yOzib6dJZkK6fQb7ZfgibI04wutC09UEAib2JP0AkFlrAmMpGYMRCmpdYcP/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447213750,1453270979,1453270979,1453270979),(95,'宁开东','oMAPGjoVE8FTaVT3jU8aU048HJjk','宁开东','','','','苏州','江苏','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhQkdRIaGqTR62zBQoUdG7fArI0Dp0PyKr3rYeQUX4SpkiaH8bHDDyJTdxibLYib6uzqUpeTGhcm2AVU/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447403736,1453270979,1453270979,1453270979),(96,'舒适100江怀宾','oMAPGjiqJ1ngNG-c_h2E4ur5_dHc','舒适100江怀宾','','','','商丘','河南','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnQrDibpibrkv5vSZRELuowIFcEO341nDtLOmzbicE2zIcm7oVxozjWnD6bwe6iaicksDNQInXRTSPDoRGjSpCJfKahhK/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447210011,1453270979,1453270979,1453270979),(97,'M','oMAPGjo4aEZVKgqtv8f5Q15LcZn4','M','','','','宝山','上海','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsJcibF4nG3R2NKj907q11pVaQOuF6q44ryIPGPLy7Dibl1AyfyWeLmf7Kkic7Th5WicmreJuud3bhfEO/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1428628688,1453270980,1453270980,1453270980),(98,'A谷鼎暖通☞邹旺成','oMAPGjrjeosxd2P23yGQkLpAzAUA','A谷鼎暖通☞邹旺成','','','','衢州','浙江','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhXiabzHtAaujLdPrCNrbjEQGKHGic6GXynqKYmicqficIuuKPrVoNJSPtZOWF0eESvBpmoeibAIxu7vX8/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447213451,1453270980,1453270980,1453270980),(99,'阳光_Yang','oMAPGjsH0xEZu0kH33OZlJPnYGVU','阳光_Yang','','','','徐汇','上海','中国','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhXVH72YagpXErAP9iboGkzCywHQSeh243Qd37DWmVMjtibOTQUwiaJty9UovOHjvUIa6pujSlDLplOV/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1446631319,1453270980,1453270980,1453270980),(100,'天际','oMAPGjqdA2oxd64T7ul9tjjlVcLE','天际','','','','杭州','浙江','中国','http://wx.qlogo.cn/mmopen/3V8OmPwsqZIOoVh6f5r2ea1jTtZQIPQtNReUwoKzVnDRFNOmlFFCsFKic9kQdX83kialicuHy1cFPYib6HK9bBjhAPSq4lC20bY0/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447208977,1453270980,1453270980,1453270980),(101,'戴琰','oMAPGjuYLr8h5Q_BRm_zPMXoIm3c','戴琰','','','','泰州','江苏','中国','http://wx.qlogo.cn/mmopen/72XtgOqOdO0iaNQbzC6mf5V0M7rsb5lSoUCTfTXWjeMBCeCJdfd8m12SDDaS5CAMibTlRylntsZ5YF5sZ1SqXZviajnibpGqDAgT/0','zh_CN',1,0.0000000,0.0000000,0.0000000,1,1447206953,1453270980,1453270980,1453270980),(102,'Emily','oMAPGjijpnmQXpBQbOVs7qNYvhbo','Emily','','','','杨浦','上海','中国','http://wx.qlogo.cn/mmopen/LfFribkZYNnRVhzH1lQBYsE5Eyo4wC27jw9E84kEwYibh6sia5bXW2zR2re9lCjZbQp85ibNl1m5eI5kpMp7iaDvs0LQnyDibcM1Zq/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1446430541,1453270981,1453270981,1453270981),(103,'向日葵是太阳的每一天笑脸','oMAPGjtJLJM85MLr-NYRtYDyjxXU','向日葵是太阳的每一天笑脸','','','','','','','http://wx.qlogo.cn/mmopen/131w7qPoTicd03pBmgfgLhSicGKgGAqjSrS1K5nicTcvdqbibyzK922O6uPRrGyeYCvEXf2fF2QsHcbYicXWPkSR2TibYwiapUaCuFy/0','zh_CN',0,0.0000000,0.0000000,0.0000000,1,1447395296,1453270981,1453270981,1453270981),(104,'安寂静岭@威廉公爵','oMAPGjp5T0QT4upKhbdfdSdXJ0nE','安寂静岭@威廉公爵','','','','','','所罗门群岛','http://wx.qlogo.cn/mmopen/LfFribkZYNnSI0viahbTm75sX9sEovGlJJyCibjWia3ze55xZf6lzSPfd2JveYiastrnwU8TC0Pz2FSo602WWHGOT7vjgUzbrOfVl/0','zh_CN',2,0.0000000,0.0000000,0.0000000,1,1448122664,1453270981,1453270981,1453270981);
/*!40000 ALTER TABLE `us_wxuser` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-19 21:44:02
