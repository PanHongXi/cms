<?php
namespace app\admin\controller;

use QL\QueryList;
use think\Controller;

class Login extends Controller
{
    public function login()
    {
        if (session('name') && session('id')) {
            $this->error('您已登录，请勿重复登录', '/cms/admin/index/index');
        }

        if (request()->isPost()) {
            $data = input('post.');
            if(!captcha_check($data['captcha'])){
                $this->error('验证码错误');
            };

            $loginStatus = model('admin')->login($data);

            if ($loginStatus == 4) {
                $this->error('该用户被禁用，请联系管理员', 'login');
            }

            if ($loginStatus == 1) {
                db('admin')->where(array('uid' => session('id')))->setField(['last_time' => time()]);
                $this->success('登录成功', '/cms/admin/index/index');
            } else {
                $this->error('账号或密码错误', 'login');
            }

        }
        return view();
    }

}