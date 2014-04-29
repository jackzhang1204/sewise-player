/********************************************************************************
 * File        : ILivePlayer.as
 * Description : 直播播放器接口
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : May 11, 2013 4:43:41 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package interfaces.player {
	
	public interface ILivePlayerMediator {

		/**
		 * 直接返回直播操作
		 */
		function live():void;
		
		/**
		 * 播放操作
		 */
		function play():void;
		
		/**
		 * 暂停操作
		 */
		function pause():void;
		
		/**
		 * 停止播放
		 */
		function stop():void;
		
		/**
		 * 跳转播放操作
		 * @param shiftTime 传值为字符类型，如："20130503123456"
		 */
		function seek(shiftTime:String):void;
		
		
		
		/**
		 * 设置清晰度
		 * @param level 清晰度级别
		 */
		function changeClarity(clarity:IClarity):void;
		
		/**
		 * 设置音量
		 * @param p 音量比例（Proportion），值：[0,1]
		 */
		function setVolume(p:Number):void;
		
		
		
		/**
	 	 * 根据视频的地址直播播放某视频
	 	 * @param title 视频的标题
	 	 * @param url 视频的地址，有两种地址类型[(1)http直播地址(2)rtmp直播地址]
	 	 * @param shiftTime 从视频中间的某位置开始播放，字符串类型，如："20130503123456"
	 	 * @param auto 调用本方法后，是否立即开始播放,值为字符型true或false
	 	 */
		function toPlay(url:String,title:String,shiftTime:String,auto:Boolean):void;
		
		
		/**
		 * 显示文本信息提示
		 */
		function showTextTip(content:String,time:Number):void;
		
		/**
		 * 隐藏文本信息提示
		 */
		function hideTextTip():void;


		
		/**
		 * 当前正在播放的视频的日期时间
		 */
		function playTime():Date;
		
		/**
		 * 当前频道直播的最新时间
		 */
		function liveTime():Date;
		
		/**
		 * 播放类型
		 */
		function type():String;

	}
}
