CREATE DATABASE IF NOT EXISTS `com` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `com`;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(16) NOT NULL,
  `password` varchar(16) NOT NULL,
  `random` varchar(16) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  com.user 的数据：~1 rows (大约)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`username`, `password`, `random`) VALUES
	('aaa', 'aaaa', 'aaaaa');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

DROP TABLE IF EXISTS `客户表`;
CREATE TABLE IF NOT EXISTS `客户表` (
  `客户号` varchar(16) NOT NULL,
  `客户名` varchar(128) NOT NULL,
  `性别` varchar(4) DEFAULT NULL,
  `区域` varchar(50) NOT NULL,
  `行业` varchar(50) NOT NULL,
  `联系方式` varchar(20) NOT NULL,
  `集团` varchar(40) DEFAULT NULL,
  `违约情况` Integer DEFAULT 0,
  PRIMARY KEY (`客户号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  com.客户表 的数据：~3 rows (大约)
DELETE FROM `客户表`;
/*!40000 ALTER TABLE `客户表` DISABLE KEYS */;
INSERT INTO `客户表` (`客户号`, `客户名`, `性别`, `区域`, `行业`, `联系方式`, `集团`, `违约情况`) VALUES
	('1', '张三', '男', '北京', '学生', '110', 'HDU', 0),
	('2', '李四', '未', '杭州', '学生', '120', 'HDU', 0),
	('3', '王五', '女', '杭州', '学生', '130', 'AAA', 0);
/*!40000 ALTER TABLE `客户表` ENABLE KEYS */;

DROP TABLE IF EXISTS `违约风险原因表`;
CREATE TABLE IF NOT EXISTS `违约风险原因表` (
  `违约原因编号` varchar(16) NOT NULL,
  `违约原因` varchar(512) NOT NULL,
  `是否启用` Integer DEFAULT 1,
  PRIMARY KEY (`违约原因编号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  com.违约风险原因表 的数据：~7 rows (大约)
DELETE FROM `违约风险原因表`;
/*!40000 ALTER TABLE `违约风险原因表` DISABLE KEYS */;
INSERT INTO `违约风险原因表` (`违约原因编号`, `违约原因`, `是否启用`) VALUES
	('1', '6 个月内，交易对手技术性或资金等原因，给当天结算带来头寸缺口 2 次以上', 1),
	('2', '未能按照合约规定支付或延期支付利息，本金或其他交付义务（不包括在宽限期内延期支付）', 1),
	('3', '6 个月内因各种原因导致成交后撤单 2 次以上', 1),
	('4', '关联违约：如果集团（内部联系较紧密的集团）或集团内任一公司（较重要的子公司，一旦发生违约会对整个集团造成较大影响的）发生违约，可视情况作为集团内所有成员违约的触发条件', 1),
	('5', '发生消极债务置换：债务人提供给债权人新的或重组的债务，或新的证券组合、现金或资产低于原有金融义务；或为了债务人未来避免发生破产或拖欠还款而进行的展期或重组', 1),
	('6', '申请破产保护，发生法律接管，或者处于类似的破产保护状态', 1),
	('7', '在其他金融机构违约（包括不限于：人行征信记录中显示贷款分类状态不良类情况，逾期超过 90 天等），或外部评级显示为违约级别', 1);
/*!40000 ALTER TABLE `违约风险原因表` ENABLE KEYS */;

DROP TABLE IF EXISTS `违约认定人工审核表`;
CREATE TABLE IF NOT EXISTS `违约认定人工审核表` (
  `违约审核编号` varchar(16) NOT NULL,
  `客户号` varchar(16) NOT NULL,
  `违约原因编号` varchar(16) NOT NULL,
  `严重程度` varchar(2) NOT NULL,
  `认定人` varchar(128) NOT NULL,
  `认定申请时间` datetime DEFAULT NULL,
  `外部最新等级` varchar(4) NOT NULL,
  `备注` varchar(512) DEFAULT NULL,
  `审核状态` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`违约审核编号`),
  KEY `客户号` (`客户号`),
  KEY `违约原因编号` (`违约原因编号`),
  FOREIGN KEY (`客户号`) REFERENCES `客户表` (`客户号`),
  FOREIGN KEY (`违约原因编号`) REFERENCES `违约风险原因表` (`违约原因编号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  com.违约认定人工审核表 的数据：~1 rows (大约)
DELETE FROM `违约认定人工审核表`;
/*!40000 ALTER TABLE `违约认定人工审核表` DISABLE KEYS */;
INSERT INTO `违约认定人工审核表` (`违约审核编号`, `客户号`, `违约原因编号`, `严重程度`, `认定人`, `认定申请时间`, `外部最新等级`, `备注`, `审核状态`) VALUES
	('aaaaa', '1', '1', 'a', 'aa', '2022-06-29 16:02:38', '1', 'aa', '审核通过');
/*!40000 ALTER TABLE `违约认定人工审核表` ENABLE KEYS */;

DROP TABLE IF EXISTS `重生原因表`;
CREATE TABLE IF NOT EXISTS `重生原因表` (
  `重生原因编号` varchar(16) NOT NULL,
  `重生原因` varchar(512) NOT NULL,
  PRIMARY KEY (`重生原因编号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  com.重生原因表 的数据：~6 rows (大约)
DELETE FROM `重生原因表`;
/*!40000 ALTER TABLE `重生原因表` DISABLE KEYS */;
INSERT INTO `重生原因表` (`重生原因编号`, `重生原因`) VALUES
	('1', '正常结算后解除'),
	('2', '在其他金融机构违约解除，或外部评级显示为非违约级别'),
	('3', '计提比例小于设置界限'),
	('4', '连续 12 个月内按时支付本金和利息'),
	('5', '客户的还款意愿和还款能力明显好转，已偿付各项逾期本金、逾期利息和其他费用（包括罚息等），且连续 12 个月内按时支付本金、利息'),
	('6', '导致违约的关联集团内其他发生违约的客户已经违约重生，解除关联成员的违约设定');
/*!40000 ALTER TABLE `重生原因表` ENABLE KEYS */;

DROP TABLE IF EXISTS `重生人工审核表`;
CREATE TABLE IF NOT EXISTS `重生人工审核表` (
  `重生审核编号` varchar(16) NOT NULL,
  `重生原因编号` varchar(16) NOT NULL,
  `违约审核编号` varchar(16) NOT NULL,
  `重生申请时间` datetime DEFAULT NULL,
  `审核状态` varchar(20) DEFAULT NULL,
  `负责人` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`重生审核编号`),
  KEY `重生原因编号` (`重生原因编号`),
  KEY `违约审核编号` (`违约审核编号`),
  FOREIGN KEY (`重生原因编号`) REFERENCES `重生原因表` (`重生原因编号`),
  FOREIGN KEY (`违约审核编号`) REFERENCES `违约认定人工审核表` (`违约审核编号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  com.重生人工审核表 的数据：~1 rows (大约)
DELETE FROM `重生人工审核表`;
/*!40000 ALTER TABLE `重生人工审核表` DISABLE KEYS */;
INSERT INTO `重生人工审核表` (`重生审核编号`, `重生原因编号`, `违约审核编号`, `重生申请时间`, `审核状态`, `负责人`) VALUES
	('aaaaaa', '2', 'aaaaa', '2022-06-29 16:09:03', '审核通过', '1');
/*!40000 ALTER TABLE `重生人工审核表` ENABLE KEYS */;

-- 触发器：
-- 1.插入违约认定人工审核表时，生成认定申请时间，审核状态（待审核）
-- Create Trigger `违约认定人工审核_1`
-- 	After Insert
-- 	ON `违约认定人工审核表`
-- AS
-- 	Update `违约认定人工审核表`
-- 	Set `审核状态`='待审核',`认定申请时间`=(Select GETDATE())
-- 	Where `违约审核编号`=(Select `违约审核编号` From inserted);

DROP TRIGGER IF EXISTS `违约认定人工审核表_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `违约认定人工审核表_before_insert` BEFORE INSERT ON `违约认定人工审核表` FOR EACH ROW BEGIN
	Set NEW.`审核状态`='待审核',NEW.`认定申请时间`=(Select NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 2.插入重生人工审核表时，生成重生申请时间，审核状态（待审核）
-- Create Trigger 重生人工审核_1
-- 	ON 重生人工审核表
-- 	After Insert
-- AS
-- 	Update 重生人工审核表
-- 	Set 审核状态='待审核',重生申请时间=(Select GETDATE())
-- 	Where 重生审核编号=(Select 重生审核编号 From inserted);

DROP TRIGGER IF EXISTS `重生人工审核表_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `重生人工审核表_before_insert` BEFORE INSERT ON `重生人工审核表` FOR EACH ROW BEGIN
	Set NEW.`审核状态`='待审核',NEW.`重生申请时间`=NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 3.当违约认定通过时，将违约情况修改为是
-- Create Trigger 违约认定人工审核_2
-- 	ON 违约认定人工审核表
-- 	After Update
-- AS
-- 	IF Update(审核状态)
-- 		IF (Select 审核状态 From inserted) = '审核通过'
-- 			Update 客户
-- 			Set 违约情况=1
-- 			Where 客户号=(Select 客户号 From inserted);

DROP TRIGGER IF EXISTS `违约认定人工审核表_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `违约认定人工审核表_after_update` AFTER UPDATE ON `违约认定人工审核表` FOR EACH ROW BEGIN
	Update `客户表`
		SET `违约情况`=1
		WHERE `客户号`=NEW.`客户号` AND NEW.`审核状态` = '审核通过';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 4.当重生审核通过，将违约情况修改为否
-- Create Trigger 重生人工审核_2
-- 	ON 重生人工审核表
-- 	After Update
-- AS
-- 	IF Update(审核状态)
-- 		IF (Select 审核状态 From inserted) = '审核通过'
-- 			Update 客户
-- 			Set 违约情况=0
-- 			Where 客户号=(Select 客户号 From inserted);

DROP TRIGGER IF EXISTS `重生人工审核表_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `重生人工审核表_after_update` AFTER UPDATE ON `重生人工审核表` FOR EACH ROW BEGIN
		UPDATE `客户表`
		Set `违约情况`=0
		Where `客户号`=(Select `客户号` FROM `违约认定人工审核表` WHERE `违约审核编号`= NEW.`违约审核编号` ) AND NEW.`审核状态` = '审核通过';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 存储过程：
-- 1.违约重生
-- Create Procedure 违约重生
-- 	@客户号_flag nvarchar(16)
-- AS
-- 	Select 客户名,违约原因 AS 认为违约原因,严重程度,认定人,认定申请时间,外部最新等级
-- 	From 客户表,违约风险原因表,违约认定人工审核表
-- 	Where 客户表.客户号=@客户号_flag AND 客户表.客户号=违约认定人工审核表.客户号 AND 违约认定人工审核表.违约原因编号=违约风险原因表.违约原因编号



-- 视图：

-- 1.违约认定审核总信息
Create View `V_违约认定审核总信息`
AS Select `违约审核编号`,`客户表`.`客户号` AS `客户号`,`客户名`,`性别`,`区域`,`行业`,`集团`,`违约原因`,`认定人`,`认定申请时间`,`严重程度`,`外部最新等级`,`审核状态`,`备注`
From `客户表`,`违约认定人工审核表`,`违约风险原因表`
Where `客户表`.`客户号`=`违约认定人工审核表`.`客户号` AND `违约认定人工审核表`.`违约原因编号`=`违约风险原因表`.`违约原因编号`;

-- 2.重生审核
Create View `V_重生审核`
AS Select `重生审核编号`,`客户表`.`客户号` AS `客户号`,`客户名`,`违约原因`,`严重程度`,`外部最新等级`,`认定人`,`认定申请时间`,`重生人工审核表`.`审核状态` AS `审核状态`,`重生原因`
From `客户表`,`违约认定人工审核表`,`违约风险原因表`,`重生人工审核表`,`重生原因表`
Where `重生人工审核表`.`违约审核编号`=`违约认定人工审核表`.`违约审核编号` AND `重生人工审核表`.`审核状态`='待审核' AND `重生人工审核表`.`重生原因编号`=`重生原因表`.`重生原因编号` AND `客户表`.`客户号`=`违约认定人工审核表`.`客户号` AND `违约认定人工审核表`.`违约原因编号`=`违约风险原因表`.`违约原因编号`;

-- 3.V_已启用的违约风险原因
Create View `已启用的违约原因`
AS Select `违约原因编号`,`违约原因`
From `违约风险原因表`
Where `是否启用`=1;



-- 6.违约统计
-- Where YEAR(认定申请时间)=某年


