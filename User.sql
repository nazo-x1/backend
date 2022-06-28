CREATE TABLE IF NOT EXISTS `User`(
   `username` VARCHAR(16) NOT NULL,
   `password` VARCHAR(16) NOT NULL,
   `random` VARCHAR(16) NOT NULL,
   PRIMARY KEY ( `username` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

Create TABLE IF NOT EXISTS `客户表`
(
   `客户号` varchar(16) not null,
   `客户名` varchar(128) not null,
   `性别` varchar(2) Check(`性别` in ('男','女')),
   `区域` varchar(50) not null,
   `行业` varchar(50) not null,
   `联系方式` varchar(20) not null,
   `集团` varchar(40),
   `违约情况` bit DEFAULT 0,
   PRIMARY KEY (`客户号`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

Create Table IF NOT EXISTS `违约风险原因表`
(
   `违约原因编号` varchar(16) not null,
   `违约原因` varchar(512) not null,
   `是否启用` bit DEFAULT 1,
   PRIMARY KEY(`违约原因编号`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

Create Table IF NOT EXISTS `违约认定人工审核表`
(
   `违约审核编号` varchar(16) not null,
   `客户号` varchar(16) not null,
   `违约原因编号` varchar(16) not null,
   `严重程度` varchar(2) not null,
   `认定人` varchar(128) not null,
   `认定申请时间` datetime ,
   `外部最新等级` varchar(2) not null,
   `备注` varchar(512),
   `审核状态` varchar(20),
   PRIMARY KEY(`违约审核编号`),
   FOREIGN KEY(`客户号`) REFERENCES `客户表`(`客户号`),
   FOREIGN KEY(`违约原因编号`) REFERENCES `违约风险原因表`(`违约原因编号`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

Create Table IF NOT EXISTS `重生原因表`
(
   `重生原因编号` varchar(16) not null,
   `重生原因` varchar(512) not null,
   PRIMARY KEY(`重生原因编号`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

Create Table IF NOT EXISTS `重生人工审核表`
(
   `重生审核编号` varchar(16) not null,
   `重生原因编号` varchar(16) not null,
   `违约审核编号` varchar(16) not null,
   `重生申请时间` datetime,
   `审核状态` varchar(20),
   `负责人` varchar(128) not null,
   PRIMARY KEY(`重生审核编号`),
   FOREIGN KEY(`重生原因编号`) REFERENCES `重生原因表`(`重生原因编号`),
   FOREIGN KEY(`违约审核编号`) REFERENCES `违约认定人工审核表`(`违约审核编号`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
