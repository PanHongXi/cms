<?php
namespace app\admin\controller;

use think\Controller;

class Fileupload extends Common
{
    public function img()
    {
        if (request()->isPost()) {
            return 1;
        }
        return view();
    }

    //图片上传
    public function upload()
    {
        $file = request()->file('img');

        if ($file) {
            $info = $file->move(ROOT_PATH . 'public' . DS . 'static' . DS . 'admin' . DS . 'uploads' . DS . 'article');
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
}