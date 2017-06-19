<?php 
require_once dirname(dirname(__DIR__)) . '/Pyramid/Pyramid.php';

require_once dirname(__DIR__) . '/config.php';

function_exists($_GET['fun']) && $_GET['fun']();

function auto_field_config() {
    global $databases;
    $schemas = db_schema()->getSchema();
    $fields  = db_select('field_config','f')
                    ->fields('f')
                    ->execute()
                    ->fetchAll();
    foreach ($fields as $v) {
        $field = $databases['default']['prefix'].'data_' . $v->field_name;
        if (isset($schemas[$field])) {
            $config = array();
            foreach ($schemas[$field] as $k => $vv) {
                if (in_array($k, array('entity_type', 'entity_id', 'delta'))) {
                    continue;
                }
                $config[str_replace($v->field_name.'_', '', $k)] = $vv;
            }
            $data = array('columns' => $config,);

            db_update('field_config')
                ->fields(array('data' => serialize($data),))
                ->condition('id', $v->id)
                ->execute();
        } else {
            echo 'no';exit;
        }
    }
    echo 'done!';
}
