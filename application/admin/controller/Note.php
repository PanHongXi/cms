<?php
namespace app\admin\controller;

use QL\QueryList;
use think\Controller;

class Note extends Common
{
    public function lst()
    {
        $list = db('note')
            ->alias('n')
            ->join('model m', 'm.id = n.model_id')
            ->field('n.*,m.model_name')
            ->order('id desc')
            ->paginate(15);

        $page = $list->render();

        //输出
        $this->assign([
            'list' => $list,
            'page' => $page,
        ]);

        return view();
    }

    //添加采集列表
    public function addlr()
    {
        //处理接收的添加数据
        if (request()->isPost()) {
            $_data = input('post.');
            $data['note_name'] = $_data['note_cname'];
            $data['model_id'] = $_data['model_id'];
            $data['output_encoding'] = $_data['output_encoding'];
            $data['input_encoding'] = $_data['input_encoding'];
            $data['addtime'] = time();
            $data['lasttime'] = time();
            $data['list_rules'] = array([
                'list_url'    => $_data['list_url'],
                'start_page'  => $_data['start_page'],
                'end_page'    => $_data['end_page'],
                'add_page'    => $_data['add_page'],
                'range'       => $_data['range'],
                'list_rules' => array([
                    'url_rule'    => $_data['url_rule'],
                    'litpic_rule' => $_data['litpic_rule'],
                ]),
            ]);

            $data['list_rules'] = json_encode($data['list_rules']);

            $note_id = db('note')->insertGetId($data);//保存数据并获取数据id
            if ($note_id) {

                session('note_id', $note_id);

                //获取添加成功后的所属模型id
                $model_id = db('note')->where('id', $note_id)->field('model_id')->find();
                $model_id = $model_id['model_id'];

                //重定向
//                $this->redirect('Note/addir', ['model_id' => $model_id]);
                return json_encode(['status' => 1, 'msg' => '', 'url' => 'addir/model_id/'.$model_id]);

            } else {
                return 2;
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

    //item配置规则
    public function addir()
    {
        $model_id = input('model_id');

        if (request()->isPost()) {
            $data = input('post.');

            $rules = array();

            if ($data) {
                foreach ($data as $k => $v) {
                    $rules[$k][0] = $v[0];
                    $rules[$k][1] = $v[1];
                    $rules[$k][2] = $v[2];
                    array_values($rules[$k]);
                }
            }

            $rules = json_encode($rules);

            $note_id = session('note_id');

            $note = db('note')->where(array('id' => $note_id))->setField(['item_rules' => $rules, 'lasttime' => time()]);

            if ($note) {
                session(null);
                return json_encode(['status' => 1, 'msg' => '保存成功！', 'url' => 'addlr']);
            } else {
                return json_encode(['status' => 2, 'msg' => '保存失败！', 'uel' => '']);
            }

        }

        //获取附表字段
        $modelFieldList = db('modelfield')->where('model_id', $model_id)->field('field_cname,field_ename')->select();

        //输出
        $this->assign([
            'modelFieldList' => $modelFieldList,
        ]);

        return view();
    }

	public function showcaiji($id)
	{
		//获取导航数据
        $cateRes = db('cate')->select();
        $catelist = model('Cate')->cateTree($cateRes);
		$this->assign([
			'id' => $id,
			'cateList' => $catelist,
		]);
		return view();
	}

    //执行采集
    public function collection($id)
    {
        $notes = db('note')->find($id);

        //获取输出编码
        $output_encoding = $notes['output_encoding'];

        //获取输入编码
        $input_encoding  = $notes['input_encoding'];

        //获取采集配置
        $list_rules = $notes['list_rules'];

        //json转换数组
        $listRules = json_decode($list_rules, true);

        //获取内容页采集规则
        $item_rules = $notes['item_rules'];

        //json转换数组
        $item_rules = json_decode($item_rules, true);


        //转化二维数组
        $_listRules = array();
        foreach ($listRules as $k => $v) {
            $_listRules = $v;
        }

        //采集类表网址
        $list_url = $_listRules['list_url'];

        //采集开始页码
        $start_page = $_listRules['start_page'];

        //最后采集页码
        $end_page = $_listRules['end_page'];

        //采集页码步长
        $add_page = $_listRules['add_page'];

        //采集范围
        $range = $_listRules['range'];

        //采集规则
        $list_rule = $_listRules['list_rules'];

        //处理采集的规则
        $_list_rules = array();
        foreach ($list_rule as $k => $v) {
        	foreach ($v as $k1 => $v1) {
        		$_list_rules[$k1] =  explode(',', $v1);
        	}
        }

        //转换为实际的采集页码网址列表
        $_listUrl = [];
 
        //处理采集网址列表
        for ($i = $start_page; $i< $end_page; $i = $i+$add_page) {
            $_listUrl[] = str_ireplace('(*)', $i , $list_url);
        }

        //循环执行采集数据
        $_data = [];
        foreach ($_listUrl as $k => $url) {
            $_data[] = QueryList::Query($url, $_list_rules, $range, $output_encoding, $input_encoding)->data;
        }
   
        //重构采集数据列表集
        $dataList = array();
        foreach ($_data as $k => $v) {
        	foreach ($v as $k1 => $v1) {
        		$dataList[] = $v1;
        	}
        }

        //内容页采集数据结果集
        $_dataItem = array();
        foreach ($dataList as $k => $v) {
        	$_dataItem[] = QueryList::Query($v['url_rule'], $item_rules, '', $output_encoding, $input_encoding)->data;
        	$_dataItem[$k][0]['url'] = $v['url_rule'];
        	$_dataItem[$k][0]['litpic'] = $v['litpic_rule'];
        }

        //重构内容页采集数据结果集
        $dataItem = array();
        foreach ($_dataItem as $k => $v) {
        	foreach ($v as $k1 => $v1) {
        		$dataItem[] = $v1;
        	}
        }

        //插入采集的数据
        foreach ($dataItem as $k => $v) {
        	$data['nid'] = $id;
        	$data['title'] = $v['title'];

        	//防止重复采集
        	$reDate = db('html')->where(array('title' => $data['title']))->find();

        	if ($reDate) {
        		 return json_encode(['status' => 0, 'msg' => '禁止重复采集！', 'url' => '']);die;
        	}

        	$data['url'] = $v['url'];
        	$data['url'] = $v['litpic'];
        	$data['addtime'] = time();
        	$data['result'] = json_encode($v);
        	db('html')->insert($data);
        }

        //更新最后采集时间
        $noteTime = db('note')->where(array('id' => $id))->setField(['lasttime' => time()]);
        if ($noteTime) {
        	return json_encode(['status' => 1, 'msg' => '采集成功！', 'url' => '']);
        }
    }

    //执行导出数据
    public function exportdata()
    {
    	$noteId = input('id');
    	$cate_id = input('cate_id');
    	$cate = db('cate')->field('model_id')->find($cate_id);
    	$model_id = $cate['model_id'];
    	$model = db('model')->field('table_name')->find($model_id);
    	$tableName = $model['table_name'];

    	//获取导出的数据
    	$data = db('html')->where(array('export' => 0, 'nid' => $noteId))->field('export, result')->select();

    	//转换数据
    	$arr = array('title', 'keywords', 'describe', 'author', 'source', 'litpic', 'content', 'url');
    	$_article = array();//主表
    	$_addTable = array();
    	foreach ($data as $k => $v) {
    		$_data = json_decode($v['result'], true);
    		foreach ($_data as $k1 => $v1) {
    			if (in_array($k1, $arr)) {
    				$_article[$k1] = $v1;
    			} else {
    				$_addTable[$k1] = $v1;
    			}
    		}

    		$_article['cate_id'] = $cate_id;
    		$_article['model_id'] = $model_id;
    		//插入数据
    		$addId = db('article')->insertGetId($_article);
    		$_addTable['aid'] = $addId;
    		db("{$tableName}")->insert($_addTable);
    		db('html')->where(array('id' => $v['id']))->setField(['export' => 1]);

    		//批量导出
            $i = 0;
    		$i++;
    		if (($i%6) == 0) {
    			sleep(3);
    		}
    	}

    	return json_encode(['status' => 1, 'msg' => '采集成功！', 'url' => '']);
    }

    public function edit()
    {
        //接受处理修改数据
        if (request()->isPost()) {
            $data = input('post.');
            $base = [];
            $base['id'] = $data['id'];
            $base['model_id'] = $data['model_id'];
            $base['note_name'] = $data['note_cname'];
            $base['input_encoding'] = $data['input_encoding'];
            $base['output_encoding'] = $data['output_encoding'];
            $base['list_rules'] = array([
                'list_url' => $data['list_url'],
                'start_page' => $data['start_page'],
                'end_page' => $data['end_page'],
                'add_page' => $data['add_page'],
                'range' => $data['range'],
                'list_rules' => array([
                    'url_rule' => $data['url_rule'],
                    'litpic_rule' => $data['litpic_rule'],
                ]),

            ]);
            $base['list_rules'] = json_encode($base['list_rules']);

            $arr = array('id', 'note_name', 'input_encoding', 'output_encoding', 'list_rules', 'model_id', 'list_url', 'start_page', 'end_page', 'add_page', 'range','url_rule','litpic_rule');

            foreach ($data as $k => $v) {
                if (in_array($k, $arr)) {
                    unset($data[$k]);
                }
            }

            $base['item_rules'] = json_encode($data);

            $note = db('note')->setField($base);
            if ($note) {
                return 1;
            } else {
                return 2;
            }
        }

        $model_id = input('model_id');
        $note_id = input('note_id');

        //获取节点信息
        $noteList = db('note')->where(array('id' => $note_id))->find();

        //转化list_rules为数组
        $_listRules = json_decode($noteList['list_rules'], true);
        $listRules = array();
        foreach ($_listRules as $k => $v) {
            foreach ($v as $k1 => $v1) {
                $listRules[$k1] = $v1;
            }
        }


        //获取采集规则
        $list_rules = array();
        foreach ($listRules['list_rules'] as $k => $v) {
            foreach ($v as $k1 => $v1) {
                $list_rules[$k1] = $v1;
            }
        }

        //获取附表采集规则信息
        $_itemRules = $noteList['item_rules'];
        $itemRules = json_decode($_itemRules,true);

        //获取模型
        $modelList = db('model')->select();

        //获取附表字段
        $modelFieldList = db('modelfield')->where('model_id', $model_id)->field('field_cname,field_ename')->select();

        //输出
        $this->assign([
            'noteList' => $noteList,
            'modelList' => $modelList,
            'modelFieldList' => $modelFieldList,
            'listRules' => $listRules,
            'list_rules' => $list_rules,
            'itemRules' => $itemRules,
        ]);

        return view();
    }

}