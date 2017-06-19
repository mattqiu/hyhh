<?php

/**
 * @file
 *
 * wechat.php
 */

//include framework
require_once dirname(__DIR__) . '/Pyramid/Pyramid.php';

//include config
require_once __DIR__ . '/config.php';


//设置后台模板目录
define('THEMEFOLDER', __DIR__ . '/theme/wechat');
$engines['default']['loaderArgs'] = array(THEMEFOLDER);


//extends Kernel
class AppKernel extends Kernel{
    
    public function __construct() {
    
    }
    
    public function afterRoute($request) {
        $matchroute = $request->route->get('matchroute');
        //logger()->debug("Request Route uri is: ".$_SERVER['REQUEST_URI']);
        switch($matchroute) {
            case 'wechat/unsubscribe':
            case 'wechat/oauth2':
            
            case 'wechat/shake/index':
            case 'wechat/shake/start':
            case 'wechat/shake/over':
            break;
            default:
                //查找session是否存在  /session()->delete('wx_authentication');exit;
                global $wx_authen;
                $wx_authen = session()->get('wx_authentication');
                if ($wx_authen && isset($wx_authen['expires_time']) && time() < $wx_authen['expires_time']) {
                    //已经授权过并在有效期内 
                    $wxuser = Entity\Wxuser\Wxuser::loadByOpenid($wx_authen['openid']);
                    if (!$wxuser || $wxuser->subscribe!=1) {    //是否是关注会员
                        header("Location: /wechat/unsubscribe");
                        exit;
                    }
                }
                else {
                    $request->get->setParameter('state',urlencode($_SERVER['REQUEST_URI']));
                    Api\Wechat\Wechat::oauth2($request);
                }

            break;
        }
    }

}

$kernel   = new AppKernel();
$kernel->registerProject('Entity', __DIR__ . '/Application');
$kernel->registerProject('Api', __DIR__ . '/Application');

$request  = Pyramid\Component\HttpFoundation\Request::createFromGlobals();
$response = $kernel->handle($request);
$response->format($request->getParameter('format'), $request->getParameter('callback'));
$response->send();
