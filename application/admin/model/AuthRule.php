<?php
namespace app\admin\model;

use think\Model;

class AuthRule extends Model
{
    protected $tableName = 'auth_rule';//不包含表前缀
    protected $trueTableName  = 'cms_auth_rule';//包含表前缀

    public function authRuleTree($ruleRes)
    {
        return $this->sort($ruleRes);
    }

    public function sort($ruleRes, $pid = 0, $level = 0)
    {
        static $arr = array();

        foreach ($ruleRes as $k => $v) {

            if ($v['pid'] == $pid) {
                $v['level'] = $level;
                $arr[] = $v;
                $this->sort($ruleRes, $v['id'], $level + 1);
            }
        }

        //返回
        return $arr;
    }

    //获取子栏目
    public function childrenIds($ruleId)
    {
        $data = db('auth_rule')->field('id ,pid')->select();
        return $this->_childrenIds($data, $ruleId);
    }

    public function _childrenIds($data, $ruleId)
    {
        static $arr = array();
        foreach ($data as $k => $v) {
            if ($v['pid'] == $ruleId) {
                $arr[] = $v['id'];
                $this->_childrenIds($data, $v['id']);
            }
        }

        return $arr;
    }
}