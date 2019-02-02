<?php
namespace app\admin\validate;

use think\Validate;

class ModelField extends Validate
{
    protected $rule =   [
        'field_ename'  => 'require|unique:modelfield',
        'field_cname'  => 'require',
    ];

    protected $message  =   [
        'field_ename.require' => '英文名称不能为空',
        'field_ename.unique'  => '英文名称不能重复',
        'field_cname.require' => '附加表名称不能为空',
    ];

    protected $scene = [
        'add'  =>  ['field_ename','field_cname'],
        'edit' =>  ['field_ename','field_cname'],
    ];
}
