/********************************************************************************
 * File        : ControlBar.as
 * Description : 点播播放器控制条
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 10:33:47 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vspaas.controlbar {
	//import com.demonsters.debugger.MonsterDebugger;
	
	import fl.controls.List;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import interfaces.player.IVodPlayerMediator;
	
	import skins.PlayerEvent;
	
	import utils.LanguageManager;
	import utils.Stringer;
	import utils.Colorer;

	public class VodControlBar extends MovieClip {
		
		//控制条区背景
		public var controlBarBg:MovieClip;
		//播放进度条
		public var progressLine:ProgressLine;
		//暂停按钮
		public var pauseBtn:MovieClip;
		//播放按钮
		public var playBtn:MovieClip;
		//声音控制条
		public var volumeLine:VolumeLine;
		//清晰度按钮
		public var clarityBtn:MovieClip;
		//全屏播放按钮
		public var fullBtn:MovieClip;
		//正常屏幕按钮
		public var normalBtn:MovieClip;
		//总时间字符串
		public var totalTime:String = "00:00:00";
		//设置清晰度事件
		public static const SHOW_CLARITY_SETTING:String = "show_clarity_setting";
		
		public function VodControlBar() {
			_vspaas = this.parent as MovieClip;
			playBtn.visible = true;
			pauseBtn.visible = false;
			normalBtn.visible = false;
			
			/**
			 * 增加字幕控制按钮
			 * 2013.12.6 jackzhang
			 */
			subtitlesBtnBtn = subtitlesBtn.btn as SimpleButton;
			subtitlesBtnList = subtitlesBtn.list as List;
			
			fullBtn.addEventListener(MouseEvent.CLICK, fullScreenHandler);
			normalBtn.addEventListener(MouseEvent.CLICK, noramlScreenHandler);
			playBtn.addEventListener(MouseEvent.CLICK, playHandler);
			pauseBtn.addEventListener(MouseEvent.CLICK, pauseHandler);
			volumeLine.addEventListener(PlayerEvent.VOLUME_CHANGE, volumeHandler);
			progressLine.addEventListener(PlayerEvent.SEEK, seekHandler);
			
		}
		
		
/**------------------------------ 本对象大小及显示设置方法 ---------------------------*/
		public function setUiColor(color:uint):void
		{
			Colorer.SetRGB(playBtn.bg, color);
			Colorer.SetRGB(pauseBtn.bg, color);
			Colorer.SetRGB(fullBtn.bg, color);
			Colorer.SetRGB(normalBtn.bg, color);
			Colorer.SetRGB(clarityBtn.bg, color);
			Colorer.SetRGB(subtitlesBtn.bg, color);
			
			progressLine.setUiColor(color);
			volumeLine.setUiColor(color);
		}
		
		
		private var progressLineW:Number;
		private var btnSpacing:int = 4;
		public function resize(w:Number,h:Number):void{
			_curW = w;
			_curH = h;
			
			controlBarBg.width = w;
			this.y = h - this.controlBarBg.height;
			
			playBtn.x = 0;
			pauseBtn.x = 0;
			progressLine.x = playBtn.x + playBtn.width + btnSpacing;
			fullBtn.x = w - fullBtn.width;
			normalBtn.x = fullBtn.x;
			volumeLine.x = fullBtn.x - volumeLine.width - btnSpacing;
			if(clarityBtn.visible)
			{
				clarityBtn.x = fullBtn.x;
				clarityBtn.y = clarityBtn.height - h;
				subtitlesBtn.x = clarityBtn.x - subtitlesBtnBtn.width - btnSpacing;
				subtitlesBtn.y = clarityBtn.y;
			}else{
				subtitlesBtn.x = fullBtn.x;
				subtitlesBtn.y = subtitlesBtn.height - h;
			}
			progressLineW = w -playBtn.width - fullBtn.width - volumeLine.width - 3 * btnSpacing;
			progressLine.resize(progressLineW);
			
			if(this.stage.displayState == StageDisplayState.FULL_SCREEN){
				fullBtn.visible = false;
				normalBtn.visible = true;
			}
			else{
				fullBtn.visible = true;
				normalBtn.visible = false;
			}
			show();
		}
		public function show():void{
			var _showTween:Tween = new Tween(this, "alpha", Regular.easeOut, this.alpha, 1, 0.3, true);
			_showTween.start();
		}
		public function hide():void{
			var _hideTween:Tween  = new Tween(this, "alpha", Regular.easeOut, this.alpha, 0, 0.6, true);
			_hideTween.start();
		}
		
/**------------------------------ 播放器视图代理调用的方法 ---------------------------*/
		public function setPlayer(p:IVodPlayerMediator):void{
			_player = p;
		}
		
		public function setDuration(d:Number):void{
			_duration = d;
			
			progressLine.duration = d;
		}
		
		//播放时间字符串
		public function set playedTime(t:String):void{
			//playTime.text = t + "/" + totalTime;
		}

		/**
		 * 设置下载速度显示
		 */
		public function setSpeed(speed:String):void{
			
		}

		public function started():void{
			playBtn.visible = false;
			pauseBtn.visible = true;
			clarityBtn.enabled = true;
			
			if(!clarityBtn.hasEventListener(MouseEvent.CLICK)) clarityBtn.addEventListener(MouseEvent.CLICK, clarityHandler);
			
			/**
			 * 增加字幕控制按钮
			 * 2013.12.6 jackzhang
			 */
			if(!subtitlesBtnBtn.hasEventListener(MouseEvent.CLICK)) subtitlesBtnBtn.addEventListener(MouseEvent.CLICK, subtitlesBtnBtnClickHandler);
			//2013.12.6 jackzhang/////////////
		}
		
		public function stopped():void{
			playBtn.visible = true;
			pauseBtn.visible = false;
			
			playTimeReset();
			progressLine.stopped();
			if(clarityBtn.hasEventListener(MouseEvent.CLICK)) clarityBtn.removeEventListener(MouseEvent.CLICK, clarityHandler);
			
			/**
			 * 增加字幕控制按钮
			 * 2013.12.6 jackzhang
			 */
			if(subtitlesBtnBtn.hasEventListener(MouseEvent.CLICK)) subtitlesBtnBtn.removeEventListener(MouseEvent.CLICK, subtitlesBtnBtnClickHandler);
			//2013.12.6 jackzhang/////////////
		}
		
		public function paused():void{
			playBtn.visible = true;
			pauseBtn.visible = false;
		}
		
		private var stop_string:String;
		private var pause_string:String;
		private var play_string:String;
		private var fullScreen_string:String;
		private var normalScreen_string:String;
		private var soundOn_string:String;
		private var soundOff_string:String;
		private var clarity_string:String;
		
		//2013.12.6 jackzhang/////////////
		private var subtitles_string:String;
		public function initLanguage():void
		{
			stop_string = LanguageManager.getInstance().getString("stop");
			pause_string = LanguageManager.getInstance().getString("pause");
			play_string = LanguageManager.getInstance().getString("play");
			fullScreen_string = LanguageManager.getInstance().getString("fullScreen");
			normalScreen_string = LanguageManager.getInstance().getString("normalScreen");
			soundOn_string = LanguageManager.getInstance().getString("soundOn");
			soundOff_string = LanguageManager.getInstance().getString("soundOff");
			clarity_string = LanguageManager.getInstance().getString("clarity");
			
			//2013.12.6 jackzhang/////////////
			subtitles_string = LanguageManager.getInstance().getString("subtitles");
		}
		
		
		/**
		 * 增加字幕控制按钮
		 * 2013.12.6 jackzhang
		 */
		public var subtitlesBtn:MovieClip;
		private var subtitlesBtnBtn:SimpleButton;
		private var subtitlesBtnList:List;
		private var subtitlesListMaxRow:uint = 7;
		public function setSubtitlesLang(subtitlesLangArray:Array):void
		{
			subtitlesBtnList.dataProvider = new DataProvider(subtitlesLangArray);
			if(subtitlesBtnList.length < subtitlesListMaxRow)
			{
				subtitlesBtnList.height = subtitlesBtnList.length * subtitlesBtnList.rowHeight;
			}else{
				subtitlesBtnList.height = subtitlesListMaxRow * subtitlesBtnList.rowHeight;
			}
			subtitlesBtnList.y = subtitlesBtnBtn.height;
			subtitlesBtnList.selectedIndex = 1;
			//subtitlesBtnBtn.addEventListener(MouseEvent.CLICK, subtitlesBtnBtnClickHandler);
			subtitlesBtnList.addEventListener(Event.CHANGE, subtitlesBtnListChangeHandler);
		}
		private function subtitlesBtnListChangeHandler(e:Event):void
		{
			var selectObj:Object = subtitlesBtnList.selectedItem;
			_player.switchSubtitle(selectObj.data);
			subtitlesBtnList.visible = false;
		}
		private function subtitlesBtnBtnClickHandler(e:MouseEvent):void
		{
			if(subtitlesBtnList.visible)
			{
				subtitlesBtnList.visible = false;
			}else{
				subtitlesBtnList.visible = true;
			}
		}
		//2013.12.6 jackzhang/////////////
		
/**------------------------------ 私有属性及方法 ---------------------------*/

		//主播放器接口
		private var _player:IVodPlayerMediator;
		//顶级对象
		//private var _vspaas:VodOrange;
		private var _vspaas:MovieClip;
		//当前应用宽度
		private var _curW:Number;
		//当前应用高度
		private var _curH:Number;
		//本视图进度代表的时间长度
		private var _duration:Number;
		
		
		/**
		 * 全屏按钮事件响应
		 */
		private function fullScreenHandler(e:MouseEvent = null):void{
			this.stage.displayState = StageDisplayState.FULL_SCREEN;
			fullBtn.visible = false;
			normalBtn.visible = true;
		}

		/**
		 * 正常屏按钮事件响应
		 */
		private function noramlScreenHandler(e:MouseEvent = null):void{
			this.stage.displayState = StageDisplayState.NORMAL;
			fullBtn.visible = true;
			normalBtn.visible = false;
		}
		
		/**
		 * 全屏接口响应
		 */
		public function toFullScreen():void{
			//fullScreenHandler();
		}
		public function toNoramlScreen():void{
			noramlScreenHandler();
		}
		
		/**
		 * 播放按钮事件响应
		 */
		private function playHandler(e:MouseEvent):void{
			_player.play();
		}
		
		/**
		 * 暂停按钮事件响应
		 */
		private function pauseHandler(e:MouseEvent):void{
			_player.pause();
		}

		/**
		 * 停止按钮响应
		 */
		private function stopHandler(e:MouseEvent):void{
			_player.stop();
		}
		
		/**
		 * 播放时间重置
		 */
		private function playTimeReset():void{
			//playTime.text = "00:00:00/00:00:00";
		}
		
		/**
		 * 清晰度设置按钮事件响应
		 */
		private function clarityHandler(e:MouseEvent):void{
			dispatchEvent(new Event(SHOW_CLARITY_SETTING));
		}
		
		/**
		 * 各按钮的功能信息提示泡显示事件响应
		 */
		
		private function seekHandler(e:Event):void{
			/**
			 * 当autoStart参数为false时，在直接执行seek操作后由于duration的值为NaN，
			 * 这将导致在皮肤层无法设置seekTime的值。为解决该问题已经在皮肤做处理，在此情况下
			 * 皮肤层直接将seekTime的值设置为seekPt，然后在这里再处理seekTime的值。
			 * 2013.9.16 jackzhang
			 */
			if(isNaN(_duration) || _duration == 0)
			{
				_player.seek(progressLine.seekPt);
			}else{
				_player.seek(progressLine.seekPt * _duration);
			}
			
			//MonsterDebugger.trace(this, "seekPt:" + progressLine.seekPt);
		}
		
		private function volumeHandler(e:Event):void{
			_player.setVolume(volumeLine.vol);
		}
		
	}
}
