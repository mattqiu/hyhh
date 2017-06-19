<?php

//载入框架
require_once dirname(__DIR__) . '/Pyramid/Pyramid.php';

//载入配置
require_once __DIR__ . '/config.php';

//设置后台模板目录
define('THEMEFOLDER', __DIR__ . '/theme/admin');
$engines['default']['loaderArgs'] = array(THEMEFOLDER);

//站点根目录
define('ADMINROOT', __DIR__);

//Kernel
class AdminKernel extends Kernel {

    public function __construct() {
    
    }

    public function afterRoute($request) {
        $matchroute = $request->route->get('matchroute');
        switch ($matchroute) {
            case 'admin/user/login':
            case 'admin/upload':
            case 'admin/user/logout':
            case 'api/wechat':
            break;
            default:
                if (!session()->get('user')) {
                    header("Location: /admin/user/login");
                    exit;
                }
            break;
        }
    }
    
    function themePager($pager, $pageurl = '') {
        static $li = '<li><a href="%spage=%s">%s</a></li>';
        static $lt = '<li><span>%s</span></li>';
        static $hasjs;
        $unique   = uniqid();
        $pageurl .= strpos($pageurl,'?') ? '&' : '?';
        $return  = '<ul class="pagination">';
        $return .= sprintf($lt, $pager['page'].'/<strong>'.$pager['pages'].'</strong> 页');
        $return .= sprintf($lt, "共 <strong>{$pager['total']}</strong> 条");
        if ($pager['page'] > 1) {
            $return .= sprintf($li, $pageurl, $pager['page']-1, '上一页');
        }
        if ($pager['page'] < $pager['pages']) {
            $return .= sprintf($li, $pageurl, $pager['page']+1, '下一页');
        }
        $return .= "<li><a href='javascript:showjumpdiv(\"{$unique}\");'>跳转</a></li>"
            . "<form method='post' action='{$pageurl}'>"
            . "<div id='div{$unique}' class='jumpdiv'> <input id='input{$unique}' type='text' name='page' /> 页 "
            . "<button type='submit' class='btn btn-info btn-xs'>确定</button></div>"
            . "</form>";
        
        $return .= '</ul>';
        if (!$hasjs) {
            $return .= '<script>function showjumpdiv(unique) { $("#div"+unique).toggle();$("#input"+unique).focus();}</script>';
            $hasjs = true;
        }
        return $return;
    }
}

//执行Kernel
$kernel   = new AdminKernel();

$kernel->registerProject('Admin', __DIR__ . '/Application');
$kernel->registerProject('Entity', __DIR__ . '/Application');
$kernel->registerProject('Api', __DIR__ . '/Application');

$request  = Pyramid\Component\HttpFoundation\Request::createFromGlobals();
$response = $kernel->handle($request);
$response->format($request->getParameter('format'), $request->getParameter('callback'));
$response->send();

