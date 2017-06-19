<?php 

/**
 *@ file Hongbao.php  微信红包派发
 */

namespace Api\Snake;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Pyramid\Component\WeChat\Utility as Utility;
use Pyramid\Component\WeChat\WeChat as BaseWechat;
use Entity;
use Api;

class Hongbao{

    /**
     * 调用微信接口 发送红包现金
     * @route
     * @access
     * @param   id      中奖ID
     * @param   openid  微信用户Openid
     * 
     * @return boolean 
     */
    public static function sendredpack($request) {
        global $wx_auhten;
        $id = $request->getParameter('id');
        $openid = $wx_auhten['openid'];
        //db_select 没有缓存在搞鬼
        $lottery = db_select("lottery","l")->fields("l")->condition("id",$id)->execute()->fetch();
        //更新为已读状态
        db_update("lottery")->fields(array("is_read"=>1,"updated"=>time()))->condition("id",$lottery->id)->execute();
        
        $hongbao = db_select("hongbao","h")
                    ->fields("h")
                    ->condition("relate_id",$id)
                    ->execute()
                    ->fetch();
              
        $wx_config = variable()->get('wxconfig');
        if ($lottery->status == 2 && empty($hongbao)) {
            //处理中
            db_update("lottery")->fields(array('status'=>5))->condition("id",$lottery->id)->execute();
            
            $array = array(
                'nonce_str'     => (string)random(8),
                'mch_id'        => $wx_config['mch_id'],
                'mch_billno'    => $wx_config['mch_id'] . date('YmdHis').rand(1000,9999),
                'send_name'     => '上海贝螺网络科技',//列表显示标题名称
                're_openid'     => $lottery->openid,
                'wxappid'       => $wx_config['appid'],
                'total_amount'  => $lottery->amount * 100,
                'total_num'     => 1,
                'wishing'       => '闯关领红包', //拆红包前祝福语
                'client_ip'     => '124.232.150.58', //'  58.246.188.86
                'act_name'      => '小游戏送大礼',
                'remark'        => '点我查收',          
            );
                     
            //发送文字提醒
            //self::sendMessage($openid,"恭喜中奖了：".$lottery->amount);           
            
            //发送红包 todo 加证书
            $certs = array(
                CURLOPT_SSLCERTTYPE => 'PEM',
                CURLOPT_SSLCERT   => '/cert/urms/apiclient_cert.pem',
                CURLOPT_SSLKEY    => '/cert/urms/apiclient_key.pem',
                CURLOPT_CAINFO    => '/cert/urms/rootca.pem',
            );
            $responseObj = self::postRedPackXml($array,$certs);
            
            if ($responseObj->return_code == 'SUCCESS' && $responseObj->result_code == 'SUCCESS') {
                //成功发送
                $updates = array(
                    'status' => '3','updated'=>time(),
                );
                $hongbao = array(
                    'username'      => $lottery->username,
                    'headimgurl'    => $lottery->headimgurl,
                    'relate_id'     => $lottery->id,
                    'listid'        => $responseObj->send_listid,
                    'billno'        => $responseObj->mch_billno,
                    'wid'           => $lottery->wid,
                    'openid'        => $lottery->openid,
                    'amount'        => $lottery->amount,
                    'status'        => 1,
                    'created'       => time(),
                    'updated'       => time(),
                );
                //写入红包记录表
                db_insert("hongbao")->fields($hongbao)->execute();
            }
            
            else {           
                logger()->debug("发送红包出错了：".var_export($responseObj,true));
                $updates = array(
                    'status' => 4,
                    'remark' => $responseObj->return_msg."||".$responseObj->err_code."||".$responseObj->err_code_des,
                    'updated' => time(),
                );
            }
            
            //更新抽奖状态
            db_update("lottery")->fields($updates)->condition("id",$lottery->id)->execute();
            
        } elseif ($lottery->status == 0 && $lottery->is_read == 0) {
            //未中奖发送文字提醒
            //self::sendMessage($openid,"抱歉，未中奖");           
        }
        
        return new Response("SUCCESS");
    }
    
    
    //临时发送文字提醒
    public static function sendMessage($openid,$content) {
        $wechat = new BaseWechat(variable()->get('wxconfig'));
        $output = array(
            "touser"    => $openid,
            "msgtype"   => "text",
            "text"      => array(
               "content" => $content,
            ),
        );
        $wechat->sendCustomMessage($output);
    }

    /**
     * @红包推送至微信接口
     * $cert = array(
     *          'CURLOPT_SSLCERT' => '',
     *          'CURLOPT_SSLKEY'  => '',
     *          )
     *
     */
    public static function postRedPackXml($params,$cert=array()) {
        //获取签名
        try{
            $params['sign'] = self::getPaySign($params);
            $sendXml = self::buildXML($params);
            $url = "https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack";
            
            //发送至微信接口
            
            $responseXml = Utility::http($url,$sendXml,$cert);
            logger()->error("response xml:".$responseXml);
            $responseObj = simplexml_load_string($responseXml, 'SimpleXMLElement', LIBXML_NOCDATA);
        } catch (\Exception $e) {
            logger()->debug("发送微信红包 DEBUG is ".$e->getMessage());
        }
        return $responseObj;
    }
    
    //拼装微信红包 xml 数据
    protected static function buildXML($array) {
        $xmlData = '<xml>';
        foreach ($array as $k => $v) {
            if (is_numeric($k)) {
                $k = 'item';
            }
            if (is_array($v) || is_object($v)) {
                $xmlData .= "<$k>" . self::buildXML((array) $v) . "</$k>";
            } else {
                $v = preg_replace("/[\\x00-\\x08\\x0b-\\x0c\\x0e-\\x1f]/u", '', $v);
                $v = str_replace(array('<![CDATA[',']]>'), array('< ![CDATA[',']] >'), $v);
                $xmlData .= "<$k><![CDATA[" . $v . "]]></$k>";
            }
        }
        $xmlData.= '</xml>';
        
        return $xmlData;
    }
    
    /**
     * 微信支付，生成签名
     * 
     * @route 
     * @access
     * @param  params 发送红包数组
     *
     * @return array
     */
    protected static function getPaySign($params) {
        //key设置：微信商户平台(pay.weixin.qq.com)-->账户设置-->API安全-->密钥设置
        $wx_config = variable()->get('wxconfig');
        $key    = $wx_config['pay_key'];
        ksort($params);
        $query = '';
        foreach($params as $k=>$v) {
            $query .= $k."=".$v."&";
        }
        $query .= "key=".$key;
        
        return strtoupper(md5($query));
    }

}