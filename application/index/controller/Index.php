<?php
namespace app\index\controller;

use think\Controller;
class Index extends Common
{
    public function index()
    {
    	//about数据
    	$about = model('cate')->getPageContent(35);

    	//公司新闻
    	$news = db('article')->where(array('cate_id' => 40))->order('id desc')->find();

    	//技术服务
    	$serw = model('cate')->getPageContent(45);

    	//产品中心
    	$proRes = db('article')->where('cate_id', 'in', 43,44)->order('id desc')->limit(10)->select();

	    $tempScr = $this->confTemp.'/index.html';
	    $topCid = '';
	    $this->assign([
	        'topCid' => $topCid,
	        'about' => $about,
	        'news' => $news,
	        'serw' => $serw,
	        'proRes' => $proRes,
	    ]);
	    return  $this->fetch($tempScr);
    }

    public function demo($name)
    {
    	return $name;
    }
}
