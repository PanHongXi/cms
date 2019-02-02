<?php
namespace app\admin\validate;

use think\Validate;

class Model extends Validate
{
    protected $rule =   [
        'model_name'  => 'require|unique:model',
        'table_name'  => 'require|unique:model',
        'keywords'    => 'require',
        'sort'        => 'number',
    ];

    protected $message  =   [
        'model_name.require' => '模型名称不能为空',
        'model_name.unique'  => '模型名称不能重复',
        'table_name.require' => '附加表名称不能为空',
        'table_name.unique'  => '附加表名称不能不能为空',
        'sort.number'        => '排序只能为数字',
    ];

    protected $scene = [
        'add'  =>  ['model_name','table_name','sort'],
        'edit' =>  ['model_name','table_name','sort'],
    ];
}
