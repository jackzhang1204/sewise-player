/********************************************************************************
 * File        : ControlBar.as
 * Description : 直播播放器皮肤控制条
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 10:33:47 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.white.controlbar {
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import interfaces.player.ILivePlayerMediator;
	
	import skins.PlayerEvent;
	
	import utils.LanguageManager;
	import utils.Stringer;

	public class LiveControlBar extends MovieClip {
		
		//控制条区背景
		public var controlBarBg:MovieClip;
		
		//播放进度条
		public var progressLine:LiveProgressLine;
		
		//暂停按钮
		public var pauseBtn:SimpleButton;
		
		//播放按钮
		public var playBtn:SimpleButton;
		
		//停止按钮
		public var liveBtn:SimpleButton;
		
		//播放时间
		public var playTime:TextField;
		
		//下载速度文本
		public var speedTf:TextField;
		
		//声音控制按钮
		public var soundCloseBtn:SimpleButton;

		//声音控制按钮
		public var soundOpenBtn:SimpleButton;
		
		//声音控制条
		public var volumeLine:VolumeLine;
		
		//清晰度按钮
		public var clarityBtn:SimpleButton;
		
		//全屏播放按钮
		public var fullBtn:SimpleButton;
		
		//正常屏幕按钮
		public var normalBtn:SimpleButton;
		
		//总时间字符串
		public var totalTime:String = "00:00:00";
		
		//设置清晰度事件
		public static const SHOW_CLARITY_SETTING:String = "show_clarity_setting";
		
		public function LiveControlBar() {
			//_white = this.parent as LiveWhite;
			_white = this.parent as MovieClip;
			
			playBtn.visible = true;
			pauseBtn.visible = false;
			normalBtn.visible = false;
			soundOpenBtn.visible = false;
			
			speedTf.visible = false;
			
			
			fullBtn.addEventListener(MouseEvent.CLICK, fullScreenHandler);
			fullBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			fullBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);

			normalBtn.addEventListener(MouseEvent.CLICK, noramlScreenHandler);
			normalBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			normalBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			
			playBtn.addEventListener(MouseEvent.CLICK, playHandler);
			playBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			playBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);

			pauseBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			pauseBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			pauseBtn.addEventListener(MouseEvent.CLICK, pauseHandler);

			liveBtn.addEventListener(MouseEvent.CLICK, liveHandler);
			liveBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			liveBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			
			soundCloseBtn.addEventListener(MouseEvent.CLICK, soundCloseHandler);
			soundCloseBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			soundCloseBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);

			soundOpenBtn.addEventListener(MouseEvent.CLICK, soundOpenHandler);
			soundOpenBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			soundOpenBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);

			volumeLine.addEventListener(VolumeLine.SOUND_OFF, soundOnHandler);
			volumeLine.addEventListener(VolumeLine.SOUND_ON, soundOffHandler);
			volumeLine.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			volumeLine.addEventListener(MouseEvent.MOUSE_MOVE, volumeTipHanlder);
			volumeLine.addEventListener(PlayerEvent.VOLUME_CHANGE, volumeHandler);
			
			//jack zhang fix////
			volumeLine.addEventListener(MouseEvent.MOUSE_OVER, volumeLineMouseOverHandler);
			volumeLine.addEventListener(MouseEvent.MOUSE_OUT, volumeLineMouseOutHandler);
			//jack zhang fix////

			clarityBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			clarityBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);

			progressLine.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			progressLine.addEventListener(MouseEvent.MOUSE_MOVE, timeTipHanlder);
			progressLine.addEventListener(PlayerEvent.SEEK, seekHandler);
		}

/**------------------------------ 本对象大小及显示设置方法 ---------------------------*/
		
		public function resize(w:Number,h:Number):void{
			_curW = w;
			_curH = h;
			controlBarBg.width = w;
			
			//jack zhang fix////
			//this.y = h - this.height;
			this.y = h - this.controlBarBg.height;
			fullBtn.x = w - fullBtn.width;
			normalBtn.x = fullBtn.x;
			if(clarityBtn.visible)
			{
				clarityBtn.x = normalBtn.x - clarityBtn.width;
				soundCloseBtn.x = clarityBtn.x - soundCloseBtn.width;
				if(playTime.visible){
					progressLineW = w - 5 * fullBtn.width - playTime.width - 2 * 6;
				}else{
					progressLineW = w - 5 * fullBtn.width - 2 * 6;
				}
			}else{
				soundCloseBtn.x = normalBtn.x - soundCloseBtn.width;
				if(playTime.visible){
					progressLineW = w - 4 * fullBtn.width - playTime.width - 2 * 6;
				}else{
					progressLineW = w - 4 * fullBtn.width - 2 * 6;
				}
			}
			soundOpenBtn.x = soundCloseBtn.x;
			//volumeLine.x = soundCloseBtn.x + (soundCloseBtn.width - volumeLine.width)/2;
			volumeLine.x = soundCloseBtn.x + 6;
			if(playTime.visible){
				playTime.x = soundCloseBtn.x - playTime.width - 6;
			}
			//jack zhang fix////
			
			if(this.stage.displayState == StageDisplayState.FULL_SCREEN){
				fullBtn.visible = false;
				normalBtn.visible = true;
			}
			else{
				fullBtn.visible = true;
				normalBtn.visible = false;
			}
			show();
			
			//jack zhang fix////
			//progressLine.resize(w);
			//progressLineW = w - 5 * fullBtn.width - playTime.width - 2 * 6;
			progressLine.resize(progressLineW);
			//jack zhang fix////
		}
		private var progressLineW:Number;
		
		public function show():void{
			//jack zhang fix////
			//var _showTween:Tween = new Tween(this, "y", Regular.easeOut, this.y, _white.bg.height - this.height, 0.5, true);
			var _showTween:Tween = new Tween(this, "y", Regular.easeOut, this.y, _white.bg.height - this.controlBarBg.height, 0.3, true);
			_showTween.start();
		}
		
		public function hide():void{
			//jack zhang fix////
			//var _hideTween:Tween  = new Tween(this, "y", Regular.easeOut, this.y, _white.bg.height, 1, true);
			var _hideTween:Tween  = new Tween(this, "y", Regular.easeOut, this.y, _white.bg.height, 0.6, true);
			_hideTween.start();
		}
		
/**------------------------------ 播放器视图代理调用的方法 ---------------------------*/
		
		public function setPlayer(p:ILivePlayerMediator):void{
			_player = p;
		}
		
		public function setDuration(d:Number):void{
			_duration = d;
		}
		
		//播放时间字符串
		public function set playedTime(t:String):void{
			playTime.text = t + "/" + totalTime;
		}
		
		/**
		 * 设置下载速度显示
		 */
		public function setSpeed(speed:String):void{
			//speedTf.text = speed;
		}

		public function started():void{
			playBtn.visible = false;
			pauseBtn.visible = true;
			clarityBtn.enabled = true;
			//speedTf.visible = true;
			if(!clarityBtn.hasEventListener(MouseEvent.CLICK)) clarityBtn.addEventListener(MouseEvent.CLICK, clarityHandler);
		}
		
		public function stopped():void{
			playBtn.visible = true;
			pauseBtn.visible = false;
			//speedTf.visible = false;
			playTimeReset();
			progressLine.stopped();
			if(clarityBtn.hasEventListener(MouseEvent.CLICK)) clarityBtn.removeEventListener(MouseEvent.CLICK, clarityHandler);
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
		private var backToLive_string:String;
		
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
			backToLive_string = LanguageManager.getInstance().getString("backToLive");
		}
		
/**------------------------------ 私有属性及方法 ---------------------------*/

		//主播放器接口
		private var _player:ILivePlayerMediator;
		//顶级对象
		//private var _white:LiveWhite;
		private var _white:MovieClip;
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
			//无法通过JS接口执行FLASH全屏操作，这里改为提示。
			var btnY:Number = this.y + playBtn.y -_white.tipBubble.height - 3;
			_white.tipBubble.showInfo(fullScreen_string, fullBtn.x + fullBtn.width/2, btnY, _white.x, _curW);
			var myTimer:Timer = new Timer(2000, 1);
			myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			myTimer.start();
			function timerHandler(event:TimerEvent):void{
				_white.tipBubble.visible = false;
				myTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
				myTimer = null;
			}
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
		private function liveHandler(e:MouseEvent):void{
			_player.live();
		}
		
		/**
		 * 播放时间重置
		 */
		private function playTimeReset():void{
			playTime.text = "00:00:00/00:00:00";
		}
		
		/**
		 * 声音关闭按钮事件响应
		 */
		private function soundCloseHandler(e:MouseEvent):void{
			soundCloseBtn.visible = false;
			soundOpenBtn.visible = true;
			_player.setVolume(0);
			volumeLine.close();
		}
		
		/**
		 * 声音打开按钮事件响应
		 */
		private function soundOpenHandler(e:MouseEvent):void{
			soundCloseBtn.visible = true;
			soundOpenBtn.visible = false;
			volumeLine.recover();
		}
		
		/**
		 * volumeLine发出的声音打开事件响应
		 */
		private function soundOnHandler(e:Event):void{
			soundCloseBtn.visible = false;
			soundOpenBtn.visible = true;
		}
		
		/**
		 * volumeLine发出的声音关闭事件响应
		 */
		private function soundOffHandler(e:Event):void{
			soundCloseBtn.visible = true;
			soundOpenBtn.visible = false;
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
		//jack zhang fix////
		private var volumeLineTimer:Timer;
		private function volumeLineTimerStart()
		{
			if(volumeLineTimer != null)
			{
				volumeLineTimer.reset();
			}else{
				volumeLineTimer = new Timer(2000);
			}
			volumeLineTimer.start();
			volumeLineTimer.addEventListener(TimerEvent.TIMER, volumeLineTimerHandler);
		}
		private function volumeLineTimerClear():void
		{
			if(volumeLineTimer != null)
			{
				volumeLineTimer.reset();
				volumeLineTimer.removeEventListener(TimerEvent.TIMER, volumeLineTimerHandler);
				volumeLineTimer = null;
			}
		}
		private function volumeLineTimerHandler(e:TimerEvent):void
		{
			volumeLineTimer.removeEventListener(TimerEvent.TIMER, volumeLineTimerHandler);
			volumeLineTimer = null;
			var volumeLineHideTween:Tween = new Tween(volumeLine, "y", Regular.easeOut, volumeLine.y, volumeLine.height, 0.5, true);
			volumeLineHideTween.start();
		}
		private function volumeLineMouseOverHandler(e:MouseEvent):void
		{
			volumeLineTimerClear();
		}
		private function volumeLineMouseOutHandler(e:MouseEvent):void
		{
			volumeLineTimerStart();
		}
		//jack zhang fix////
		
		private function tipShowHandler(e:MouseEvent):void{
			var btnY:Number = this.y + playBtn.y -_white.tipBubble.height - 3;
			//jack zhang fix////
			var volumeLineShowTween:Tween;
			
			switch(e.target){
				case clarityBtn:
					_white.tipBubble.showInfo(clarity_string, clarityBtn.x + clarityBtn.width/2, btnY, _white.x, _curW);
					break;
				case soundOpenBtn:
					_white.tipBubble.showInfo(soundOn_string, soundOpenBtn.x + soundOpenBtn.width/2, btnY, _white.x, _curW);
					
					//jack zhang fix////
					volumeLineShowTween = new Tween(volumeLine, "y", Regular.easeOut, volumeLine.y, 0, 0.5, true);
					volumeLineShowTween.start();
					
					break;
				case soundCloseBtn:
					_white.tipBubble.showInfo(soundOff_string, soundCloseBtn.x + soundCloseBtn.width/2, btnY, _white.x, _curW);

					//jack zhang fix////
					volumeLineShowTween = new Tween(volumeLine, "y", Regular.easeOut, volumeLine.y, 0, 0.5, true);
					volumeLineShowTween.start();
					
					break;
				case liveBtn:
					_white.tipBubble.showInfo(backToLive_string, liveBtn.x + liveBtn.width/2, btnY, _white.x, _curW);
					break;
				case pauseBtn:
					_white.tipBubble.showInfo(pause_string, pauseBtn.x + pauseBtn.width/2, btnY, _white.x, _curW);
					break;
				case playBtn:
					_white.tipBubble.showInfo(play_string, playBtn.x + playBtn.width/2, btnY, _white.x, _curW);
					break;
				case normalBtn:
					_white.tipBubble.showInfo(normalScreen_string, normalBtn.x + normalBtn.width/2, btnY, _white.x, _curW);
					break;
				case fullBtn:
					_white.tipBubble.showInfo(fullScreen_string, fullBtn.x + fullBtn.width/2, btnY, _white.x, _curW);
					break;
			}
		}
		
		/**
		 * 进度条时间提示泡事件响应
		 */
		//jack zhang fix////
		private function timeTipHanlder(e:MouseEvent):void{
			if(!_player.playTime()) return;
			//进度条y轴坐标
			var progressLineY:Number = this.y + progressLine.y -_white.tipBubble.height - 2;

			//计算出直播的时间
			var mouseTime:Date = new Date(Math.floor(_player.playTime().time/1000/3600)*3600*1000 + _duration*(this.mouseX/_curW)*1000);
			//var xTime:String = Stringer.dateToStrHMS(mouseTime);
			var xTime:String = Stringer.secToString(_duration * (progressLine.mouseX / progressLineW));

			//显示该时间
			//_white.tipBubble.showInfo(xTime, progressLine.mouseX, progressLineY, _white.x, _curW);
			_white.tipBubble.showInfo(xTime, progressLine.mouseX + progressLine.x, progressLineY, _white.x, _curW);
		}
		
		/**
		 * 音量提示泡事件响应
		 */
		
		private function volumeTipHanlder(e:MouseEvent):void{
			var volumeLineY:Number = this.y + volumeLine.y -_white.tipBubble.height - 2;
			
			//_white.tipBubble.showInfo(String(volumeLine.mouseX), progressLine.mouseX, volumeLineY, _white.x, _curW);
			
			var value:Number = Math.round((volumeLine.mouseX - volumeLine.volumeDragger.x) / volumeLine.volumeDragger.width * 100);
			if(value >=0 && value <= 100)
			{
				//_white.tipBubble.showInfo(String(value), progressLine.mouseX, volumeLineY, _white.x, _curW);
				_white.tipBubble.showInfo(String(value), volumeLine.x + volumeLine.width / 2, volumeLineY - volumeLine.height, _white.x, _curW);
			}
		}
		
		
		/**
		 * 关闭提示泡事件响应
		 */
		private function tipHideHanlder(e:MouseEvent):void{
			_white.tipBubble.visible = false;
			
			if(e.target == soundOpenBtn || e.target == soundCloseBtn)
			{
				volumeLineTimerStart();
			}
		}

		private function seekHandler(e:Event):void{
			var seekTime:Date = new Date(Math.floor(_player.playTime().getTime()/1000/3600)*3600*1000 + progressLine.seekPt*_duration*1000);
			_player.seek(Stringer.dateTimeToStr14(seekTime));
		}

		private function volumeHandler(e:Event):void{
			_player.setVolume(volumeLine.vol);
		}
		
	}
}
