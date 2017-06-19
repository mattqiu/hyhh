<?php

namespace Api\Snake;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;
use Api;

class Snake {

    /**
     * 贪吃蛇游戏页面入口(渠道统计)
     * @route /wechat/game/snake
     * @access  admin_access
     * @return  array['userinf','signPackage','snake']
     */
    public static function index($request) {
        global $wx_authen;
        $agent = $request->server->getParameter('HTTP_USER_AGENT');
        if (!preg_match('/MicroMessenger/i', $agent)) {
            return new Response(theme()->render('error.html'));
        }
        
        $openid = $wx_authen['openid'];
        if (empty($openid)) {
            return true;
        }
        $res['userinfo']    = Entity\Wxuser\Wxuser::loadByOpenid($wx_authen['openid']); //用户个人信息
        $res['signPackage'] = Api\Tool\Tool::getSignPackage(); //公众号签名包        
        //当天游戏记录
        $res['snake'] = self::getSnake($res['userinfo']->wid);

        return new Response(theme()->render('index.html',$res));
    }
    
     /**
     * 贪吃蛇游戏页面
     * @route /wechat/snake/play
     * @access  admin_access
     * @return array['userinf','signPackage','token']
     */
    public static function play($request) {
        global $wx_authen;
        $agent = $request->server->getParameter('HTTP_USER_AGENT');
        if (!preg_match('/MicroMessenger/i', $agent)) {
            return new Response(theme()->render('error.html'));
        }
        
        $res['userinfo']    = Entity\Wxuser\Wxuser::loadByOpenid($wx_authen['openid']); //用户个人信息
        if (!isset($res['userinfo']->wid)) {
            header("Location: /wechat/game/snake");
        }
        //是否已经达到规定次数
        $snake = Entity\Snake\Snake::loadByWid($res['userinfo']->wid);
        if (!empty($snake) && $snake->play_game != true) {
             header("Location: /wechat/snake/outoftimes");
        }
        
        $res['token']       = self::getSnakeToken($res['userinfo']->wid); //游戏令牌
        $res['signPackage'] = Api\Tool\Tool::getSignPackage(); //公众号签名包
        
        return new Response(theme()->render('snake-play.html',$res));
    }
    
    /**
     * 次数用完
     * @route /wechat/snake/outoftimes
     * @access
     * @return  array['userinfo','lottery','beatUser','snake','signPackage']
     */
    public static function outoftimes($request) {
        global $wx_authen;
        $agent = $request->server->getParameter('HTTP_USER_AGENT');
        if (!preg_match('/MicroMessenger/i', $agent)) {
            return new Response(theme()->render('error.html'));
        }
        
        $userinfo = Entity\Wxuser\Wxuser::loadByOpenid($wx_authen['openid']); //用户个人信息
        $snake    = self::getSnake($userinfo->wid);
        if (isset($snake->last_score)) {//有游戏记录
            $beatUser = self::beatUser($snake->last_score);
        } else {
            $beatUser = 0;
        }
        $score = db_select('snake_top','s')
                    ->fields('s')
                    ->condition('wid', $userinfo->wid)
                    ->execute()
                    ->fetchObject();
        $signPackage = Api\Tool\Tool::getSignPackage();
        return new Response(
                        theme()->render('snake-outoftimes.html', array(
                            'beatUser'      => $beatUser,
                            'score'         => $score,
                            'userinfo'      => $userinfo,
                            'signPackage'   => $signPackage,
                        ))
                    );

    }
    
    /**
     * 提交游戏本次得分
     * @route /wechat/snake/score
     * @access
     * @param   score   本次得分 【必填】
     * @param   token   游戏令牌 【必填】
     * @return  json    [data:ERROR|array('lottery','snake','userinfo','token','beatUser')]
     */
    public static function score($request) {
        global $wx_authen;
        $token  = $request->getParameter('token');
        $score  = $request->getParameter('score');
        $sst = $request->getParameter('sst'); //玩家请求play时的时间戳
        $st = $request->getParameter('st'); //玩家本地的时间戳
        $ip = $request->getIp();
        $wxuser = Entity\Wxuser\Wxuser::loadByOpenid($wx_authen['openid']);
        $wid  = $wxuser->wid;
        
        //记录每次提交数据
        db_insert("snake_score")
            ->fields(array(
                'wid'   => $wid,
                'score' => $score,
                'token' => $token,
                'ip'    => $ip,
                'play_date' => date('Ymd'),
                'created' => time()
            ))
            ->execute();
            
        if ($score > 180000 || empty($wxuser)) {
            logger()->error("Hack 180000 {$ip} " . $wid);
            return new Response('ERROR');
        }
        logger()->debug("Post Score data is: wid=>".$wid." token=>".$token." score=>".$score);
        $snake_date = date('Ymd');  //本次游戏日期，有可能跨日期玩游戏
        if (empty($wid) || empty($token)
            || ($token_created=self::checkSnakeToken($wid,$token)) == false) { //校验token是否有效
            
            return new Response('ERROR');
        }
        //通过sst st来筛选非法请求,score来计算
        if (empty($sst) || time() - $sst < 5) {
            logger()->error("Hack sst {$ip} " . $wid);
            return new Response('ERROR');
        }
        if (abs($token_created - $sst) > 8) {
            logger()->error("HackTokenTime {$ip} " . $wid);
            return new Response('ERROR');
        }
        if ($score > 100000 && (empty($sst) || time() - $sst < 200)) {
            logger()->error("Hack 80000 {$ip} " . $wid);
            return new Response('ERROR');
        }
        if ($score > 20000 && (empty($sst) || time() - $sst < 90)) {
            logger()->error("Hack 20000 {$ip} " . $wid);
            return new Response('ERROR');
        }
        if ($score > 10000 && (empty($sst) || time() - $sst < 70)) {
            logger()->error("Hack 10000 {$ip} " . $wid);
            return new Response('ERROR');
        }
        if ($score > 5000 && (empty($sst) || time() - $sst < 40)) {
            logger()->error("Hack 5000 {$ip} " . $wid);
            return new Response('ERROR');
        }
        if ($score > 1000 && (empty($sst) || time() - $sst < 10)) {
            logger()->error("Hack 1000 {$ip} " . $wid);
            return new Response('ERROR');
        }
        //if (empty($sst) && empty($st)) {
        //    return new Response('ERROR');
        //}
        
        //游戏令牌生成时间跟当前时间比对。解决跨天玩游戏提交
        if (date('Ymd',time()) != date('Ymd',$token_created)) {
            $snake_date = date('Ymd',$token_created);
        }
        
        $snake = Entity\Snake\Snake::loadByWid($wid,$snake_date);

        //关注的用户才可以
        if ($wxuser->subscribe != 1) {
            return new Response('ERROR');
        }
        
        if (empty($snake) || (isset($snake->play_game) && $snake->play_game == true)) {
            if (empty($snake)) {
                //当天没有游戏记录
                $array = array(
                    'wid'           => $wid,
                    'play_date'     => $snake_date,
                    'play_times'    => 1,
                    'present_times' => 0,
                    'score'         => $score,
                    'last_score'    => $score,                  
                );
                Entity\Snake\Snake::insert(entity_request($array));              
            }
            else {
                //更新当天游戏记录
                $array = array(
                    'id'        => $snake->id,
                    'play_times'=> $snake->play_times+1,
                    'score'     => ($score>$snake->score) ? $score : $snake->score,
                    'last_score'=> $score,
                    'updated'   => time(),
                );
                Entity\Snake\Snake::update(entity_request($array));
            }
            
            //更新个人排行榜
            self::updateSnakeTop($wid,$score);
            
            //预抽奖
            $lottery = Api\Snake\Lottery::getAmount(array('wid'=>$wid,'score'=>$score,'openid'=>$wxuser->openid));
            
            //删除游戏令牌
            self::deleteSnakeToken($wid,$token);
            
            //当天游戏情况
            $snake = self::getSnake($wid);
                       
            return new Response(array(
                    'lottery'   => $lottery,
                    'snake'     => $snake,
                    'beatUser'  => self::beatUser($score),
            ));
        }
        
        return new Response('ERROR');
    }
    
    /**
     * 游戏结束
     * @route /wechat/snake/over
     * @access
     * @return  array['userinfo','lottery','beatUser','snake','signPackage']
     */
    public static function over($request) {
        global $wx_authen;
        $agent = $request->server->getParameter('HTTP_USER_AGENT');
        if (!preg_match('/MicroMessenger/i', $agent)) {
            return new Response(theme()->render('error.html'));
        }
        
        $userinfo = Entity\Wxuser\Wxuser::loadByOpenid($wx_authen['openid']); //用户个人信息
        
        $snake    = self::getSnake($userinfo->wid);  //当天游戏最后记录

        //击败用户(百分比*100)
        if (isset($snake->last_score)) {//有游戏记录
            $beatUser = self::beatUser($snake->last_score);
        } else {
            $beatUser = 0;
        }
            
        //抽奖项
        $lottery = Api\Snake\Lottery::lastLottery(array('play_date'=>$snake->play_date,'wid'=>$userinfo->wid,'score'=>$snake->last_score));
       
        //签名
        $signPackage = Api\Tool\Tool::getSignPackage();    
        //logger()->debug("游戏结束准备输出结果");
        
        return new Response(theme()->render('snake-over.html',
                    array(
                        'beatUser'      => $beatUser,
                        'snake'         => $snake,
                        'lottery'       => $lottery,
                        'signPackage'   => $signPackage,
                        'userinfo'      => $userinfo,
                    )
                ));

    }

    /**
     * 贪吃蛇排行榜
     * @route /wechat/snake/top
     * @access  admin_access
     * @return String
     */
    public static function top($request) {
        global $wx_authen;
        $res['userinfo'] = Entity\Wxuser\Wxuser::loadByOpenid($wx_authen['openid']); //用户个人信息
        if (empty($res['userinfo'])) {//连续两次请求bug
            return true;
        }
        //排名前十的数据
        $data = db_select("snake_top","t")
                    ->fields("t",array("wid","score","updated"))
                    ->range(0,50)
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
        array_multisort($scores, SORT_DESC, $updateds, SORT_ASC, $tops);
        
        //处理用户姓名带*
        foreach($tops as $t=>$top) {
            $tops[$t]['userinfo']->nickname = self::changeNickName($top['userinfo']->nickname);
        }
        
        //前十排名数据
        $res['tops'] = $tops;
        
        //计算用户当前排名
        $topScore = db_select("snake_top","t")
                        ->fields("t",array("score"))
                        //->condition("wid",3)
                        ->condition("wid",$res['userinfo']->wid)
                        ->execute()
                        ->fetchField();
        
        if ($topScore) {
            $total = db_query("select count(*) as total from {snake_top} where score>{$topScore}")->fetch();
            $res['currentRank'] = $total->total+1;
        }
        //签名
        $res['signPackage'] = Api\Tool\Tool::getSignPackage();
        
        //最高分
        $res['topScore'] = $topScore;
        
        return new Response(theme()->render('snake-top.html',$res));
    }
    
    //将用户名转成带*
    public static function changeNickName($name) {
        //替换苹果emoji
        $name = preg_replace(
                '/[\x00-\x08\x10\x0B\x0C\x0E-\x19\x7F]' .
                '|[\x00-\x7F][\x80-\xBF]+' .
                '|([\xC0\xC1]|[\xF0-\xFF])[\x80-\xBF]*' .
                '|[\xC2-\xDF]((?![\x80-\xBF])|[\x80-\xBF]{2,})' .
                '|[\xE0-\xEF](([\x80-\xBF](?![\x80-\xBF]))|(?![\x80-\xBF]{2})|[\x80-\xBF]{3,})/S', '', $name);
        
        //替换安卓emoji 
        $name = preg_replace(
                '/\xE0[\x80-\x9F][\x80-\xBF]' .
                '|\xED[\xA0-\xBF][\x80-\xBF]/S', '', $name);
        
        //字符长度
        $length = mb_strlen($name,'utf8');
        
        if ($length == 1 || $length == 2) {
            //一个或两个字符长度
            $name = mb_substr($name,0,1,'UTF8')."**";
        } elseif ($length >= 3) {
            //三个字符长度以上
            $first = mb_substr($name,0,1,'UTF8');
            $last  = mb_substr($name,-1,1,'UTF8');
            $name  = $first . "**" . $last;
        } else {
            
        }
        
        return $name;
    }
    
    /**
     * 领取抽奖通知【抽奖采用预先抽奖模式】
     * @route   /wechat/lottery
     * @access
     * @param   id      奖池ID
     * @return json
     */
    public static function myLottery($request) {
    
        return Api\Snake\Lottery::myLottery($request);
    }   
    
    /**
     * 微信分享到朋友圈记录
     * @route /wechat/snake/share
     * @access
     * @param  openid      微信用户OPENID
     * 
     * @return json [data:SUCCESS]
     */
    public static function wechatShare($request) {
        global $wx_authen;
        $openid = $wx_authen['openid'];
        if ($openid) {
            $wxuser = Entity\Wxuser\Wxuser::loadByOpenid($openid);
            $snake  = Entity\Snake\Snake::loadByWid($wxuser->wid);
            if (empty($snake)) {
                $array = array(
                    'wid'       => $wxuser->wid,
                    'play_date' => date('Ymd'),
                    'is_share'  => 1,
                    'present_times' => config()->get('snakePresentTimes'),
                );
                Entity\Snake\Snake::insert(entity_request($array));
                logger()->debug("用户分享成功：".var_export($array,true));
            }
            else {
                $array = array(
                    'id'        => $snake->id,
                    'is_share'  => 1,
                    'present_times' => config()->get('snakePresentTimes'),
                );
                Entity\Snake\Snake::update(entity_request($array));
                logger()->debug("用户分享成功：".var_export($array,true)); 
            }
                   
        }
        
        return new Response('SUCCESS');
    }
    
    
    //计算当前击败多少用户
    public static function beatUser($score) {
        $allCount = db_query("select count(*) as allCount from {snake_top}")->fetch();
        $minCount = db_query("select count(*) as minCount from {snake_top} where score<{$score}")->fetch();
        
        return number_format($minCount->minCount/$allCount->allCount,2)*100;
    }
    
    //更新最新排行榜
    public static function updateSnakeTop($wid,$score) {
        $top = db_select("snake_top","t")
                    ->fields("t")
                    ->condition("t.wid",$wid)
                    ->execute()
                    ->fetch();
        if (empty($top)) {
            db_insert("snake_top")
                ->fields(array(
                    'wid'   => $wid,
                    'score' => $score,
                    'created' => time(),
                    'updated' => time(),
                ))
                ->execute();
        } elseif ($score>$top->score) {
            //大于之前的最高分
            db_update("snake_top")
                ->fields(array("score"=>$score,"updated"=>time()))
                ->condition("id",$top->id)
                ->execute(); 
        }
    }
    
    
    /**
     * 校验游戏令牌
     * @route
     * @param wid
     * @param token
     * @return boolean
     */
    public static function checkSnakeToken($wid,$token) {
        if (!empty($wid) && !empty($token)) {
            $data = db_select("snake_token")
                    ->fields("snake_token")
                    ->condition("wid",$wid)
                    ->condition("token",$token)
                    ->execute()
                    ->fetch();
            //无效状态： is_deleted=1 或者 token 超过1小时
            return (empty($data) || ((time()-$data->created)>3600) || $data->is_deleted==1)? false : $data->created;
        }
        return false;
    }
    
    /**
     * 获取游戏令牌
     * @route
     * @access 
     * @param wid       微信用户ID
     * return String
     */
    public static function getSnakeToken($wid) {
        if ($wid) {
            $array = array(
                'wid'       => $wid,
                'token'     => uniquesn(),
                'created'   => time(), 
            );
            db_insert("snake_token")
                ->fields($array)
                ->execute();
            return $array['token'];
        }       
    }
    
    /**
     * 删除游戏令牌
     * @route
     * @param wid
     * @param token
     * @return boolean
     */
    public static function deleteSnakeToken($wid,$token) {
        if (!empty($wid) && !empty($token)) {
            db_update("snake_token")
                    ->fields(array('is_deleted'=>1))
                    ->condition("wid",$wid)
                    ->condition("token",$token)
                    ->execute();
        }        
        return true;
    }
    
    //获取用户当天玩游戏情况
    public static function getSnake($wid) {
        $snake = Entity\Snake\Snake::loadByWid($wid);
        if (empty($snake)) {
            return (object) array('play_game'=>true,'residue_times'=>config()->get('snakePlayMaxTimes'));
        }
        else {
            return $snake;
        }
    }
}