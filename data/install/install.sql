/*
Navicat MySQL Data Transfer

Source Server         : 线下
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : cms

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2019-02-02 13:25:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cms_ad
-- ----------------------------
DROP TABLE IF EXISTS `cms_ad`;
CREATE TABLE `cms_ad` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `ad_name` varchar(60) DEFAULT NULL COMMENT '广告名称',
  `status` tinyint(1) DEFAULT '1' COMMENT '是否使用（1.是 0.否）',
  `link` varchar(100) DEFAULT NULL COMMENT '链接',
  `type` tinyint(1) DEFAULT '1' COMMENT '广告类型（1.图片广告 2.轮播广告）',
  `file` varchar(150) DEFAULT NULL COMMENT '图片',
  `adpos_id` smallint(6) DEFAULT NULL COMMENT '广告位id',
  `sort` smallint(5) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_ad
-- ----------------------------
INSERT INTO `cms_ad` VALUES ('26', '测试', '0', 'www.baidu.com', '1', 'ad/20190122/26e635382ca17e12f9e7678bbf1ab5cc.jpg', '9', '5');
INSERT INTO `cms_ad` VALUES ('27', '轮播', '1', '', '2', null, '9', '50');
INSERT INTO `cms_ad` VALUES ('28', '', '0', '', '1', null, '0', '50');
INSERT INTO `cms_ad` VALUES ('29', '', '1', '', '1', null, '0', '50');
INSERT INTO `cms_ad` VALUES ('30', '测试', '1', 'www.baidu.com', '1', null, '10', '50');
INSERT INTO `cms_ad` VALUES ('31', '轮播2', '1', 'http://meaty.top/cms/public/index.php/admin/ad/add.html', '1', null, '11', '50');
INSERT INTO `cms_ad` VALUES ('32', '测试', '1', 'sdf', '1', 'ad/20190127/2f45610ada6c4c55e45753cdcb0ea145.png', '13', '50');

-- ----------------------------
-- Table structure for cms_adflash
-- ----------------------------
DROP TABLE IF EXISTS `cms_adflash`;
CREATE TABLE `cms_adflash` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileimg` varchar(150) DEFAULT NULL,
  `filelink` varchar(150) DEFAULT NULL,
  `ad_id` smallint(6) DEFAULT NULL COMMENT '广告id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_adflash
-- ----------------------------
INSERT INTO `cms_adflash` VALUES ('19', 'ad/20190122/c44dea2d4ddaf08964c826445588d9de.jpg', 'http://www.baidu.com', '27');
INSERT INTO `cms_adflash` VALUES ('23', 'ad/20190122/ddfb864566c4b4faad2d24ed20a084e5.gif', 'http://www.wu.com', '27');

-- ----------------------------
-- Table structure for cms_admin
-- ----------------------------
DROP TABLE IF EXISTS `cms_admin`;
CREATE TABLE `cms_admin` (
  `uid` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理id',
  `uname` varchar(60) DEFAULT NULL COMMENT '管理员名称',
  `password` char(100) DEFAULT NULL COMMENT '密码',
  `create_time` varchar(11) DEFAULT NULL COMMENT '创建时间',
  `last_time` varchar(11) DEFAULT NULL COMMENT '最后登录时间',
  `status` smallint(1) DEFAULT '1' COMMENT '使用状态(1.正常 0.禁用)',
  `gruopid` mediumint(9) unsigned NOT NULL COMMENT '所属用户组',
  PRIMARY KEY (`uid`),
  KEY `用户组` (`gruopid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_admin
-- ----------------------------
INSERT INTO `cms_admin` VALUES ('13', 'admin', 'b30eb6cd4e5233bf8ecd2fb3efc01d85', '1548264984', '1549027711', '1', '2');

-- ----------------------------
-- Table structure for cms_article
-- ----------------------------
DROP TABLE IF EXISTS `cms_article`;
CREATE TABLE `cms_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(150) DEFAULT NULL COMMENT '文章标题',
  `keywords` varchar(150) DEFAULT NULL COMMENT '关键字',
  `describe` varchar(255) DEFAULT NULL COMMENT '描述',
  `author` varchar(60) DEFAULT NULL COMMENT '作者',
  `source` varchar(100) DEFAULT NULL COMMENT '来源',
  `litpic` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `attr` varchar(60) DEFAULT NULL COMMENT '属性',
  `click` mediumint(9) DEFAULT NULL COMMENT '点击量',
  `content` longtext COMMENT '内容',
  `cate_id` int(10) DEFAULT NULL COMMENT '栏目id',
  `model_id` int(10) DEFAULT NULL COMMENT '模型id',
  `addtime` varchar(12) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cms_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `cms_auth_group`;
CREATE TABLE `cms_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_auth_group
-- ----------------------------
INSERT INTO `cms_auth_group` VALUES ('1', '会计组', '1', '10,11,12,13,14,54');
INSERT INTO `cms_auth_group` VALUES ('2', '超级管理员组', '1', '1,2,3,53,10,11,12,55,60,61,13,51,14,15,20,23,21,22,24,52,25,26,27,28,29,30,31,59,32,33,34,35,36,37,38,39,56,57,58,40,41,42,43,44,45,46,47,48,49,50');

-- ----------------------------
-- Table structure for cms_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `cms_auth_group_access`;
CREATE TABLE `cms_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_auth_group_access
-- ----------------------------
INSERT INTO `cms_auth_group_access` VALUES ('11', '1');
INSERT INTO `cms_auth_group_access` VALUES ('12', '2');
INSERT INTO `cms_auth_group_access` VALUES ('13', '2');

-- ----------------------------
-- Table structure for cms_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `cms_auth_rule`;
CREATE TABLE `cms_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则上级id 0表示顶级g规则id',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则名',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `condition` char(100) NOT NULL DEFAULT '',
  `pid` mediumint(9) DEFAULT NULL COMMENT '上级规则id',
  `icon` char(100) DEFAULT NULL COMMENT '图标',
  `show` tinyint(1) DEFAULT '1' COMMENT '菜单是否在左边显示（1.显示 0.不显示）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_auth_rule
-- ----------------------------
INSERT INTO `cms_auth_rule` VALUES ('1', 'admin/Conf', '系统配置', '1', '1', '', '0', 'icon-settings', '1');
INSERT INTO `cms_auth_rule` VALUES ('2', 'admin/Conf/confList', '配置列表', '1', '1', '', '1', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('3', 'admin/Conf/cSave', '配置添加', '1', '1', '', '1', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('10', 'admin/Cate', '导航管理', '1', '1', '', '0', 'icon-text', '1');
INSERT INTO `cms_auth_rule` VALUES ('51', 'admin/Admin/loginOut', '注销', '1', '1', '', '13', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('52', 'admin/AuthGroup/auth', '权限配置', '1', '1', '', '24', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('11', 'admin/Cate/save', '导航添加', '1', '1', '', '10', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('12', 'admin/Cate/lst', '导航列表', '1', '1', '', '10', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('13', 'admin/Admin', '管理员管理', '1', '1', '', '0', 'icon-people', '1');
INSERT INTO `cms_auth_rule` VALUES ('14', 'admin/Admin/lst', '管理员列表', '1', '1', '', '13', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('15', 'admin/Admin/add', '管理员添加', '1', '1', '', '13', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('23', 'admin/AuthRule/edit', '权限修改', '1', '1', '', '20', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('21', 'admin/AuthRule/lst', '权限列表', '1', '1', '', '20', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('22', 'admin/AuthRule/add', '权限添加', '1', '1', '', '20', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('20', 'admin/AuthRule', '权限管理', '1', '1', '', '0', 'icon-friendadd text-orange-light', '1');
INSERT INTO `cms_auth_rule` VALUES ('24', 'admin/AuthGroup', '用户组管理', '1', '1', '', '0', 'icon-friend', '1');
INSERT INTO `cms_auth_rule` VALUES ('25', 'admin/AuthGroup/lst', '用户组列表', '1', '1', '', '24', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('26', 'admin/AuthGroup/add', '用户组添加', '1', '1', '', '24', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('27', 'admin/AuthGroup/edit', '用户组修改', '1', '1', '', '24', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('28', 'admin/Model', '模型管理', '1', '1', '', '0', 'icon-goods', '1');
INSERT INTO `cms_auth_rule` VALUES ('29', 'admin/Model/lst', '模型列表', '1', '1', '', '28', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('30', 'admin/Model/add', '模型添加', '1', '1', '', '28', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('31', 'admin/Model/edit', '模型修改', '1', '1', '', '28', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('32', 'admin/ModelField', '字段管理', '1', '1', '', '0', 'icon-shop', '1');
INSERT INTO `cms_auth_rule` VALUES ('33', 'admin/ModelField/lst', '字段列表', '1', '1', '', '32', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('34', 'admin/ModelField/add', '字段添加', '1', '1', '', '32', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('35', 'admin/ModelField/edit', '字段修改', '1', '1', '', '32', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('36', 'admin/Article', '文章管理', '1', '1', '', '0', 'icon-shop', '1');
INSERT INTO `cms_auth_rule` VALUES ('37', 'admin/Article/lst', '文章列表', '1', '1', '', '36', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('38', 'admin/Article/edit', '文章修改', '1', '1', '', '36', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('39', 'admin/Article/add', '文章添加', '1', '1', '', '36', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('40', 'admin/Note', '采集管理', '1', '1', '', '0', 'icon-shop', '1');
INSERT INTO `cms_auth_rule` VALUES ('41', 'admin/Note/lst', '采集列表', '1', '1', '', '40', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('42', 'admin/Note/addlr', '添加采集', '1', '1', '', '40', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('43', 'admin/Note/showcaiji', '执行采集', '1', '1', '', '40', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('44', 'admin/Note/edit', '采集修改', '1', '1', '', '40', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('45', 'admin/Position', '广告管理', '1', '1', '', '0', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('46', 'admin/Position/lst', '广告位列表', '1', '1', '', '45', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('47', 'admin/Position/add', '广告位添加', '1', '1', '', '45', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('48', 'admin/Position/edit', '广告位修改', '1', '1', '', '45', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('49', 'admin/Ad/lst', '广告列表', '1', '1', '', '45', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('50', 'admin/Ad/add', '广告添加', '1', '1', '', '45', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('53', 'admin/Conf/clist', '配置管理', '1', '1', '', '1', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('55', 'admin/Cate/edit', '导航修改', '1', '1', '', '10', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('56', 'admin/Article/addSelect', '文章添加2', '1', '1', '', '36', null, '1');
INSERT INTO `cms_auth_rule` VALUES ('57', 'admin/Article/ajaxAddSelect', '文章-添加', '1', '1', '', '36', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('58', 'admin/Article/del', '文章删除', '1', '1', '', '36', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('59', 'admin/Model/del', '模型删除', '1', '1', '', '28', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('60', 'admin/Cate/del', '导航删除1', '1', '1', '', '10', null, '0');
INSERT INTO `cms_auth_rule` VALUES ('61', 'admin/Cate/delete', '导航删除2', '1', '1', '', '10', null, '0');

-- ----------------------------
-- Table structure for cms_cate
-- ----------------------------
DROP TABLE IF EXISTS `cms_cate`;
CREATE TABLE `cms_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '导航id',
  `pid` int(10) DEFAULT '0' COMMENT '上级id',
  `cate_name` varchar(50) DEFAULT NULL COMMENT '导航名称',
  `title` varchar(60) DEFAULT NULL COMMENT '导航标题',
  `keywords` varchar(100) DEFAULT NULL COMMENT '关键字',
  `desc` varchar(255) DEFAULT NULL COMMENT '描述',
  `content` text COMMENT '导航内容',
  `enabled` smallint(1) DEFAULT NULL COMMENT '是否隐藏(0.隐藏 1.显示)',
  `jump_id` tinyint(4) NOT NULL DEFAULT '0' COMMENT '跳转到哪个栏目（0.无跳转）',
  `img` varchar(150) DEFAULT NULL COMMENT '导航图片',
  `cate_attr` smallint(1) DEFAULT NULL COMMENT '导航属性(1.列表 2.频道 3.外链)',
  `list_tmp` varchar(60) DEFAULT NULL COMMENT '导航列表模板',
  `index_tmp` varchar(60) DEFAULT NULL COMMENT '频道模板',
  `article_tmp` varchar(60) DEFAULT NULL COMMENT '内容平模板',
  `sort` smallint(6) DEFAULT '50' COMMENT '排序',
  `model_id` smallint(4) DEFAULT '1' COMMENT '所属模型',
  `link` varchar(255) DEFAULT NULL COMMENT '导航外链',
  `foot_nav` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否在底部显示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_cate
-- ----------------------------
INSERT INTO `cms_cate` VALUES ('35', '0', '关于我们', '关于我们', '关于我们', '关于我们', '<p>关于我们<br></p>', '1', '36', null, '2', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '1');
INSERT INTO `cms_cate` VALUES ('36', '35', '公司简介', '公司简介', '公司简介', '公司简介', '<p>公司简介<br></p>', '1', '0', null, '2', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '1');
INSERT INTO `cms_cate` VALUES ('37', '35', '生产基地', '生产基地', '生产基地', '生产基地', '<p>生产基地<br></p>', '1', '0', null, '2', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '1');
INSERT INTO `cms_cate` VALUES ('38', '35', '资质荣誉', '资质荣誉', '资质荣誉', '资质荣誉', '<p>资质荣誉<br></p>', '1', '0', null, '2', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '0');
INSERT INTO `cms_cate` VALUES ('39', '0', '新闻动态', '新闻动态', '新闻动态', '新闻动态', '<p>新闻动态<br></p>', '1', '40', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '1');
INSERT INTO `cms_cate` VALUES ('40', '39', '公司新闻', '公司新闻', '公司新闻', '公司新闻', '<p>公司新闻<br></p>', '1', '0', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '1');
INSERT INTO `cms_cate` VALUES ('41', '39', '行业动态', '行业动态', '行业动态', '行业动态', '<p>行业动态<br></p>', '1', '0', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '1');
INSERT INTO `cms_cate` VALUES ('42', '0', '产品中心', '产品中心', '产品中心', '产品中心', '<p>产品中心<br></p>', '1', '43', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '0');
INSERT INTO `cms_cate` VALUES ('43', '42', '产品分类一', '产品分类一', '产品分类一', '产品分类一', '<p>产品分类一<br></p>', '1', '0', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '0');
INSERT INTO `cms_cate` VALUES ('44', '42', '产品分类二', '产品分类二', '产品分类二', '产品分类二', '<p>产品分类二<br></p>', '1', '0', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '0');
INSERT INTO `cms_cate` VALUES ('45', '0', '技术服务', '技术服务', '技术服务', '技术服务', '<p>技术服务<br></p>', '1', '46', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '0');
INSERT INTO `cms_cate` VALUES ('46', '45', '研究成果', '研究成果', '研究成果', '研究成果', '<p>研究成果<br></p>', '1', '0', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '0');
INSERT INTO `cms_cate` VALUES ('47', '0', '联系我们', '联系我们', '联系我们', '联系我们', '<p>联系我们<br></p>', '1', '0', null, '1', 'list_article.html', 'index_article.html', 'article_article.html', '50', '37', '', '0');

-- ----------------------------
-- Table structure for cms_ceshi2
-- ----------------------------
DROP TABLE IF EXISTS `cms_ceshi2`;
CREATE TABLE `cms_ceshi2` (
  `aid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_ceshi2
-- ----------------------------

-- ----------------------------
-- Table structure for cms_conf
-- ----------------------------
DROP TABLE IF EXISTS `cms_conf`;
CREATE TABLE `cms_conf` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置项id',
  `cname` varchar(60) NOT NULL COMMENT '配置中文名称',
  `ename` varchar(60) NOT NULL COMMENT '配置英文名称',
  `value` varchar(100) NOT NULL COMMENT '默认值',
  `valuess` varchar(255) NOT NULL COMMENT '可选值',
  `dt_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1.文本输入框 2.单选 3.复选 4.下拉菜单 5.文本域 6.附件类型',
  `cf_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1.站点基本信息 2.联系方式 3.SEO设置',
  `enabled` tinyint(1) DEFAULT '1' COMMENT '是否启用（1.启用 0.不启用）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='系统配置信息';

-- ----------------------------
-- Records of cms_conf
-- ----------------------------
INSERT INTO `cms_conf` VALUES ('62', '邮政编码', 'code', '4524451111', '', '1', '1', '1');
INSERT INTO `cms_conf` VALUES ('63', '邮箱', 'E-mail', '10967284454@qq.ccom', '', '1', '2', '1');
INSERT INTO `cms_conf` VALUES ('59', '站点默认关键字', 'keyword', '苹果,三星,索尼,华为,魅族,佳能,小米,美的,格力', '苹果,三星,索尼,华为,魅族,佳能,小米,美的,格力', '5', '3', '1');
INSERT INTO `cms_conf` VALUES ('66', '联系方式', 'aaaa', '', 'QQ,电话,微信', '3', '2', '1');
INSERT INTO `cms_conf` VALUES ('56', 'QQ', 'qq', '45274527', '', '1', '1', '1');
INSERT INTO `cms_conf` VALUES ('57', '地址', 'address', 'nghgh', '', '1', '2', '1');
INSERT INTO `cms_conf` VALUES ('58', '网站logo', 'logo', 'conf/20181020\\cf60f65600b1a283e9d93a2b1ff1fcc9.png', '', '6', '1', '1');
INSERT INTO `cms_conf` VALUES ('55', '电话', 'phone', '1376061549', '', '1', '2', '1');
INSERT INTO `cms_conf` VALUES ('53', '站点描述', 'desc', '7257', '', '5', '1', '1');
INSERT INTO `cms_conf` VALUES ('54', '网站备案号', 'record', '75272', '', '1', '1', '1');
INSERT INTO `cms_conf` VALUES ('52', '开启缓存', 'iscache', '是', '是,否', '2', '1', '1');
INSERT INTO `cms_conf` VALUES ('50', '网站名称', 'webName', 'www.meaty.top', '', '1', '1', '1');
INSERT INTO `cms_conf` VALUES ('51', '网站版权信息', 'Copyright', '782782', '', '5', '1', '1');
INSERT INTO `cms_conf` VALUES ('64', '热门搜索', 'hotSearch', '苹果,三星,索尼,华为,魅族,佳能,小米,美的,格力', '苹果,三星,索尼,华为,魅族,佳能,小米,美的,格力', '1', '3', '1');
INSERT INTO `cms_conf` VALUES ('67', '是否添加缩略图', 'thum_bnail', '否', '是,否', '2', '1', '1');
INSERT INTO `cms_conf` VALUES ('68', '是否添加水印', 'watermark', '是', '是,否', '2', '1', '1');
INSERT INTO `cms_conf` VALUES ('69', '缩略图宽度', 'thum_width', '200', '', '1', '1', '1');
INSERT INTO `cms_conf` VALUES ('70', '缩略图高度', 'thum_height', '200', '', '1', '1', '1');
INSERT INTO `cms_conf` VALUES ('71', '缩略图裁剪位置', 'thum_type', '等比例缩放', '等比例缩放,缩放后填充,居中裁剪,左上角裁剪,右下角裁剪,固定尺寸缩放', '2', '1', '1');
INSERT INTO `cms_conf` VALUES ('72', '水印位置', 'water_position', '右下角', '左上角,上居中,右上角,左居中,居中,右居中,左下角,下居中,右下角', '2', '1', '1');
INSERT INTO `cms_conf` VALUES ('73', '水印透明度', 'water_tmd', '40', '', '1', '1', '1');
INSERT INTO `cms_conf` VALUES ('74', '水印', 'water', 'conf/20190127/9477d2be19cbd3358550023ae4d5d671.png', '', '6', '1', '1');
INSERT INTO `cms_conf` VALUES ('75', '模板', 'temp', 'default', '', '1', '1', '1');

-- ----------------------------
-- Table structure for cms_content
-- ----------------------------
DROP TABLE IF EXISTS `cms_content`;
CREATE TABLE `cms_content` (
  `aid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_content
-- ----------------------------
INSERT INTO `cms_content` VALUES ('25');
INSERT INTO `cms_content` VALUES ('28');
INSERT INTO `cms_content` VALUES ('31');

-- ----------------------------
-- Table structure for cms_film
-- ----------------------------
DROP TABLE IF EXISTS `cms_film`;
CREATE TABLE `cms_film` (
  `aid` int(10) unsigned NOT NULL,
  `daoyan` varchar(150) NOT NULL DEFAULT '' COMMENT '导演',
  `yanyuan` varchar(150) NOT NULL DEFAULT '' COMMENT '演员',
  `jianzhi` varchar(600) NOT NULL DEFAULT '' COMMENT '监制',
  `juqing` varchar(150) NOT NULL DEFAULT '' COMMENT '剧情',
  `yuyan` varchar(150) NOT NULL DEFAULT '' COMMENT '语言',
  `chandi` varchar(150) NOT NULL DEFAULT '' COMMENT '产地',
  `jianjie` varchar(600) NOT NULL DEFAULT '' COMMENT '简介',
  `juzhao` varchar(150) NOT NULL DEFAULT '' COMMENT '剧照',
  `xiangqing` longtext COMMENT '详情',
  `zhutu` varchar(150) NOT NULL DEFAULT '' COMMENT '主图',
  `file` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_film
-- ----------------------------
INSERT INTO `cms_film` VALUES ('24', '', '', '', '', '', '', '', '', null, '', null);
INSERT INTO `cms_film` VALUES ('26', '', '', '', '', '', '', '', '', null, '', null);
INSERT INTO `cms_film` VALUES ('27', '', '', '', '', '', '', '', '', null, '', null);
INSERT INTO `cms_film` VALUES ('29', '', '', '', '', '', '', '', '', null, '', null);
INSERT INTO `cms_film` VALUES ('30', '', '', '', '', '', '', '', '', null, '', null);
INSERT INTO `cms_film` VALUES ('22', '', '', '', '', '', '', '', '', null, '', null);

-- ----------------------------
-- Table structure for cms_html
-- ----------------------------
DROP TABLE IF EXISTS `cms_html`;
CREATE TABLE `cms_html` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nid` mediumint(9) NOT NULL COMMENT '采集节点的ID',
  `title` varchar(150) NOT NULL COMMENT '文章标题',
  `addtime` varchar(11) NOT NULL COMMENT '采集时间',
  `export` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否导出：0未导出，1导出',
  `result` longtext NOT NULL COMMENT '采集结果集',
  `url` varchar(150) NOT NULL COMMENT '采集路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_html
-- ----------------------------
INSERT INTO `cms_html` VALUES ('382', '34', '人生哲理：得饶人处且饶人，话到嘴边留三分', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u5f97\\u9976\\u4eba\\u5904\\u4e14\\u9976\\u4eba\\uff0c\\u8bdd\\u5230\\u5634\\u8fb9\\u7559\\u4e09\\u5206\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/73456.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/10\\/weimetu01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/10/weimetu01160.jpg');
INSERT INTO `cms_html` VALUES ('383', '34', '人生哲理：树叶不是一天黄的，人心不是一天凉的', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u6811\\u53f6\\u4e0d\\u662f\\u4e00\\u5929\\u9ec4\\u7684\\uff0c\\u4eba\\u5fc3\\u4e0d\\u662f\\u4e00\\u5929\\u51c9\\u7684\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/73454.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/10\\/weimetu03160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/10/weimetu03160.jpg');
INSERT INTO `cms_html` VALUES ('384', '34', '人生哲理：有一种心累是人到中年，过一天少一天！', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u6709\\u4e00\\u79cd\\u5fc3\\u7d2f\\u662f\\u4eba\\u5230\\u4e2d\\u5e74\\uff0c\\u8fc7\\u4e00\\u5929\\u5c11\\u4e00\\u5929\\uff01\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/73452.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/10\\/weimetu02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/10/weimetu02160.jpg');
INSERT INTO `cms_html` VALUES ('385', '34', '人生哲理：学会乐观，别让琐事，挤走快乐', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u5b66\\u4f1a\\u4e50\\u89c2\\uff0c\\u522b\\u8ba9\\u7410\\u4e8b\\uff0c\\u6324\\u8d70\\u5feb\\u4e50\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/73450.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/10\\/weimetu05160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/10/weimetu05160.jpg');
INSERT INTO `cms_html` VALUES ('386', '34', '人生哲理：珍惜眼前人，走好脚下路', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u73cd\\u60dc\\u773c\\u524d\\u4eba\\uff0c\\u8d70\\u597d\\u811a\\u4e0b\\u8def\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/73110.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/10\\/sheng09160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/10/sheng09160.jpg');
INSERT INTO `cms_html` VALUES ('387', '34', '人生哲理：生命中握不住的，都要学会放下', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u751f\\u547d\\u4e2d\\u63e1\\u4e0d\\u4f4f\\u7684\\uff0c\\u90fd\\u8981\\u5b66\\u4f1a\\u653e\\u4e0b\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/73018.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/10\\/gangan04160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/10/gangan04160.jpg');
INSERT INTO `cms_html` VALUES ('388', '34', '人生哲理：没有做不好的事；只有做不好事的人', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u6ca1\\u6709\\u505a\\u4e0d\\u597d\\u7684\\u4e8b\\uff1b\\u53ea\\u6709\\u505a\\u4e0d\\u597d\\u4e8b\\u7684\\u4eba\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/72217.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/10\\/weimein03160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/10/weimein03160.jpg');
INSERT INTO `cms_html` VALUES ('389', '34', '两口子再生气，也别在这三个地方吵架！', '1547486121', '0', '{\"title\":\"\\u4e24\\u53e3\\u5b50\\u518d\\u751f\\u6c14\\uff0c\\u4e5f\\u522b\\u5728\\u8fd9\\u4e09\\u4e2a\\u5730\\u65b9\\u5435\\u67b6\\uff01\",\"keywords\":\"\\u592b\\u59bb, \\u7236\\u6bcd, \\u751f\\u6d3b\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/72008.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/10\\/meibumei02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/10/meibumei02160.jpg');
INSERT INTO `cms_html` VALUES ('390', '34', '人生哲理：做人太精无路，太苛无友！', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u505a\\u4eba\\u592a\\u7cbe\\u65e0\\u8def\\uff0c\\u592a\\u82db\\u65e0\\u53cb\\uff01\",\"keywords\":\"\\u54f2\\u7406\\u4eba\\u751f, \\u54f2\\u7406\\u7b7e\\u540d, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/71860.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/gongzi03160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/gongzi03160.jpg');
INSERT INTO `cms_html` VALUES ('391', '34', '犹太人的两种神思维，看后深受启发！', '1547486121', '0', '{\"title\":\"\\u72b9\\u592a\\u4eba\\u7684\\u4e24\\u79cd\\u795e\\u601d\\u7ef4\\uff0c\\u770b\\u540e\\u6df1\\u53d7\\u542f\\u53d1\\uff01\",\"keywords\":\"\\u4eba\\u751f\\u667a\\u6167, \\u667a\\u6167, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/71744.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/zhwxi03160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/zhwxi03160.jpg');
INSERT INTO `cms_html` VALUES ('392', '34', '人生哲理：内心强大者的十个特征！', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u5185\\u5fc3\\u5f3a\\u5927\\u8005\\u7684\\u5341\\u4e2a\\u7279\\u5f81\\uff01\",\"keywords\":\"\\u54f2\\u7406\\u4eba\\u751f, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/71712.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/tezheng01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/tezheng01160.jpg');
INSERT INTO `cms_html` VALUES ('393', '34', '真正的用人三境界：用师者王，用友者霸，用徒者亡', '1547486121', '0', '{\"title\":\"\\u771f\\u6b63\\u7684\\u7528\\u4eba\\u4e09\\u5883\\u754c\\uff1a\\u7528\\u5e08\\u8005\\u738b\\uff0c\\u7528\\u53cb\\u8005\\u9738\\uff0c\\u7528\\u5f92\\u8005\\u4ea1\",\"keywords\":\"\\u4eba\\u751f\\u683c\\u8a00, \\u54f2\\u7406\\u4eba\\u751f, \\u54f2\\u7406\\u6545\\u4e8b, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/71338.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/xing02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/xing02160.jpg');
INSERT INTO `cms_html` VALUES ('394', '34', '杨绛：人生在世，谁不吃苦受累？', '1547486121', '0', '{\"title\":\"\\u6768\\u7edb\\uff1a\\u4eba\\u751f\\u5728\\u4e16\\uff0c\\u8c01\\u4e0d\\u5403\\u82e6\\u53d7\\u7d2f\\uff1f\",\"keywords\":\"\\u4eba\\u751f\\u5728\\u4e16, \\u6768\\u7edb, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/71256.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/yangjian01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/yangjian01160.jpg');
INSERT INTO `cms_html` VALUES ('395', '34', '庸人败于惰，庸人败于惰，能人败于傲', '1547486121', '0', '{\"title\":\"\\u5eb8\\u4eba\\u8d25\\u4e8e\\u60f0\\uff0c\\u5eb8\\u4eba\\u8d25\\u4e8e\\u60f0\\uff0c\\u80fd\\u4eba\\u8d25\\u4e8e\\u50b2\",\"keywords\":\"\\u52aa\\u529b, \\u52aa\\u529b\\u594b\\u6597, \\u76ee\\u6807, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/71228.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/pengde02140.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/pengde02140.jpg');
INSERT INTO `cms_html` VALUES ('396', '34', '幽默哲理的句子：失言就是一不小心说了实话', '1547486121', '0', '{\"title\":\"\\u5e7d\\u9ed8\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\uff1a\\u5931\\u8a00\\u5c31\\u662f\\u4e00\\u4e0d\\u5c0f\\u5fc3\\u8bf4\\u4e86\\u5b9e\\u8bdd\",\"keywords\":\"\\u4eba\\u751f, \\u54f2\\u7406, \\u6210\\u719f, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/70789.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/shixing01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/shixing01160.jpg');
INSERT INTO `cms_html` VALUES ('397', '34', '一段经典的君臣对话，值得每个人看看', '1547486121', '0', '{\"title\":\"\\u4e00\\u6bb5\\u7ecf\\u5178\\u7684\\u541b\\u81e3\\u5bf9\\u8bdd\\uff0c\\u503c\\u5f97\\u6bcf\\u4e2a\\u4eba\\u770b\\u770b\",\"keywords\":\"\\u667a\\u6167, \\u70e6\\u607c, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/70760.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/knak01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/knak01160.jpg');
INSERT INTO `cms_html` VALUES ('398', '34', '人生哲理：你的命不好，全是德行在作怪', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u4f60\\u7684\\u547d\\u4e0d\\u597d\\uff0c\\u5168\\u662f\\u5fb7\\u884c\\u5728\\u4f5c\\u602a\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u559d\\u5f69, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/70337.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/fuqing02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/fuqing02160.jpg');
INSERT INTO `cms_html` VALUES ('399', '34', '一个人的风景，一个人的牵挂，一个人的错', '1547486121', '0', '{\"title\":\"\\u4e00\\u4e2a\\u4eba\\u7684\\u98ce\\u666f\\uff0c\\u4e00\\u4e2a\\u4eba\\u7684\\u7275\\u6302\\uff0c\\u4e00\\u4e2a\\u4eba\\u7684\\u9519\",\"keywords\":\"\\u7275\\u6302, \\u751f\\u6d3b\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/70073.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/fengjin01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/fengjin01160.jpg');
INSERT INTO `cms_html` VALUES ('400', '34', '人生哲理：真正聪明的人，往往很少交朋友', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u771f\\u6b63\\u806a\\u660e\\u7684\\u4eba\\uff0c\\u5f80\\u5f80\\u5f88\\u5c11\\u4ea4\\u670b\\u53cb\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/69833.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/shushi02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/shushi02160.jpg');
INSERT INTO `cms_html` VALUES ('401', '34', '人生哲理：人穷别多问，人富别多想', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u4eba\\u7a77\\u522b\\u591a\\u95ee\\uff0c\\u4eba\\u5bcc\\u522b\\u591a\\u60f3\",\"keywords\":\"\\u54f2\\u7406\\u4eba\\u751f, \\u751f\\u5b58, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/69829.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/09\\/shushi01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/09/shushi01160.jpg');
INSERT INTO `cms_html` VALUES ('402', '34', '此地无银三百两，下一句是什么？', '1547486121', '0', '{\"title\":\"\\u6b64\\u5730\\u65e0\\u94f6\\u4e09\\u767e\\u4e24\\uff0c\\u4e0b\\u4e00\\u53e5\\u662f\\u4ec0\\u4e48\\uff1f\",\"keywords\":\"\\u54f2\\u7406\\u6545\\u4e8b, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/69149.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/liang01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/liang01160.jpg');
INSERT INTO `cms_html` VALUES ('403', '34', '人生短暂，欲成大器的人，必须做到此六戒！', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u77ed\\u6682\\uff0c\\u6b32\\u6210\\u5927\\u5668\\u7684\\u4eba\\uff0c\\u5fc5\\u987b\\u505a\\u5230\\u6b64\\u516d\\u6212\\uff01\",\"keywords\":\"\\u54f2\\u7406\\u4eba\\u751f, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/69112.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/leilw02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/leilw02160.jpg');
INSERT INTO `cms_html` VALUES ('404', '34', '晚上睡不着的时候就看看，说得非常富有哲理！', '1547486121', '0', '{\"title\":\"\\u665a\\u4e0a\\u7761\\u4e0d\\u7740\\u7684\\u65f6\\u5019\\u5c31\\u770b\\u770b\\uff0c\\u8bf4\\u5f97\\u975e\\u5e38\\u5bcc\\u6709\\u54f2\\u7406\\uff01\",\"keywords\":\"\\u5bcc\\u6709\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/69108.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/leilw01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/leilw01160.jpg');
INSERT INTO `cms_html` VALUES ('405', '34', '什么是人，三分冷，三分无情，三分冷漠', '1547486121', '0', '{\"title\":\"\\u4ec0\\u4e48\\u662f\\u4eba\\uff0c\\u4e09\\u5206\\u51b7\\uff0c\\u4e09\\u5206\\u65e0\\u60c5\\uff0c\\u4e09\\u5206\\u51b7\\u6f20\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u51b7\\u6f20, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/68996.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/yongyu03160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/yongyu03160.jpg');
INSERT INTO `cms_html` VALUES ('406', '34', '人生哲理的句子：一生很短，路要自己走，话要自己说', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\uff1a\\u4e00\\u751f\\u5f88\\u77ed\\uff0c\\u8def\\u8981\\u81ea\\u5df1\\u8d70\\uff0c\\u8bdd\\u8981\\u81ea\\u5df1\\u8bf4\",\"keywords\":\"\\u54f2\\u7406\\u4eba\\u751f, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/68673.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/zhele160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/zhele160.jpg');
INSERT INTO `cms_html` VALUES ('407', '34', '当你穷的时候，请一定牢记以下26条人生哲理！', '1547486121', '0', '{\"title\":\"\\u5f53\\u4f60\\u7a77\\u7684\\u65f6\\u5019\\uff0c\\u8bf7\\u4e00\\u5b9a\\u7262\\u8bb0\\u4ee5\\u4e0b26\\u6761\\u4eba\\u751f\\u54f2\\u7406\\uff01\",\"keywords\":\"\\u54f2\\u7406\\u4eba\\u751f, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/68362.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/qiong02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/qiong02160.jpg');
INSERT INTO `cms_html` VALUES ('408', '34', '有哲理的句子：喂狗三天，记三年；养人三年，记三天', '1547486121', '0', '{\"title\":\"\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\uff1a\\u5582\\u72d7\\u4e09\\u5929\\uff0c\\u8bb0\\u4e09\\u5e74\\uff1b\\u517b\\u4eba\\u4e09\\u5e74\\uff0c\\u8bb0\\u4e09\\u5929\",\"keywords\":\"\\u4e00\\u5207\\u968f\\u7f18, \\u54f2\\u7406\\u7b7e\\u540d, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/67926.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/lomshe05160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/lomshe05160.jpg');
INSERT INTO `cms_html` VALUES ('409', '34', '人生哲理的句子：善良的人，老天眷恋，真诚的人，终有好福', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\uff1a\\u5584\\u826f\\u7684\\u4eba\\uff0c\\u8001\\u5929\\u7737\\u604b\\uff0c\\u771f\\u8bda\\u7684\\u4eba\\uff0c\\u7ec8\\u6709\\u597d\\u798f\",\"keywords\":\"\\u54f2\\u7406\\u7b7e\\u540d, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/67917.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/lomshe04160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/lomshe04160.jpg');
INSERT INTO `cms_html` VALUES ('410', '34', '狼是怎么死在羊的手里？看懂悟透了就会明白生存发展之道', '1547486121', '0', '{\"title\":\"\\u72fc\\u662f\\u600e\\u4e48\\u6b7b\\u5728\\u7f8a\\u7684\\u624b\\u91cc\\uff1f\\u770b\\u61c2\\u609f\\u900f\\u4e86\\u5c31\\u4f1a\\u660e\\u767d\\u751f\\u5b58\\u53d1\\u5c55\\u4e4b\\u9053\",\"keywords\":\"\\u54f2\\u7406\\u6545\\u4e8b, \\u751f\\u5b58, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/67498.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/yang02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/yang02160.jpg');
INSERT INTO `cms_html` VALUES ('411', '34', '这10条人生哲理，学校不教，父母不讲，但值得收藏！', '1547486121', '0', '{\"title\":\"\\u8fd910\\u6761\\u4eba\\u751f\\u54f2\\u7406\\uff0c\\u5b66\\u6821\\u4e0d\\u6559\\uff0c\\u7236\\u6bcd\\u4e0d\\u8bb2\\uff0c\\u4f46\\u503c\\u5f97\\u6536\\u85cf\\uff01\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/67121.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/li04160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/li04160.jpg');
INSERT INTO `cms_html` VALUES ('412', '34', '人心换人心，你真我更真，你假我转身！', '1547486121', '0', '{\"title\":\"\\u4eba\\u5fc3\\u6362\\u4eba\\u5fc3\\uff0c\\u4f60\\u771f\\u6211\\u66f4\\u771f\\uff0c\\u4f60\\u5047\\u6211\\u8f6c\\u8eab\\uff01\",\"keywords\":\"\\u4eba\\u751f, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66985.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/08\\/renxin01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/08/renxin01160.jpg');
INSERT INTO `cms_html` VALUES ('413', '34', '富有哲理的句子：如果你失去了耐心，就会失去更多', '1547486121', '0', '{\"title\":\"\\u5bcc\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\uff1a\\u5982\\u679c\\u4f60\\u5931\\u53bb\\u4e86\\u8010\\u5fc3\\uff0c\\u5c31\\u4f1a\\u5931\\u53bb\\u66f4\\u591a\",\"keywords\":\"\\u5bcc\\u6709\\u54f2\\u7406, \\u8010\\u5fc3, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66918.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/zheli04160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/zheli04160.jpg');
INSERT INTO `cms_html` VALUES ('414', '34', '从现在起，做一个傻一点的人吧，傻一点才幸福！', '1547486121', '0', '{\"title\":\"\\u4ece\\u73b0\\u5728\\u8d77\\uff0c\\u505a\\u4e00\\u4e2a\\u50bb\\u4e00\\u70b9\\u7684\\u4eba\\u5427\\uff0c\\u50bb\\u4e00\\u70b9\\u624d\\u5e78\\u798f\\uff01\",\"keywords\":\"\\u4eba\\u751f\\u6001\\u5ea6, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66901.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/ren07160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/ren07160.jpg');
INSERT INTO `cms_html` VALUES ('415', '34', '人生最大的可怜，是弥留之际才明白应该做什么！', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u6700\\u5927\\u7684\\u53ef\\u601c\\uff0c\\u662f\\u5f25\\u7559\\u4e4b\\u9645\\u624d\\u660e\\u767d\\u5e94\\u8be5\\u505a\\u4ec0\\u4e48\\uff01\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66877.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/ren01160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/ren01160.jpg');
INSERT INTO `cms_html` VALUES ('416', '34', '做人，不能缺德，缺钱可以赚，缺德准完蛋', '1547486121', '0', '{\"title\":\"\\u505a\\u4eba\\uff0c\\u4e0d\\u80fd\\u7f3a\\u5fb7\\uff0c\\u7f3a\\u94b1\\u53ef\\u4ee5\\u8d5a\\uff0c\\u7f3a\\u5fb7\\u51c6\\u5b8c\\u86cb\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66569.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/ya05160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/ya05160.jpg');
INSERT INTO `cms_html` VALUES ('417', '34', '人生哲理：做人，不得不懂的八个心计', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u505a\\u4eba\\uff0c\\u4e0d\\u5f97\\u4e0d\\u61c2\\u7684\\u516b\\u4e2a\\u5fc3\\u8ba1\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u5fc3\\u8ba1, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66561.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/ya03160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/ya03160.jpg');
INSERT INTO `cms_html` VALUES ('418', '34', '人生哲理：有钱时，不交五友；没钱时，不求五人', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u6709\\u94b1\\u65f6\\uff0c\\u4e0d\\u4ea4\\u4e94\\u53cb\\uff1b\\u6ca1\\u94b1\\u65f6\\uff0c\\u4e0d\\u6c42\\u4e94\\u4eba\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66557.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/ya02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/ya02160.jpg');
INSERT INTO `cms_html` VALUES ('419', '34', '那些说到心坎的文字，看懂了人生豁然开朗！', '1547486121', '0', '{\"title\":\"\\u90a3\\u4e9b\\u8bf4\\u5230\\u5fc3\\u574e\\u7684\\u6587\\u5b57\\uff0c\\u770b\\u61c2\\u4e86\\u4eba\\u751f\\u8c41\\u7136\\u5f00\\u6717\\uff01\",\"keywords\":\"\\u8bf4\\u5230\\u5fc3\\u574e, \\u8c41\\u7136\\u5f00\\u6717, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66487.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/huan08160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/huan08160.jpg');
INSERT INTO `cms_html` VALUES ('420', '34', '人生哲理：别求太多，珍惜拥有，用心活着', '1547486121', '0', '{\"title\":\"\\u4eba\\u751f\\u54f2\\u7406\\uff1a\\u522b\\u6c42\\u592a\\u591a\\uff0c\\u73cd\\u60dc\\u62e5\\u6709\\uff0c\\u7528\\u5fc3\\u6d3b\\u7740\",\"keywords\":\"\\u4eba\\u751f\\u54f2\\u7406, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/66030.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/kan02160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/kan02160.jpg');
INSERT INTO `cms_html` VALUES ('421', '34', '30条有哲理但很讽刺的句子，那些说到心坎的文字', '1547486121', '0', '{\"title\":\"30\\u6761\\u6709\\u54f2\\u7406\\u4f46\\u5f88\\u8bbd\\u523a\\u7684\\u53e5\\u5b50\\uff0c\\u90a3\\u4e9b\\u8bf4\\u5230\\u5fc3\\u574e\\u7684\\u6587\\u5b57\",\"keywords\":\"\\u4e00\\u7a77\\u4e8c\\u767d, \\u8bf4\\u5230\\u5fc3\\u574e, \\u4eba\\u751f\\u54f2\\u7406_\\u4eba\\u751f\\u54f2\\u7406\\u7684\\u53e5\\u5b50_\\u6709\\u54f2\\u7406\\u7684\\u53e5\\u5b50\\u5927\\u5168\",\"author\":\"\\u610f\\u7a7a\\u95f4\",\"daoyan\":\"\\u610f\\u7a7a\\u95f4\",\"yanyuan\":\"\\u610f\\u7a7a\\u95f4\",\"jianzhi\":\"\\u610f\\u7a7a\\u95f4\",\"url\":\"http:\\/\\/yispace.net\\/65928.html\",\"litpic\":\"http:\\/\\/yispace.net\\/wp-content\\/uploads\\/2017\\/07\\/nv06160.jpg\"}', 'http://yispace.net/wp-content/uploads/2017/07/nv06160.jpg');

-- ----------------------------
-- Table structure for cms_model
-- ----------------------------
DROP TABLE IF EXISTS `cms_model`;
CREATE TABLE `cms_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型表的名称',
  `model_name` varchar(50) DEFAULT NULL COMMENT '模型的名称',
  `table_name` varchar(50) DEFAULT NULL COMMENT '模型表的名称',
  `status` smallint(1) DEFAULT NULL COMMENT '启用状态（0.禁用 1.启用）',
  `sort` smallint(5) DEFAULT '50' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_model
-- ----------------------------
INSERT INTO `cms_model` VALUES ('1', '电影', 'film', '1', '1');
INSERT INTO `cms_model` VALUES ('34', '测试', 'cehi', '1', '12');
INSERT INTO `cms_model` VALUES ('37', '前端文章', 'content', '1', '3');
INSERT INTO `cms_model` VALUES ('38', '测试2', 'ceshi2', '1', '50');

-- ----------------------------
-- Table structure for cms_modelfield
-- ----------------------------
DROP TABLE IF EXISTS `cms_modelfield`;
CREATE TABLE `cms_modelfield` (
  `field_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `field_cname` varchar(60) DEFAULT NULL COMMENT '中文名称',
  `field_ename` varchar(255) DEFAULT NULL COMMENT '英文名称',
  `field_type` smallint(1) DEFAULT '1' COMMENT '1.文本输入框 2.单选 3.复选 4.下拉菜单 5.文本域 6.附件类型 7.浮点 8.整型 9.长文本',
  `model_id` smallint(3) DEFAULT NULL COMMENT '模型id',
  `field_values` varchar(255) DEFAULT NULL COMMENT '可选值',
  PRIMARY KEY (`field_id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_modelfield
-- ----------------------------
INSERT INTO `cms_modelfield` VALUES ('30', '导演', 'daoyan', '1', '1', 'sedf');
INSERT INTO `cms_modelfield` VALUES ('31', '演员', 'yanyuan', '8', '1', '发过火');
INSERT INTO `cms_modelfield` VALUES ('32', '监制', 'jianzhi', '5', '1', '而风格');
INSERT INTO `cms_modelfield` VALUES ('42', '详情', 'xiangqing', '9', '1', '');
INSERT INTO `cms_modelfield` VALUES ('40', '简介', 'jianjie', '5', '1', '');
INSERT INTO `cms_modelfield` VALUES ('37', '剧情', 'juqing', '2', '1', '喜剧,爱情,动作,惊悚');
INSERT INTO `cms_modelfield` VALUES ('38', '语言', 'yuyan', '3', '1', '国语,粤语,英语,韩语,俄语');
INSERT INTO `cms_modelfield` VALUES ('39', '产地', 'chandi', '4', '1', '中国,美国,韩国,英国');
INSERT INTO `cms_modelfield` VALUES ('41', '剧照', 'juzhao', '6', '1', '');
INSERT INTO `cms_modelfield` VALUES ('43', '主图', 'zhutu', '6', '1', '');

-- ----------------------------
-- Table structure for cms_note
-- ----------------------------
DROP TABLE IF EXISTS `cms_note`;
CREATE TABLE `cms_note` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '节点id',
  `note_name` varchar(60) DEFAULT NULL COMMENT '节点名称',
  `model_id` mediumint(9) DEFAULT NULL COMMENT '模型id',
  `output_encoding` varchar(30) DEFAULT NULL COMMENT '输出编码',
  `input_encoding` varchar(30) DEFAULT NULL COMMENT '输入编码',
  `list_rules` varchar(1000) DEFAULT NULL COMMENT '列表页采集规则',
  `item_rules` varchar(6000) DEFAULT NULL COMMENT '内容页采集规则',
  `addtime` int(11) DEFAULT NULL COMMENT '采集时间',
  `lasttime` int(11) DEFAULT NULL COMMENT '最后采集时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_note
-- ----------------------------
INSERT INTO `cms_note` VALUES ('18', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"g\",\"list_rules\":[{\"url_rule\":\"g\",\"litpic_rule\":\"g\"}]}]', null, '1546683731', '1546683731');
INSERT INTO `cms_note` VALUES ('19', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"g\",\"list_rules\":[{\"url_rule\":\"g\",\"litpic_rule\":\"g\"}]}]', null, '1546683764', '1546683764');
INSERT INTO `cms_note` VALUES ('20', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"g\",\"list_rules\":[{\"url_rule\":\"g\",\"litpic_rule\":\"g\"}]}]', null, '1546683810', '1546683810');
INSERT INTO `cms_note` VALUES ('21', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"f\",\"list_rules\":[{\"url_rule\":\"f\",\"litpic_rule\":\"f\"}]}]', null, '1546683950', '1546683950');
INSERT INTO `cms_note` VALUES ('22', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"d\",\"list_rules\":[{\"url_rule\":\"d\",\"litpic_rule\":\"d\"}]}]', null, '1546683999', '1546683999');
INSERT INTO `cms_note` VALUES ('23', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"f\",\"list_rules\":[{\"url_rule\":\"f\",\"litpic_rule\":\"f\"}]}]', null, '1546695693', '1546695693');
INSERT INTO `cms_note` VALUES ('24', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"us\",\"list_rules\":[{\"url_rule\":\"x\",\"litpic_rule\":\"x\"}]}]', null, '1546783386', '1546783386');
INSERT INTO `cms_note` VALUES ('25', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"l\",\"list_rules\":[{\"url_rule\":\"l\",\"litpic_rule\":\"l\"}]}]', null, '1546783886', '1546783886');
INSERT INTO `cms_note` VALUES ('26', '水电费水电费是的', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"ddxgdf\",\"start_page\":\"1\",\"end_page\":\"4\",\"add_page\":\"1\",\"range\":\"o\",\"list_rules\":[{\"url_rule\":\"o\",\"litpic_rule\":\"o\"}]}]', '{\"title\":[\"dfg\",\"dfg\",\"dfg\"],\"keyword\":[\"dfg\",\"dfg\",\"dfg\"]}', '1546783928', '1546783928');
INSERT INTO `cms_note` VALUES ('27', '文章列表', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"http:\\/\\/www.duwenzhang.com\\/wenzhang\\/aiqingwenzhang\\/list_1_(*).html\",\"start_page\":\"1\",\"end_page\":\"10\",\"add_page\":\"1\",\"range\":\".tbspan\",\"list_rules\":[{\"url_rule\":\"b.ulink,text\",\"litpic_rule\":\"td img ,src\"}]}]', '{\"title\":[\"b .ulink\",\"td img,src\",\"-ins\"]}', '1546874836', '1546875011');
INSERT INTO `cms_note` VALUES ('28', '励志文章', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"http:\\/\\/www.wenzhangba.com\\/lizhigushi\\/list_11_(*).html\",\"start_page\":\"1\",\"end_page\":\"8\",\"add_page\":\"1\",\"range\":\".cmt_info\",\"list_rules\":[{\"url_rule\":\".cmt_pic a\",\"litpic_rule\":\".cmt_pic a img\"}]}]', '{\"title\":[\".subBox a img ,text\",\".subBox a img,src\",\"-strong\"]}', '1546957434', '1546957635');
INSERT INTO `cms_note` VALUES ('29', '励志文章', '1', 'UTF-8', 'UTF-8', '[{\"list_url\":\"http:\\/\\/yispace.net\\/category\\/inspirational-life\\/page\\/(*)\",\"start_page\":\"1\",\"end_page\":\"13\",\"add_page\":\"1\",\"range\":\".content>ul>li\",\"list_rules\":[{\"url_rule\":\"a.pic,href\",\"litpic_rule\":\"a.pic img,src\"}]}]', '{\"title\":[\"h2,text\",\"h2 a\",\"-p\"]}', '1546959932', '1546960039');

-- ----------------------------
-- Table structure for cms_position
-- ----------------------------
DROP TABLE IF EXISTS `cms_position`;
CREATE TABLE `cms_position` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `width` smallint(6) DEFAULT NULL COMMENT '广告位宽度',
  `height` smallint(6) DEFAULT NULL COMMENT '广告位高度',
  `sort` smallint(6) DEFAULT NULL COMMENT '排序',
  `status` smallint(1) DEFAULT NULL COMMENT '是否使用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_position
-- ----------------------------
INSERT INTO `cms_position` VALUES ('9', '顶部广告', '1000', '5000', '50', '1');
INSERT INTO `cms_position` VALUES ('10', '中部广告', '1000', '5000', '50', '1');
INSERT INTO `cms_position` VALUES ('11', '底部广告', '1000', '5000', '50', '1');
INSERT INTO `cms_position` VALUES ('12', '顶部广告', '1000', '5000', '50', '1');
INSERT INTO `cms_position` VALUES ('13', '中部广告', '1000', '5000', '50', '1');
