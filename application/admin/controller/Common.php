<?php
namespace app\admin\controller;

use think\Controller;
use think\Db;
use think\Request;
use auth\Auth;

class Common extends Controller
{
    public $config;

    //初始化
    public function _initialize()
    {
        if (!session('name')) {
            $this->error('请先登录', '/cms/public/index.php/admin/Login/login');
        }
        $request = Request::instance();
        $module = $request->module();//获取模块名
        $con = $request->controller();//获取控制器
        $action = $request->action();//获取控制器下的方法

        $auth = new Auth();

        //获取用户拥有的左侧菜单
        $groups = $auth->getGroups(session('id'));
        $rules = explode(',', $groups[0]['rules']);
        $menu = array();
        $map['pid'] = ['=', 0];
        $map['show'] = ['=', 1];
        $map['id']  = ['in', $rules];
        $_map['id']  = ['in', $rules];
        $menu = \db('auth_rule')->where($map)->select();
        foreach ($menu as $k => $v) {
            $menu[$k]['children'] = \db('auth_rule')->where($_map)->where(array('pid' => $v['id'], 'show' => 1))->select();;
        }

        $name = $module.'/'.$con.'/'.$action;

        //输出
        $this->assign([
            'menuRes' => $menu,
            'name' => $name,
            'con' => $con,
            'action' => $action,
        ]);
        
//        验证权限
         if ($name !== 'admin/Index/index'){
             if (!$auth->check($name, session('id'))) {
                 $this->error('无该操作权限！');
             }
         }

        $this->getConf();

    }

    //获取配置项
    public function getConf ()
    {
        $confRes = array();
        $_confRes = \db('conf')->field('ename, value')->select();

        foreach ($_confRes as $v) {
            $confRes[$v['ename']] = $v['value'];
        }

        $this->config = $confRes;
    }

}