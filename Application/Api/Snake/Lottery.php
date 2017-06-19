<?php 

/**
 *@ file Lottery.php  用户中奖
 */

namespace Api\Snake;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Mobile\WeChat as BaseWechat;
use Entity;
use Api;

class Lottery{
    
    /**
     * 领取抽奖通知【抽奖采用预先抽奖模式】
     * @access
     * @param   id      奖池ID
     * @param   wid     微信用户
     * @return json
     */
    public static function myLottery($request) {
        global $wx_authen;
        $id  = $request->get('id');
        $wid = $wx_authen['wid'];
        $lottery = Entity\Lottery\Lottery::load(entity_request(array('id'=>$id)));
        if ($lottery && $lottery->wid==$wid) {
            //更新状态
            if ($lottery->status==1) {               
                db_update("lottery")->fields(array("status"=>2,"updated"=>time()))->condition("id",$id)->execute();
            } else {
                //未中奖的 不更新status
                db_update("lottery")->fields(array("updated"=>time()))->condition("id",$id)->execute();
            }
            
            //更新后的lottery
            $res['lottery'] = db_select("lottery","l")->fields("l")->condition("id",$id)->execute()->fetch();
            
            //用户当天游戏记录
            $res['snake']   = Api\Snake\Snake::getSnake($wid);
            
            //签名
            $res['signPackage'] = Api\Tool\Tool::getSignPackage();
            
            //用户信息
            $res['userinfo']    = Entity\Wxuser\Wxuser::load(entity_request(array('wid'=>$wid)));
            
            //调发送红包            
            Api\Snake\Hongbao::sendredpack(entity_request(array('id'=>$lottery->id,'openid'=>$lottery->openid)));
                        
            return new Response(theme()->render('snake-lottery.html',$res));
        } 
        else {
            $res['snake'] = Mobile\Snake\Snake::getSnake($wid);
            $res['userinfo'] = Entity\Wxuser\Wxuser::load(entity_request(array('wid'=>$wid)));
            return new Response(theme()->render('snake-lottery.html',$res));
        }
    }
    
    /**
     * 最后的抽奖记录
     * @route
     * @access
     * @param play_date
     * @param wid
     * @param score
     * @return object
     */
    public static function lastLottery($params) {
        if (isset($params['wid']) && !empty($params['score']) && isset($params['play_date'])) {
            $lottery = db_select("lottery","l")
                        ->fields("l")
                        ->condition("play_date",$params['play_date'])
                        ->condition("wid",$params['wid'])
                        ->orderBy("id","DESC")
                        ->execute()
                        ->fetch();
            if ($lottery->score == $params['score'] && $lottery->status != 2) {
                return $lottery;
            } else {
                return array();
            }
        }
        else {
            return array();
        }
    }


    /**
     * 根据用户得分预派送奖金
     * @access
     * @param   wid     微信用户
     * @param   score   游戏得分
     * @param   openid  微信Openid
     
     *
     * @return array    [level,amount]
     */
    public static function getAmount($params) {
        global $wx_authen;
        $wxuser = Entity\Wxuser\Wxuser::load(entity_request(array('wid'=>$wx_authen['wid'])));
        $score = $params['score'];
        $params['username']   = $wxuser->username;
        $params['headimgurl'] = $wxuser->headimgurl;
        if ($score >= 1000 && $score < 3000) {
            return self::lottery_amount($params,array(1,2));
        }
        elseif ($score >= 3000 && $score < 6000) {
            return self::lottery_amount($params,array(3));
        }
        elseif ($score >= 6000 && $score < 8000) {
            return self::lottery_amount($params,array(4));
        }
        elseif ($score >= 8000) {
            return self::lottery_amount($params,array(5));
        }
        else {
            //得分不够抽奖
            return (object)array('level'=>0,'amount' => '0.00');
        }
    
    }
    
    /**
     * 计算当前奖金的命中概率
     * @route
     * @return int 
     */
    public static function getProb($level) {
        $lottery_configs = config()->get('snake_lottery');
        $totals = $lottery_configs[$level]['total']; //总份数
                
        //已派发份数
        $winCount = db_query("select count(*) as winCount from {lottery} where level={$level} and status<>0")->fetch();
        
        //当前已派发比例
        $current_present  = number_format($winCount->winCount/$totals,2)*100;
        
        
        //0:00-8:30不能发红包
        $t = (int) date('Hi');
        if ($t < 810) {
            return 0;
        }
        
        if ($current_present < 20) {
            return 8;
        } elseif ($current_present >=20 && $current_present<40) {
            return 6;
        } elseif ($current_present >=40 && $current_present<60) {
            return 6;
        } elseif ($current_present >=60 && $current_present<80) {
            return 5;
        } elseif ($current_present >=80 && $current_present<100) {
            return 5;
        } else {
            //没有奖金可派发
            return 0;
        }
        
    }
    
    //抽奖并写入数据表
    protected static function lottery_amount($params,$levels=array()) {
        $level  = $levels[array_rand($levels)];
        $amount = config()->get('snake_lottery')[$level]['money'];
        $prob  = self::getProb($level);
        $array = array(
            'wid'       => $params['wid'],
            'play_date' => date('Ymd'),
            'level'     => $level,
            'openid'    => $params['openid'],
            'score'     => $params['score'],
            'username'  => $params['username'],
            'headimgurl'=> $params['headimgurl'],
        );
        if (rand(1,100) <= $prob) {
            //中奖了
            $array['status'] = 1;
            $array['amount'] = $amount;
        } else {
            //未中奖
            $array['status'] = 0;
            $array['amount'] = '0.00';
        } 
        
        return self::save($array);
    }
    
    //写入数据
    protected static function save($array) {
        if (!empty($array)) {
            return Entity\Lottery\Lottery::insert(entity_request($array));
        } else {
            return (object)array();
        }
    }
      
}