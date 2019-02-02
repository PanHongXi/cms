<?php
namespace app\admin\model;

use think\Model;

class AuthGroup extends Model
{
    protected $tableName = 'auth_group';//不包含表前缀
    protected $trueTableName  = 'cms_auth_group';//包含表前缀
}