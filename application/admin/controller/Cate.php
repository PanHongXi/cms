<?php

namespace app\admin\controller;

use think\Controller;

class Cate extends Common
{
    public function lst()
    {
        //处理排序数据
        if (request()->isPost()) {
            $data = input('post.');

            foreach ($data['sort'] as $k => $v) {

                if (!is_numeric($v)) {
                    return alert('排序只能为数字', '', '5');
                    die;
                }

                db('cate')->where('id', $k)->update(['sort' => $v]);
            }
            echo "<script language=JavaScript> location.replace(location.href);</script>";
        }

        //获取导航数据
        $_list = db('cate')
            ->alias('c')
            ->join('model m','c.model_id = m.id')
            ->field('c.*,m.model_name')
            ->order('c.sort asc')
            ->select();
        $list = model('Cate')->cateTree($_list);

        $this->assign([
            'list' => $list,
        ]);
        return view();
    }

    //ajax处理导航收缩问题
    public function ajaxList()
    {
        $cateId = input('cateId');
        $childrenIds = model('cate')->childrenIds($cateId);

        echo json_encode($childrenIds);
    }

    //添加数据
    public function save()
    {
        //接受cateId
        $cateId = input('cateId');

        $cate = db('cate');
        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('Cate');
            if (!$validate->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            //处理图片上传
            if ($_FILES['img']['tmp_name']) {
                $data['img'] = 'cate/' . $this->upload();
            }

            $cate = $cate->insert($data);

            if ($cate) {
                return json_encode(['status' => 1, 'msg' => '保存成功！', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败！']);
            }
        }

        //获取导航数据
        $cateRes = $cate->select();
        $list = model('Cate')->cateTree($cateRes);

        //获取模型id
        $modelId = $cate->where('id', $cateId)->field('model_id')->find();

        //获取模型
        $modelList = db('model')->select();

        $this->assign([
            'list'      => $list,
            'cateId'    => $cateId,
            'modelId'    => $modelId['model_id'],
            'modelList' => $modelList,
        ]);
        return view();
    }

    //修改数据
    public function edit()
    {
        //接受cateId
        $cateId = input('cateId');

        $cate = db('cate');
        if (request()->isPost()) {
            $data = input('post.');

            //验证的数据
            $validate = validate('Cate');
            if (!$validate->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            //处理图片上传
            if ($_FILES['img']['tmp_name']) {
                $data['img'] = 'cate/' . $this->upload();
            }

            $cate = $cate->where(array('id' => $data['id']))->setField($data);

            if ($cate) {
                return json_encode(['status' => 1, 'msg' => '保存成功！', 'url' => '']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败！']);
            }
        }

        //获取导航数据
        $cateRes = $cate->select();
        $list = model('Cate')->cateTree($cateRes);

        //获取单条数据
        $cateList = $cate->where(array('id' => $cateId))->find();
    

        //获取模型
        $modelList = db('model')->select();

        $this->assign([
            'list' => $list,
            'cateList' => $cateList,
            'modelList' => $modelList,
        ]);
        return view();
    }

    //改变导航状态
    public function changeStatus()
    {
        $cate = db('cate');
        $cateId = input('cateId');
        $status = $cate->where('id', $cateId)->field('enabled')->find();
        $enabled = $status['enabled'];
        if ($enabled == 1) {
            $cate->where('id', $cateId)->update(['enabled' => 0]);
            return 1;
        } else {
            $cate->where('id', $cateId)->update(['enabled' => 1]);
            return 2;
        }
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {
            $conf = db('cate')->where('id', $v)->delete();
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
        $cateId = input('id');
        $childrenIds = model('cate')->childrenIds($cateId);
        $childrenIds[] = (int)$cateId;

        //删除栏目相关的数据
        foreach ($childrenIds as $k => $v) {
            $cates = db('cate')->find($v);
            //删除图片
            if ($cates['img']) {
               $imgsrc = IMG.$cates['img'];
                if (file_exists($imgsrc)) {
                    @unlink($imgsrc);
                }
            }

            //删除栏目下的文章
            $modelId = $cates['model_id'];
            $models = db('model')->where(array('id' => $modelId))->field('table_name')->find();
            $tableName = $models['table_name'];
            $artRes = db("article")->where(array('cate_id' => $v))->select();

            //删除附加表的数据
            foreach ($artRes as $k1 => $v1) {
                db("{$tableName}")->where(array('aid' => $v1['id']))->delete();
            }

            //删除文章主表图片以及数据
            foreach ($artRes as $k2 => $v2) {
                //删除图片
                if ($v2['litpic']) {
                   $imgsrc = IMG.$v2['litpic'];
                    if (file_exists($imgsrc)) {
                        @unlink($imgsrc);
                    }
                }

                //删除文章数据
                db("article")->where(array('id' => $v1['id']))->delete();
            }
        }

        $del = db('cate')->where('id', input('id'))->delete();
        if ($del) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

    //图片上传
    public function upload()
    {
        $file = request()->file('img');
        if ($file) {
            $info = $file->move(ROOT_PATH . 'public' . DS . 'static' . DS . 'admin' . DS . 'uploads' . DS . 'cate');
            if ($info) {
                // 成功上传后 获取上传信息
                // 输出 20160820/42a79759f284b767dfcb2a0197904287.jpg
                return $info->getSaveName();
            } else {
                // 上传失败获取错误信息
                echo $file->getError();
            }
        }
    }

    //ajax获取栏目信息
    public function ajaxCate()
    {
        $pCateId = input('cateId');

        $list = db('cate')->where('id', $pCateId)->find();
        //获取导航数据
//        $list = db('cate')
//            ->alias('c')
//            ->where('c.id', $pCateId)
//            ->join('model m','c.model_id = m.id')
//            ->field('c.*,m.model_name')
//            ->find();

        echo json_encode($list);
    }
}