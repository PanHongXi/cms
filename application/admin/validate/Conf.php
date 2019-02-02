<?php
namespace app\admin\validate;

use think\Validate;

class Conf extends Validate
{
    protected $rule =   [
        'cname'  => 'require|max:25|unique:conf',
        'ename'  => 'require|unique:conf',
        'age'   => 'number|between:1,120',
        'email' => 'email',
    ];

    protected $message  =   [
        'cname.require' => '中文名称不能为空',
        'cname.max'     => '中文名称最多不能超过25个字符',
        'cname.unique'  => '名称不能重复',
        'ename.unique'  => '名称不能重复',
        'ename.require' => '英文名不能为空',
    ];

}