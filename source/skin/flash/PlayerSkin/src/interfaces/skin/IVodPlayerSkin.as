/********************************************************************************
 * File        : ISkin.as
 * Description : 皮肤入口程序接口
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 1, 2013 10:45:27 AM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package interfaces.skin {
	import flash.display.MovieClip;
	import flash.net.NetStream;
	
	import interfaces.player.IVodPlayerMediator;
	
	public interface IVodPlayerSkin{

		/**
		 * 设置播放核心对象方法，皮肤加载完成时被调用
		 */
		function set player(pm:IVodPlayerMediator):void;
		
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
		 * 获取皮肤广告MC容器对象
		 */
		function get ads():MovieClip
		
		/**
		 * 获取皮肤视频容器对象
		 */
		function get videoBox():MovieClip;
		
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
		
		/**
		 * 设置字幕播放器
		 */
		function set subtitlesPlayer(path:String):void;

/**------------------------------ 设置播放器各种状态的方法 ---------------------------*/

		/**
		 * 是否正在缓冲
		 */
		function set buffering(b:Boolean):void;
		
		/**
		 * 是否正在执行跳转操作
		 */
		function set seeking(b:Boolean):void;

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

/**------------------------------ 设置播放器各种进度的方法 ---------------------------*/		
		
		/**
		 * 设置缓冲的进度
		 * @param p 进度值，范围：[0,1]
		 */
		function set bufferProgress(p:Number):void;
		
		/**
		 * 设置下载数据进度
		 * @param p 下载数据进度比例，范围：[0,1]
		 */
		function set loadedProgress(p:Number):void;
		
/**------------------------------ 设置播放器某些数据的方法 ---------------------------*/		
		
		/**
		 * 设置播放器上显示的节目标题
		 */
		function set programTitle(title:String):void;

		/**
		 * 设置视频总时长
		 * @param t 视频总时长，单位：秒
		 */
		function set duration(t:Number):void;
		
		/**
		 * 设置视频已经播放的视频时间长度
		 * @param t 视频已播时间长度，单位：秒
		 */
		function set playTime(t:Number):void;
		
		/**
		 * 设置开始播放时间
		 */
		function set startTime(t:Number):void;
		
		/**
		 * 设置下载速度
		 * @param speed 下载速度，单位：字节/秒
		 */
		function set loadSpeed(speed:Number):void;

		/**
		 * 初始化清晰度数据
		 * @param levels 包括IClarity对象的数组
		 */
		function initialClarity(levels:Array):void;
		
		/**
		 * 设置语言列表
		 */
		function set subtitlesLang(subtitlesLangArray:Array):void
		
	}
}