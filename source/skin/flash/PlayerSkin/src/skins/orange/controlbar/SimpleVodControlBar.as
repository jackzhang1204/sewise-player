/********************************************************************************
 * File        : ControlBar.as
 * Description : 点播播放器控制条
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 10:33:47 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.orange.controlbar {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import fl.controls.List;
	import fl.data.DataProvider;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	import interfaces.player.IVodPlayerMediator;
	
	import skins.PlayerEvent;
	
	import utils.LanguageManager;
	import utils.Stringer;

	public class SimpleVodControlBar extends MovieClip {
		
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
		
		//声音控制条
		public var volumeLine:VolumeLine;
		
		//设置清晰度事件
		public static const SHOW_CLARITY_SETTING:String = "show_clarity_setting";
		
		public function SimpleVodControlBar() {
			_orange = this.parent as SimpleVodOrange;
			
			playBtn.visible = true;
			pauseBtn.visible = false;
			
			/**
			 * 增加字幕控制按钮
			 * 2013.12.6 jackzhang
			 */
			subtitlesBtnBtn = subtitlesBtn.btn as SimpleButton;
			subtitlesBtnList = subtitlesBtn.list as List;
			subtitlesBtnBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			subtitlesBtnBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			//2013.12.6////////
			
			playBtn.addEventListener(MouseEvent.CLICK, playHandler);
			playBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			playBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);

			pauseBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			pauseBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			pauseBtn.addEventListener(MouseEvent.CLICK, pauseHandler);

			stopBtn.addEventListener(MouseEvent.CLICK, stopHandler);
			stopBtn.addEventListener(MouseEvent.MOUSE_OVER, tipShowHandler);
			stopBtn.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);

			volumeLine.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			volumeLine.addEventListener(MouseEvent.MOUSE_MOVE, volumeTipHanlder);
			volumeLine.addEventListener(PlayerEvent.VOLUME_CHANGE, volumeHandler);

			progressLine.addEventListener(MouseEvent.MOUSE_OUT, tipHideHanlder);
			progressLine.addEventListener(MouseEvent.MOUSE_MOVE, timeTipHanlder);
			progressLine.addEventListener(PlayerEvent.SEEK, seekHandler);
		}

/**------------------------------ 本对象大小及显示设置方法 ---------------------------*/
		
		public function resize(w:Number,h:Number):void{
			_curW = w;
			_curH = h;
			
			controlBarBg.width = w;
			
			//2013.12.6 jackzhang/////////////
			this.y = h - this.controlBarBg.height;
			//this.y = h - this.height;
			
			volumeLine.x = w - volumeLine.width - 10;
			
			/**
			 * 增加字幕控制按钮
			 * 2013.12.6 jackzhang
			 */
			if(subtitlesBtn.visible)
			{
				subtitlesBtn.x = volumeLine.x - subtitlesBtn.btn.width - 10;
			}
			//2013.12.6 jackzhang/////////////
			
			show();
			progressLine.resize(w);
		}
		
		public function show():void{
			//2013.12.6 jackzhang/////////////
			var _showTween:Tween = new Tween(this, "y", Regular.easeOut, this.y, _orange.bg.height - this.controlBarBg.height, 0.5, true);
			//var _showTween:Tween = new Tween(this, "y", Regular.easeOut, this.y, _orange.bg.height - this.height, 0.5, true);
			_showTween.start();
		}
		
		public function hide():void{
			var _hideTween:Tween  = new Tween(this, "y", Regular.easeOut, this.y, _orange.bg.height, 1, true);
			_hideTween.start();
		}
		
/**------------------------------ 播放器视图代理调用的方法 ---------------------------*/
		
		public function setPlayer(p:IVodPlayerMediator):void{
			_player = p;
		}
		
		public function setDuration(d:Number):void{
			_duration = d;
		}
		
		public function started():void{
			playBtn.visible = false;
			pauseBtn.visible = true;
			
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
			progressLine.stopped();
			
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
			subtitlesBtnList.y = - subtitlesBtnList.height - 14;
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
		private var _orange:SimpleVodOrange;
		//当前应用宽度
		private var _curW:Number;
		//当前应用高度
		private var _curH:Number;
		//本视图进度代表的时间长度
		private var _duration:Number;
		
		
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
		 * 各按钮的功能信息提示泡显示事件响应
		 */
		private function tipShowHandler(e:MouseEvent):void{
			var btnY:Number = this.y + playBtn.y -_orange.tipBubble.height - 3;
			
			switch(e.target){
				case stopBtn:
					_orange.tipBubble.showInfo(stop_string, stopBtn.x + stopBtn.width/2, btnY, _orange.x, _curW);
					break;
				case pauseBtn:
					_orange.tipBubble.showInfo(pause_string, pauseBtn.x + pauseBtn.width/2, btnY, _orange.x, _curW);
					break;
				case playBtn:
					_orange.tipBubble.showInfo(play_string, playBtn.x + playBtn.width/2, btnY, _orange.x, _curW);
					break;
				
				/**
				 * 增加字幕控制按钮
				 * 2013.12.6 jackzhang
				 */
				case subtitlesBtnBtn:
					_orange.tipBubble.showInfo(subtitles_string, subtitlesBtn.x + subtitlesBtnBtn.width / 2, btnY, _orange.x, _curW);
					break;
				//2013.12.6 jackzhang/////////////
				
			}
		}
		
		/**
		 * 进度条时间提示泡事件响应
		 */
		private function timeTipHanlder(e:MouseEvent):void{
			var progressLineY:Number = this.y + progressLine.y -_orange.tipBubble.height - 2;
			
			var xTime:String = Stringer.secToString(_duration*(this.mouseX/_curW));
			
			_orange.tipBubble.showInfo(xTime, progressLine.mouseX, progressLineY, _orange.x, _curW);
		}
		
		/**
		 * 音量提示泡事件响应
		 */
		private function volumeTipHanlder(e:MouseEvent):void{
			var volumeLineY:Number = this.y + volumeLine.y -_orange.tipBubble.height - 2;
			_orange.tipBubble.showInfo(String(volumeLine.mouseX), progressLine.mouseX, volumeLineY, _orange.x, _curW);
		}
		
		/**
		 * 关闭提示泡事件响应
		 */
		private function tipHideHanlder(e:MouseEvent):void{
			_orange.tipBubble.visible = false;
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
		}

		private function volumeHandler(e:Event):void{
			_player.setVolume(volumeLine.vol);
		}
		
	}
}
