CREATE TABLE IF NOT EXISTS `us_snake` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	`wid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '微信用户',
	`play_date` CHAR(8) NOT NULL COMMENT '玩游戏日期',
	`play_times` INT(4) NOT NULL DEFAULT '0' COMMENT '已玩次数',
	`present_times` INT(4) NOT NULL DEFAULT '0' COMMENT '赠送次数',
	`score` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '当天最高分',
	`last_score` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最后得分',
	`is_share` INT(1) NOT NULL DEFAULT '0' COMMENT '默认0未分享,1为分享',
	`created` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
	`updated` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
	PRIMARY KEY (`id`),
	INDEX `idx_wid_play_date` (`wid`, `play_date`)
)
COMMENT='贪吃蛇游戏记录'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `us_snake_score` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	`wid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户',
	`score` INT(10) UNSIGNED NULL DEFAULT '0' COMMENT '得分',
	`ip` VARCHAR(50) NULL DEFAULT '' COMMENT 'ip',
	`token` VARCHAR(50) NULL DEFAULT '' COMMENT 'token',
    `play_date` VARCHAR(8) NULL DEFAULT '' COMMENT '日期',
	`created` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
	PRIMARY KEY (`id`),
	INDEX `wid` (`wid`)
)
COMMENT='贪吃蛇游戏分数记录'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `us_snake_token` (
	`wid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '微信用户',
	`token` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '令牌',
	`created` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发令时间',
	`is_deleted` INT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否失效 1为失效',
	PRIMARY KEY (`wid`, `token`)
)
COMMENT='贪吃蛇游戏令牌'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `us_snake_top` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	`wid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '微信用户',
	`score` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最高得分',
	`created` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
	`updated` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
	PRIMARY KEY (`id`),
	INDEX `wid` (`wid`),
	INDEX `score` (`score`)
)
COMMENT='贪吃蛇游戏排行榜'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `us_lottery` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	`wid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '微信用户',
	`play_date` CHAR(8) NOT NULL DEFAULT '' COMMENT '抽奖日期',
	`openid` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '微信Openid',
    `username` VARCHAR(64) NOT NULL DEFAULT '' COMMENT '微信称呼',
    `headimgurl` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '微信头像',
	`level` INT(4) NOT NULL DEFAULT '0' COMMENT '抽中等级',
	`amount` DECIMAL(6,2) NOT NULL DEFAULT '0.00' COMMENT '抽中金额',
	`score` INT(10) NOT NULL DEFAULT '0' COMMENT '游戏得分',
	`status` INT(4) NOT NULL DEFAULT '0' COMMENT '0未中奖,1中奖未领取,2已领取,3发送成功,4发送失败,5处理中',
	`is_read` INT(4) NOT NULL DEFAULT '0' COMMENT '1为已读',
	`remark` TEXT NULL COMMENT '信息',
	`created` INT(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
	`updated` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
	PRIMARY KEY (`id`),
	INDEX `idx_wid_play_date` (`wid`, `play_date`),
	INDEX `idx_level` (`level`, `status`)
)
COMMENT='抽奖表'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `us_hongbao` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	`relate_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '关联ID',
	`listid` VARCHAR(50) NOT NULL COMMENT '微信单号',
	`billno` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '单号',
    `username` VARCHAR(64) NOT NULL DEFAULT '' COMMENT '微信称呼',
    `headimgurl` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '微信头像',
	`wid` INT(10) NOT NULL DEFAULT '0' COMMENT '微信用户内部ID',
	`openid` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '微信用户Openid',
	`amount` DECIMAL(8,2) NOT NULL DEFAULT '0.00' COMMENT '红包金额',
	`status` INT(10) NOT NULL DEFAULT '0' COMMENT '0待发送,1发送成功,2用户已拆红包',
    `remark` VARCHAR(255) NULL DEFAULT '' COMMENT '备注',
	`created` INT(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
	`updated` INT(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
	PRIMARY KEY (`id`),
	INDEX `wid` (`wid`)
)
COMMENT='微信抽奖红包'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;