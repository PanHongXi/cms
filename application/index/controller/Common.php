<?php
namespace app\index\controller;
use think\Controller;
class Common extends Controller
{
	public $confTemp;
    public $confs;

    //初始化
    public function _initialize()
    {
        $tempFloder = $this->getTemp();
        $this->confTemp = config('template.view_path').$tempFloder;
        $temp_src = config('view_replace_str.temp_srcs').$tempFloder;
        $cateTopRes = $this->getTopCate();
        $cateFootRes = $this->getFootCate();
        $this->confs = $this->getConf();//获取配置项
    
    	$this->assign([
            'temp' => $this->confTemp,
            'temp_src' => $temp_src,
            'cateTopRes' => $cateTopRes,
            'cateFootRes' => $cateFootRes,
            'confs' => $this->confs,
        ]);
    }

    //获取头部导航
    public function getTopCate()
    {
        $cateTopRes = db('cate')->where(array('pid' => 0, 'enabled' => 1))->select();
        foreach ($cateTopRes as $k => $v) {
            $cateTopRes[$k]['children'] = db('cate')->where(array('pid' => $v['id'], 'enabled' => 1))->select();;
        }

        return $cateTopRes;
    }

    //获取底部导航
    public function getFootCate()
    {
        $cateFootRes = db('cate')->where(array('pid' => 0, 'enabled' => 1, 'foot_nav' => 1))->select();
        foreach ($cateFootRes as $k => $v) {
            $cateFootRes[$k]['children'] = db('cate')->where(array('pid' => $v['id'], 'enabled' => 1, 'foot_nav' => 1))->select();;
        }

        return $cateFootRes;
    }

	//获取配置项
    public function getTemp ()
    {
        $confTemp = \db('conf')->where(array('ename' => 'temp'))->field('value')->find();

        // $tempUrl['tempUrl'] = config('template.view_path').$confTemp['value'];
        // $fielName = $confTemp['value'];
        // $tempUrl['temp_src'] = config('view_replace_str.temp_srcs').$fielName;

        // $this->config = $confRes;
        return $confTemp['value'];
    }

    //获取配置项并进行组装
    public function getConf()
    {
        $_confRes = db('conf')->field('ename,value')->select();
        $confRes = array();
        foreach ($_confRes as $k => $v) {
            $confRes[$v['ename']] = $v['value'];
        }

        return $confRes;
    }
}