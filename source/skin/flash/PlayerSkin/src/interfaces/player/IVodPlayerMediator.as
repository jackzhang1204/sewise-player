/********************************************************************************
 * File        : IVodPlayer.as
 * Description : 点播播放器接口
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : May 11, 2013 4:46:37 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package interfaces.player {
	public interface IVodPlayerMediator {
		
		/**
		 * 播放操作
		 */
		function play():void;
		
		/**
		 * 暂停操作
		 */
		function pause():void;
		
		/**
		 * 停止播放操作
		 */
		function stop():void;
		
		/**
		 * 跳转播放操作
		 * @param t 跳转到的时间，单位：秒
		 */
		function seek(t:Number):void;
		
		
		
		/**
		 * 设置清晰度
		 * @param level 清晰度级别
		 */
		function changeClarity(level:IClarity):void;
		
		/**
		 * 设置音频
		 * @param p 音量比例（Proportion），值：[0,1]
		 */
		function setVolume(p:Number):void;
		
		
		
		/**
		 * 根据视频的地址直播播放某视频
		 * @param title 视频的标题
		 * @param httpUrl 视频的地址
		 * @param starttime 从视频中间的某位置开始播放，单位：秒
		 */
		function toPlay(httpUrl:String,title:String,startTime:Number,auto:Boolean,adsXmlUrl:String="",subtitlesId:String="",subtitlesLang:String=""):void;
		
		/**
		 * 获得当前播放视频的总时长，单位：秒
		 */
		function duration():Number;
		
		/**
		 * 获得当前视频正播放到的位置，单位：秒
		 */
		function playTime():Number;

		
		/**
		 * 播放类型
		 */
		function type():String;
		
		
		/**
		 * 显示文本信息提示
		 */
		function showTextTip(content:String,time:Number):void;
		
		/**
		 * 隐藏文本信息提示
		 */
		function hideTextTip():void;
		
		/**
		 * 设置字幕语言列表
		 */
		function setSubtitlesLang(subtitlesLangArray:Array):void;
		
		/**
		 * 切换字幕语言
		 */
		function switchSubtitle(lang:String):void;
		
	}
}
