<?php
namespace app\admin\validate;

use think\Validate;

class Cate extends Validate
{
    protected $rule =   [
        'cate_name'  => 'require|max:25|unique:cate',
        'cate_name'  => 'require|max:60',
        'keywords'   => 'require',
        'sort'       => 'number',
    ];

    protected $message  =   [
        'cate_name.require' => '导航名称不能为空',
        'cate_name.max'     => '导航名称最多不能超过25个字符',
        'cate_name.unique'  => '导航名称不能重复',
        'title.require'     => '标题不能为空',
        'title.max'         => '标题不能超过60个字符',
        'keywords.require'  => '关键字不能为空',
        'sort.number'       => '排序只能是数字',

    ];

}