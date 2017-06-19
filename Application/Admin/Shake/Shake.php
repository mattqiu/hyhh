<?php

namespace Admin\Shake;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;
use Admin;

class Shake {
   
    /**
     * 列表
     * @route /admin/shake/search
     * @access  admin_access
     * @param int $page     当前页数
     * @param int $size     每页显示数量
     * @param str $name     搜索关键词
     * @param int $status   状态
     * @return String
     */
    public static function search($request) {
        //conditions
        $conditions = array(
            'status' => array('value' => '0','flag'=>'<>'),
        );      
        $request->setParameter('conditions',$conditions);
        
        $res = array(
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            'list'  => Entity\Shake\Shake::search($request),
        );

        return new Response(theme()->render('shake-search.html',$res));  
    }
    

    /**
     * 添加
     * @route /admin/shake/add
     * @access  admin_access
     * @param  string title    活动名
     * @param  string preview  预览图
     * @return String
     */
    public static function add ($request) {     
        $post_data = $request->post->getParameters();        
        if (!empty($post_data)) {
            $array = $post_data;
            if (empty($array['title'])) {
                return new Response(json_encode(
                            array('status'=>'error' ,'msg'=>'必须填写标题')),'200',
                            array('Content-Type'=>'application/json'));
            }
            if (empty($array['timeout'])) {
                return new Response(json_encode(
                            array('status'=>'error' ,'msg'=>'必须填写游戏时间')),'200',
                            array('Content-Type'=>'application/json'));
            }
            
            Entity\Shake\Shake::insert(entity_request($array));
            return new Response(json_encode(
                            array('status'=>'success' ,'msg'=>'ok')),'200',
                            array('Content-Type'=>'application/json'));
        }
        else {
            $res['menus'] = Entity\Menu\Menu::getMenu($request->route->get('path'))[0];
            return new Response(theme()->render('shake-add.html',$res));
        }
    }

    /**
     * 修改
     * @route /admin/shake/edit/{id}
     * @access  admin_access
     * @param int $id
     * @return String
     */
	public static function edit($request) {
        $id = (int)$request->route->getParameter('id');
        $res['shake'] = Entity\Shake\Shake::load(entity_request(array('id'=>$id)));
        if (empty($res['shake'])) {
            return new RedirectResponse($request->getUriForPath('/admin/shake/search'),'2',
                        '非法操作',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $res['menus'] = Entity\Menu\Menu::getMenu($request->route->get('path'))[0];
        return new Response(theme()->render('shake-edit.html',$res));
    }
   
    /**
     * 更新
     * @route /admin/shake/update
     * @access  admin_access
     * @param array $request
     * @return json
     */
	public static function update($request) {
		$post_data = $request->getParameters();
		if (!empty($post_data['id'])) {
            $array = $post_data;
            $array['id']   = (int)$post_data['id'];
            if (empty($array['title'])) {
                return new Response(json_encode(
                            array('status'=>'error' ,'msg'=>'必须填写标题')),'200',
                            array('Content-Type'=>'application/json'));
            }
            if (empty($array['timeout'])) {
                return new Response(json_encode(
                            array('status'=>'error' ,'msg'=>'必须填写游戏时间')),'200',
                            array('Content-Type'=>'application/json'));
            }
            if ($array['status'] == 1) {
                //开始时间置0
                $array['opentime'] = 0;
            }
            
			Entity\Shake\Shake::update(entity_request($array));
            return new Response(json_encode(
                        array('status'=>'success','msg'=>'ok')),'200',
                        array('Content-Type'=>'application/json'));
		}
        else {
            return new Response(json_encode(
                            array('status'=>'error' ,'msg'=>'非法操作')),'200',
                            array('Content-Type'=>'application/json'));
        }
	}
    
    /**
	 * 删除
     * @route /admin/shake/delete/{id}
     * @access  admin_access
     * @param int $id
	 * @return redirect
	 */
	public static function delete($request) {
		$id = (int)$request->route->getParameter('id');
		if ($id) {
            $shake = Entity\Shake\Shake::load(entity_request(array('id'=>$id)));
            db_update("shake")
                ->fields(array('status'=>'0','updated'=>time()))
                ->condition("id",$id)
                ->execute();
            return new RedirectResponse($request->getUriForPath('/admin/shake/search'),'0','成功');
        }
        else {
            return new RedirectResponse($request->getUriForPath('/admin/shake/search'),'2',' illegal operation');
        }

	}
    
    
     /**
     * 列表
     * @route /admin/shake/score
     * @access  admin_access
     * @param int $page     当前页数
     * @param int $size     每页显示数量
     * @param str $shake_id 搜索关键词
     * @return String
     */
    public static function score($request) {
        $shake_id = $request->get('shake_id');
        if (empty($shake_id)){
            return new RedirectResponse($request->getUriForPath('/admin/shake/search'),'2','请选择活动轮次');
        }
        
        $data = array('data'=>db_select("shake_score","s")
                        ->fields("s")
                        ->extend('Pager')->page(1)->size(10)
                        ->condition("shake_id",$shake_id)
                        ->condition("status",1)
                        ->orderBy("score","DESC")
                        ->execute()
                        ->fetchAll()
                    );
        $res = array(
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            'list'  => $data,
        );

        return new Response(theme()->render('shake-top.html',$res));  
    }
    
}