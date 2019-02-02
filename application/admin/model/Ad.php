<?php
namespace app\admin\model;

use think\console\input\Option;
use think\Model;

class Ad extends Model
{
    protected $field = true;//忽略不是本表的字段

    protected static function init()
    {
        //前置钩子获取图片路径
        Ad::beforeInsert(function ($ad) {
            $data = input('post.');

            //判断是单张广告还是轮播广告图
            if ($data['type'] == 1) {
                if ($_FILES['file']['tmp_name']) {
                    $file = request()->file('file');
                    if($file) {
                        $info = $file->move(ROOT_PATH . 'public/static/index' . DS . 'uploads/ad');
                        if ($info) {
                            // 成功上传后 获取上传信息
                            $imgSrc = $info->getSaveName();
                            $ad['file'] = 'ad/'.$imgSrc;
                        } else {
                            // 上传失败获取错误信息
                            echo $file->getError();
                        }
                    }
                }
            }

            //改变同类型的广告状态
            if ($data['status'] == 1) {
                db('ad')->where(array('adpos_id' => $data['adpos_id']))->setField(['status' => 0]);
            }
        });

        //后置钩子获取轮播图片路径
        Ad::afterInsert(function ($ad) {
            $data = input('post.');

            //判断是单张广告还是轮播广告图
            if ($data['type'] == 2) {
                if ($_FILES['fileimg']['tmp_name']) {

                    //处理文件为空的链接
                    foreach ($_FILES['fileimg']['tmp_name'] as $k => $v) {
                        if (!$v) {
                            unset($data['filelink'][$k]);
                        }
                    }
                    sort($data['filelink']);//重新排序

                    $files = request()->file('fileimg');
                    foreach($files as $k => $file){
                        // 移动到框架应用根目录/public/uploads/ 目录下
                        $info = $file->move(ROOT_PATH . 'public/static/index' . DS . 'uploads/ad');
                        if($info){
                            //插入附表数据
                            $arr = array();
                            $arr['ad_id'] = $ad->id;
                            $arr['fileimg'] = 'ad/'.$info->getSaveName();
                            $arr['filelink'] = $data['filelink'][$k];
                            db('adflash')->insert($arr);

                        }else{
                            // 上传失败获取错误信息
                            echo $file->getError();
                        }
                    }
                }
            }
        });

        //前置钩子删除
        Ad::beforeDelete(function($ad){
            $adId = $ad->data['id'];
           
            $ad = Ad::find($adId);
            //判断广告的类型
            if ($ad['type'] == 1) {
                $imgSrc = INDEXIMG.$ad['file'];
                if (file_exists($imgSrc)) {
                    @unlink($imgSrc);
                }
            } else {
                $fileSrc = db('adflash')->field('fileimg')->where(array('ad_id' => $ad['id']))->select();
                
                foreach ($fileSrc as $k => $v) {
                    $fileimg = INDEXIMG.$v['fileimg'];
                    if (file_exists($fileimg)) {
                        @unlink($fileimg);
                    }
                }
                db('adflash')->where(array('ad_id' => $ad['id']))->delete();
            }
        });

        //修改前置钩子
        Ad::beforeUpdate(function($ad){
            $data = input('post.');

            if ($data['type'] == 1) {
               if ($_FILES['file']['tmp_name']) {
                    //处理旧的图片
                    $oldFile = INDEXIMG.$data['oldfile'];
                    if (file_exists($oldFile)) {
                       @unlink($oldFile);
                    }

                    $file = request()->file('file');
                    if($file) {
                        $info = $file->move(ROOT_PATH . 'public/static/index' . DS . 'uploads/ad');
                        if ($info) {
                            // 成功上传后 获取上传信息
                            $imgSrc = $info->getSaveName();
                            $neewFile = 'ad/'.$imgSrc;
                            Ad::where(array('id' => $data['id']))->update(['file' => $neewFile]);
                        } else {
                            // 上传失败获取错误信息
                            echo $file->getError();
                        }
                    }
                } 
                //处理启用状态
                if ($data['status'] == 1) {
                   Ad::where(array('adpos_id' => $data['adpos_id']))->update(['status' => 0]);
                }

            } else {
                if (isset($_FILES['fileimg']['tmp_name'])) {
                    //处理文件为空的链接
                    foreach ($_FILES['fileimg']['tmp_name'] as $k => $v) {
                        if (!$v) {
                            unset($data['filelink'][$k]);
                        }
                    }
                    sort($data['filelink']);//重新排序

                    $files = request()->file('fileimg');
                    foreach($files as $k => $file){
                        // 移动到框架应用根目录/public/uploads/ 目录下
                        $info = $file->move(ROOT_PATH . 'public/static/index' . DS . 'uploads/ad');
                        if($info){
                            //插入附表数据
                            $arr = array();
                            $arr['ad_id'] = $data['id'];
                            $arr['fileimg'] = 'ad/'.$info->getSaveName();
                            $arr['filelink'] = $data['filelink'][$k];
                            db('adflash')->insert($arr);

                        }else{
                            // 上传失败获取错误信息
                            echo $file->getError();
                        }
                    }
                }
                
                //处理启用状态
                if ($data['status'] == 1) {
                   Ad::where(array('adpos_id' => $data['adpos_id']))->update(['status' => 0]);
                }

                //处理链接
                if (isset($data['oldfilelink'])) {
                   foreach ($data['oldfilelink'] as $k => $v) {
                      db('adflash')->where(array('id' => $k))->update(['filelink' => $v]);
                   }
                }
            }
        });
    }
}