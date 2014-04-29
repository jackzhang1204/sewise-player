/********************************************************************************
 * File        : MediaLoader.as
 * Description : 媒体文件下载器，主要是图片与swf文件
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Jan 14, 2013 21:51:05 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package utils {
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;

	public class MediaLoader extends EventDispatcher implements IEventDispatcher {
		
		public static const MEDIA_LOAD_SUCCESS:String = "media_load_success";
		public static const MEDIA_LOAD_FAILED:String = "media_load_failed";
		
		//内容下载器
		private var _loader:Loader;
		
		//广告内容
		private var _media:DisplayObject;
		
		/**
		 * 构造函数
		 */
		public function MediaLoader(target : IEventDispatcher = null) {
			super(target);
		}
		
		public function get media():DisplayObject{
			return _media;
		}
		
		/**
		 * 执行下载任务
		 */
		public function doLoad(url:String):void{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, ldrHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ldrErrorHandler);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ldrErrorHandler);
			_loader.contentLoaderInfo.addEventListener(AsyncErrorEvent.ASYNC_ERROR, ldrErrorHandler);
			_loader.load(new URLRequest(url));
		}
		
		private function ldrHandler(evt:Event):void{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, ldrHandler);
			switch(_loader.contentLoaderInfo.contentType){
				case 'application/x-shockwave-flash':
					if(_loader.contentLoaderInfo.actionScriptVersion == 3){
						_media = _loader.contentLoaderInfo.content;
					}
					else{
						_media = _loader;
					}
					break;
				case 'image/jpeg':
				case 'image/gif':
				case 'image/png':
					_media = _loader;
					break;
			}
			
			this.dispatchEvent(new Event(MEDIA_LOAD_SUCCESS));
		}
		
		/**
		 * 销毁下载下来的对象,前提是先将引用去掉，例如等removeChild
		 */
		public function destroyMedia():void{
			if(!_loader) return;
			_loader.unloadAndStop();
			_loader = null;
		}
		
		/**
		 * 下载失败
		 */
		private function ldrErrorHandler(e:Event):void{
			this.dispatchEvent(new Event(MEDIA_LOAD_FAILED));
		}
		
	}
}
