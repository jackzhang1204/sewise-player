/********************************************************************************
 * File        : ILivePlayerSkin.as
 * Description : ILivePlayerSkin.as
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : May 11, 2013 5:55:49 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package interfaces.skin {
	import interfaces.player.ILivePlayerMediator;
	import flash.net.NetStream;

	public interface ILivePlayerSkin{

		/**
		 * 设置播放核心对象方法，皮肤加载完成时被调用
		 */
		function set player(pm:ILivePlayerMediator):void;
		
		/**
		 * 设置流对象给video
		 */
		function set stream(stream:NetStream):void;

		/**
		 * 设置语言
		 */
		function set lang(lang:String):void;
		
		/**
		 * 设置logo地址
		 */
		function set logo(url:String):void;
		
		/**
		 * 设置clarity按钮是否显示
		 */
		function set clarityButton(state:String):void;
		
		/**
		 * 设置播放时间是否显示
		 */
		function set timeDisplay(state:String):void;
		
		/**
		 * 设置控制栏是否显示
		 */
		function set controlBarDisplay(state:String):void;
		
		/**
		 * 设置顶部栏是否显示
		 */
		function set topBarDisplay(state:String):void;
		
/**------------------------------ 设置播放器各种状态的方法 ---------------------------*/
		/**
		 * 设置是否允许拖动
		 */
		function set draggable(d:Boolean):void;
		
		/**
		 * 是否正在缓冲
		 */
		function set buffering(b:Boolean):void;
		
		/**
		 * 是否正在执行跳转操作
		 */
		function set seeking(b:Boolean):void;



		/**
		 * 播放进程心跳方法，播放器会不断调用本方法，皮肤可以在本方法中实现播放进度，直播进度
		 */
		function playProgress():void;
		
		/**
		 * 播放开始时调用
		 */
		function started():void;
		
		/**
		 * 播放停止时调用
		 */
		function stopped():void;
		
		/**
		 * 播放暂停时调用
		 */
		function paused():void;

		
		
		/**
		 * 设置缓冲的进度，在缓冲时会不断调用本方法
		 * @param p 进度值，范围：[0,1]
		 */
		function set bufferProgress(p:Number):void;

		/**
		 * 设置下载速度
		 * @param speed 下载速度，单位：字节/秒
		 */
		function set loadSpeed(speed:Number):void;
		
		/**
		 * 设置视频总时长
		 * @param t 视频总时长，单位：秒
		 */
		function set duration(t:Number):void;
		
		/**
		 * 设置播放器上显示的节目标题
		 */
		function set programTitle(title:String):void;



		/**
		 * 初始化清晰度数据
		 * @param levels 包括IClarity对象的数组
		 */
		function initialClarity(levels:Array):void;
		
		/**
		 * 设置海报
		 */
		function set poster(url:String):void;
		
		/**
		 * 设置默认音量值
		 */
		function set volume(value:Number):void;
		
	}
}
