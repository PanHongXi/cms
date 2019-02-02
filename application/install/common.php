<?php

//环境检查
function check_env()
{
	$envArr = array(
		'os' => array('操作系统','无限制','linux',PHP_OS,'success'),
		'php' =>array('PHP版本','5.3','5.5',PHP_VERSION,'success'),
		'gd' => array('GD库','2.0','2.0','未知','success'),
		'upload' => array('附件','未限制','2M','未知','success'),
		'dsk' => array('磁盘空间','100M','>100M','未知','success'),
	);

	//检测附件上传
	if (@ini_get('file_uploads')) {
		$envArr['upload'][3]=ini_get('upload_max_filesize');
	}

	//获取磁盘空间
	 if (function_exists('disk_free_space')) {
	 	$envArr['dsk'][3]=floor(disk_free_space(ROOT_PATH)/(1024*1024)).'M';
		
	 }
	
	//检测GD库
	$tempArr = function_exists('gd_info')? gd_info() : array();
	if (empty($tempArr['GD Version'])) {
		$envArr['gd'][3]='未安装';
		$envArr['gd'][4]='error';
		session('error',true);
	} else{
		$envArr['gd'][3]=$tempArr['GD Version'];
	}
	unset($tempArr);
	return $envArr;
}

//目录、文件权限检查
function check_dirfile()
{
	$dirfile = array(
		array('dir','可写','可写','runtime','success'),
		array('dir','可写','可写','public/static/admin/uploads','success'),
		array('file','可写','可写','application/config.php','success'),
		array('file','可写','可写','application/database.php','success'),
	);

	foreach ($dirfile as $k => $v) {
		//文件目录判断
		if ($v[0] == 'dir') {
			if (!is_writable(ROOT_PATH.$v[3])) {
				if (is_dir(ROOT_PATH.$v[3])) {
					$dirfile[$k][2]='不可写';
					$dirfile[$k][4]='error';
					session('error',true);
				} else {
					$dirfile[$k][2]='文件不存在';
					$dirfile[$k][4]='error';
					session('error',true);
				}
			}
		} else{
			//文件判断
			if(file_exists(ROOT_PATH.$v[3])) {
				if (!is_writable(ROOT_PATH.$v[3])) {
					$dirfile[$k][2]='不可写';
					$dirfile[$k][4]='error';
					session('error',true);
				}
			} else{
				$dirfile[$k][2]='文件不存在';
				$dirfile[$k][4]='error';
				session('error',true);
			}
		}
	}

	return $dirfile;
}

//函数检查
function check_function()
{
	$funArr=array(
		array('mysql_connect','支持','支持','success'),
		array('fsockopen','支持','支持','success'),
		array('gethostbyname','支持','支持','success'),
		array('file_get_contents','支持','支持','success'),
		array('mb_convert_encoding','支持','支持','success'),
		array('json_encode','支持','支持','success'),

	);

	foreach ($funArr as $k => $v) {
		if (!function_exists($v[0])) {
			$funArr[$k][2]='不支持';
			$funArr[$k][3]='error';
			session('error',true);
		}
	}

	return $funArr;
}

//实时输出界面
function show_msg($msg, $class)
{
    echo "<script type='text/javascript'>show_msg(\"{$msg}\",\"{$class}\");</script>";
    flush();
    ob_flush();
    sleep(1);
}

//创建数据表函数
function create_table($dbs,$prefix)
{
    //读取数据表文件内容
    $sql = file_get_contents(ROOT_PATH.'data/install/install.sql');

    //替换表前缀
    $original_prefix = config('original_prefix');//获取默认表前缀
    $sql = str_replace("`{$original_prefix}", "`{$prefix}", $sql);

    //拆分为数组
    $sqlArr = explode(';', $sql);
    show_msg('开始安装数据表...', 'green');
    foreach ($sqlArr as $k => $v) {
        $v = trim($v);
        if (empty($v)) {
            unset($v);
        } else {
            if (substr($v , 0, 12) == 'CREATE TABLE') {
                $name = preg_replace("/^CREATE TABLE `(\w+)` .*/s", "\\1", $v);
                $msg = "创建数据表{$name}";
                if ($dbs->execute($v) !== false) {
                    show_msg($msg."...成功", "green");
                } else {
                    return 2131;
                    show_msg($msg."...成功", "red");
                    session('error', true);
                    return 2131;
                }
            } else {
                $dbs->execute($v);
            }
        }
    }
}
