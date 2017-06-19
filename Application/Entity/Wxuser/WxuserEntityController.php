<?php

/**
 * @file
 *
 * WxuserEntityController 
 */

namespace Entity\Wxuser;

use Pyramid\Component\Entity\EntityController;

class WxuserEntityController extends EntityController {
    
    //@inherited attachLoad
    protected function attachLoad(&$query_entities) {
        parent::attachLoad($query_entities);
        foreach ($query_entities as $entity_id => $entity) {
            //加载用户来源渠道
            //$this->assembleChannel($entity);
        }
    }
}
