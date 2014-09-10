/********************************************************************************
 * File        : ControlBar.as
 * Description : 点播播放器控制条
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 10:33:47 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vodfoream.controlbar {
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
	import skins.vodfoream.settings.ClarityWindow;
	
	import utils.LanguageManager;
	import utils.Stringer;

	public class VodControlBar extends MovieClip {
		
		//控制条区背景
		public var controlBarBg:MovieClip;
		
		//播放进度条
		public var progressLine:ProgressLine;
		
		//暂停按钮
		public var pauseBtn:SimpleButton;
		
		//播放按钮
		public var playBtn:SimpleButton;
		
		//停止按钮
		public var stopBtn:SimpleButton;
		
		//播放时间
		public var playTime:TextField;
		
		//时间总长
		public var totalsTime:TextField;
		
		//下载速度文本
		public var speedTf:TextField;
		
		//声音控制按钮
		public var soundCloseBtn:SimpleButton;

		//声音控制按钮
		public var soundOpenBtn:SimpleButton;
		
		//声音控制条
		public var volumeLine:VolumeLine;
		
		//清晰度按钮
		public var clarityBtn:MovieClip;
		
		//全屏播放按钮
		public var fullBtn:SimpleButton;
		
		//正常屏幕按钮
		public var normalBtn:SimpleButton;
		
		//总时间字符串
		public var totalTime:String = "00:00:00";
		
		//设置清晰度事件
		public static const SHOW_CLARITY_SETTING:String = "show_clarity_setting";
		
		public var topBarDisplay:Boolean = true;
		
		public function VodControlBar() {
			//_vodfoream = this.parent as VodOrange;
			_vodfoream = this.parent as MovieClip;
			
			playBtn.visible = true;
			pauseBtn.visible = false;
			normalBtn.visible = false;
			soundOpenBtn.visible = false;
			
			speedTf.visible = false;
			
			stopBtn.visible = false;
			clarityBtn.buttonMode = true;
			clarityBtn.info.mouseEnabled = false;
			
			/**
			 * 增加字幕控制按钮
			 * 2013.12.6 jackzhang
			 */
			subtitlesBtnBtn = subtitlesBtn.btn as SimpleButton;
			subtitlesBtnList = subtitlesBtn.list as List;
			subtitlesBtnBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			subtitlesBtnBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			//2013.12.6////////
			
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

			stopBtn.addEventListener(MouseEvent.CLICK, stopHandler);
			stopBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			stopBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			
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
			/**
			 * 增加字幕控制按钮
			 * 2013.12.6 jackzhang
			 */
			var rightRefBtn:DisplayObject;
			var refBtnNum:uint;
			var btnSpacing:Number = 5;
			
			fullBtn.x = w - fullBtn.width - btnSpacing;
			normalBtn.x = fullBtn.x;
			if(subtitlesBtn.visible)
			{
				subtitlesBtn.x = fullBtn.x - subtitlesBtn.btn.width - btnSpacing;
				rightRefBtn = subtitlesBtn;
				refBtnNum = 4;
			}else{
				rightRefBtn = fullBtn;
				refBtnNum = 3;
			}
			//2013.12.6 jackzhang/////////////
			
			volumeLine.x =  rightRefBtn.x - volumeLine.width - btnSpacing;
			soundCloseBtn.x = volumeLine.x - soundCloseBtn.width - btnSpacing;
			soundOpenBtn.x = soundCloseBtn.x;
			
			if(playTime.visible){
				totalsTime.x = soundCloseBtn.x - totalsTime.width - btnSpacing;
				progressLineW = w - (playTime.width + btnSpacing) * 2 - (volumeLine.width + btnSpacing) - refBtnNum * (fullBtn.width  + btnSpacing) - 2 * btnSpacing;
			}else{
				totalsTime.visible = false;
				progressLine.x = playBtn.x + playBtn.width + btnSpacing;
				progressLineW = w - (volumeLine.width + btnSpacing) - refBtnNum * (fullBtn.width  + btnSpacing) - 2 * btnSpacing;
			}
			
			if(clarityBtn.visible){
				clarityBtn.x = w - clarityBtn.width + 10;
				if(topBarDisplay){
					clarityBtn.y = this.controlBarBg.height - h / 2 - clarityBtn.height / 2;
				}else{
					clarityBtn.y = this.controlBarBg.height - h - 5;
				}
			}
			
			progressLine.resize(progressLineW);
			
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
			
		}
		private var progressLineW:Number;
		
		public function show():void{
			//jack zhang fix////
			//var _showTween:Tween = new Tween(this, "y", Regular.easeOut, this.y, _vodfoream.bg.height - this.height, 0.5, true);
			
			//var _showTween:Tween = new Tween(this, "y", Regular.easeOut, this.y, _vodfoream.bg.height - this.controlBarBg.height, 0.3, true);
			var _showTween:Tween = new Tween(this, "alpha", Regular.easeOut, this.alpha, 1, 0.3, true);
			
			_showTween.start();
		}
		
		public function hide():void{
			//jack zhang fix////
			//var _hideTween:Tween  = new Tween(this, "y", Regular.easeOut, this.y, _vodfoream.bg.height, 1, true);
			
			//var _hideTween:Tween  = new Tween(this, "y", Regular.easeOut, this.y, _vodfoream.bg.height, 0.6, true);
			var _hideTween:Tween  = new Tween(this, "alpha", Regular.easeOut, this.alpha, 0, 0.6, true);
			_hideTween.start();
		}
		
/**------------------------------ 播放器视图代理调用的方法 ---------------------------*/
		
		public function setPlayer(p:IVodPlayerMediator):void{
			_player = p;
			//progressLine.setPlayer(p);
			//volumeLine.setPlayer(p);
		}
		
		public function setDuration(d:Number):void{
			_duration = d;
		}
		
		//播放时间字符串
		public function set playedTime(t:String):void{
			//playTime.text = t + "/" + totalTime;
			
			playTime.text = t;
		}
		
		public function set durations(t:String):void{
			totalsTime.text = t;
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
			//speedTf.visible = false;
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
			
			//jack 2014.6.9///////////////////
			this.stage.addEventListener("selected_radio_label_change", selectedRadioLabelChange);
		}
		
		//jack 2014.6.9///////////////////
		private function selectedRadioLabelChange(e:Event):void{
			//MonsterDebugger.trace(this, ClarityWindow.currentClarityName);
			
			clarityBtn.info.text = ClarityWindow.currentClarityName;
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
			subtitlesBtnList.y = - subtitlesBtnList.height;
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
		//private var _vodfoream:VodOrange;
		private var _vodfoream:MovieClip;
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
			var btnY:Number = this.y + playBtn.y -_vodfoream.tipBubble.height - 3;
			_vodfoream.tipBubble.showInfo(fullScreen_string, fullBtn.x + fullBtn.width/2, btnY, _vodfoream.x, _curW);
			var myTimer:Timer = new Timer(2000, 1);
			myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			myTimer.start();
			function timerHandler(event:TimerEvent):void{
				_vodfoream.tipBubble.visible = false;
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
		private function stopHandler(e:MouseEvent):void{
			_player.stop();
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
		
		private function tipShowHandler(e:MouseEvent):void{
			var btnY:Number = this.y + playBtn.y -_vodfoream.tipBubble.height - 3;
			//jack zhang fix////
			//var volumeLineShowTween:Tween;
			
			switch(e.target){
				case clarityBtn:
					_vodfoream.tipBubble.showInfo(clarity_string, clarityBtn.x + clarityBtn.width/2, btnY + clarityBtn.y, _vodfoream.x, _curW);
					break;
				case soundOpenBtn:
					_vodfoream.tipBubble.showInfo(soundOn_string, soundOpenBtn.x + soundOpenBtn.width/2, btnY, _vodfoream.x, _curW);
					
					//jack zhang fix////
					//volumeLineShowTween = new Tween(volumeLine, "y", Regular.easeOut, volumeLine.y, 0, 0.5, true);
					//volumeLineShowTween.start();
					
					break;
				case soundCloseBtn:
					_vodfoream.tipBubble.showInfo(soundOff_string, soundCloseBtn.x + soundCloseBtn.width/2, btnY, _vodfoream.x, _curW);
					
					//jack zhang fix////
					//volumeLineShowTween = new Tween(volumeLine, "y", Regular.easeOut, volumeLine.y, 0, 0.5, true);
					//volumeLineShowTween.start();
					
					
					break;
				case stopBtn:
					_vodfoream.tipBubble.showInfo(stop_string, stopBtn.x + stopBtn.width/2, btnY, _vodfoream.x, _curW);
					break;
				case pauseBtn:
					_vodfoream.tipBubble.showInfo(pause_string, pauseBtn.x + pauseBtn.width/2, btnY, _vodfoream.x, _curW);
					break;
				case playBtn:
					_vodfoream.tipBubble.showInfo(play_string, playBtn.x + playBtn.width/2, btnY, _vodfoream.x, _curW);
					break;
				case normalBtn:
					_vodfoream.tipBubble.showInfo(normalScreen_string, normalBtn.x + normalBtn.width/2, btnY, _vodfoream.x, _curW);
					break;
				case fullBtn:
					_vodfoream.tipBubble.showInfo(fullScreen_string, fullBtn.x + fullBtn.width/2, btnY, _vodfoream.x, _curW);
					break;
				
				/**
				 * 增加字幕控制按钮
				 * 2013.12.6 jackzhang
				 */
				case subtitlesBtnBtn:
					_vodfoream.tipBubble.showInfo(subtitles_string, subtitlesBtn.x + subtitlesBtnBtn.width / 2, btnY, _vodfoream.x, _curW);
					break;
				//2013.12.6 jackzhang/////////////
				
			}
		}
		
		/**
		 * 进度条时间提示泡事件响应
		 */
		//jack zhang fix////
		private function timeTipHanlder(e:MouseEvent):void{
			var progressLineY:Number = this.y + progressLine.y -_vodfoream.tipBubble.height - 2;
			
			//var xTime:String = Stringer.secToString(_duration*(this.mouseX/_curW));
			var xTime:String = Stringer.secToString(_duration * (progressLine.mouseX / progressLineW));
			
			//_vodfoream.tipBubble.showInfo(xTime, progressLine.mouseX, progressLineY, _vodfoream.x, _curW);
			_vodfoream.tipBubble.showInfo(xTime, progressLine.mouseX + progressLine.x, progressLineY, _vodfoream.x, _curW);
			
		}
		
		/**
		 * 音量提示泡事件响应
		 */
		private function volumeTipHanlder(e:MouseEvent):void{
			var value:Number = Math.round((volumeLine.mouseX - volumeLine.volumeDragger.x) / volumeLine.volumeDragger.width * 100);
			if(value >=0 && value <= 100)
			{
				var volumeLineY:Number = this.y + volumeLine.y -_vodfoream.tipBubble.height - 2;
				_vodfoream.tipBubble.showInfo(String(value), (volumeLine.x + volumeLine.mouseX), volumeLineY, _vodfoream.x, _curW);
			}
		}
		
		/**
		 * 关闭提示泡事件响应
		 */
		private function tipHideHanlder(e:MouseEvent):void{
			_vodfoream.tipBubble.visible = false;
			
			/*if(e.target == soundOpenBtn || e.target == soundCloseBtn)
			{
				volumeLineTimerStart();
			}*/
			
		}
		
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
