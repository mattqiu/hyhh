<?php 

/**
 *@ file Tool.php
 */

namespace Api\Tool;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Pyramid\Component\WeChat\WeChat as BaseWechat;
use Entity;

class Tool{
    /**
     *  获取jsapi 签名包
     * 
     *
     */
    public static function getSignPackage(){
        $wxconfig = variable()->get('wxconfig');
        $jsapiTicket = self::getJsapiTicket();
        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";
        $url = "$protocol$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        $timestamp = time();
        $nonceStr = random();
        $string = "jsapi_ticket=$jsapiTicket&noncestr=$nonceStr&timestamp=$timestamp&url=$url";
        $signature = sha1($string);
        $signPackage = array(
          "appId"     => $wxconfig['appid'],
          "nonceStr"  => $nonceStr,
          "timestamp" => $timestamp,
          "url"       => $url,
          "signature" => $signature,
          "rawString" => $string
        );
        //logger()->debug("Get Jsapi signpackage is:".var_export($signPackage,true));
        return $signPackage; 
    }
    
    /**
     * 获取jsapi Ticket
     *
     */
    public static function getJsapiTicket(){
        $url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token=%s";
        //从数据库读取
        $tickets = variable()->get('jsapi_ticket');
        if (empty($tickets) || time()>$tickets['expire_time']) {
            $baseWechat = new BaseWechat(variable()->get('wxconfig'));
            $token = $baseWechat->getAccessToken();
            $body = file_get_contents(sprintf($url, $token));
            $json = json_decode($body, true);
            
            $tickets = array(
                'jsapi_ticket' => $json['ticket'],
                'expire_time'  => time() + 7000,
            );
            variable()->set('jsapi_ticket',$tickets);     
        }
        return $tickets['jsapi_ticket'];
    }
    
    

}