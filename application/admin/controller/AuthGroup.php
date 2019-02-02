<?php

namespace app\admin\controller;

use think\Controller;

use think\Db;

class AuthGroup extends Common
{
    public function lst()
    {
        //获取导航数据
        $list = db('auth_group')->paginate(15);
        $page = $list->render();

        $this->assign([
            'list' => $list,
            'page' => $page,
        ]);
        return view();
    }

    public function add()
    {
        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('AuthGroup');
            if (!$validate->scene('add')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            $add = \db('auth_group')->insert($data);
            if ($add) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败']);
            }
        }
        return view();
    }

    public function edit()
    {
        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('AuthGroup');
            if (!$validate->scene('edit')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            if (!array_key_exists('status', $data)) {
                $data['status'] = 0;
            }

            $add = \db('auth_group')->setField($data);
            if ($add !== false) {
                $this->success('修改组别成功', 'lst');
            } else {
                $this->success('修改组别失败', 'lst');
            }
        }

        $id = input('id');
        //获取模型id
        $list = db('auth_group')->where('id', $id)->find();

        $this->assign([
            'list' => $list,
        ]);
        return view();
    }

    //权限配置
    public function auth()
    {
        //配置权限
        if (request()->isPost()) {
            $data = input('post.');
            $rule = implode(',', $data['ids']);

            $save = \db('auth_group')->where(array('id' => $data['id']))->setField(['rules' => $rule]);
            if ($save !== false) {
                $this->success('配置权限成功');
            } else {
                $this->success('配置权限失败');
            }
        }

        //获取权限选项
        $data = \db('auth_rule')->where(['pid' => 0])->select();
        foreach ($data as $k => $v) {
            $data[$k]['children'] = \db('auth_rule')->where(['pid' => $v['id']])->select();
            foreach ($data[$k]['children'] as $k1 => $v1) {
                $data[$k]['children'][$k1]['children'] = \db('auth_rule')->where(['pid' => $v1['id']])->select();
            }
        }

        $id = input('id');
        $authGroup = \db('auth_group')->find($id);
        $rules = explode(',', $authGroup['rules']);

        //输出
        $this->assign([
            'authGroup' => $authGroup,
            'data' => $data,
            'rules' => $rules,
        ]);

        return view();
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        $admin = '';
        foreach ($ids as $k => $v) {
            $admin = db('admin')->where('gruopid', $v)->delete();
            $conf = db('auth_group')->where('id', $v)->delete();
        }

        if ($conf && $admin) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

    //删除一条数据
    public function del()
    {
        $admin = db('admin')->where('gruopid', input('id'))->delete();
        $del = db('auth_group')->where('id', input('id'))->delete();
        if ($del && $admin) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

    //修改启用状态
    public function changeStatus()
    {
        $id = input('gId');
        $ad = \db('auth_group');
        $status = $ad->where(array('id' => $id))->field('status')->find();
        $status = $status['status'];
        if ($status == 0) {
            $ad->where(array('id' => $id))->update(['status' => 1]);
            return 1;
        } else {
            $ad->where(array('id' => $id))->update(['status' => 0]);
            return 2;
        }
    }
}