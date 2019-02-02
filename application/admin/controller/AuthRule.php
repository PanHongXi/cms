<?php

namespace app\admin\controller;

use think\Controller;

use think\Db;

class AuthRule extends Common
{
    public function lst()
    {
        //获取导航数据
        $_list = db('auth_rule')->select();
        $list = model('AuthRule')->authRuleTree($_list);

        $this->assign([
            'list' => $list,
        ]);
        return view();
    }

    public function add()
    {
        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('AuthRule');
            if (!$validate->scene('add')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            $add = \db('auth_rule')->insert($data);
            if ($add) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败']);
            }

        }
        //获取导航数据
        $_list = db('auth_rule')->select();
        $list = model('AuthRule')->authRuleTree($_list);

        $this->assign([
            'list' => $list,
        ]);
        return view();
    }

    public function edit()
    {
        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('AuthRule');
            if (!$validate->scene('edit')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            if (!array_key_exists('status', $data)) {
                $data['status'] = 0;
            }
            if (!array_key_exists('show', $data)) {
                $data['show'] = 0;
            }

            $add = \db('auth_rule')->setField($data);
            if ($add) {
                $this->success('修改规则成功', 'lst');
            } else {
                $this->success('修改规则失败', 'lst');
            }
        }

        $id = input('id');
        //获取模型id
        $rule = db('auth_rule')->where('id', $id)->find();

        //获取导航数据
        $_list = db('auth_rule')->select();
        $list = model('AuthRule')->authRuleTree($_list);

        $this->assign([
            'list' => $list,
            'rule' => $rule,
        ]);
        return view();
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {
            $conf = db('auth_rule')->where('id', $v)->delete();
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
        $del = db('auth_rule')->where('id', input('id'))->delete();
        if ($del) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

    //ajax处理导航收缩问题
    public function ajaxList()
    {
        if (request()->isAjax()) {
            $id = input('id');
            $childrenIds = model('auth_rule')->childrenIds($id);

            echo json_encode($childrenIds);
        }
    }

    //修改启用状态
    public function changeStatus()
    {
        $id = input('rId');
        $ad = \db('auth_rule');
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