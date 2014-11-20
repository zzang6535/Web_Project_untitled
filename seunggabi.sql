CREATE DATABASE seunggabi DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL ON *.* TO 'seunggabi'@'localhost' IDENTIFIED BY 'seunggabi';

use seunggabi;

CREATE TABLE `board` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `u_id` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `wtime` datetime DEFAULT NULL,
  `cnt` int(11) DEFAULT NULL,
  `ofilename` varchar(255) DEFAULT NULL,
  `sfilename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(255) DEFAULT NULL,
  `pw` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#회원가입 
#password == seunggabi
INSERT INTO users ( id, pw, name, email, tel, gender ) VALUES ( 'seunggabi', '18f96b78a4b05228de42e899a1d685a1', '김승갑', 'test@google.com', '010-0000-0000', 'M');

#글 삽입
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
INSERT INTO `board` VALUES (1,'notice','test','테스트글입니다.','내용','2014-11-18 23:47:07',0,'','');
