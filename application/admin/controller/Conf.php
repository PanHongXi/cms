<?php
namespace app\admin\controller;

use think\Controller;

class Conf extends Common
{
    //配置列表
    public function confList()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $enameArr = db('conf')->column('ename');
            $imgcolumn = \db('conf')->where(array('dt_type' => 6))->column('ename'); //附件类型数据处理
            $confArr = array();
            foreach ($data as $k => $v) {
                $confArr[] = $k;
                if (is_array($v)) {//处理复选框的数据
                    $v = implode(',', $v);
                }
                $conf = db('conf')->where(array('ename' => $k))->update(['value' => $v]);
            }
            //处理数据为空的情况
            foreach ($enameArr as $k => $v) {
                if (!in_array($v, $confArr) && !in_array($v, $imgcolumn)) {
                    $conf = db('conf')->where(array('ename' => $v))->update(['value' => '']);
                }
            }
            //附件类型数据处理
            foreach ($imgcolumn as $k => $v) {
                if ($_FILES[$v]['tmp_name']) {
                    $file = request()->file($v);
                    $info = $file->move(ROOT_PATH . 'public' . DS . 'static' . DS . 'admin' . DS . 'uploads' . DS . 'conf');
                    $imgsrc = 'conf/'.$info->getSaveName();
                    if ($imgsrc) {
                        db('conf')->where(array('ename' => $v))->update(['value' => $imgsrc]);
                    }
                }
            }

            return json_encode(['status' => 1, 'msg' => '保存成功！', 'url' => '']);
            return;
        }

        $list = db('conf')->select();

        //输出
        $this->assign([
            'list' => $list
        ]);

        return view('conf/confList');
    }

    //配置管理
    public function cList()
    {
        //搜索
        $data = input('get.');
        if ($data) {
            $searchValue = $data['searchValue'];
            $pageSize = $data['pageSize'];
            if ($pageSize) {
                $pageSize = $pageSize;
            } else {
                $pageSize = 20;
            }
            $list = db('conf')->order('id desc')->where('cname','like', "%".$searchValue."%")->paginate($pageSize,false,['query' => request()->param()]);
        }else {
            $list = db('conf')->order('id desc')->paginate(15,false,['query' => array('searchValue' => '','pageSize' => '')]);
        }

        //查询所有的配置数据
        $page = $list->render();

        //输出
        $this->assign([
            'list' => $list,
            'page' => $page,

        ]);

        return view('conf/cList');
    }

    //配置数据保存
    public function cSave($id)
    {
        //实例化数据表
        $confs = db('conf');

        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('Conf');
            if (!$validate->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            //将中文状态的‘，’替换成英文状态下的‘,’
            if ($data['valuess']) {
                $data['valuess'] = str_replace('，', ',', $data['valuess']);
            }

            if ($data['value']) {
                $data['value'] = str_replace('，', ',', $data['value']);
            }

            //判断数组中是否存在某个键
            if (array_key_exists('enabled',$data)) {
                $data['enabled'] = 1;
            } else {
                $data['enabled'] = 0;
            }

            //判断是修改数据还是增加数据
            if ($data['id'] > 0) {
                $conf = $confs->where(array('id' => $data['id']))->setField($data);
                $url = '';
            } else {
                $conf = $confs->insert($data);
                $url = 'cList';
            }

            if ($conf) {
                return json_encode(['status' => 1, 'msg' => '保存成功！', 'url' => $url]);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败！']);
            }

        }

        //获取一条数据
        $list = $confs->where(array('id' => $id))->find();

        $this->assign([
            'list' => $list,
        ]);
        return view('conf/cSave');
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {
            $conf = db('conf')->where('id',$v)->delete();
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
        $del = db('conf')->where('id', input('id'))->delete();
        if ($del) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }
}