<?php

/**
 * @ Api file WechatEvent.php
 */
namespace Api\Wechat;

use Pyramid\Component\WeChat\WeChat as BaseWechat;
use Entity;

class WechatEvent {
    
    //注册回调方法
    public static function registerEvent($wechat) {
        $methods = get_class_methods(new Static);
        foreach($methods as $method) {
            if (strpos($method,'on') !== false) {
                $wechat->on(substr($method,2),'\Api\Wechat\WechatEvent::'.$method);
            }
        }
    }
    
    //拿到上报地理位置时
    public static function onReportLocation($request) {
        //仅对第一地理位置做记录
        $openid = $request->getParameter('FromUserName');
        $user = db_query("select * from {wxuser} where openid=:openid", array(':openid'=>$openid))->fetchObject();
        logger()->error("user lat: ". $user->lat . '===' . $user->lat);
        if ($user && $user->lat == 0 && $request->getParameter('Latitude') != 0) {
            db_update("wxuser")
                ->fields(array(
                    'lng'   => $request->getParameter('Longitude'),
                    'lat'   => $request->getParameter('Latitude'),
                    'zoom'  => $request->getParameter('Precision'),
                ))
                ->condition("openid",$openid)
                ->execute();
        }
        /*
        //先转换为腾讯坐标
        $changexyurl = "http://apis.map.qq.com/ws/coord/v1/translate?locations=%s&type=1&key=%s";
        $request = array(
            'location' => $array['lat'].",".$array['lng'],
            'key'      => config()->get('tengxun_key')
        );
        $xy = file_get_contents(vsprintf($changexyurl,$request));
        $xy = json_decode($xy,true);
        if ($xy['status'] == 0) {
            $array['lng'] = $xy['locations'][0]['lng'];
            $array['lat'] = $xy['locations'][0]['lat'];
        }
        */
    }
    
    //取消关注时
    public static function onUnsubscribe($request) {
        db_update("wxuser")
            ->fields(array('subscribe'=>2))
            ->condition("openid",$request->getParameter('FromUserName'))
            ->execute();
    }

    //关注时
    public static function onSubscribe($request) {
        $openid = $request->getParameter('FromUserName');
        $u = db_query("select * from {wxuser} where openid=:openid", array(':openid'=>$request->getParameter('FromUserName')))->fetchObject();
        //没有则新增
        if (!$u) {
            //通过接口拿个人信息
            $wechat = new BaseWechat(variable()->get('wxconfig'));
            $user   = $wechat->getUserInfo($request->getParameter('FromUserName'));
            
            db_insert('wxuser')
                ->fields(array(
                    'openid'         => $request->getParameter('FromUserName'),
                    'subscribe'      => 1,
                    'username'       => isset($user['nickname']) ? $user['nickname'] : $request->getParameter('FromUserName'),
                    'nickname'       => isset($user['nickname']) ? $user['nickname'] : $request->getParameter('FromUserName'),
                    'sex'            => isset($user['sex']) ?  $user['sex'] : '',
                    'province'       => isset($user['province']) ?  $user['province'] : '',
                    'city'           => isset($user['city']) ?  $user['city'] : '',
                    'headimgurl'     => isset($user['headimgurl']) ?  $user['headimgurl'] : '',
                    'subscribe_time' => time(),
                    'updated'        => time(),
                ))
                ->execute();
        }
        elseif ($u && $u->username==$openid) {
            //没更新个人信息
            $wechat = new BaseWechat(variable()->get('wxconfig'));
            if ($user = $wechat->getUserInfo($openid)) {
                $wxuser = array(
                    'wid'            => $u->wid,
                    'subscribe'      => 1,
                    'username'       => isset($user['nickname']) ? $user['nickname'] : $openid,
                    'nickname'       => isset($user['nickname']) ? $user['nickname'] : $openid,
                    'sex'            => isset($user['sex']) ?  $user['sex'] : '',
                    'province'       => isset($user['province']) ?  $user['province'] : '',
                    'city'           => isset($user['city']) ?  $user['city'] : '',
                    'headimgurl'     => isset($user['headimgurl']) ?  $user['headimgurl'] : '',
                    'subscribe_time' => time(),
                    'updated'        => time(),
                );
                //写入数据库
                Entity\Wxuser\Wxuser::update(entity_request($wxuser));
            }

        }
        //有 就更新为关注状态
        elseif ($u->subscribe != 1) {
            $wechat = new BaseWechat(variable()->get('wxconfig'));
            $user   = $wechat->getUserInfo($request->getParameter('FromUserName'));
            db_update('wxuser')
                ->fields(array(
                    'subscribe'      => 1,
                    'headimgurl'     => isset($user['headimgurl']) ?  $user['headimgurl'] : '',
                    'subscribe_time' => time(),
                    'updated'        => time(),
                ))
                ->condition('wid', $u->wid)
                ->execute();
        }
        
    }
    
    //收到输入关键字时
    public static function onText($request) {
        //回复
        $output = array(
            "touser"    => $request->getParameter('FromUserName'),
            "msgtype"   => "text",
            "text"      => array(
                'content'   => "你的消息已收到...休息太多\n无法一一回复，我们会看的。".$request->getParameter('Content'),
            ),
        );
        $content = $request->getParameter('Content');
        if ($content == '贪吃蛇') {
            $sendnews = array(
                "touser"    => $request->getParameter('FromUserName'),
                "msgtype"   => "news",
                "news"      => array(
                    'articles'   => array(
                        '0' => array(
                            "title"         => "小游戏试玩贪吃蛇送红包",
                            "description"   => "贪吃蛇再现江湖，无论你是怀旧70后还是奋进80后，亦或是个性90后，只要你敢接下这封战书，下一个称霸贪吃蛇的可能就是你！ ",
                            "url"           => "http://urms.cn/wechat/game/snake",
                            "picurl"        => "http://urms.cn/theme/wechat/assets/images/snake4.jpg",
                        ),
                    ),
                ),
            );
            $wechat = new BaseWechat(variable()->get('wxconfig'));
            $wechat->sendCustomMessage($sendnews);
        }
        else {
            $wechat = new BaseWechat(variable()->get('wxconfig'));
            $wechat->sendCustomMessage($output);
        }
    }
    
}