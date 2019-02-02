<?php
namespace app\admin\validate;

use think\Validate;

class AuthGroup extends Validate
{
    protected $rule =   [
        'title'  => 'require|max:60|unique:auth_group',
        'name'  => 'require',
    ];

    protected $message  =   [
        'title.require' => '用户组名称不能为空',
        'title.max'     => '用户组名称最多不能超过60个字符',
        'title.unique'  => '用户组名称不能重复',
    ];

    protected $scene = [
        'add'  =>  ['title'],
        'edit' =>  ['title'],
    ];

}