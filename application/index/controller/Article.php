<?php
namespace app\index\controller;

use think\Controller;

class Article extends Common
{
	public function index($aid)
	{
		$arts = db('article')->find($aid);
		$cid = $arts['cate_id'];
		$cates = db('cate')->find($arts['cate_id']);
		$artTmp = $cates['article_tmp'];
		$tempSrc = $this->confTemp.'/'.$artTmp;

		//获取侧边栏的栏目数据
		$topCid = model('cate')->getTopId($cid);
		$topCates = db('cate')->where(array('enabled' => 1))->find($topCid);
		$sonCateRes = db('cate')->where(array('pid' => $topCid, 'enabled' => 1))->select();
		//面包屑导航
		$pos = model('cate')->breadNav($cid);
		
		//获取文章
		$this->assign([
			'arts' => $arts,
			'cates' => $cates,
			'topCates' => $topCates,
			'sonCateRes' => $sonCateRes,
			'topCid' => $topCid,//用于顶级栏目高亮的处理
			'cid' => $cid,//当前栏目的id，用于子栏目的高亮
			'pos' => $pos,
		]);

        return  $this->fetch($tempSrc);
	}
}