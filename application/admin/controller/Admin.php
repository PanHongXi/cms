<?php
namespace app\admin\controller;

use QL\QueryList;
use think\Controller;

class Admin extends Common
{
    public function lst()
    {
        $list = db('admin')->alias('a')->join('auth_group g', 'g.id=a.gruopid')->field('a.*,g.title')->paginate(15);
        $page = $list->render();

        //输出
        $this->assign([
            'list' => $list,
            'page' => $page,
        ]);

        return view();
    }

    //管理员添加
    public function add()
    {
        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('Admin');
            if (!$validate->scene('add')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            if ($data['password']) {

                //验证密码由字母，数字组合
                if(!preg_match('/^(?![0-9]+$)(?![a-zA-Z]+$)/', $data['password']))
                {
                    return json_encode(['status' => 0, 'msg' => '密码必须由字母数字组合']);
                }

                $data['password'] = md5($data['password']);
            }

            $data['create_time'] = time();
            $data['last_time'] = time();

            $admin = db('admin')->insertGetId($data);

            //对应的管理员和用户组
            $_data = array();
            $_data['uid'] = $admin;
            $_data['group_id'] = $data['gruopid'];
            $auth_group_access = db('auth_group_access')->insert($_data);

            if ($admin) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败']);
            }
        }

        //获取用户组
        $groupList = db('auth_group')->select();
        $this->assign([
            'groupList' => $groupList,
        ]);

        return view();
    }

    //修改启用状态
    public function changeStatus()
    {
        $id = input('uId');
        $ad = \db('admin');
        $status = $ad->where(array('uid' => $id))->field('status')->find();
        $status = $status['status'];
        if ($status == 0) {
            $ad->where(array('uid' => $id))->update(['status' => 1]);
            return 1;
        } else {
            $ad->where(array('uid' => $id))->update(['status' => 0]);
            return 2;
        }
    }

    public function edit()
    {
        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('Admin');
            if (!$validate->scene('edit')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            if ($data['password']) {

                //验证密码由字母，数字组合
                if(!preg_match('/^(?![0-9]+$)(?![a-zA-Z]+$)/', $data['password']))
                {
                    return json_encode(['status' => 0, 'msg' => '密码必须由字母数字组合']);
                }

                $data['password'] = md5($data['password']);
            } else {
                unset($data['password']);
            }

            if (!array_key_exists('status', $data)) {
                $data['status'] = 0;
            }

            $_data = array();
            $_data['group_id'] = $data['gruopid'];
            $auth_group_access = db('auth_group_access')->where(array('uid' => $data['uid']))->setField($_data);

            $edit = db('admin')->where(array('uid' => $data['uid']))->setField($data);
            if ($edit !== false) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => '/cms/public/index.php/admin/admin/lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败']);
            }
        }

        $uId = input('uid');
        $list = db('admin')->where('uid', $uId)->find();

        //获取用户组
        $groupList = db('auth_group')->select();

        //输出
        $this->assign([
            'list' => $list,
            'groupList' => $groupList,
        ]);
        return view();
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {
            $conf = db('admin')->where('uid', $v)->delete();
        }

        if ($conf) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

    //删除一条数据
    public function del()
    {
        $del = db('admin')->where('uid', input('id'))->delete();
        if ($del) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

    //退出登录
    public function loginOut()
    {
        session(null);
        $this->success('退出成功', 'Login/login');
    }

}