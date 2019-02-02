<?php
namespace app\admin\model;

use think\console\input\Option;
use think\Model;

class Position extends Model
{
    protected static function init()
    {
        //前置钩子删除
        Position::beforeDelete(function($position){
            $adId = input('id');
            Ad::destroy(['adpos_id' => $adId]);
        });
    }
}