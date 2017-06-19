<?php

/**
 * @ Api file WechatOauth.php
 */
namespace Api\Wechat;

use Pyramid\Component\WeChat\WeChat as BaseWechat;
use Entity;

class WechatOauth {

    //验证oauth2
    public static function oauth2($request) {
        //if has wecaht return code 
        $code = $request->get('code');
        if ($code) {
            $wechat = new BaseWechat(variable()->get('wxconfig'));
            $result = $wechat->getWebToken($code);
            if ($result && !empty($result['openid'])) {
                $result['expires_time'] = time() + $result['expires_in'] - 200;
                $wxuser = Entity\Wxuser\Wxuser::loadByOpenid($result['openid']);
                if (empty($wxuser) || $wxuser->subscribe != 1) {
                    //未关注用户跳到关注页面
                    header("Location: /wechat/unsubscribe");
                }
                $result['wid'] = $wxuser->wid;
                session()->set('wx_authentication',$result);//设置session
                $state = $request->get('state');
                logger()->debug("Go to referer state:".$state);
                header("Location: ".$state);
            }
            exit;
        }
        else {
            //跳转获取code页面
            $wechat = new BaseWechat(variable()->get('wxconfig'));
            $header_url = $wechat->getWebCodeUrl(array(
                    'redirect_uri'  => urlencode("http://" . $request->getHttpHost() . "/wechat/oauth2"),
                    'scope'         => 'snsapi_base',
                    'state'         => $request->get('state',1),
            ));
            
            header("Location: ".$header_url);
        }
    }
}