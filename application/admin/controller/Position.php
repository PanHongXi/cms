<?php

namespace app\admin\controller;

use think\Controller;

use think\Db;

class Position extends Common
{
    public function lst()
    {
        $list = db('position')->paginate(15);
        $page = $list->render();

        $this->assign([
            'list' => $list,
            'page' => $page
        ]);

        return view();
    }

    public function add()
    {
        if (request()->isPost()){
            $data = input('post.');

            $position = \db('position')->insert($data);

            if ($position) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存成功', 'url' => 't']);
            }

        }
        return view();

    }

    public function edit($id)
    {
        if (request()->isPost()){
            $data = input('post.');

            $position = \db('position')->where(array('id' => $data['id']))->setField($data);

            if ($position) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存成功']);
            }

        }

        $list = \db('position')->where('id', $id)->find();
        $this->assign([
            'list' => $list,
        ]);
        return view();
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {
            $conf = db('position')->where('id', $v)->delete();
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
        $position = model('position');
        $del = $position::destroy(input('id'));;
        if ($del) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

}