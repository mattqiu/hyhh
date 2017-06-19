<?php 

/**
 * @ file menu
 * @ 返回用户可见权限菜单
 * @ return authentication menu
 */
namespace Entity\Menu;
use Entity;

class Menu { 
    /**
     * 获取菜单
     * @route
     * @access 
     * @param 
     * @return array 
     */
    public static function getMenu($route) {
        $path = '/' . $route;
        $menus = self::setMenus();
        $admin = Entity\User\User::load(entity_request(array('uid'=>session()->get('user')->uid)));
        foreach ($menus as $k=>$v) {
            foreach($v['childs'] as $kk => $vv) {
				if(strpos($path,dirname($vv['href'])) === 0) {
					$menus[$k]['active'] = true;
				}
                if (!isset($admin->permissions[$vv['href']])) {
                    unset($menus[$k]['childs'][$kk]);
                }
            }

            if (empty($menus[$k]['childs']))
                unset($menus[$k]);

        }
        //print_r($menus);exit;
        foreach ($menus as $k => $v) {
			if($v['active'] == true) {
				foreach ($v['childs'] as $kk => $vv) {
					if ($vv['href'] == $path || strpos($path,$vv['href'])!==false) {
						$menus[$k]['childs'][$kk]['active'] = true;						
					}
				}
                return array($menus, $menus[$k]);
			}
        }
        $route = dirname($route);
        if ($route == '.' || $route == '/' || $route == '\\') {
            return array($menus, array());
        } else {
            return self::getMenu($route);
        }
    }
    /**
     * 设置路由
     * @route 
     * @access 
     * @param 
     * @return array 
     */
    public static function setMenus(){
        return array(
                '6'  => array(
                    'name'   => '热点主页',
                    'href'   => '/admin/hotnews/search',
                    'icon'   => 'fa-mobile',
                    'active' => false,
					'module' => 'hotnews',
                    'childs' => array(
                        array(
                            'name'   => '信息列表',
                            'href'   => '/admin/hotnews/search',
                            'icon'   => 'fa-list',
                            'active' => false,
                        ),
                        array(
                            'name'   => '新增信息',
                            'href'   => '/admin/hotnews/search',
                            'icon'   => 'fa-list',
                            'active' => false,
                        ),
                    ),
                ),
                
                '8'  => array(
                    'name'   => '微信企业号',
                    'href'   => '/admin/wechat/user',
                    'icon'   => 'fa-weixin',
                    'active' => false,
					'module' => 'wechat',
                    'childs' => array(
                        array(
                            'name'   => '会员列表',
                            'href'   => '/admin/wechat/user',
                            'icon'   => 'fa-user',
                            'active' => false,
                        ),
                        array(
                            'name'   => '留言消息',
                            'href'   => '/admin/wechat/message',
                            'icon'   => 'fa-user',
                            'active' => false,
                        ),
                        array(
                            'name'   => '应用配置',
                            'href'   => '/admin/wechat/setting',
                            'icon'   => 'fa-gear',
                            'active' => false,
                        ),
                        
					),
                ),
                '98' => array(
                    'name'   => '管理员',
                    'href'   => '/admin/user/search',
                    'icon'   => 'fa-users',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '用户列表',
                            'href'   => '/admin/user/search',
                            'icon'   => 'fa-user',
                            'active' => false,
                        ),
						array(
                            'name'   => '新增用户',
                            'href'   => '/admin/user/add',
                            'icon'   => 'fa-pencil',
                            'active' => false,
                        ),
					),
				),
                '99' => array(
                    'name'   => '角色管理',
                    'href'   => '/admin/role/search',
                    'icon'   => 'fa-wrench',
                    'active' => false,
                    'childs' => array(                       
                        array(
                            'name'   => '角色列表',
                            'href'   => '/admin/role/search',
                            'icon'   => 'fa-reorder',
                            'active' => false,
                        ),
						array(
                            'name'   => '添加角色',
                            'href'   => '/admin/role/add',
                            'icon'   => 'fa-pencil',
                            'active' => false,
                        ),
                    ),
                ),
        
        );
    }
}