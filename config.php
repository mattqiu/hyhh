<?php

//配置: session
$sessions = array(
    'prefix' => 'hyhh#lgzhi',
);

//配置: 数据库
$databases = array(
    'default' => array(
        'host'      => '127.0.0.1',
        'port'      => '3306',
        'database'  => 'hyhh',
        'username'  => 'root',
        'password'  => '123456',
        'prefix'    => 'us_',
        'charset'   => 'utf8mb4',
    ),
);


//配置: Log 日志路径
$loggers = array(    
    'default' => array(
        'class' => 'Pyramid\Component\Logger\FileLogger',
        'level' => 'debug',
		'file' => 'cache/logs/hyhh_default',
    ),
    'system' => array(
        'class' => 'Pyramid\Component\Logger\FileLogger',
        'level' => 'debug',
		'file' => 'cache/logs/hyhh_system',
    ),
);

//配置: 模板引擎
$engines = array(
    'default' => array(
        'engine'      => 'Pyramid\Component\Templating\PhpEngine',
        'loader'      => 'Pyramid\Component\Templating\Php\Loader',
        'environment' => 'Pyramid\Component\Templating\Php\Environment',
        'loaderArgs'  => array(),
        'envArgs'     => array(),
    ),
);

//配置：api status
$api_status = array(
    '200'   => 'OK',
    '10000' => '当前服务不可用',
    '10001' => '请填写完整信息',
    '10002' => '密码输入有误',
    '10003' => '该用户不存在',
    '10004' => '请输入用户名',
    '10005' => '注册失败',
    '10006' => '登录失败',
    '10007' => '非法操作',
);
config()->set('status',$api_status);

//贪吃蛇当天可玩次数
config()->set('snakePlayMaxTimes',5);

//分享到朋友圈获得赠送次数
config()->set('snakePresentTimes',3);

//设置抽奖关卡分数和奖金
config()->set('snake_lottery',array(
    '5' => array(
        'money'     => '2.50',
        'total'     => 20,
        'score'     => 8000,
    ),
    '4' => array(
        'money'     => '2.00',
        'total'     => 30,
        'score'     => 6000,
    ),
    '3' => array(
        'money'     => '1.68',
        'total'     => 40,
        'score'     => 3000,
    ),
    '2' => array(
        'money'     => '1.00',
        'total'     => 50,
        'score'     => 1000,
    ),
    '1' => array(
        'money'     => '1.00',
        'total'     => 60,
        'score'     => 1000,
    ),
));