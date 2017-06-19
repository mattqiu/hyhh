

CREATE TABLE IF NOT EXISTS `us_shake` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	`title` VARCHAR(255) NULL DEFAULT '' COMMENT '标题',
	`summary` VARCHAR(255) NULL DEFAULT '' COMMENT '摘要',
	`preview` VARCHAR(255) NULL DEFAULT '' COMMENT '图片',
	`opentime` INT(10) NOT NULL DEFAULT '0' COMMENT '开始时间',
	`timeout` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '游戏总时间',
	`status` INT(10) UNSIGNED NOT NULL DEFAULT '1' COMMENT '0删除,1未开始,2进行中,3结束',
	`created` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
	`updated` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
	PRIMARY KEY (`id`),
	INDEX `status` (`status`)
)
COMMENT='摇一摇游戏'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `us_shake_score` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	`shake_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '活动ID',
	`wid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户ID',
	`username` VARCHAR(64) NULL DEFAULT '' COMMENT '用户名',
	`headimgurl` VARCHAR(255) NULL DEFAULT '' COMMENT '头像',
	`score` INT(10) NULL DEFAULT '0' COMMENT '得分',
	`status` INT(10) NULL DEFAULT '1' COMMENT '1有效,0无效',
	`created` INT(10) NULL DEFAULT '0' COMMENT '创建时间',
	`updated` INT(10) NULL DEFAULT '0' COMMENT '更新时间',
	PRIMARY KEY (`id`),
	INDEX `idx_shake_id_score` (`shake_id`, `status`, `score`),
	INDEX `idx_shake_id_wid` (`shake_id`, `wid`)
)
COMMENT='摇一摇记录'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB;


