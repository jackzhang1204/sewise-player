/********************************************************************************
 * File        : Orange.as
 * Description : 橙色皮肤程序入口
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 6, 2013 6:01:24 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package  {
	//import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.NetStream;
	import flash.system.Security;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import interfaces.modules.IPlayerSkin;
	import interfaces.player.IVodPlayerMediator;
	import interfaces.skin.IVodPlayerSkin;
	
	import skins.PlayerEvent;
	import skins.orange.BigIconContainer;
	import skins.orange.BufferProgress;
	import skins.orange.TipBubble;
	import skins.orange.controlbar.VodControlBar;
	import skins.orange.settings.ClarityWindow;
	import skins.orange.topbar.TopBar;
	import skins.orange.videocontainer.VideoContainer;
	
	import utils.LanguageManager;
	import utils.Stringer;
	
	public class VodOrange extends MovieClip implements IVodPlayerSkin, IPlayerSkin{
		
		public var tipBubble:TipBubble;
		public var bigIcon:BigIconContainer;
		public var buffer:BufferProgress;
		public var controlBar:VodControlBar;
		public var videoContainer:VideoContainer;
		public var topBar:TopBar;
		public var bg:MovieClip;
		
		public var logoBox:MovieClip;
		//2013.12.6 jackzhang/////////////
		public var adsBox:MovieClip;
		
		public function VodOrange() {
			Security.allowDomain("*");
			
			//MonsterDebugger.initialize(this);
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.addEventListener(MouseEvent.MOUSE_MOVE, showBarHandler);
			
			bigIcon.addEventListener(PlayerEvent.PLAY, playHandler);
		}
		
		public function set player(pm : IVodPlayerMediator) : void {
			_player = pm;
			controlBar.setPlayer(_player);
		}
		
		/**
		 * 增加字幕控制按钮
		 * 2013.12.6 jackzhang
		 */
		public function get ads():MovieClip
		{
			return adsBox;
		}
		public function get videoBox():MovieClip
		{
			return videoContainer as MovieClip;
		}
		public function set subtitlesLang(subtitlesLangArray:Array):void {
			//MonsterDebugger.trace(this, subtitlesLangArray);
			
			controlBar.setSubtitlesLang(subtitlesLangArray);
		}
		public function set subtitlesPlayer(path:String) : void
		{
			//MonsterDebugger.trace(this, "path:" + path);
			
			if(path == "")
			{
				controlBar.subtitlesBtn.visible = false;
				controlBar.resize(bg.width, bg.height);
			}
		}
		//2013.12.6 jackzhang/////////////
		
		public function set stream(stream : NetStream) : void {
			videoContainer.setNetStream(stream);
		}

/**------------------------------ 设置播放器各种状态的方法 ---------------------------*/

		public function set buffering(b:Boolean):void{
			if(_stopped) return;
			buffer.visible = b;
		}
		
		public function set seeking(b:Boolean):void{
			controlBar.progressLine.seeking(b);
		}

		public function started() : void {
			controlBar.started();
			videoContainer.started();
			bigIcon.playing();
			_hideBarTimer.start();
			_stopped = false;
			_paused = false;
		}

		public function stopped() : void {
			controlBar.stopped();
			videoContainer.stopped();
			bigIcon.stopped();
			_hideBarTimer.reset();
			controlBar.show();
			topBar.show();
			_stopped = true;
			_paused =false;
		}

		public function paused() : void {
			controlBar.paused();
			bigIcon.paused();
			_paused = true;
		}

/**------------------------------ 设置播放器各种进度的方法 ---------------------------*/

		public function set bufferProgress(p : Number) : void {
			buffer.setProgress(p);
		}

		public function set loadedProgress(p : Number) : void {
			controlBar.progressLine.setLoadProgress(p);
		}

/**------------------------------ 设置播放器某些数据的方法 ---------------------------*/
		
		public function set programTitle(title : String) : void {
			topBar.setTitle(title);
		}

		public function set duration(t : Number) : void {
			_duration = t;
			controlBar.setDuration(_duration);
			controlBar.totalTime = Stringer.secToString(t);
		}

		public function set playTime(t : Number) : void {
			_playTime = t;
			//var playPt:Number = _playTime / _duration;
			
			var playPt:Number;
			if(_duration == 0){
				playPt = 0;
				controlBar.progressLine.setPlayProgress(playPt);
			}else{
				playPt = _playTime / _duration;
			}
			
			if(playPt > _startPt) controlBar.progressLine.setPlayProgress(playPt);
			topBar.setClock(Stringer.dateToTimeStr(new Date()));

			//controlBar.playedTime = Stringer.secToString(_playTime);
			
			//2013.7.8 jack fix 解决对未下载部分视频时移时播放器当前播放时为0的问题//////
			if(_playTime < 1)
			{
				controlBar.playedTime = Stringer.secToString(_startTime);
			}else{
				controlBar.playedTime = Stringer.secToString(_playTime);
			}
			///////////////////////////////////////////////////////////
			
		}
		
		public function set lang(lan : String) : void{
			LanguageManager.language = lan;
			controlBar.initLanguage();
			topBar.initLanguage();
			_clarityWindow.initLanguage();
			buffer.initLanguage();
			
			//get current language//////////////
			//var jsOutput:String = "Current Language:" + LanguageManager.getInstance().getString("soundOn");
			//ExternalInterface.call("jsTrace", jsOutput);
		}
		public function set logo(url : String) : void
		{
			if(url != "")
			{
				logoBox.load(url);
			}else{
				this.removeChild(logoBox);
			}
			
			//get current language//////////////
			//var jsOutput:String = "logo url:" + url;
			//ExternalInterface.call("jsTrace", jsOutput);
		}
		public function set clarityButton(state : String) : void
		{
			//MonsterDebugger.trace(this, "clarityButton:" + state);
			
			if(state == "enable")
			{
				controlBar.clarityBtn.visible = true;
			}else{
				controlBar.clarityBtn.visible = false;
				controlBar.resize(bg.width, bg.height);
			}
		}
		public function set timeDisplay(state : String) : void
		{
			if(state == "enable")
			{
				controlBar.playTime.visible = true;
			}else{
				controlBar.playTime.visible = false;
				//controlBar.resize(bg.width, bg.height);
			}
		}
		public function set controlBarDisplay(state : String) : void
		{
			//MonsterDebugger.trace(this, "controlBarDisplay:" + state);
			
			if(state != "enable")
			{
				controlBar.visible = false;
			}
		}
		public function set topBarDisplay(state : String) : void
		{
			//MonsterDebugger.trace(this, "topBarDisplay:" + state);
			
			if(state != "enable")
			{
				topBar.visible = false;
			}
		}
		
		public function set startTime(t:Number):void{
			_startTime = t;
			//_startPt = _startTime / _duration;
			
			if(_duration == 0)
			{
				_startPt = 0;
			}else{
				_startPt = _startTime / _duration;
			}
			
			controlBar.progressLine.setStartPosition(_startPt);
		}
		
		public function set loadSpeed(speed:Number):void{
			controlBar.setSpeed(Stringer.dataSpeedStr(speed));
		}

		public function initialClarity(levels : Array) : void {
			_clarityWindow.initialClarities(levels);
		}


/**------------------------------ 私有属性和方法 ---------------------------*/

		private var _player:IVodPlayerMediator;
		private var _duration:Number;
		private var _startTime:Number;
		private var _playTime:Number;
		private var _startPt:Number;
		
		private var _hideBarTimer:Timer;
		
		private var _stopped:Boolean = true;
		private var _paused:Boolean = false;
		
		private var _clarityWindow:ClarityWindow;
		
		private function addedToStage(e:Event):void{
			//创建清晰度设置窗口
			_clarityWindow = new ClarityWindow();
			this.addChild(_clarityWindow);
			_clarityWindow.addEventListener(PlayerEvent.CLARITY_CHANGE, clarityHandler);
			
			//侦听打开清晰度设置窗口的通知
			controlBar.addEventListener(VodControlBar.SHOW_CLARITY_SETTING, clarityShowHandler);

			//设置皮肤侦听事件
			resizeHandler();
			this.stage.addEventListener(Event.RESIZE, resizeHandler);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
			
			//创建皮肤显示时钟
			_hideBarTimer = new Timer(3000);
			_hideBarTimer.addEventListener(TimerEvent.TIMER, hideBarHandler);
		}
		
		private function resizeHandler(e:Event=null):void{
			bg.width = this.stage.stageWidth;
			bg.height = this.stage.stageHeight;
			
			//2013.12.6 jackzhang/////////////
			bigIcon.y = bg.height - controlBar.controlBarBg.height - bigIcon.height - 10;
			//bigIcon.y = bg.height - controlBar.height - bigIcon.height - 10;
			
			controlBar.resize(bg.width,bg.height);
			videoContainer.resize(bg.width,bg.height);
			topBar.resize(bg.width);
			buffer.resize(bg.width,bg.height);
			_clarityWindow.resize(bg.width, bg.height);
			
			logoBox.resize(bg.width);
		}
		
		private function showBarHandler(e:MouseEvent):void{
			if(_hideBarTimer.running) _hideBarTimer.reset();
			_hideBarTimer.start();
			controlBar.show();
			topBar.show();
		}
		
		private function hideBarHandler(e:TimerEvent):void{
			_hideBarTimer.reset();
			if(_stopped) return;
			controlBar.hide();
			topBar.hide();
			_clarityWindow.visible = false;
		}
		
		private function clarityShowHandler(e:Event):void{
			_clarityWindow.visible = true;
		}
		
		private function clarityHandler(e:Event):void{
			_player.changeClarity(_clarityWindow.clarity);
		}
		
		private function keyHandler(e:KeyboardEvent):void{
			switch(e.keyCode){
				case Keyboard.SPACE:
					if(_stopped) return;
					if(_paused) _player.play();
					else _player.pause();
					break;
			}
		}
		
		private function playHandler(e:Event):void{
			_player.play();
		}

	}
}
