<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// [ 应用入口文件 ]

// 定义应用目录
define('APP_PATH', __DIR__ . '/application/');
define('IMG', __DIR__ . '/public/static/admin/uploads/');//图片上传的路径
define('INDEXIMG', __DIR__ . '/public/static/index/uploads/');//前端图片路径
// 加载框架引导文件
require __DIR__ . './thinkphp/start.php';
$build = include APP_PATH.'build.php';
\think\Build::run($build);
