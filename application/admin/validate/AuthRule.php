<?php
namespace app\admin\validate;

use think\Validate;

class AuthRule extends Validate
{
    protected $rule =   [
        'title'  => 'require|max:60|unique:auth_rule',
        'name'  => 'require',
    ];

    protected $message  =   [
        'title.require' => '权限名称不能为空',
        'title.max'     => '权限名称最多不能超过60个字符',
        'title.unique'  => '权限名称不能重复',
        'name.require'     => '规则名不能为空',
    ];

    protected $scene = [
        'add'  =>  ['name','title'],
        'edit' =>  ['name','title'],
    ];

}