<?php
namespace app\index\controller;

use think\Controller;

class Cate extends Common
{
	public function index($cid)
	{
		$cates = db('cate')->find($cid);
		$cateTmp = $cates['list_tmp'];
		$tempSrc = $this->confTemp.'/'.$cateTmp;

		//判断指定栏目的跳转
  		if (!$cates['jump_id'] == 0) {
  			$cid = $cates['jump_id'];
  			$cates = db('cate')->find($cid);//查询当前栏目信息
  		}

		//获取侧边栏的栏目数据
		$topCid = model('cate')->getTopId($cid);
		$topCates = db('cate')->where(array('enabled' => 1))->find($topCid);
		$sonCateRes = db('cate')->where(array('pid' => $topCid, 'enabled' => 1))->select();

		//面包屑导航
		$pos = model('cate')->breadNav($cid);

		//获取文章
		$artRes = db('article')->where(array('cate_id' => $cid))->paginate(3);
		$page = $artRes->render();

		$sid = model('admin/cate')->childrenIds($cid);
		$sid[] = intval($cid);
		$map['cate_id'] = array('in', $sid);
		$artList = db('article')->where($map)->select();
		$this->assign([
			'artRes' => $artRes,
			'page' => $page,
			'cates' =>$cates,
			'topCates' => $topCates,
			'sonCateRes' => $sonCateRes,
			'topCid' => $topCid,//用于顶级栏目高亮的处理
			'cid' => $cid,//当前栏目的id，用于子栏目的高亮
			'pos' => $pos,
		]);

        return  $this->fetch($tempSrc);
	}
}