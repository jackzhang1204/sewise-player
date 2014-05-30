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
	import utils.Stringer;
	import skins.PlayerEvent;
	import interfaces.player.ILivePlayerMediator;
	import skins.orange.controlbar.LiveControlBar;
	import interfaces.skin.ILivePlayerSkin;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import skins.orange.TipBubble;
	import flash.system.Security;
	import skins.orange.BigIconContainer;
	import skins.orange.settings.ClarityWindow;
	import skins.orange.BufferProgress;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	import skins.orange.topbar.TopBar;
	import skins.orange.videocontainer.VideoContainer;
	import flash.net.NetStream;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import flash.external.ExternalInterface;
	
	import utils.LanguageManager;

	public class LiveOrange extends MovieClip implements ILivePlayerSkin {
		
		public var tipBubble:TipBubble;
		public var bigIcon:BigIconContainer;
		public var buffer:BufferProgress;
		public var controlBar:LiveControlBar;
		public var videoContainer:VideoContainer;
		public var topBar:TopBar;
		public var bg:MovieClip;
		
		public var logoBox:MovieClip;
		
		public function LiveOrange() {
			Security.allowDomain("*");
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.addEventListener(MouseEvent.MOUSE_MOVE, showBarHandler);
			
			bigIcon.addEventListener(PlayerEvent.PLAY, playHandler);
		}


/**------------------------------ 给播放调用的接口方法 ---------------------------*/

		public function set player(pm : ILivePlayerMediator) : void {
			_player = pm;
			controlBar.setPlayer(_player);
		}

		public function set stream(stream : NetStream) : void {
			videoContainer.setNetStream(stream);
		}

		public function set draggable(d:Boolean):void{
			_draggable = d;
		}
		
		public function set buffering(b:Boolean):void{
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


		public function set bufferProgress(p : Number) : void {
			buffer.setProgress(p);
		}

		public function playProgress() : void {
			if(!_player.playTime()) return;
			
			//设置播放时钟
			topBar.setClock(Stringer.dateToTimeStr(_player.playTime()));
			
			//设置所播放视频的开始时间与结束时间
			controlBar.totalTime = Stringer.dateToStrHMS(new Date(Math.ceil(_player.playTime().time/1000/_duration)*_duration*1000));
			controlBar.playedTime = Stringer.dateToStrHMS(new Date(Math.floor(_player.playTime().time/1000/_duration)*_duration*1000));
			
			//计算并设置播放进度
			var playPt:Number = (Math.floor(_player.playTime().time / 1000) % _duration) / _duration;
			controlBar.progressLine.setPlayProgress(playPt);
			
			//计算并设置下载进度
			var loadPt:Number;
			var playTimeRightHour:Number = Math.ceil(_player.playTime().time/1000/3600);
			var serverTimeLeftHour:Number = Math.floor(_player.liveTime().time/1000/3600);
			if(serverTimeLeftHour>=playTimeRightHour) loadPt = 1;
			else{
				loadPt = (Math.floor(_player.liveTime().time / 1000) % _duration) / _duration;
			}
			controlBar.progressLine.setLoadProgress(loadPt);
		}
		
		public function set loadSpeed(speed:Number):void{
			controlBar.setSpeed(Stringer.bandWidthStr(speed));
		}
		

		public function set duration(t : Number) : void {
			_duration = t;
			controlBar.setDuration(_duration);
		}

		public function initialClarity(levels : Array) : void {
			_clarityWindow.initialClarities(levels);
		}


		public function set programTitle(title : String) : void {
			topBar.setTitle(title);
		}
		
		public function set lang(lan : String) : void{
			LanguageManager.language = lan;
			controlBar.initLanguage();
			topBar.initLanguage();
			_clarityWindow.initLanguage();
			buffer.initLanguage();
			
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
			}
			controlBar.resize(bg.width, bg.height);
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
		
		/**
		 * 增加海报功能
		 * 2014.5.26 jackzhang
		 */
		public function set poster(url:String) : void
		{
			if(url != ""){
				videoContainer.loadPoster(url);
			}
		}
		//2014.5.26 jackzhang/////////////
		
		/**
		 * 设置默认音量值
		 * 2014.5.30 jackzhang
		 */
		public function set volume(value:Number) : void
		{
			if(value >= 0 && value <= 1){
				//重置音量UI状态
				
			}
		}
		//2014.5.30 jackzhang/////////////
		
		
/**------------------------------ 皮肤私有属性和方法 ---------------------------*/

		private var _player:ILivePlayerMediator;
		private var _hideBarTimer:Timer;
		private var _stopped:Boolean = true;
		private var _paused:Boolean = false;
		private var _duration:Number;
		private var _draggable:Boolean = true;
		private var _clarityWindow:ClarityWindow;
		
		private function addedToStage(e:Event):void{
			_clarityWindow = new ClarityWindow();
			_clarityWindow.addEventListener(PlayerEvent.CLARITY_CHANGE, clarityHandler);
			this.addChild(_clarityWindow);
			controlBar.addEventListener(LiveControlBar.SHOW_CLARITY_SETTING, clarityShowHandler);

			resizeHandler();
			this.stage.addEventListener(Event.RESIZE, resizeHandler);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
			
			_hideBarTimer = new Timer(3000);
			_hideBarTimer.addEventListener(TimerEvent.TIMER, hideBarHandler);
		}
		
		private function resizeHandler(e:Event=null):void{
			bg.width = this.stage.stageWidth;
			bg.height = this.stage.stageHeight;
			bigIcon.y = bg.height - controlBar.height - bigIcon.height - 10;
			
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
