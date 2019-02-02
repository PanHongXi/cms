<?php

namespace app\admin\controller;

use think\Controller;

use think\Db;

class Model extends Common
{
    public function lst()
    {
        //处理排序
        if (request()->isPost()) {
            $data = input('post.');
            foreach ($data['sort'] as $k => $v) {
                if (!is_numeric($v)) {
                    return alert('排序只能是数字', '', 5);
                }

                \db('model')->where('id', $k)->update(['sort' => $v]);
            }
            echo "<script language=JavaScript> location.replace(location.href);</script>";
        }

        //获取模型列表
        $list = \db('model')->order('sort desc')->paginate(15);
        $page = $list->render();

        //获取数据表前缀
        $prefix = config('database.prefix');

        //输出
        $this->assign([
            'list'   => $list,
            'page'   => $page,
            'prefix' => $prefix
        ]);

        return view();
    }

    public function add1()
    {
        return view('model/add');
    }

    //添加模型
    public function add()
    {

        if (request()->isPost()) {
            $_data = input('post.');
           
            $data['table_name'] = $_data['table_names'];
            $data['model_name'] = $_data['model_name'];
            $data['sort']       = $_data['sort'];
            $data['status']     = $_data['status'];

            //验证
            $validate = Validate('model');
            if (!$validate->scene('add')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError(), 'url'=>'']);
            }

            $model = db('model')->insert($data);
            $tableName = $_data['table_names'];

            //获取表的表前缀，并拼接
            $tableName = config('database.prefix').$tableName;

            //检查数据表已经存在
            $exist = Db::query("show tables like '". $tableName."'");

            if (!$exist) {
                if ($model) {

                    //生成数据表
                    $sql = "create table {$tableName} (aid int unsigned not null ) engine=MYISAM default charset=utf8";

                    //执行语句，引用Db类
                    Db::execute($sql);

                    return json_encode(['status' => 1, 'msg' => '保存成功', 'url' => 'lst']);
                } else {
                    return json_encode(['status' => 0, 'msg' => '保存失败', 'url' => '']);
                }
            } else {
                return json_encode(['status' => 0, 'msg' => '附加表已存在', 'url' => '']);
            }
        }
        
        return view();
    }

    //修改模型
    public function edit()
    {
        $id = input('id');
        //获取数据
        $list = db('model')->where('id', $id)->find();

        if (request()->isPost()) {
            $_data = input('post.');
           
            $data['table_name'] = $_data['table_names'];
            $data['model_name'] = $_data['model_name'];
            $data['sort']       = $_data['sort'];
            $data['status']     = $_data['status'];

            //验证
            $validate = Validate('model');
            if (!$validate->scene('edit')->check($data)) {
                return json_encode(['status' => 0, 'msg' => $validate->getError(), 'url'=>'']);
            }

            if (!isset($data['status'])) {
                $data['status'] = 0;
            }

            $old_table_name = $list['table_name'];

            $model = \db('model')->where('id', $id)->setField($data);

            //处理修改后的数据表
            if ($old_table_name != $data['table_name']) {

                //获取数据表前缀
                $prefix = config('database.prefix');

                $old_table_name = $prefix.$old_table_name;
                $new_table_name = $prefix.$data['table_name'];

                $sql = "alter table {$old_table_name}  rename to {$new_table_name}";

                //执行删除语句
                Db::execute($sql);
            }

            if ($model !== false) {
                return json_encode(['status' => 1, 'msg' => '保存成功', 'url'=>'']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败', 'url'=>'']);
            }
        }

        //输出
        $this->assign([
            'list' => $list,
        ]);

        return view();
    }

    //修改启用状态
    public function changeStatus()
    {
        $id = input('modelId');
        $model = \db('model');
        $status = $model->where(array('id' => $id))->field('status')->find();
        $status = $status['status'];
        if ($status == 1) {
            $model->where(array('id' => $id))->update(['status' => 0]);
            return 1;
        } else {
            $model->where(array('id' => $id))->update(['status' => 1]);
            return 2;
        }

    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {

            //获取数据表前缀
            $prefix = config('database.prefix');

            //查询数据表
            $table_name = db('model')->where('id', $v)->field('table_name')->find();

            //拼接数据表前缀
            $table_name = $prefix.$table_name['table_name'];

            //删除数据表模型
            $sql = "drop table {$table_name}";

            //执行删除语句
            Db::execute($sql);

            $conf = db('model')->where('id', $v)->delete();
        }

        //返回
        if ($conf) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }

    //删除一条数据
    public function del()
    {
        $table_name = input('table_name');

        $del = db('model')->where('id', input('id'))->delete();

        //删除数据表模型
        $sql = "drop table {$table_name}";

        //执行删除语句
        Db::execute($sql);

        if ($del) {

            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }
}