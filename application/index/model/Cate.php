<?php
namespace app\index\model;

use think\Model;

class Cate extends Model
{
	//面包屑导航
	public function breadNav($cid)
	{
		static $pos = array();

		if (empty($pos)) {
			$cates = db('cate')->field('pid,cate_name,id,cate_attr')->find($cid);
			$pos[] = $cates;
		}

		$data = db('cate')->field('pid,cate_name,id,cate_attr')->select();//所有栏目信息
		$cates = db('cate')->field('pid,cate_name,id,cate_attr')->find($cid);//当前栏目的信息

		foreach ($data as $k => $v) {
			if ($cates['pid'] == $v['id']) {
				$pos[] = $v;
				$this->breadNav($v['id']);
			}
		}

		return array_reverse($pos);
	}

	//根据当前栏目id获取顶级栏目id
	public function getTopId($cid)
	{
		$data = db('cate')->select();
		return $this->_getTopId($cid, $data);
	}

	public function _getTopId($cid, $data)
	{
		static $topId;
		$cates = db('cate')->find($cid);
		if ($cates['pid'] == 0) {
			return $cates['id'];
		}
		foreach ($data as $k => $v) {
			if ($cates['pid'] == $v['id']) {
				$topId = $v['id'];
				$this->_getTopId($v['id'], $data);
			}
		}

		return $topId;
	}

	//获取单页面的数据
	public function getPageContent($cid)
	{
		$cates = $this->field('content')->find($cid);
		$content = strip_tags($cates['content']);
		return $content;
	}
}