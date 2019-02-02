<?php
namespace app\admin\controller;

use think\Controller;
use think\Db;

class ModelField extends Common
{
    //字段列表
    public function lst()
    {

        $modelId = input('id');
        if ($modelId) {
             $map['f.model_id'] = ['=', $modelId];
         } else {
            $map = 1;
         }

        //获取数据列表
        $list = \db('modelfield')
            ->alias('f')
            ->where($map)
            ->join('model m', 'f.model_id = m.id')
            ->field('f.*, m.model_name')
            ->order('field_id desc')
            ->paginate(15);

        //分页
        $page = $list->render();

        //输出
        $this->assign([
            'list' => $list,
            'page' => $page
        ]);

        return view();
    }

    //添加字段
    public function add()
    {
        if (request()->isPost()) {
            $data = input('post.');

            //替换中文“，”
            if ($data['field_values']) {
                $data['field_values'] = str_ireplace('，', ',', $data['field_values']);
            }

            //验证的数据
            $validate = validate('ModelField');
            if (!$validate->scene('add')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            //获取模型字段
            $tableName = db('model')->field('table_name')->find($data['model_id']);

            //获取表的表前缀，并拼接
            $tableName = config('database.prefix').$tableName['table_name'];

            $field = db('modelfield')->insert($data);

            if ($field) {

                //循环判断字段类型
                switch ($data['field_type']) {
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 6:
                        $fieldType = 'varchar(150) not null default ""';
                        break;

                    case 5:
                        $fieldType = "varchar(600) not null default ''";
                        break;

                    case 7:
                        $fieldType = 'float not null default "0.0"';
                        break;

                    case 8:
                        $fieldType = 'int not null default "0"';
                        break;

                    case 9:
                        $fieldType = 'longtext';
                        break;

                    default:
                        $fieldType = 'varchar(150) not null default "0"';
                        break;
                }

                //添加字段 $sql = "ALTER TABLE cms_film ADD dd varchar(150) NOT NULL ";

                $sql = "ALTER TABLE {$tableName} ADD {$data['field_ename']} {$fieldType} comment '{$data['field_cname']}'";

                //执行语句，引用Db类
                Db::execute($sql);

                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败']);
            }
        }

        //获取模型
        $modelList = db('model')->select();

        //输出
        $this->assign([
            'modelList' => $modelList
        ]);

        return view();
    }

    //字段修改
    public function edit()
    {
        $modelField = db('modelfield');

        //处理修改的信息
        if (request()->isPost()) {
            $data = input('post.');

            //替换中文“，”
            if ($data['field_values']) {
                $data['field_values'] = str_ireplace('，', ',', $data['field_values']);
            }

            //验证的数据
            $validate = validate('ModelField');
            if (!$validate->scene('edit')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError()]);
                die;
            }

            //连表查询
            $fieldInfo = \db('modelfield')
                ->alias('f')
                ->where('f.field_id', $data['field_id'])
                ->join('model m', 'f.model_id = m.id')
                ->field('f.field_ename, m.table_name')->find();

            //获取表的表前缀，并拼接
            $tableName = config('database.prefix').$fieldInfo['table_name'];

            //获取旧的字段
            $oldFieldName = $fieldInfo['field_ename'];

            //新的字段名称
            $newFieldName = $data['field_ename'];

            //循环判断字段类型
            switch ($data['field_type']) {
                case 1:
                case 2:
                case 3:
                case 4:
                case 6:
                    $fieldType = 'varchar(150) not null default ""';
                    break;

                case 5:
                    $fieldType = "varchar(600) not null default ''";
                    break;

                case 7:
                    $fieldType = 'float not null default "0.0"';
                    break;

                case 8:
                    $fieldType = 'int not null default "0"';
                    break;

                case 9:
                    $fieldType = 'longtext';
                    break;

                default:
                    $fieldType = 'varchar(150) not null default "0"';
                    break;
            }

            //修改字段
            $sql = "ALTER TABLE {$tableName} CHANGE {$oldFieldName} {$newFieldName} {$fieldType} comment '{$data['field_cname']}'";

            //执行语句，引用Db类
            Db::execute($sql);

            //执行更新数据
            $edit = $modelField->where('field_id', $data['field_id'])->setField($data);

            if ($edit) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => '']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败']);
            }
        }

        //获取字段信息
        $info = $modelField->where('field_id', input('id'))->find();

        //获取模型
        $modelList = db('model')->select();

        //输出
        $this->assign([
            'info'      => $info,
            'modelList' => $modelList
        ]);

        return view();
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {

            //连表查询
            $fieldInfo = \db('modelfield')
                ->alias('f')
                ->where('f.field_id', $v)
                ->join('model m', 'f.model_id = m.id')
                ->field('f.field_ename, m.table_name')->find();

            //获取表的表前缀，并拼接
            $tableName = config('database.prefix').$fieldInfo['table_name'];

            //获取删除的字段
            $fieldName = $fieldInfo['field_ename'];

            //删除表字段
            $sql = "alter table {$tableName} drop column {$fieldName}";

            //执行sql
            Db::execute($sql);


            $conf = db('modelfield')->where('field_id', $v)->delete();
        }

        if ($conf) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

    //删除一条数据
    public function del()
    {
        $id = input('id');

        //连表查询
        $fieldInfo = \db('modelfield')
            ->alias('f')
            ->where('f.field_id', $id)
            ->join('model m', 'f.model_id = m.id')
            ->field('f.field_ename, m.table_name')->find();

        //获取表的表前缀，并拼接
        $tableName = config('database.prefix').$fieldInfo['table_name'];

        //获取删除的字段
        $fieldName = $fieldInfo['field_ename'];

        //删除表字段
        $sql = "alter table {$tableName} drop column {$fieldName}";

        //执行sql
        Db::execute($sql);

        //删除
        $del = db('modelfield')->where('field_id', $id)->delete();

        if ($del) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

}