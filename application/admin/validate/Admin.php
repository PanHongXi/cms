<?php
namespace app\admin\validate;

use think\Validate;

class Admin extends Validate
{
    protected $rule =   [
        'uname'  => 'require|max:30|unique:admin',
        'password'  => 'require|min:6',
        'gruopid'   => 'require',
    ];

    protected $message  =   [
        'uname.require' => '管理员名称不能为空',
        'uname.max'     => '管理员名称最多不能超过30个字符',
        'uname.unique'  => '管理员名称不能重复',
        'password.require'     => '密码不能为空',
        'password.min'         => '密码不能少于6位',
        'gruopid.require'      => '请选择所属用户组',
    ];

    protected $scene = [
        'add'  =>  ['uname','password', 'gruopid'],
        'edit' =>  ['uname', 'gruopid'],
    ];

}