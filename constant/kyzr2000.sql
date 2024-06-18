/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50727
Source Host           : localhost:3306
Source Database       : kyzr2000

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2022-05-09 22:57:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `answer`
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `user_id` int(2) NOT NULL,
  `title` varchar(50) NOT NULL,
  `article` varchar(500) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `createAt` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `AID` (`user_id`),
  CONSTRAINT `AID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES ('1', '1', '这是一条测试用的的帖子', '这是文章内容', '0', '2022-02-16 18:37');
INSERT INTO `answer` VALUES ('2', '2', '我是心理咨询师杨磊，欢迎大家预约！', '阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴阿巴', '0', '2022-02-16 19:22');
INSERT INTO `answer` VALUES ('3', '3', '大家好，欢迎大家使用本系统', '居然啥也没发生？？？', '0', '2022-02-24 12:10');
INSERT INTO `answer` VALUES ('4', '2', '心理焦虑患者戳我', '如题', '0', '2022-02-24 12:11');
INSERT INTO `answer` VALUES ('5', '7', '我现在被困在了上海，我有点慌', '111', '0', '2022-02-24 12:12');
INSERT INTO `answer` VALUES ('6', '9', '关于二月的工作成果', '如题', '0', '2022-02-24 12:12');
INSERT INTO `answer` VALUES ('7', '1', '首页右下角的新功能今天开放啦！', '这次大家可以在首页看到最新更新的10条帖子啦，希望大家多在论坛里留言！', '0', '2022-02-24 12:14');
INSERT INTO `answer` VALUES ('8', '1', '那么问题就来到了闫欣宇这边', '你以为？', '0', '2022-02-25 15:31');
INSERT INTO `answer` VALUES ('9', '2', '欢迎大家咨询心理咨询师狗磊', '111', '0', '2022-02-25 15:33');
INSERT INTO `answer` VALUES ('10', '1', '关于开学以后会产生的一些心理问题', '如题', '0', '2022-02-26 11:48');
INSERT INTO `answer` VALUES ('11', '1', '欢迎大家使用公益解答模块', '在这里大家可以提出想要提的问题', '0', '2022-02-26 11:49');
INSERT INTO `answer` VALUES ('12', '1', '今天是3月3日，大家积极留言！', '如题', '0', '2022-03-03 16:33');
INSERT INTO `answer` VALUES ('13', '1', '四月份的心理咨询系统也会一直为大家开放', '<p>大家踊跃发帖，会有心理咨询师为大家解答！</p>', '0', '2022-04-12 13:19');
INSERT INTO `answer` VALUES ('14', '1', '5月25日是心理健康日', 'rt', '0', '2022-05-06 13:24');
INSERT INTO `answer` VALUES ('15', '1', '测试用例', '测试用例', '0', '2022-05-06 13:45');

-- ----------------------------
-- Table structure for `checks`
-- ----------------------------
DROP TABLE IF EXISTS `checks`;
CREATE TABLE `checks` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `title_id` int(2) NOT NULL,
  `question_id` int(2) NOT NULL,
  `question` varchar(100) NOT NULL,
  `optionA` varchar(50) NOT NULL,
  `optionB` varchar(50) NOT NULL,
  `optionC` varchar(50) NOT NULL,
  `valueA` int(2) NOT NULL,
  `valueB` int(2) NOT NULL,
  `valueC` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of checks
-- ----------------------------
INSERT INTO `checks` VALUES ('1', '1', '1', '我感到事事都很顺利，不会有倒霉的事情发生。', '没有或很少时间', '相当多时间', '绝大部分或全部时间', '9', '6', '3');
INSERT INTO `checks` VALUES ('2', '1', '2', '我觉得心平气和，并且容易安静坐着。', '没有或很少时间', '相当多时间', '绝大部分或全部时间', '3', '6', '9');
INSERT INTO `checks` VALUES ('3', '1', '3', '我常常要小便。', '没有或很少时间', '相当多时间', '绝大部分或全部时间', '9', '6', '3');
INSERT INTO `checks` VALUES ('4', '1', '4', '我容易入睡并且一夜睡得很好。', '没有或很少时间', '相当多时间', '绝大部分或全部时间', '3', '6', '9');
INSERT INTO `checks` VALUES ('5', '1', '5', '我做恶梦。', '没有或很少时间', '相当多时间', '绝大部分或全部时间', '9', '6', '3');
INSERT INTO `checks` VALUES ('6', '2', '1', '你与人交往越深入，越觉得惶恐不安？', '是', '偶尔', '不是', '3', '6', '9');
INSERT INTO `checks` VALUES ('7', '2', '2', '当恋人与你发生亲密的肢体接触，你会觉得恶心？。', '是', '偶尔', '不是', '3', '6', '9');
INSERT INTO `checks` VALUES ('8', '2', '3', '你童年时期和家人的关系很冷淡？', '是', '偶尔', '不是', '3', '6', '9');
INSERT INTO `checks` VALUES ('9', '2', '4', '你喜欢被别人依赖的感觉？', '是', '偶尔', '不是', '3', '6', '9');
INSERT INTO `checks` VALUES ('10', '2', '5', '你的社交手段非常高明？', '是', '偶尔', '不是', '3', '6', '9');
INSERT INTO `checks` VALUES ('11', '3', '1', '看到不爽的人你是怎样的态度？', '不屑', '嘲笑对方', '无视', '9', '6', '3');
INSERT INTO `checks` VALUES ('12', '3', '2', '你是一个严肃的人吗？', '不是', '是', '看人', '9', '6', '3');
INSERT INTO `checks` VALUES ('13', '3', '3', '你是一个随和的人吗？', '不是', '是', '看人', '9', '6', '3');
INSERT INTO `checks` VALUES ('14', '3', '4', '你经常打断别人的讲话吗？', '不会', '偶尔', '会打断', '3', '6', '9');
INSERT INTO `checks` VALUES ('15', '3', '5', '你会莫名其妙的心情不好吗？', '不会', '会', '看情况', '9', '6', '3');
INSERT INTO `checks` VALUES ('16', '4', '1', '你每天早上起床后一想到要上班或上学，就觉得很抓狂吗？', '是的', '不是', '看情况', '30', '20', '10');
INSERT INTO `checks` VALUES ('17', '4', '2', '你觉得其实自己的心理年龄比实际年龄偏年轻吗？', '是的', '偏老', '差不多', '30', '20', '10');
INSERT INTO `checks` VALUES ('18', '4', '3', '失恋之后，你的一般情况是选择哪一种？', '打扮好看', '懒得打扮', '照常打扮', '30', '20', '10');

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `answer_id` int(2) NOT NULL,
  `user_id` int(2) NOT NULL,
  `article` varchar(500) NOT NULL,
  `createAt` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CAID` (`answer_id`),
  KEY `CUID` (`user_id`),
  CONSTRAINT `CAID` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CUID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '1', '1', '111', '2022-2-17 13:00');
INSERT INTO `comment` VALUES ('2', '2', '1', '阿巴阿巴', '2022-02-17 11:39');
INSERT INTO `comment` VALUES ('3', '2', '2', '我是叨叨磊', '2022-02-17 11:42');
INSERT INTO `comment` VALUES ('4', '2', '5', '测试一下？', '2022-02-17 17:01');
INSERT INTO `comment` VALUES ('5', '1', '5', '测试一波，阿巴阿巴', '2022-02-17 17:02');
INSERT INTO `comment` VALUES ('6', '2', '1', '重复测试！', '2022-02-20 16:02');
INSERT INTO `comment` VALUES ('7', '8', '1', '你以为呢？', '2022-02-25 15:31');
INSERT INTO `comment` VALUES ('8', '12', '1', '你好', '2022-03-19 15:15');
INSERT INTO `comment` VALUES ('9', '12', '2', '你好，这里是心理咨询师狗磊先生，有需要的请预约我！价格便宜', '2022-04-06 15:39');
INSERT INTO `comment` VALUES ('10', '13', '1', '1111', '2022-04-12 13:19');
INSERT INTO `comment` VALUES ('11', '13', '1', '2222', '2022-04-12 13:19');
INSERT INTO `comment` VALUES ('12', '14', '1', '欢迎留言！', '2022-05-06 13:24');
INSERT INTO `comment` VALUES ('13', '15', '1', '测试用例', '2022-05-06 13:46');
INSERT INTO `comment` VALUES ('14', '15', '1', '测试用例', '2022-05-06 13:46');

-- ----------------------------
-- Table structure for `course`
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `img` varchar(100) NOT NULL,
  `title` varchar(50) NOT NULL,
  `createAt` varchar(50) NOT NULL,
  `price` varchar(50) NOT NULL DEFAULT '0',
  `courseURL` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', 'http://nickyzj.run:12450/lychee/uploads/big/d513294c148eda20b7aa8c1f3b1cca8e.jpg', '做自己情绪的主人', '2021-12-13 13:00', '0', 'http://player.bilibili.com/player.html?aid=200856047&bvid=BV1Qz411v7kQ&cid=194839477&page=1&high_quality=1&danmaku=1');
INSERT INTO `course` VALUES ('2', 'http://nickyzj.run:12450/lychee/uploads/big/ce6fce033dfedae457fbd4dcf882fcc2.jpg', '大学生心理健康', '2021-12-14 14:25', '0', 'http://player.bilibili.com/player.html?aid=459584617&bvid=BV1u5411P7yS&cid=308849187&page=1&high_quality=1&danmaku=1');
INSERT INTO `course` VALUES ('3', 'http://nickyzj.run:12450/lychee/uploads/big/fe9bfe07cb3b68e17f623a35d44aad1f.jpg', '“心理健康，生命阳光”精神卫生科普动画片', '2022-03-01 14:43', '0', 'http://player.bilibili.com/player.html?aid=39249522&bvid=BV1yt411r7xA&cid=68977221&page=1&high_quality=1&danmaku=1');
INSERT INTO `course` VALUES ('4', 'http://nickyzj.run:12450/lychee/uploads/big/b43efe705e8eb0f5d9b8e87210b81ccc.jpg', '8个改善心理健康的小习惯', '2022-03-02 13:33', '0', 'http://player.bilibili.com/player.html?aid=632833789&bvid=BV1yb4y117ph&cid=403991800&page=1&high_quality=1&danmaku=1');
INSERT INTO `course` VALUES ('5', 'http://nickyzj.run:12450/lychee/uploads/big/d16d77fc5ac7904f2816b8ff086eb8df.jpg', '如何长期保持心理健康?', '2022-03-02 13:35', '0', 'http://player.bilibili.com/player.html?aid=206014144&bvid=BV1Ch411e7ue&cid=351932804&page=1&high_quality=1&danmaku=1');
INSERT INTO `course` VALUES ('6', 'http://nickyzj.run:12450/lychee/uploads/big/5d8865ebb062acd8c53cdb1ecd079f90.jpg', '心理疾病预防建议：活得鲁莽一些！', '2022-03-02 13:35', '0', 'http://player.bilibili.com/player.html?aid=414802026&bvid=BV11V41117zR&cid=240533084&page=1&high_quality=1&danmaku=1');

-- ----------------------------
-- Table structure for `expert`
-- ----------------------------
DROP TABLE IF EXISTS `expert`;
CREATE TABLE `expert` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `introduction` varchar(100) NOT NULL,
  `img` varchar(100) NOT NULL,
  `value` varchar(10) NOT NULL,
  `tagOne` varchar(10) DEFAULT NULL,
  `tagTwo` varchar(10) DEFAULT NULL,
  `tagThree` varchar(10) DEFAULT NULL,
  `user_id` int(3) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `EID` (`user_id`),
  CONSTRAINT `EID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of expert
-- ----------------------------
INSERT INTO `expert` VALUES ('1', '杨磊', '爱挑虾线', 'http://nickyzj.run:12450/lychee/uploads/big/c5d7eb8bf9c693e28aca704a0d8322d0.jpg', '50', '嚣张跋扈', '富家子弟', '挑你虾线', '2', '1');
INSERT INTO `expert` VALUES ('2', '闫欣宇', '有着两段刻苦铭心的情感经历', 'http://nickyzj.run:12450/lychee/uploads/big/325781db7ffa3e6afb9feb70a6530e1c.jpg', '100', '雪中送炭', '欣宇大大', '莫得感情', '3', '1');
INSERT INTO `expert` VALUES ('4', '王君博', '模拟模拟', 'url', '150', '2', '3', '4', '2', '2');
INSERT INTO `expert` VALUES ('6', '犬犬', '111', 'url', '111', '测试', '测试', '测试', '9', '2');
INSERT INTO `expert` VALUES ('7', '职业哥', '测试一下哈', 'http://nickyzj.run:12450/lychee/uploads/big/87233c315c91718fde72bca329d18dda.jpg', '10', '测试', '测试', '测试', '7', '1');
INSERT INTO `expert` VALUES ('8', '测试用例1', '测试用例1', 'url', '10', '测试', '测试', '测试', '9', '0');
INSERT INTO `expert` VALUES ('9', '测试用例2', '测试用例2', 'url', '10', '测试', '测试', '测试', '9', '2');
INSERT INTO `expert` VALUES ('10', '测试用例3', '测试用例3', 'url', '10', '测试', '测试', '测试', '9', '0');
INSERT INTO `expert` VALUES ('11', '测试用例4', '测试用例4', 'url', '10', '测试', '测试', '测试', '9', '0');
INSERT INTO `expert` VALUES ('12', '测试用例5', '测试用例5', 'url', '10', '测试', '测试', '测试', '9', '0');
INSERT INTO `expert` VALUES ('13', '测试用例6', '测试用例6', 'url', '10', '测试', '测试', '测试', '9', '2');
INSERT INTO `expert` VALUES ('14', '杨智杰', '上海陆家嘴帅小伙一枚', 'http://nickyzj.run:12450/lychee/uploads/big/046b375c35be5b7ddc89c81a45df7e85.jpg', '20', '肤白貌美', '价格实惠', '耐心解答', '10', '1');
INSERT INTO `expert` VALUES ('15', '魏昊天', '湖南昊天锤拥有者', 'http://nickyzj.run:12450/lychee/uploads/big/a4099352a71e2c885b715a2432edcd42.jpg', '200', '昊天斗罗', '武魂殿主', '2023界备考研究生', '11', '1');
INSERT INTO `expert` VALUES ('16', '王保安', '有着n段感情经历的无情人', 'http://nickyzj.run:12450/lychee/uploads/big/befaceccee7d71ac6012c2772855ac4d.jpg', '500', '你的保安', '221寝室1床', 'BRB', '12', '1');

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `house_id` int(5) NOT NULL,
  `customer_id` int(3) NOT NULL,
  `expert_id` int(3) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `createAt` varchar(20) NOT NULL,
  `price` varchar(10) NOT NULL,
  `myInfo` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `OCID` (`customer_id`),
  KEY `OEID` (`expert_id`),
  CONSTRAINT `OCID` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OEID` FOREIGN KEY (`expert_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '10000', '1', '2', '3', '2022-03-10 17:50', '50', '11111测试修改');
INSERT INTO `orders` VALUES ('2', '10001', '1', '3', '2', '2022-03-10 17:50', '100', '');
INSERT INTO `orders` VALUES ('3', '10002', '1', '2', '3', '2022-03-10 17:50', '50', '');
INSERT INTO `orders` VALUES ('4', '81249', '5', '2', '2', '2022-03-10 17:50', '50', '');
INSERT INTO `orders` VALUES ('5', '88440', '5', '3', '2', '2022-03-10 17:50', '100', '');
INSERT INTO `orders` VALUES ('6', '63649', '5', '2', '2', '2022-03-13 14:26', '50', '');
INSERT INTO `orders` VALUES ('7', '87992', '5', '2', '2', '2022-03-13 15:12', '50', '');
INSERT INTO `orders` VALUES ('8', '33068', '5', '2', '3', '2022-03-17 12:45', '50', '');
INSERT INTO `orders` VALUES ('9', '80020', '11', '2', '3', '2022-03-17 13:16', '50', '');
INSERT INTO `orders` VALUES ('10', '14044', '11', '3', '3', '2022-03-17 13:17', '100', '');
INSERT INTO `orders` VALUES ('11', '37269', '11', '7', '3', '2022-03-17 13:18', '10', '');
INSERT INTO `orders` VALUES ('12', '89655', '5', '7', '2', '2022-03-17 13:20', '10', '');
INSERT INTO `orders` VALUES ('13', '50636', '5', '2', '2', '2022-03-17 13:52', '50', '');
INSERT INTO `orders` VALUES ('14', '70818', '5', '12', '2', '2022-03-19 15:16', '500', '');
INSERT INTO `orders` VALUES ('15', '53652', '5', '12', '2', '2022-03-19 15:20', '500', '');
INSERT INTO `orders` VALUES ('16', '36642', '5', '12', '2', '2022-04-04 21:04', '500', '');
INSERT INTO `orders` VALUES ('17', '18206', '5', '2', '2', '2022-04-08 21:09', '50', '');
INSERT INTO `orders` VALUES ('18', '46198', '5', '2', '2', '2022-04-17 07:41', '50', '');
INSERT INTO `orders` VALUES ('19', '84190', '5', '2', '2', '2022-04-17 09:11', '50', '');
INSERT INTO `orders` VALUES ('20', '28506', '5', '2', '2', '2022-04-17 09:18', '50', '');
INSERT INTO `orders` VALUES ('21', '30091', '5', '11', '2', '2022-04-29 14:18', '200', '');
INSERT INTO `orders` VALUES ('22', '74690', '13', '11', '2', '2022-04-29 14:20', '200', '明天十点，昊天宗见，可否？');
INSERT INTO `orders` VALUES ('30', '27630', '13', '11', '3', '2022-04-30 13:50', '200', '账号非法');
INSERT INTO `orders` VALUES ('31', '74837', '13', '11', '2', '2022-04-30 14:53', '200', '111111111');
INSERT INTO `orders` VALUES ('32', '79619', '13', '11', '3', '2022-04-30 14:59', '200', '我不想给你咨询');
INSERT INTO `orders` VALUES ('33', '51530', '5', '10', '3', '2022-05-04 15:48', '20', '1111111');
INSERT INTO `orders` VALUES ('34', '87609', '5', '11', '3', '2022-05-04 15:56', '200', '');
INSERT INTO `orders` VALUES ('35', '98372', '5', '11', '1', '2022-05-05 14:23', '200', '');

-- ----------------------------
-- Table structure for `passage`
-- ----------------------------
DROP TABLE IF EXISTS `passage`;
CREATE TABLE `passage` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `img` varchar(100) NOT NULL,
  `article` varchar(1000) NOT NULL,
  `createAt` varchar(100) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of passage
-- ----------------------------
INSERT INTO `passage` VALUES ('1', '心理咨询系统正式成立啦~', 'http://nickyzj.run:12450/lychee/uploads/big/84c0f4dd684f53ddf0d77ab1eea6aac5.png', '<p>随着高校招收人数的不断增加，学生越来越多的同时，也使得许多同学的心理健康问题没有能够得到及时的解决。当前学生在生活中、学习和就业方面存在着十分大的压力，为了缓解学生的心理焦虑，引导学生心理健康的发展，需要深入分析学生存在的心理健康问题，这样才能够提出针对性的解决策略。同时，许多高校学生沉迷于电脑、手机游戏，与同学毫无交流，心理长期处于压抑状态，负面情绪得不到释放，并且常与室友发生争吵，严重情况下甚至会出现斗殴，但不愿走进线下心理咨询室的大门，与学校内的心理咨询师进行敞开心扉的交流，所以许多学校也逐渐将心理咨询这一服务置于线上展开。</p>\r\n					<p>在近年来，学生群体中大约有30%左右的人有着不同程度的心理问题，并且心理问题造成严重事件的情况也经常能够在报导中看见，许许多多关于高校学生的负面新闻也会经常出现在我们的视野中，由此可见，学生存在着不同程度上的心理问题、心理障碍或心理疾病，解决这一问题也显得刻不容缓。</p>\r\n<p>随着高校招收人数的不断增加，学生越来越多的同时，也使得许多同学的心理健康问题没有能够得到及时的解决。当前学生在生活中、学习和就业方面存在着十分大的压力，为了缓解学生的心理焦虑，引导学生心理健康的发展，需要深入分析学生存在的心理健康问题，这样才能够提出针对性的解决策略。同时，许多高校学生沉迷于电脑、手机游戏，与同学毫无交流，心理长期处于压抑状态，负面情绪得不到释放，并且常与室友发生争吵，严重情况下甚至会出现斗殴，但不愿走进线下心理咨询室的大门，与学校内的心理咨询师进行敞开心扉的交流，所以许多学校也逐渐将心理咨询这一服务置于线上展开。</p>\r\n					<p>在近年来，学生群体中大约有30%左右的人有着不同程度的心理问题，并且心理问题造成严重事件的情况也经常能够在报导中看见，许许多多关于高校学生的负面新闻也会经常出现在我们的视野中，由此可见，学生存在着不同程度上的心理问题、心理障碍或心理疾病，解决这一问题也显得刻不容缓。</p>\r\n', '2021-11-25 10:53', '0');
INSERT INTO `passage` VALUES ('2', '话题终结者的烦恼', 'http://nickyzj.run:12450/lychee/uploads/big/14bf399596a2c2490820787f2721f91b.jpg', '<p>个案资料：男，30岁，中专毕业，设计类专业，在亲戚开的一家小型的商品房设计装修公司上班，任设计助理一职。主述：小学和初中时候，只有1-2个朋友，其他人不怎么来往。现在公司中，和大部分同事之间无交流。自述想沟通，但是不知说什么，自述自己是“话题终结者”，说不上几句，就不知说什么了。因此也不敢参加公司聚餐，因为大家都谈笑风生，而自己不知怎么插入话题，只能玩手机，而这样自己都觉得被孤立，融入不了，非常痛苦。 小学以前，亲戚老乡反映他“脾气暴躁”，行为过激。 同来的表哥反应，来访者母亲脾气暴躁，外婆脾气暴躁，舅舅脾气暴躁。去年曾经有一次，来访者和8岁的小孩玩时，不知怎么发生冲突，冲动的时候拿着一把刀出来，把大家吓了一跳。 毕业后在亲戚家的公司任职3年多，公司的老板反映，来访者经常迟到，而且经常和直属上司顶嘴，不愿意听从上司的设计工作的安排。来访者目前处于没有动力，没有目标，得过且过的状态。因为是亲戚，所以容忍他，也曾想炒掉他，但是他不走。此次咨询是亲戚付费，并且一再强调不要说来访者有“心理问题”，担心他不能接受而拒接再来咨询。</p>\r\n<p>通过咨询，让来访者自己察觉到人际关系差的产生原因，以及自己的人际相处模式。自己觉察到脾气暴躁的原因，及暴躁的触发模式。首先是觉察，然后才能调整。</p>\r\n<p>采用认知行为疗法进行调整。先调整认知，然后控制和改变情绪，最后改善行为。咨询师协助来访者建构正确的，和谐的人际相处机制。</p>\r\n<p>用正念减压放松的方法，教会来访者冲动易怒的克服方法。比如每当想发脾气，或者发生口角的时候，试着先控制自己的冲动，然后再选择适合的解决问题的方法。</p>', '2021-11-25 11:00', '0');
INSERT INTO `passage` VALUES ('3', '2022.2.26系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/df908f1c1875530020c37dba1337052a.jpg', '<p>本次更新“公益解答”模块的所有内容都已基本完成，新增了搜索功能，发布帖子功能，回复功能，如有发现BUG大家可及时联系QQ342133194</p>', '2022-02-26 15:29', '0');
INSERT INTO `passage` VALUES ('4', '2022.2.27系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/cecf3ad44e5763bc3c06126329614971.jpg', '<p>本次更新，为首页的公告栏新增了搜索功能，大家可以更方便的使用心理咨询系统啦！</p>', '2022-02-27 13:00', '0');
INSERT INTO `passage` VALUES ('5', '2022.2.28系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/289f76ef094df0181c6d01901b4a4eef.jpg', '<p>今天心理咨询系统主要更新了后台与首页文章有关的一些的相关内容，分别是首页文章的添加、搜索。</p>\r\n<p>打算在今天把后台的首页文章分页，前台的首页文章分页也弄出来。</p>', '2022-02-28 13:53', '0');
INSERT INTO `passage` VALUES ('6', '厌倦工作却不敢辞职', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>看得出来，你现在的心里感到非常的纠结与矛盾。你不喜欢现在的工作氛围与工作环境，但是却为了生计而不得不接受这份工作, 我能理解你的心情。</p>\r\n<p>能不能说一说你现在的工作氛围与环境是什么样子的呢？而你所期待的工作氛围又是如何的呢？再想一想，如果你离开了现在的单位，是否还有其他的选择呢？</p>\r\n<p>其实无论是什么工作，都会有很多选择的机会，并不是说只有这一家公司，这个地方才会有的，因此你还是有很多可以去发展的地方，不用担心换了个地方无法挣钱。</p>\r\n<p>那我们首先还是要思考清楚自己所处在的工作环境氛围如何？我们不喜欢的是什么地方？如果换了一个地方，是否还会存在这样的问题呢？</p>', '2022-02-28 14:26', '0');
INSERT INTO `passage` VALUES ('7', '如何戒网瘾？', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>我以前也有这种感觉，但是一想到之后自己的考试和作业可能不过，没法毕业，就会在特定时间比如提前半年复习，每天学习2小时这样。学习的时候学习，玩的时候玩。其实不是手机的问题，手机只是个媒介，我学习也是要用到电子产品上网课➕记录笔记的。不知道你是工作党还是学生党？如果实在很想玩，可以在学习前出去打会球，或者看1小时电视剧后。规定自己好学习2小时，这样吸收知识也会更快更专注。如果一开始没法长时间坚持，可以先试着先学习15分钟，然后玩或者放松5分钟。提高自己的专注力，哪怕只有15分钟的注意力集中。等以后大脑习惯了，就往上加时间。</p>', '2022-02-28 14:27', '0');
INSERT INTO `passage` VALUES ('8', '感觉自己不相信任何人了怎么回事？', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>看到你在说不喜欢社交了，感到很多都不值得。换个角度来说这是不是一种成长呢？更加明白了人与人之间的界线？可以有所选择的和一些人交往。很多人可以和我们走一时，在我们做不同的事可以找不同的人讨论，有人讨论美食，有人讨论居家打理，有人讨论电视剧，这样的人生不也是很丰盛吗？我们的选择余地也大了很多。</p>', '2022-02-28 14:28', '0');
INSERT INTO `passage` VALUES ('9', '成长，焦虑，未来迷茫', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p> 我非常理解你的感受，看到你心里很难受。实际上你有很多优点，只是你忽略它们，夸大弱点。比如你很善良、很努力、很有爱心、爱家人、体谅他人，又努力、又有目标，而且非常有执行力，每天坚持早起（这很难的），非常自律。但就善良有爱就可以盖过他人很多的优点。以后记住这些美好的自己，每天的进步写下来，把它们永远的存储在你的大脑了，每天睡前回想它们。你提到的不好的经历每个人都有，只是不同，学会忘记，今天开始把它们删除出去。你本来就是很棒的。觉察力强，自律、坚定，坚持就是胜利。我相信你是有力量的！人只要有坚强的意志没有什么做不到的，加油。</p>', '2022-02-28 14:28', '0');
INSERT INTO `passage` VALUES ('10', '前半生太顺利，后半生一定会经历坎坷吗？', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p> 正好相反。\r\n人生其实是一场轮回，一场强迫性重复。\r\n人生的内在关系模式，在3岁之前就已经固定；3岁以后的人生，只是在重复3岁之前的强迫性轮回。\r\n\r\n小时候得到过幸福，生命就会重复幸福；\r\n小时候遭遇不幸，生命就会重重不幸；\r\n小时候一直是挫败，生命就会遭遇挫败；\r\n小时候能够轻易成功，生命历程中就会重复成功。</p>', '2022-02-28 14:29', '0');
INSERT INTO `passage` VALUES ('12', '2022.3.1系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>今天系统主要更新了与后台管理页面有关的内容，同时修复了一个比较重要的bug</p>\r\n<p>首先先说一下这个bug吧，简单记录一下，这个bug出现在了对课程、首页文章的“编辑”操作上，每次我点编辑，后台都会通过按钮绑定的id给我返回这条文章或者课程的数据，但是一旦我确认编辑了之后，在想要对其他文章或者视频编辑的时候，我刚才编辑的其中一条内容就会显示到这个视频或者文章的编辑数据中来，后来看了一下源码，发现input内的数据显示成了上一个数据，但是value值是没问题的，带着这个问题我找到了csdn上解决有关于jquery的attr问题，有大哥说改成prop就好了，我改了一下真的好使了</p>\r\n<p>今天更新的内容，后台的心理咨询师审批、课程管理、钱包管理的搜索功能，同时新增了课程管理的添加功能，计划今天把用户信息管理的搜索功能也做出来，分页过两天做，太累了</p>', '2022-03-01 15:13', '0');
INSERT INTO `passage` VALUES ('13', '2022.3.2系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>今天更新了许多地方的翻页功能，主要还是体现在后台</p>\r\n<p>后台：心理咨询师审批、课程管理、钱包管理、用户信息管理的分页。明天打算弄一下统计分析以及用户信息管理的编辑和删除功能，休息了</p>', '2022-03-02 14:57', '0');
INSERT INTO `passage` VALUES ('14', '2022.3.3系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>今天完善了一下后台，把用户信息管理所有内容都做出来了，同时今天还打算做一下“统计分析”模块的内容，还没有什么好的想法，大家有好的想法可以发给我（虽然没人看这条信息）</p>', '2022-03-03 15:04', '0');
INSERT INTO `passage` VALUES ('15', '2022.3.4系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>今天摸鱼，把后台统计分析的剩下数据都做出来了，明天把课程分页和搜索做了，后天开始研究预约和咨询的事！</p>', '2022-03-04 14:54', '0');
INSERT INTO `passage` VALUES ('16', '2022.3.5系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>今天更新了一下用户使用的页面：课程，这个页面其实之前设想过许多东西，可以付费之类的，目前就把它当成一个免费的看视频的地方吧。添加了翻页、搜索功能，中间搜索功能制作时出现了点问题。</p>\r\n<p>问题主要出现于，进入课程页面后右上角即显示自己的名字，也显示登录、注册按钮，这个问题出现过很多次了，之前排查过问题，后来发现是因为头文件里面的js有window.onload，而且下面的页面内容也有window.onload，发生了这种问题之后只好把头文件里面js代码复制放到下面的页面js代码里一份了，这是第一个问题。第二个问题是做搜索功能的时候，点击搜索下面全变白了，我就一步一步推，用alert进行测试，看看哪部分数据没进来，后来发现是因为ajax导入data的时候需要名称和后台的形参名称一致，以后需要多注意！</p>', '2022-03-05 16:41', '0');
INSERT INTO `passage` VALUES ('17', '2022.3.10系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>摸了好几天鱼之后爆发一波，今天把预约整个功能做好了，研究了两天的聊天室，一开始打算用websocket发现太麻烦，问了下好朋友，他表示可以用node.js做一个很简单的就行，他发给我了一个以前做过的，我点了一下确实简单，所以我就让他帮我做了233</p>\r\n<p>除了预约功能外，今天把用户个人中心页面的订单也实现出来了，没有实现的就是里面的按钮功能，明天有空搞</p>', '2022-03-10 19:07', '0');
INSERT INTO `passage` VALUES ('18', '2022.3.13系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>又躺了两天，今天把毕设最后剩的东西基本都做完了，把订单里面的几个操作做出来了，然后就是首页内的咨询，用的聊天室，还是有一些弊端的，比如用户和心理咨询师只能同时给一个用户咨询，必须咨询完一个之后才能继续给另一个人咨询，毕业设计的内容大体上就这么多，做的也差不多了，其他的就是细节上的问题了，比如说我现在用的这个添加文章当时我记得是没有添加非空的判断，这个后期一点点测试吧，在歇两天</p>', '2022-03-13 15:18', '0');
INSERT INTO `passage` VALUES ('19', '2022.3.17系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>更新内容</p>\r\n<p>3.个人中心的订单模块：实现完成订单后收付款功能，同时用户预约时增加一个钱数的判断，如果钱不够不能预约。</p>\r\n<p>4.个人中心的订单模块：增加价格属性。</p>', '2022-03-17 14:07', '0');
INSERT INTO `passage` VALUES ('20', '2022.3.19系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>更新内容</p>\r\n<p>1.首页统计分析：点击可查看详情信息。</p>\r\n<p>2.预约专家模块：新增搜索、翻页功能。</p>', '2022-03-19 15:11', '0');
INSERT INTO `passage` VALUES ('21', '2022.3.29系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>5.用户注册和登录和修改密码时的密码加密、解密功能。</p>\r\n<p>6.用户的session信息问题，确保后台重新发布后session无错误。</p>', '2022-03-29 17:50', '0');
INSERT INTO `passage` VALUES ('22', '2022.4.9系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>好久没更新了，需要优化的东西还是很多的，今晚把心理测评的样式以及个人中心内“设置”和“管理员界面”优化了一下</p>', '2022-04-09 21:39', '0');
INSERT INTO `passage` VALUES ('23', '2022.4.11系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>今天优化了一下个人中心的“首页”，同时心理咨询师使用订单的时候可以观看每个申请预约的用户都得到了多少测评分数，很累，歇了。</p>', '2022-04-11 18:48', '0');
INSERT INTO `passage` VALUES ('24', '2022.4.14系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>优化了个人中心的钱包模块以及个人中心的注册心理咨询师模块</p>', '2022-04-14 07:44', '0');
INSERT INTO `passage` VALUES ('25', '2022.4.25系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>今天更新了心理测评有关的功能，目前个人可以查看心理测评的历史记录了，咨询师在后续的更新中也能够查看客户的测评历史记录</p>', '2022-04-25 14:22', '0');
INSERT INTO `passage` VALUES ('26', '2022.4.26系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>优化了心理测评后生成的报告界面，搞了一天很累，然后弄了一下报告的生成界面，问题还是蛮多的，一开始全覆盖阴影错乱，找了一个多小时才发现这个问题出自哪里，最后下载出来的图片里html内置导入的图有问题，无法正常显示，这个没办法修改了，害</p>', '2022-04-26 22:18', '0');
INSERT INTO `passage` VALUES ('27', '2022.4.29系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>今天和昨天做了一下咨询师方面的功能，目前咨询师可以查看预约用户的心理测评历史记录了，同时心理咨询界面添加了房间的选择，心理咨询师可以选择用户的房间进行咨询，用来解决咨询纠纷的客服方面还未完善</p>', '2022-04-29 15:17', '1');
INSERT INTO `passage` VALUES ('28', '2022.4.30系统更新公告', 'http://nickyzj.run:12450/lychee/uploads/big/6eb978d63d906ae7a3e0b0122ba148bf.png', '<p>优化了心理咨询、心理咨询预约的流程，添加了客服账号</p>', '2022-04-30 15:16', '1');

-- ----------------------------
-- Table structure for `purse`
-- ----------------------------
DROP TABLE IF EXISTS `purse`;
CREATE TABLE `purse` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `user_id` int(2) NOT NULL,
  `money` varchar(10) NOT NULL DEFAULT '0',
  `inMoney` varchar(10) DEFAULT '',
  `outMoney` varchar(10) DEFAULT '',
  `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `PID` (`user_id`),
  CONSTRAINT `PID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of purse
-- ----------------------------
INSERT INTO `purse` VALUES ('1', '1', '13450', '', '', '0');
INSERT INTO `purse` VALUES ('2', '2', '20161', '', '', '0');
INSERT INTO `purse` VALUES ('3', '3', '30000', '', '', '4');
INSERT INTO `purse` VALUES ('5', '5', '1000', '', '', '0');
INSERT INTO `purse` VALUES ('6', '6', '0', '', '', '0');
INSERT INTO `purse` VALUES ('7', '7', '10', '', '', '0');
INSERT INTO `purse` VALUES ('8', '8', '0', '', '', '0');
INSERT INTO `purse` VALUES ('9', '9', '200', '', '', '0');
INSERT INTO `purse` VALUES ('10', '10', '0', '', '', '0');
INSERT INTO `purse` VALUES ('11', '11', '400', '', '', '0');
INSERT INTO `purse` VALUES ('12', '12', '1500', '', '', '0');
INSERT INTO `purse` VALUES ('13', '13', '4600', '', '', '0');

-- ----------------------------
-- Table structure for `score`
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `user_id` int(2) NOT NULL,
  `title_id` int(2) NOT NULL,
  `grades` int(3) NOT NULL,
  `createAt` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `SID` (`user_id`),
  CONSTRAINT `SID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('1', '1', '1', '33', '2022-04-25 13:00');
INSERT INTO `score` VALUES ('2', '1', '2', '45', '2022-04-25 13:00');
INSERT INTO `score` VALUES ('3', '2', '3', '8', '2022-04-25 13:00');
INSERT INTO `score` VALUES ('4', '1', '3', '27', '2022-04-25 13:00');
INSERT INTO `score` VALUES ('5', '1', '4', '60', '2022-04-25 13:00');
INSERT INTO `score` VALUES ('6', '5', '1', '33', '2022-04-25 13:00');
INSERT INTO `score` VALUES ('7', '1', '1', '33', '2022-04-25 13:00');
INSERT INTO `score` VALUES ('8', '1', '1', '39', '2022-04-25 13:04');
INSERT INTO `score` VALUES ('9', '1', '4', '50', '2022-04-25 14:19');
INSERT INTO `score` VALUES ('10', '1', '1', '36', '2022-05-04 15:39');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `account` varchar(20) NOT NULL COMMENT '账号',
  `password` varchar(50) NOT NULL,
  `name` varchar(5) NOT NULL,
  `sex` varchar(5) NOT NULL,
  `email` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `status` int(1) NOT NULL,
  `createAt` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '21232F297A57A5A743894A0E4A801FC3', '王君博', '男', '342133194@qq.com', '18249837995', '2', '2022-01-05 19:56');
INSERT INTO `user` VALUES ('2', '56613130', '1034164A6BF90E12A53A30C777F84579', '狗磊', '男', '56613130@qq.com', '13356815217', '1', '2022-01-05 19:56');
INSERT INTO `user` VALUES ('3', '572460957', '1034164A6BF90E12A53A30C777F84579', '黄金欣宇', '男', '572460957@qq.com', '18249837995', '1', '2022-01-05 19:56');
INSERT INTO `user` VALUES ('5', '572466956', '1034164A6BF90E12A53A30C777F84579', '外比八步', '男', '342133194@qq.com', '13356815217', '0', '2022-01-05 19:56');
INSERT INTO `user` VALUES ('6', '1151515190', '1034164A6BF90E12A53A30C777F84579', '上官乐强', '女', '56613130@qq.com', '18249837995', '0', '2022-01-09 11:18');
INSERT INTO `user` VALUES ('7', '123456789', '1034164A6BF90E12A53A30C777F84579', '欣宇龙导', '女', '572460957@qq.com', '11111111111', '1', '2022-01-09 11:25');
INSERT INTO `user` VALUES ('8', '7777777777', '1034164A6BF90E12A53A30C777F84579', '王君博', '男', '342133194@qq.com', '18249837995', '0', '2022-01-09 11:30');
INSERT INTO `user` VALUES ('9', '98765432', '1034164A6BF90E12A53A30C777F84579', '犬犬', '女', '342133194@qq.com', '13356815217', '0', '2022-01-10 17:23');
INSERT INTO `user` VALUES ('10', '1927139831', 'B40F06E7160CCD0F5AC9B79050C964E6', '杨智杰', '女', '1927139831@qq.com', '13356815217', '1', '2022-03-02 14:32');
INSERT INTO `user` VALUES ('11', '471899040', 'B40F06E7160CCD0F5AC9B79050C964E6', '昊天斗罗', '男', 'cxymgh@163.com', '11011101110', '1', '2022-03-02 14:32');
INSERT INTO `user` VALUES ('12', '1287617769', '1034164A6BF90E12A53A30C777F84579', '王保安', '男', '1287617769@qq.com', '13356815217', '1', '2022-03-19 15:02');
INSERT INTO `user` VALUES ('13', '1018519667', 'B40F06E7160CCD0F5AC9B79050C964E6', '范津铭', '男', '1018519667@qq.com', '13356815217', '0', '2022-03-29 17:41');
