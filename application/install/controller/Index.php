<?php
namespace app\install\controller;

use think\Controller;
use think\Db;

class Index extends Controller
{
    public function index()
    {
    	session('step', 0);
    	session('error', false);

        return view();
    }

    public function step1()
    {
    	//判断是否是从上一步或下一步进来
    	if (session('step') != 0 && session('step') != 2) {
    		$this->redirect('index');
    	}
    	session('error', false);
    	$envArr = check_env();
    	$dirfile=check_dirfile();
    	$funArr = check_function();
    	$this->assign([
    		'envArr' => $envArr,
    		'funArr' => $funArr,
    		'dirfile' => $dirfile,
    	]);
        session('step', 1);
        return view();
    }
    public function step2()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $dbArr = $data['db'];
            $adminArr = $data['admin'];

            //验证管理员信息
            if (!is_array($adminArr) || empty($adminArr['site_name']) || empty($adminArr['admin']) || empty($adminArr['password']) || empty($adminArr['rpassword'])) {
                $this->error('管理员信息不完整，请检查！');
            } else {
                if (!preg_match('/^[a-zA-Z0-9_-]{5,10}$/', $adminArr['admin'])) {
                    $this->error('账号格式不正确！');
                } else {
                    if (!preg_match('/^[a-zA-Z0-9_-]{5,10}$/', $adminArr['password'])) {
                        $this->error('密码格式不正确！');
                    } else {
                        if ($adminArr['password'] != $adminArr['rpassword']) {
                            $this->error('两次密码不一致！');
                        } else {
                            $admin_info = serialize($adminArr);
                            session('admin_info', $admin_info);
                        }
                    }
                }
            }

            //验证数据库信息
            if (!is_array($dbArr) || empty($dbArr['hostname']) || empty($dbArr['database']) || empty($dbArr['username']) || empty($dbArr['prefix']) || empty($dbArr['hostport'])) {
                $this->error('数据库信息不完整！');
            } else {
                $_dbArr = serialize($dbArr);
                $_adminArr = serialize($adminArr);
                session('db_config', $_dbArr);
                session('admin_info', $_adminArr);
                $dbName = $dbArr['database'];
                unset($dbArr['database']);
                //链接数据库
                $db = Db::connect($dbArr);
                $sql = "CREATE DATABASE IF NOT EXISTS {$dbName} DEFAULT CHARACTER SET utf8";
                if (!$db-> execute($sql)) {
                    $this->error($db->getError());
                } else {
                    $this->success('创建成功！', url('index/step3', ['access' => 'success']));
                }
            }
        }

//        if (session('error')) {
//            $this->error('环境检测未通过，请调试环境后重试！');
//        }

        //判断从哪里进过
        $step = session('step');
        if ($step != 1 && $step != 2) {
            $this->request('index');
        }
        session('step', 2);
        return view();
    }
    public function step3()
    {
        if (input('access') != 'success' || session('step') != 2) {
            $this->redirect('index');
        }

        session('step', 3);
        echo $this->fetch();
        $db_config = session('db_config');
        $db_config = unserialize($db_config);
        $prefix = $db_config['prefix'];
        $db = Db::connect($db_config);
        //创建数据表
        create_table($db,$prefix);

        //写入配置文件
        $_db_config['hostname'] = $db_config['hostname'];
        $_db_config['type']     = $db_config['type'];
        $_db_config['database'] = $db_config['database'];
        $_db_config['username'] = $db_config['username'];
        $_db_config['password'] = $db_config['password'];
        $_db_config['prefix']   = $db_config['prefix'];
        $_db_config['hostport'] = $db_config['hostport'];
        $file = "../application/database.php";
        //合并两个数组，如果有相同的话就进行替换 ,array_change_key_case将键转换为大写
        $config = array_merge(include $file, $_db_config);
        $str = "<?php\r\n return " . var_export($config, true) . ";";
        file_put_contents($file, $str);

        //写入初始信息
        $admin_info = session('admin_info');
        $admin_info = unserialize($admin_info);
        $data['uname'] = $admin_info['admin'];
        $data['password'] = md5($admin_info['password']);
        $data['create_time'] = time();
        $data['last_time'] = time();
        $data['status'] = 1;
        $data['gruopid'] = 2;
        $admin = db('admin')->insertGetId($data);

        //对应的管理员和用户组
        $_data = array();
        $_data['uid'] = $admin;
        $_data['group_id'] = $data['gruopid'];
        $auth_group_access = db('auth_group_access')->insert($_data);

        $this->success('安装成功','admin/Login/login');

    }
}
