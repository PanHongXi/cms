<?php

namespace app\admin\controller;

use think\Controller;

use think\Db;

class Article extends Common
{
    public function lst()
    {
        //获取文章列表信息
        $list = \db('article')
            ->field('a.*,m.model_name, c.cate_name')
            ->alias('a')
            ->join('model m', 'm.id = a.model_id')
            ->join('cate c', 'c.id = a.cate_id')->paginate(15);

        //分页
        $page = $list->render();

        //接受cateId，modelId
        $cateId  = input('cateId');
        $modelId = input('modelId');

        if (!$modelId) {
            $modelId = 0;
        }

        $this->assign([
            'cateId'  => $cateId,
            'modelId' => $modelId,
            'list' => $list,
            'page' => $page,
        ]);

        return view();
    }

    public function add()
    {
        //接受cateId，modelId
        $cateId  = input('cateId');
   
        $modelId = input('modelId');
        if (!$modelId) {
            $modelId = 0;
        }

        if (request()->isPost()) {
            $data = input('post.');

            //处理图片上传
            $data['litpic'] = session('img');

            //获取表前缀
            $table = config('database.prefix').'article';

            //获取主表字段
            $columns = array();
            $_columns = Db::query("SHOW COLUMNS FROM {$table}");
            foreach ($_columns as $k => $v) {
                $columns[] = $v['Field'];
            }

            //处理主表，附表字段
            $masterTable = array();//主表
            $scheduleTable = array();//附表
            foreach ($data as $k => $v) {
                if (in_array($k, $columns)) {

                    //转换数组为字符串
                    if (is_array($v)) {
                        $v = implode(',', $v);
                    }
                    $masterTable[$k] = $v;
                } else {
                    if (is_array($v)) {

                        $v = implode(',', $v);
                    }
                    $scheduleTable[$k] = $v;
                }
            }

            //处理附表字段的图片添加
            if ($_FILES) {
                foreach ($_FILES as $k => $v) {
                    //判断是否上传图片
                    if ($v['name'] != '') {
                        $scheduleTable[$k] = uploadImg($k, 'article');
                    }
                }
            }

            $masterTable['addtime'] = time();//主表的添加时间
            //添加主表数据并返回id
            $_masterTable = \db('article')->insertGetId($masterTable);

            //获取附表表名
            $tableName = \db('model')->where('id', $data['model_id'])->field('id, table_name')->find();
            $tableName = $tableName['table_name'];

            //添加附表数据
            $scheduleTable['aid'] = $_masterTable;
            $_scheduleTable = \db("{$tableName}")->insert($scheduleTable);

            if ($_masterTable && $_scheduleTable) {
                session('img', '');
                return json_encode(['status' => 1, 'msg' => '保存成功！', 'url' => 'lst']);
            } else {
                return json_encode(['status' => 0, 'msg' => '保存失败！']);
            }

            return;
        }

        //获取模型
        $modelList = db('model')->select();

        //获取当前模型的字段
        $diyField = db('modelfield')->where('model_id', $modelId)->order('field_type asc')->select();

        //获取长文本的数据
        $longText = db('modelfield')->where(['model_id' => $modelId, 'field_type' => 9])->select();

        //获取导航数据
        $cate = db('cate')->where('id', $cateId)->field('id, cate_name')->find();

        //输出
        $this->assign([
            'modelList' => $modelList,
            'cate'      => $cate,
            'cateId'    => $cateId,
            'modelId'   => $modelId,
            'diyField'  => $diyField,
            'longText'  => $longText,
        ]);

        return view();
    }

    public function edit()
    {
        //接受cateId，modelId
        $cateId  = input('cate_id');
        $modelId = input('model_id');
        $artId = input('art_id');
        if (!$modelId) {
            $modelId = 0;
        }

        //获取附加表数据
        $diyTable = db('model')->where('id', $modelId)->field('table_name')->find();
        $diyTableName =  $diyTable['table_name'];
        $diyValues = \db("{$diyTableName}")->where(array('aid' => $artId))->find();

        //处理修改数据
        if (request()->isPost()) {
            $data = input('post.');

            //处理图片上传
            $data['litpic'] = session('img');

            //获取表前缀
            $table = config('database.prefix').'article';

            //获取主表字段
            $columns = array();
            $_columns = Db::query("SHOW COLUMNS FROM {$table}");
            foreach ($_columns as $k => $v) {
                $columns[] = $v['Field'];
            }

            //处理主表，附表字段
            $masterTable = array();//主表
            $scheduleTable = array();//附表
            foreach ($data as $k => $v) {
                if (in_array($k, $columns)) {

                    //转换数组为字符串
                    if (is_array($v)) {
                        $v = implode(',', $v);
                    }
                    $masterTable[$k] = $v;
                } else {
                    if (is_array($v)) {

                        $v = implode(',', $v);
                    }
                    $scheduleTable[$k] = $v;
                }
            }

            //处理附表字段的图片添加
            if ($_FILES) {
                foreach ($_FILES as $k => $v) {

                    //判断是否上传图片
                    if ($v['name'] != '') {
                        $scheduleTable[$k] = uploadImg($k, 'article');
                    }
                }
            }

            //修改主表数据
            $saveArticle = db('article')->where('id', $masterTable['id'])->setField($masterTable);

            //修改附加表的数据
            $saveDiyTable = \db("{$diyTableName}")->where('aid', $masterTable['id'])->setField($scheduleTable);

            if ($saveArticle !== false && $saveDiyTable !== false) {
                session('img', '');
                $this->success('修改成功', 'lst');
            } else {
                $this->error('修改失败');
            }


        }

        //获取模型
        $modelList = db('model')->select();

        //获取附加表数据
        $diyTable = db('model')->where('id', $modelId)->field('table_name')->find();
        $diyTableName =  $diyTable['table_name'];
        $diyValues = \db("{$diyTableName}")->where(array('aid' => $artId))->find();

        //获取当前模型的字段
        $diyField = db('modelfield')->where('model_id', $modelId)->order('field_type asc')->select();

        //获取长文本的数据
        $longText = db('modelfield')->where(['model_id' => $modelId, 'field_type' => 9])->select();

        //获取导航数据
        $cate = db('cate')->where('id', $cateId)->field('id, cate_name')->find();

        //获取当前文章数据
        $artList = \db('article')->where('id', $artId)->find();

        //输出
        $this->assign([
            'modelList' => $modelList,
            'cate'      => $cate,
            'cateId'    => $cateId,
            'modelId'   => $modelId,
            'diyField'  => $diyField,
            'longText'  => $longText,
            'artList'   => $artList,
            'diyValues' => $diyValues,
            'artId'     => $artId,
            'modelId'   => $modelId,
        ]);

        return view();
    }

    public function addSelect()
    {
        //获取导航数据
        $cateRes = \db('cate')->select();
        $list = model('Cate')->cateTree($cateRes);
        $this->assign([
            'list'   => $list,
        ]);

        return view();
    }

    public function ajaxAddSelect()
    {
        $cateId = input('cateId');

        $modelId = \db('cate')->where(array('id' => $cateId))->find();

        echo json_encode($modelId['model_id']);
    }

    //ajax删除图片
    public function ajaxDelImg() {
        $art_id = input('art_id');
        $midel_id = input('midel_id');
        $field_name = input('field_name');

        $model = \db('model')->find($midel_id);

        //获取附加表名称
        $tableName = $model['table_name'];

        //删除文件夹的图片
        $urlImg = \db("{$tableName}")->where('aid', $art_id)->field("{$field_name}")->find();
        $delImg = IMG.$urlImg["{$field_name}"];
        @unlink($delImg);

        //处理数据
        $saveTable = \db("{$tableName}")->where('aid', $art_id)->setField("{$field_name}", '');

        if ($saveTable) {
            echo 1;
        } else {
            echo 2;
        }
    }

    //图片上传
    public function upload()
    {
        //获取相关的添加图片配置
        $thum_bnail = $this->config['thum_bnail'];//是否允许添加缩略图
        $watermark = $this->config['watermark'];//是否允许添加图片
        $thum_width = $this->config['thum_width'];//缩略图片宽度
        $thum_height = $this->config['thum_height'];//缩略图片高度
        $thum_type = $this->config['thum_type'];//缩略图裁剪位置
        $water_position = $this->config['water_position'];//水印位置
        $water_tmd = $this->config['water_tmd'];//水印透明度
        $water = IMG.$this->config['water'];//水印图片位置

        //处理缩略图裁剪位置
        switch ($thum_type) {
            case '等比例缩放':
                $_thum_type = 1;
                break;
            case '缩放后填充':
                $_thum_type = 2;
                break;
            case '居中裁剪':
                $_thum_type = 3;
                break;
            case '左上角裁剪':
                $_thum_type = 4;
                break;
            case '右下角裁剪':
                $_thum_type = 5;
                break;
            default :
                $_thum_type = 6;
                break;
        }

        //处理水印位置
        switch ($water_position) {
            case '左上角':
                $_water_position = 1;
                break;
            case '上居中':
                $_water_position = 2;
                break;
            case '右上角':
                $_water_position = 3;
                break;
            case '左居中':
                $_water_position = 4;
                break;
            case '居中':
                $_water_position = 5;
                break;
            case '右居中':
                $_water_position = 6;
                break;
            case '左下角':
                $_water_position = 7;
                break;
            case '下居中':
                $_water_position = 8;
                break;
            default :
                $_water_position = 9;
                break;
        }

        $file = request()->file('file');
        if ($file) {
            $info = $file->move(ROOT_PATH . 'public/static/admin/uploads/article');
            if ($info) {

                //获取图片上传成功后的路径
                $imgSrc = IMG.'article/'.$info->getSaveName();

                //打开上传的图片
                $image = \think\Image::open($imgSrc);

                if ($watermark == '是') {
                    // 按照原图的比例生成一个最大为150*150的缩略图并保存为thumb.png
                    $image->thumb($thum_width,$thum_height,$_thum_type)->water($water, $_water_position, $water_tmd)->save($imgSrc);
                } else {
                    $image->thumb($thum_width,$thum_height,$_thum_type)->save($imgSrc);
                }

                // 成功上传后 获取上传信息
                $img = session('img','article/'.$info->getSaveName());
                return $info->getSaveName();
            } else {
                // 上传失败获取错误信息
                echo $file->getError();
            }
        }
    }

    //批量删除
    public function delete()
    {
        $ids = $_POST['ids'];

        $conf = '';
        foreach ($ids as $k => $v) {
            $conf = db('admin')->where('uid', $v)->delete();
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
        $article = db('article')->where('id', input('id'))->field('litpic,model_id')->find();

        //删除图片
        $imgSrc = IMG.$article['litpic'];
        if ($article['litpic']) {
           if (file_exists($imgSrc)) {
            @unlink($imgSrc);
            }
        }
        
        //获取附加表数据并删除
        $model = db('model')->where(array('id' => $article['model_id']))->field('table_name')->find();
        $tableName = db("{$model['table_name']}")->where(array('aid' => input('id')))->delete();

        //删除文章数据
        $del = db('article')->where('id', input('id'))->delete();

        if ($del && $tableName) {
            return json(['message' => '删除成功！']);
        } else {
            return json(['message' => '删除失败！']);
        }
    }
}