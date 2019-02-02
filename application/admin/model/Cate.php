<?php

namespace app\admin\model;

use think\Model;

class Cate extends Model
{
    public function cateTree($cateRes)
    {
        return $this->sort($cateRes);
    }

    public function sort($cateRes, $pid = 0, $level = 0)
    {
        static $arr = array();

        foreach ($cateRes as $k => $v) {

            if ($v['pid'] == $pid) {
                $v['level'] = $level;
                $arr[] = $v;
                $this->sort($cateRes, $v['id'], $level + 1);
            }
        }

        //返回
        return $arr;
    }

    //获取子栏目
    public function childrenIds($cateId)
    {
        $data = db('cate')->field('id ,pid')->select();
        return $this->_childrenIds($data, $cateId);
    }

    public function _childrenIds($data, $cateId)
    {
        static $arr = array();
        foreach ($data as $k => $v) {
            if ($v['pid'] == $cateId) {
                $arr[] = $v['id'];
                $this->_childrenIds($data, $v['id']);
            }
        }

        return $arr;
    }
}