<?php

/**
 * @ file
 *  
 * @ Channel
 */

namespace Entity\Snake;

use PDO;
use Exception;

entity_register('snake', array(
    'controller' => 'Entity\\Snake\\SnakeEntityController',
    'primaryKey' => 'id',
    'baseTable'  => 'snake',
));

class Snake {

    //根据主键读取
    public static function load($request) {
        $id  = (int) $request->getParameter('id');
        $data = entity_load('snake', array($id));
        return reset($data);
    }
    
    //根据game_path读取
    public static function loadByGamePath($request) {
        $game_path  = $request->getParameter('game_path');
        $ids = db_select("snake","c")
                ->fields("c",array("id"))
                ->condition("game_path",$game_path)
                ->execute()
                ->fetchCol();
        $data = entity_load('snake', $ids);
        return reset($data);
    }
    
    //根据主键读取多个
    public static function loadMulti($request) {
        $ids = $request->getParameter('ids');
        if ($ids && !is_array($ids)) {
            $ids = explode(',', $ids);
        }
        $data = entity_load('snake', $ids);
        return $data;
    }
    
    //LoadByWid
    public static function loadByWid($wid,$play_date=null) {
        if (empty($play_date)) {
            $play_date = date('Ymd');
        }
        $ids = db_select("snake","s")
                    ->fields("s",array('id'))
                    ->condition("wid",$wid)
                    ->condition("play_date",$play_date)
                    ->execute()
                    ->fetchCol();
        return self::load(entity_request(array('id'=>current($ids))));
    }
    
    //新增
    public static function insert($request) {
        $snake = (object) $request->getParameters();
        unset($snake->id);
        $snake->created = $snake->updated = time();
        entity_insert('snake', $snake);            
        //logger()->info("新增游戏成功: ".var_export((array)$snake,true));
        return $snake;
    }
    
    //更新
    public static function update($request) {
        $snake = (object) $request->getParameters();
        unset($snake->created);
        $snake->updated = time();
        entity_update('snake', $snake);           
        return $snake;
    }

    //列表
    public static function search($request) {
        $navi   = array('page'=> 1,'size' => 10, 'total'=> 0, 'pages' => 1);
        $page   = (int) $request->getParameter('page', 1);
        $size   = (int) $request->getParameter('size', 10);
        $query  = db_select('snake', 'c')
                        ->extend('Pager')->page($page)->size($size)
                        ->fields('c', array('id'));     
        foreach ($request->getParameter('conditions',array()) as $key=>$val) {
            $flag = isset($val['flag'])? $val['flag'] : '=';
            if (!is_null($val['value'])) {
                $query->condition($key,$val['value'],$flag);
            }
        }
        foreach($request->getParameter('leftJoin',array()) as $tb=>$val) {
            $query->leftJoin($tb,$tb,$tb.".entity_id=c.id");
            foreach ($val as $kk=>$vv) {
                $flag = isset($vv['flag'])? $vv['flag'] : '=';
                if (!is_null($vv['value'])) {
                    $query->condition($tb.".".$kk,$vv['value'],$flag);
                }
            }
        }
        foreach ($request->getParameter('orderBys',array()) as $key=>$val) {
            if (!is_null($val['value'])) {
                $query->orderBy($key,$val['value']);
            }
        }
        $query->orderBy('id','DESC');
        $pager = array_merge($navi, $query->fetchPager());
        $ids   = $query->execute()->fetchCol();
        $data  = self::loadMulti(entity_request(array('ids'=>$ids)));

        return array('data'=>$data, 'pager'=>$pager);
    }
    
}
