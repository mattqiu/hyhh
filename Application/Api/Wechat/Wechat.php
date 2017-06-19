<?php

/**
 * @ Api file Wechat.php
 */
namespace Api\Wechat;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Pyramid\Component\WeChat\WeChat as BaseWechat;
use Pyramid\Component\WeChat\Request as WeChatRequest;
use Entity;
use Api;

class Wechat {
    /**
     * 微信回调入口api【请忽略】
     * @route /api/wechat
     * @access
     */
    public static function api($request) {
        //打印微信返回
        $w_post = file_get_contents('php://input');
        logger()->debug("Weixin Post xml data: ".var_export($w_post,true));
        /** end 微信请求数据**/
        
        $wechat = new BaseWechat(variable()->get('wxconfig'));
        Api\Wechat\WechatEvent::registerEvent($wechat);
        $wechatRequest = WeChatRequest::createFromGlobals();
        $response = $wechat->handle($wechatRequest);
        $response->send();
        exit;
    }
    
    /**
     * 微信关注页面
     * @route /wechat/unsubscribe
     * @access
     * @return array['signPackage']
     */
    public static function unsubscribe($request) {
        /*
        $res = array(
            'signPackage'   =>  Mobile\Tool\Tool::getSignPackage(), //公众号签名包
        );
        */
        return new Response(theme()->render('unsubscribe.html',array()));
    }
    
    /**
     * 微信网页授权
     * @route /wechat/oauth2
     * @access
     */
    public static function oauth2($request) {
        $result = Api\Wechat\WechatOauth::oauth2($request);
        
        return new Response($result);
    }
    
    /**
     * 测试
     * @route /wechat/test
     * @access
     * @return array['signPackage']
     */
    public static function test($request) {
        global $wx_authen;
        /*
        $res = array(
            'signPackage'   =>  Mobile\Tool\Tool::getSignPackage(), //公众号签名包
        );
        */
        $res['wx_authen'] = $wx_authen;
        return new Response(theme()->render('weihu.html',$res));
    }
    
    /**
     * 测试
     * @route /wechat/test/post
     * @access
     * @return array['signPackage']
     */
    public static function test_post($request) {
        $post_data = $request->post->getParameters();
        logger()->debug("post data:".var_export($post_data,true));
        return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
    }
    
}
