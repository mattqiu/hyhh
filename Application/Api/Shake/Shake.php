<?php 

/**
 *@ file Shake.php
 */

namespace Api\Shake;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;
use Api;

class Shake{
    
    /**
     * 摇一摇首页
     * @route /wechat/shake
     * @access 
     * return String
     */
    public static function index($request) {
        global $wx_authen;
        $res['wx_authen'] = $wx_authen;
        
        return new Response(theme()->render('shake.html',$res));
    }
    
    /**
     * 提交摇一摇得分
     * @route /wechat/shake/score
     * @access
     * @param   score   本次得分
     * @return  json    ['data'=>array('start','shake_id','score')]
     */
    public static function score($request) {
        global $wx_authen;
         
        $score  = $request->get('score');
        $openid = $wx_authen['openid'];
        
        logger()->debug("Post Data: ".$openid." => ".$score);
        if (!empty($openid)) {
            $user = Entity\Wxuser\Wxuser::loadByOpenid($openid);
            $wid  = $user->wid;
        } else {
            return new Response(array('start'=>false,'shake_id'=>0,'score'=>0,'pre_score'=>0,'post_score'=>0));
        }
        
        //关注的用户才可以
        if ($user->subscribe != 1) {
            return new Response(array('start'=>false,'shake_id'=>0,'score'=>0,'pre_score'=>0,'post_score'=>0));
        }
        
        //查找当前进行中的活动
        $current_shake = null;
        $shakes = db_select("shake", 's')
                    ->fields("s")
                    ->condition("status",2)
                    ->condition("opentime",0,"<>")
                    ->orderBy("id","DESC")
                    ->execute()
                    ->fetchAll();
        
        foreach ($shakes as $shake) {
            if (time() > $shake->opentime && time() < ($shake->opentime+$shake->timeout)) {
                $current_shake = $shake;
                break;
            }
        }
        //判断活动是否存在
        if (empty($current_shake) || time() > ($current_shake->opentime+$current_shake->timeout)) {
            return new Response(array('start'=>false,'shake_id'=>0,'score'=>0,'pre_score'=>0,'post_score'=>0));
        }

        //查找用户当前得分
        $shake_score = db_select("shake_score", 's')
                        ->fields("s")
                        ->condition("shake_id",$current_shake->id)
                        ->condition("wid",$wid)
                        ->execute()
                        ->fetch();

                        
        if ($score > 1000) {
            $score = substr($score, 0, 2);
        }

        //分数限制
        if ($shake_score && $score > 1000) {
            return new Response(array(
                'start'    => true,
                'shake_id' => $current_shake->id,
                'score'    => $shake_score->score,
                'pre_score'=> $shake_score->score,
                'post_score' => $score,
            ));
        } elseif ($score > 1000) {
            return new Response(array(
                'start'    => true,
                'shake_id' => $current_shake->id,
                'score'    => 0,
                'pre_score'=> 0,
                'post_score' => $score,
            ));
        }
        
        if ($shake_score) {
            //已有记录,累加分数
            db_update('shake_score')
                ->fields(array(
                    'score'   => $score+$shake_score->score, //得分
                    'updated' => time(),                   //最后提交
                ))
                ->condition("id",$shake_score->id)
                ->execute();
                
            return new Response(array(
                'start'    => true,
                'shake_id' => $current_shake->id,
                'pre_score'=> $shake_score->score,
                'score'    => $score+$shake_score->score,
                'post_score' => $score,
            ));
        } else {
            //没有记录，新写入
            db_insert("shake_score")
                    ->fields(array(
                        'shake_id'  => $current_shake->id,
                        'wid'       => $user->wid,
                        'username'  => $user->username,
                        'headimgurl' => $user->headimgurl,
                        'score'     => $score,
                        'status'    => 1,
                        'created'   => time(),
                        'updated'   => time(),
                    ))
                    ->execute();
            
            return new Response(array(
                'start'    => true,
                'shake_id' => $current_shake->id,
                'score'    => $score,
                'pre_score'=> 0,
                'post_score' => $score,
            ));
        }
        
        
        
    }
    
    /**
     * 大屏幕活动开始页面
     * @route /wechat/shake/start
     * @access 
     * return String
     */
    public static function start($request) {
    
        $timeout  = 30;
        $start    = $request->get('start',0);
        $shake_id = $request->get('shake_id',0);
        if ($start) {
            //进行中
            $opening = db_select('shake', 's')
                        ->fields("s")
                        ->condition("status",2)
                        ->orderBy("id","DESC")
                        ->forUpdate(true)
                        ->execute()
                        ->fetchObject();
            //未启动
            $waitopen = db_select('shake', 's')
                        ->fields("s")
                        ->condition("status", 1)
                        ->condition("opentime",0)
                        ->orderBy("id","DESC")
                        ->execute()
                        ->fetchObject();
            if ($opening) {
                $res['shake'] = $opening;
            } elseif ($waitopen) {
                db_update("shake")
                        ->fields(array('opentime'=>time()+4,'status'=>2))
                        ->condition("id",$waitopen->id)
                        ->execute();
                $res['shake'] = $waitopen;
            } else {
                //生成新的游戏
                $shake = db_insert("shake")
                            ->fields(array(
                                'title'    => '疯狂摇大奖：'.date('n/j/Y H:i'),
                                'summary'  => '开始游戏',
                                'opentime' => time()+4,
                                'timeout'  => $timeout,
                                'status'   => 2,
                                'created'  => time(),
                                'updated'  => time(),
                            ))
                            ->execute();
                            
                $res['shake']   = Entity\Shake\Shake::load(entity_request(array('id'=>$shake)));
                $res['timeout'] = $timeout;
            }
        } 
        elseif ($shake_id) {
            $res['shake']   = Entity\Shake\Shake::load(entity_request(array('id'=>$shake_id)));
            $res['timeout'] = $timeout;
        }
        
        if ($request->getParameter('format') == 'json') {
            return new Response($res);
        } else {
            return new Response(theme()->render('shake_index_5.html',$res));
        }
    }
    
    /**
     * 结束游戏
     * @route /wechat/shake/over
     * @access 
     * return String
     */
    public static function over($request) {
        $shake_id = $request->getParameter('shake_id');
        $res['shake'] = Entity\Shake\Shake::load(entity_request(array('id'=>$shake_id)));
        if ($shake_id && $res['shake']) {
            if ($res['shake']->status == 2) {
                db_update("shake")
                    ->fields(array('status'=>3))
                    ->condition("id",$shake_id)
                    ->execute();
            }
        }
        
        //当前排名数据
        $res['shake_scores'] = db_select("shake_score","s")
                                    ->fields("s")
                                    ->extend('Pager')->page(1)->size(5)
                                    ->condition("shake_id",$shake_id)
                                    ->condition("status",1)
                                    ->orderBy("score","DESC")
                                    ->execute()
                                    ->fetchAll();

        return new Response(theme()->render('shake_index_6.html',$res));
    }
}