<?php

/**
 * @file
 *
 * SnakeEntityController 
 */

namespace Entity\Snake;

use Pyramid\Component\Entity\EntityController;

class SnakeEntityController extends EntityController {
    
    //@inherited attachLoad
    protected function attachLoad(&$query_entities) {
        parent::attachLoad($query_entities);
        foreach ($query_entities as $entity_id => $entity) {
            //计算已玩次数
            $this->assemblePlayTimes($entity);
        }
    }
    
    //计算已玩次数
    protected function assemblePlayTimes($entity) {
        if ($entity && $entity->play_times < ($entity->present_times+config()->get('snakePlayMaxTimes'))){
            $entity->play_game = true;
            $entity->residue_times = ($entity->present_times+config()->get('snakePlayMaxTimes')) - $entity->play_times;
        } else {
            $entity->play_game = false;
            $entity->residue_times = 0;
        }
    }
}
