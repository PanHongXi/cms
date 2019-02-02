<?php

namespace app\admin\controller;

use think\Controller;

use think\Db;

class Ad extends Common
{
    public function lst()
    {
        $list = db('ad')->alias('a')->join('position p', 'p.id=a.adpos_id')->field('a.*, p.name')->paginate(15);
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

            $ad = model('ad');
            $ad = $ad->save($data);

            if ($ad) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败']);
            }
        }

        $position = \db('position')->where('status' , 1)->select();

        $this->assign([
            'position' => $position,
        ]);

        return view();

    }

    //修改启用状态
    public function changeStatus()
    {
        $id = input('adId');
        $adpos_id = input('adposId');
        $ad = \db('ad');
        $status = $ad->where(array('id' => $id))->field('status')->find();
        $status = $status['status'];
        if ($status == 0) {
			$ad->where(array('adpos_id' => $adpos_id))->update(['status' => 0]);
            $ad->where(array('id' => $id))->update(['status' => 1]);
            return 1;
        } else {
        	 $ad->where(array('id' => $id))->update(['status' => 0]);
            return 2;
        }
    }

	//修改
    public function edit($id)
    {
        if (request()->isPost()){
            $data = input('post.');

            $ad = model('ad');
            $ad = $ad->update($data);
            if ($ad !== false) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存成功']);
            }

        }

        //获取广告信息
        $adList = db('ad')->where(array('id' => $id))->find();

        //判断类型广告
        if ($adList['type'] == 2) {
        	$adFlash = db('adflash')->where(array('ad_id' => $id))->select();
        	$this->assign([
        		'adFlash' => $adFlash,
        	]);
        }

        //获取广告位信息
        $position = \db('position')->where('status' , 1)->select();

        $this->assign([
            'position' => $position,
            'adList' => $adList,
        ]);
        return view();
    }

    //异步删除轮播广告
    public function ajaxdelimg()
    {
    	$id  = input('id');
    	
		$adflash = db('adflash')->where(array('id' => $id))->find();

		if (file_exists($adflash['fileimg'])) {
			$fileimg = INDEXIMG.$adflash['fileimg'];
			@unlink($fileimg);
		}
		$del = db('adflash')->where(array('id' => $id))->delete();
		if ($del) {
			echo 1;
		} else {
			echo 2;
		}
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {
            $conf = db('ad')->where('id', $v)->delete();
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
    	$ad = model('ad');
        $del = $ad::destroy(input('id'));
        if ($del) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

}