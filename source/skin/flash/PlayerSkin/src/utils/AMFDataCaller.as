/********************************************************************************
 * File        : AMFDataCaller.as
 * Description : 从实现了AMF的Web服务器获取数据
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 13, 2013 11:02:44 AM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package utils {
	import flash.events.Event;
	import flash.net.NetConnection;
	import flash.events.NetStatusEvent;
	import flash.net.Responder;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class AMFDataCaller extends EventDispatcher {
		
		public static const DATA_CALL_SUCCESS:String = "data_call_success";
		public static const DATA_CALL_FAILED:String = "data_call_failed";
		
		private var _serverPath:String;
		private var _serverApi:String;
		private var _connection:NetConnection;
		private var _responder:Responder;
		
		private var _data:Object;
		private var _error:Object;
		
		public function AMFDataCaller(target : IEventDispatcher = null) {
			super(target);
		}
		
		/**
		 * 初始化DataCaller，创建连接，创建反应器
		 * @param serverPath 被连接的目标服务器地址，如：http://219.232.160.193/flashservice/gateway.php
		 * @param serverApi 被调用的目标服务器接口，如：ServerApi.execute
		 */
		public function initial(serverPath:String,serverApi:String):void{
			_serverPath = serverPath;
			_serverApi = serverApi;
			_connection = new NetConnection();
			_connection.addEventListener(NetStatusEvent.NET_STATUS, onStatus);
			_responder = new Responder(onResult,onFault);
		}
		
		/**
		 * 请求数据的方法
		 * @param request 向目标服务器所传递的参数，如：{mod:"program",do:"getstreams",programid:"d4Goi9rJ"}
		 */
		public function call(request:Object):void{
			_connection.connect(_serverPath);
			_connection.call(_serverApi, _responder, request);
		}
		
		public function get data():Object{
			return _data;
		}
		
		/**
		 * 连接状态反馈，可能值：
		 * 1.NetConnection.Call.Failed（连接地址：http://219.232.160.193/flashservice/gateway-a.php）
		 * 2.NetConnection.Call.BadVersion（连接地址：http://219.232.160.193/flashservice/gateway.php-a）
		 */
		private function onStatus(e:NetStatusEvent):void{
			dispatchEvent(new Event(DATA_CALL_FAILED));
		}
		
		/**
		 * 数据获取成功
		 */
		private function onResult(data:Object):void{
			_data = data;
			dispatchEvent(new Event(DATA_CALL_SUCCESS));
		}
		
		/**
		 * 数据获取失败
		 */
		private function onFault(error:Object):void{
			_error = error;
			dispatchEvent(new Event(DATA_CALL_FAILED));
		}
		
		
	}
}
