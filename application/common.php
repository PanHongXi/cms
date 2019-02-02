<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件
function alert($msg='',$url='',$icon='',$time=3)
{
    $str = '<script type="text/javascript" src="' . config('admin_static') . 'https://code.jquery.com/jquery-3.3.1.min.js"></script><script type="text/javascript" src="' . config('admin_static') . 'https://res.layui.com/layui/release/layer/dist/layer.js?v=3111"></script>';//加载jquery和layer
    $str .= '<script>$(function(){layer.msg("' . $msg . '",{icon:' . $icon . ',time:' . ($time * 500) . '});setTimeout(function(){location.replace(location.href);},1000)});</script>';//主要方法
    return $str;
}

//获取编辑器
function get_ueditor ($name, $value='', $width=800, $height=400)
{
    $str=<<<HTML
    <textarea id='$name' name='$name'>$value</textarea>
    <script type="text/javascript">
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    UE.getEditor('$name',{
        initialFrameWidth:$width,
        initialFrameHeight:$height,
        toolbars: [[
            'fullscreen', 'source', 'undo', 'redo','bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript','removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist','selectall', 'cleardoc'
        ]]
    });
    </script>
HTML;

    return $str;
}

//上传图片
function uploadImg($fileName, $url){
    // 获取表单上传文件 例如上传了001.jpg
    $file = request()->file($fileName);

    // 移动到框架应用根目录/public/uploads/ 目录下
    if($file){
        $info = $file->move(ROOT_PATH . 'public/static/admin/uploads/'.$url);
        if($info){
            // 成功上传后 获取上传信息
            return $url . '/' .$info->getSaveName();

        }else{
            // 上传失败获取错误信息
            return $file->getError();
        }
    }
}