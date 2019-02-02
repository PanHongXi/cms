<?php
namespace app\index\controller;

use think\Controller;

class Page extends Common
{
	public function index($cid)
	{
		$cates = db('cate')->find($cid);//查询当前栏目信息

  		//判断指定栏目的跳转
  		if (!$cates['jump_id'] == 0) {
  			$cid = $cates['jump_id'];
  			$cates = db('cate')->find($cid);//查询当前栏目信息
  		}

		$cateTmp = $cates['index_tmp'];//获取当前栏目加载的模板
		$tempSrc = $this->confTemp.'/'.$cateTmp;//组装模板路径
        
		//获取侧边栏的栏目数据
		$topCid = model('cate')->getTopId($cid);
		$topCates = db('cate')->where(array('enabled' => 1))->find($topCid);
		$sonCateRes = db('cate')->where(array('pid' => $topCid, 'enabled' => 1))->select();

		//面包屑导航
		$pos = model('cate')->breadNav($cid);

		$sid = model('admin/cate')->childrenIds($cid);
		$sid[] = intval($cid);
		$map['cate_id'] = array('in', $sid);
		$artList = db('article')->where($map)->select();

		//输出
		$this->assign([
			'cates' => $cates,
			'topCates' => $topCates,
			'sonCateRes' => $sonCateRes,
			'topCid' => $topCid,//用于顶级栏目高亮的处理
			'cid' => $cid,//当前栏目的id，用于子栏目的高亮
			'pos' => $pos,
			'artList' => $artList,
		]);

        return  $this->fetch($tempSrc);
	}
}