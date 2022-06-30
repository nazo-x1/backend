CREATE DATABASE IF NOT EXISTS `com` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `com`;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(16) NOT NULL,
  `password` varchar(16) NOT NULL,
  `random` varchar(16) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ���ڵ�����  com.user �����ݣ�~1 rows (��Լ)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`username`, `password`, `random`) VALUES
	('aaa', 'aaaa', 'aaaaa');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

DROP TABLE IF EXISTS `�ͻ���`;
CREATE TABLE IF NOT EXISTS `�ͻ���` (
  `�ͻ���` varchar(16) NOT NULL,
  `�ͻ���` varchar(128) NOT NULL,
  `�Ա�` varchar(4) DEFAULT NULL,
  `����` varchar(50) NOT NULL,
  `��ҵ` varchar(50) NOT NULL,
  `��ϵ��ʽ` varchar(20) NOT NULL,
  `����` varchar(40) DEFAULT NULL,
  `ΥԼ���` Integer DEFAULT 0,
  PRIMARY KEY (`�ͻ���`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ���ڵ�����  com.�ͻ��� �����ݣ�~3 rows (��Լ)
DELETE FROM `�ͻ���`;
/*!40000 ALTER TABLE `�ͻ���` DISABLE KEYS */;
INSERT INTO `�ͻ���` (`�ͻ���`, `�ͻ���`, `�Ա�`, `����`, `��ҵ`, `��ϵ��ʽ`, `����`, `ΥԼ���`) VALUES
	('1', '����', '��', '����', 'ѧ��', '110', 'HDU', 0),
	('2', '����', 'δ', '����', 'ѧ��', '120', 'HDU', 0),
	('3', '����', 'Ů', '����', 'ѧ��', '130', 'AAA', 0);
/*!40000 ALTER TABLE `�ͻ���` ENABLE KEYS */;

DROP TABLE IF EXISTS `ΥԼ����ԭ���`;
CREATE TABLE IF NOT EXISTS `ΥԼ����ԭ���` (
  `ΥԼԭ����` varchar(16) NOT NULL,
  `ΥԼԭ��` varchar(512) NOT NULL,
  `�Ƿ�����` Integer DEFAULT 1,
  PRIMARY KEY (`ΥԼԭ����`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ���ڵ�����  com.ΥԼ����ԭ��� �����ݣ�~7 rows (��Լ)
DELETE FROM `ΥԼ����ԭ���`;
/*!40000 ALTER TABLE `ΥԼ����ԭ���` DISABLE KEYS */;
INSERT INTO `ΥԼ����ԭ���` (`ΥԼԭ����`, `ΥԼԭ��`, `�Ƿ�����`) VALUES
	('1', '6 �����ڣ����׶��ּ����Ի��ʽ��ԭ�򣬸�����������ͷ��ȱ�� 2 ������', 1),
	('2', 'δ�ܰ��պ�Լ�涨֧��������֧����Ϣ������������������񣨲������ڿ�����������֧����', 1),
	('3', '6 �����������ԭ���³ɽ��󳷵� 2 ������', 1),
	('4', '����ΥԼ��������ţ��ڲ���ϵ�Ͻ��ܵļ��ţ���������һ��˾������Ҫ���ӹ�˾��һ������ΥԼ�������������ɽϴ�Ӱ��ģ�����ΥԼ�����������Ϊ���������г�ԱΥԼ�Ĵ�������', 1),
	('5', '��������ծ���û���ծ�����ṩ��ծȨ���µĻ������ծ�񣬻��µ�֤ȯ��ϡ��ֽ���ʲ�����ԭ�н������񣻻�Ϊ��ծ����δ�����ⷢ���Ʋ�����Ƿ��������е�չ�ڻ�����', 1),
	('6', '�����Ʋ��������������ɽӹܣ����ߴ������Ƶ��Ʋ�����״̬', 1),
	('7', '���������ڻ���ΥԼ�����������ڣ��������ż�¼����ʾ�������״̬��������������ڳ��� 90 ��ȣ������ⲿ������ʾΪΥԼ����', 1);
/*!40000 ALTER TABLE `ΥԼ����ԭ���` ENABLE KEYS */;

DROP TABLE IF EXISTS `ΥԼ�϶��˹���˱�`;
CREATE TABLE IF NOT EXISTS `ΥԼ�϶��˹���˱�` (
  `ΥԼ��˱��` varchar(16) NOT NULL,
  `�ͻ���` varchar(16) NOT NULL,
  `ΥԼԭ����` varchar(16) NOT NULL,
  `���س̶�` varchar(2) NOT NULL,
  `�϶���` varchar(128) NOT NULL,
  `�϶�����ʱ��` datetime DEFAULT NULL,
  `�ⲿ���µȼ�` varchar(4) NOT NULL,
  `��ע` varchar(512) DEFAULT NULL,
  `���״̬` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ΥԼ��˱��`),
  KEY `�ͻ���` (`�ͻ���`),
  KEY `ΥԼԭ����` (`ΥԼԭ����`),
  FOREIGN KEY (`�ͻ���`) REFERENCES `�ͻ���` (`�ͻ���`),
  FOREIGN KEY (`ΥԼԭ����`) REFERENCES `ΥԼ����ԭ���` (`ΥԼԭ����`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ���ڵ�����  com.ΥԼ�϶��˹���˱� �����ݣ�~1 rows (��Լ)
DELETE FROM `ΥԼ�϶��˹���˱�`;
/*!40000 ALTER TABLE `ΥԼ�϶��˹���˱�` DISABLE KEYS */;
INSERT INTO `ΥԼ�϶��˹���˱�` (`ΥԼ��˱��`, `�ͻ���`, `ΥԼԭ����`, `���س̶�`, `�϶���`, `�϶�����ʱ��`, `�ⲿ���µȼ�`, `��ע`, `���״̬`) VALUES
	('aaaaa', '1', '1', 'a', 'aa', '2022-06-29 16:02:38', '1', 'aa', '���ͨ��');
/*!40000 ALTER TABLE `ΥԼ�϶��˹���˱�` ENABLE KEYS */;

DROP TABLE IF EXISTS `����ԭ���`;
CREATE TABLE IF NOT EXISTS `����ԭ���` (
  `����ԭ����` varchar(16) NOT NULL,
  `����ԭ��` varchar(512) NOT NULL,
  PRIMARY KEY (`����ԭ����`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ���ڵ�����  com.����ԭ��� �����ݣ�~6 rows (��Լ)
DELETE FROM `����ԭ���`;
/*!40000 ALTER TABLE `����ԭ���` DISABLE KEYS */;
INSERT INTO `����ԭ���` (`����ԭ����`, `����ԭ��`) VALUES
	('1', '�����������'),
	('2', '���������ڻ���ΥԼ��������ⲿ������ʾΪ��ΥԼ����'),
	('3', '�������С�����ý���'),
	('4', '���� 12 �����ڰ�ʱ֧���������Ϣ'),
	('5', '�ͻ��Ļ�����Ը�ͻ����������Ժ�ת���ѳ����������ڱ���������Ϣ���������ã�������Ϣ�ȣ��������� 12 �����ڰ�ʱ֧��������Ϣ'),
	('6', '����ΥԼ�Ĺ�����������������ΥԼ�Ŀͻ��Ѿ�ΥԼ���������������Ա��ΥԼ�趨');
/*!40000 ALTER TABLE `����ԭ���` ENABLE KEYS */;

DROP TABLE IF EXISTS `�����˹���˱�`;
CREATE TABLE IF NOT EXISTS `�����˹���˱�` (
  `������˱��` varchar(16) NOT NULL,
  `����ԭ����` varchar(16) NOT NULL,
  `ΥԼ��˱��` varchar(16) NOT NULL,
  `��������ʱ��` datetime DEFAULT NULL,
  `���״̬` varchar(20) DEFAULT NULL,
  `������` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`������˱��`),
  KEY `����ԭ����` (`����ԭ����`),
  KEY `ΥԼ��˱��` (`ΥԼ��˱��`),
  FOREIGN KEY (`����ԭ����`) REFERENCES `����ԭ���` (`����ԭ����`),
  FOREIGN KEY (`ΥԼ��˱��`) REFERENCES `ΥԼ�϶��˹���˱�` (`ΥԼ��˱��`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ���ڵ�����  com.�����˹���˱� �����ݣ�~1 rows (��Լ)
DELETE FROM `�����˹���˱�`;
/*!40000 ALTER TABLE `�����˹���˱�` DISABLE KEYS */;
INSERT INTO `�����˹���˱�` (`������˱��`, `����ԭ����`, `ΥԼ��˱��`, `��������ʱ��`, `���״̬`, `������`) VALUES
	('aaaaaa', '2', 'aaaaa', '2022-06-29 16:09:03', '���ͨ��', '1');
/*!40000 ALTER TABLE `�����˹���˱�` ENABLE KEYS */;

-- ��������
-- 1.����ΥԼ�϶��˹���˱�ʱ�������϶�����ʱ�䣬���״̬������ˣ�
-- Create Trigger `ΥԼ�϶��˹����_1`
-- 	After Insert
-- 	ON `ΥԼ�϶��˹���˱�`
-- AS
-- 	Update `ΥԼ�϶��˹���˱�`
-- 	Set `���״̬`='�����',`�϶�����ʱ��`=(Select GETDATE())
-- 	Where `ΥԼ��˱��`=(Select `ΥԼ��˱��` From inserted);

DROP TRIGGER IF EXISTS `ΥԼ�϶��˹���˱�_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ΥԼ�϶��˹���˱�_before_insert` BEFORE INSERT ON `ΥԼ�϶��˹���˱�` FOR EACH ROW BEGIN
	Set NEW.`���״̬`='�����',NEW.`�϶�����ʱ��`=(Select NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 2.���������˹���˱�ʱ��������������ʱ�䣬���״̬������ˣ�
-- Create Trigger �����˹����_1
-- 	ON �����˹���˱�
-- 	After Insert
-- AS
-- 	Update �����˹���˱�
-- 	Set ���״̬='�����',��������ʱ��=(Select GETDATE())
-- 	Where ������˱��=(Select ������˱�� From inserted);

DROP TRIGGER IF EXISTS `�����˹���˱�_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `�����˹���˱�_before_insert` BEFORE INSERT ON `�����˹���˱�` FOR EACH ROW BEGIN
	Set NEW.`���״̬`='�����',NEW.`��������ʱ��`=NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 3.��ΥԼ�϶�ͨ��ʱ����ΥԼ����޸�Ϊ��
-- Create Trigger ΥԼ�϶��˹����_2
-- 	ON ΥԼ�϶��˹���˱�
-- 	After Update
-- AS
-- 	IF Update(���״̬)
-- 		IF (Select ���״̬ From inserted) = '���ͨ��'
-- 			Update �ͻ�
-- 			Set ΥԼ���=1
-- 			Where �ͻ���=(Select �ͻ��� From inserted);

DROP TRIGGER IF EXISTS `ΥԼ�϶��˹���˱�_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ΥԼ�϶��˹���˱�_after_update` AFTER UPDATE ON `ΥԼ�϶��˹���˱�` FOR EACH ROW BEGIN
	Update `�ͻ���`
		SET `ΥԼ���`=1
		WHERE `�ͻ���`=NEW.`�ͻ���` AND NEW.`���״̬` = '���ͨ��';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 4.���������ͨ������ΥԼ����޸�Ϊ��
-- Create Trigger �����˹����_2
-- 	ON �����˹���˱�
-- 	After Update
-- AS
-- 	IF Update(���״̬)
-- 		IF (Select ���״̬ From inserted) = '���ͨ��'
-- 			Update �ͻ�
-- 			Set ΥԼ���=0
-- 			Where �ͻ���=(Select �ͻ��� From inserted);

DROP TRIGGER IF EXISTS `�����˹���˱�_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `�����˹���˱�_after_update` AFTER UPDATE ON `�����˹���˱�` FOR EACH ROW BEGIN
		UPDATE `�ͻ���`
		Set `ΥԼ���`=0
		Where `�ͻ���`=(Select `�ͻ���` FROM `ΥԼ�϶��˹���˱�` WHERE `ΥԼ��˱��`= NEW.`ΥԼ��˱��` ) AND NEW.`���״̬` = '���ͨ��';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- �洢���̣�
-- 1.ΥԼ����
-- Create Procedure ΥԼ����
-- 	@�ͻ���_flag nvarchar(16)
-- AS
-- 	Select �ͻ���,ΥԼԭ�� AS ��ΪΥԼԭ��,���س̶�,�϶���,�϶�����ʱ��,�ⲿ���µȼ�
-- 	From �ͻ���,ΥԼ����ԭ���,ΥԼ�϶��˹���˱�
-- 	Where �ͻ���.�ͻ���=@�ͻ���_flag AND �ͻ���.�ͻ���=ΥԼ�϶��˹���˱�.�ͻ��� AND ΥԼ�϶��˹���˱�.ΥԼԭ����=ΥԼ����ԭ���.ΥԼԭ����



-- ��ͼ��

-- 1.ΥԼ�϶��������Ϣ
Create View `V_ΥԼ�϶��������Ϣ`
AS Select `ΥԼ��˱��`,`�ͻ���`.`�ͻ���` AS `�ͻ���`,`�ͻ���`,`�Ա�`,`����`,`��ҵ`,`����`,`ΥԼԭ��`,`�϶���`,`�϶�����ʱ��`,`���س̶�`,`�ⲿ���µȼ�`,`���״̬`,`��ע`
From `�ͻ���`,`ΥԼ�϶��˹���˱�`,`ΥԼ����ԭ���`
Where `�ͻ���`.`�ͻ���`=`ΥԼ�϶��˹���˱�`.`�ͻ���` AND `ΥԼ�϶��˹���˱�`.`ΥԼԭ����`=`ΥԼ����ԭ���`.`ΥԼԭ����`;

-- 2.�������
Create View `V_�������`
AS Select `������˱��`,`�ͻ���`.`�ͻ���` AS `�ͻ���`,`�ͻ���`,`ΥԼԭ��`,`���س̶�`,`�ⲿ���µȼ�`,`�϶���`,`�϶�����ʱ��`,`�����˹���˱�`.`���״̬` AS `���״̬`,`����ԭ��`
From `�ͻ���`,`ΥԼ�϶��˹���˱�`,`ΥԼ����ԭ���`,`�����˹���˱�`,`����ԭ���`
Where `�����˹���˱�`.`ΥԼ��˱��`=`ΥԼ�϶��˹���˱�`.`ΥԼ��˱��` AND `�����˹���˱�`.`���״̬`='�����' AND `�����˹���˱�`.`����ԭ����`=`����ԭ���`.`����ԭ����` AND `�ͻ���`.`�ͻ���`=`ΥԼ�϶��˹���˱�`.`�ͻ���` AND `ΥԼ�϶��˹���˱�`.`ΥԼԭ����`=`ΥԼ����ԭ���`.`ΥԼԭ����`;

-- 3.V_�����õ�ΥԼ����ԭ��
Create View `�����õ�ΥԼԭ��`
AS Select `ΥԼԭ����`,`ΥԼԭ��`
From `ΥԼ����ԭ���`
Where `�Ƿ�����`=1;



-- 6.ΥԼͳ��
-- Where YEAR(�϶�����ʱ��)=ĳ��


