<?php

namespace Admin\Snake;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;
use Admin;

class Snake {    
    /**
     * 列表
     * @route /admin/snake/search
     * @access  admin_access
     * @param int $page     当前页数
     * @param int $size     每页显示数量
     * @return String
     */
    public static function search($request) {
        $res = array(
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            'list'  => Entity\Snake\Snake::search($request),
        );
        foreach($res['list']['data'] as $k => $data) {
            $res['list']['data'][$k]->userinfo = Entity\Wxuser\Wxuser::load(entity_request(array("wid"=>$data->wid)));
        }

        return new Response(theme()->render('snake-search.html',$res));  
    }
    
    /**
     * 排行榜列表
     * @route /admin/snake/top
     * @access  admin_access
     *
     * @return String
     */
    public static function top($request) {
    
        //排名前十的数据
        $data = db_select("snake_top","t")
                    ->fields("t",array("wid","score","updated"))
                    ->range(0,20)
                    ->orderBy("score","DESC")
                    ->execute()
                    ->fetchAll();
        
        foreach($data as $i=>$dlist) {
            $tops[] = array(
                'wid'   => $dlist->wid,
                'score' => $dlist->score,
                'updated' => $dlist->updated,
                'userinfo' => Entity\Wxuser\Wxuser::load(entity_request(array("wid"=>$dlist->wid))),
            );
            $scores[] = $dlist->score;
            $updateds[] = $dlist->updated;
        }
        //排序 时间正序 得分倒序
        array_multisort( $scores, SORT_DESC, $updateds, SORT_ASC, $tops);

        $res = array(
            'tops'  => $tops,
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );

        return new Response(theme()->render('snake-top.html',$res));  
    }
    
    /**
     * 抽奖列表
     * @route /admin/snake/lottery
     * @access  admin_access
     * @param int $page     当前页数
     * @param int $size     每页显示数量
     * @return String
     */
    public static function lottery_search($request) {
        $conditions = array(
            'status' => array('value' => $request->get('status',null)),
        );
        //conditions
        $request->setParameter('conditions',$conditions);
        $res = array(
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            'list'  => Entity\Lottery\Lottery::search($request),
            'status'  => $request->get('status',null),
        );
        
        return new Response(theme()->render('snake-lottery.html',$res));
    }
    
     /**
     * 红包发放
     * @route /admin/snake/hongbao
     * @access  admin_access
     * @param int $page     当前页数
     * @param int $size     每页显示数量
     * @return String
     */
    public static function hongbao_search($request) {

        $res = array(
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            'list'  => Entity\Hongbao\Hongbao::search($request),
        );
        
        $res['totalAmount'] = db_query("select sum(amount) from {hongbao} where status=1")->fetchField();
        
        return new Response(theme()->render('snake-hongbao.html',$res));
    }
       
}