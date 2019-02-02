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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
-- Table structure for cms_ceshi2
-- ----------------------------
DROP TABLE IF EXISTS `cms_ceshi2`;
CREATE TABLE `cms_ceshi2` (
  `aid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
-- Table structure for cms_content
-- ----------------------------
DROP TABLE IF EXISTS `cms_content`;
CREATE TABLE `cms_content` (
  `aid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
