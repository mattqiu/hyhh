<?php
/**
 * @ file Index.php
 */
namespace Api\Index;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Api;
use Entity;

class Index {
    
  
    /**
     * 大屏幕入口
     * @route /wechat/shake/index
     * @param $step 
     * @access
     * @return array['signPackage']
     */
    public static function index($request) {
        $res['step'] = $request->get('step',4);
        

        return new Response(theme()->render('shake_index_'.$res['step'].'.html',$res));
    }
    
}