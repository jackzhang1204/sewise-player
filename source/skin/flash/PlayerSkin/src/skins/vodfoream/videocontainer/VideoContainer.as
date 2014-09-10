/********************************************************************************
 * File        : VideoContainer.as
 * Description : 视频区容器
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 14, 2013 9:58:04 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vodfoream.videocontainer {
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import utils.Resizer;
	
	import interfaces.player.IVodPlayerMediator;

	public class VideoContainer extends MovieClip {
		
		public var video:Video;
		public var videoMask:MovieClip;
		
		private var vSizeTimer:Timer;
		private var whObj:Object = {width:600,height:450};
		
		public function VideoContainer() {
			video.smoothing = true;
			
			//jack fix///
			video.visible = false;
			//jack fix///
			
			//视频开始播放时，调整视频大小的计时器，由于视频大小在视频播放开始的一段时间内所获得的值不固定，因此定义10秒钟不断设置
			vSizeTimer = new Timer(1000,10);
			vSizeTimer.addEventListener(TimerEvent.TIMER, vSizeHandler);
			vSizeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, vSizeCompleteHandler);

			this.doubleClickEnabled = true;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
		}
		private function doubleClickHandler(e:MouseEvent):void{
			if(this.stage.displayState == StageDisplayState.FULL_SCREEN)
			this.stage.displayState = StageDisplayState.NORMAL;
			else this.stage.displayState = StageDisplayState.FULL_SCREEN;
		}

		private function vSizeHandler(e:TimerEvent):void{
			if(video.videoWidth && video.videoHeight){
				Resizer.resizeInContainer(video, videoMask, {width:video.videoWidth,height:video.videoHeight});
				
				//jack fix///
				video.visible = true;
				//jack fix///
				
			}
		}
		
		private function vSizeCompleteHandler(e:TimerEvent):void{
			vSizeTimer.reset();
		}
		
		public function resize(w:Number,h:Number):void{
			videoMask.width = w;
			videoMask.height = h;
			if(video.videoWidth && video.videoHeight){
				whObj = {width:video.videoWidth,height:video.videoHeight};
			}
			Resizer.resizeInContainer(video, videoMask, whObj);
			
			/**
			 * 增加海报功能
			 * 2014.5.26 jackzhang
			 */
			Resizer.resizeInContainer(poster, videoMask, {width:poster.width, height:poster.height});
			//2014.5.26 jackzhang/////////////
		}
		
		public function setNetStream(stream:NetStream):void{
			video.attachNetStream(stream);
		}
		
		public function started():void{
			vSizeTimer.start();
			
			/**
			 * 增加海报功能
			 * 2014.5.26 jackzhang
			 */
			clearPoster();
			//2014.5.26 jackzhang/////////////
		}
		
		public function stopped():void{
			video.clear();
		}
		
		
		/**
		 * 增加海报功能
		 * 2014.5.26 jackzhang
		 */
		public var poster:MovieClip;
		private var loader:Loader;
		public function loadPoster(url:String):void{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler);
			loader.load(new URLRequest(url));
		}
		private function clearPoster():void
		{
			while(poster.numChildren)poster.removeChildAt(0);
			if(loader)loader.unload();
			loader = null;
		}
		private function loaderCompleteHandler(e:Event):void
		{
			if(loader){
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler);
				while(poster.numChildren)poster.removeChildAt(0);
				poster.addChild(loader);
				Resizer.resizeInContainer(poster, videoMask, {width:poster.width, height:poster.height});
			}
		}
		private function loaderErrorHandler(e:Event):void
		{
			//trace("error");
		}
		//2014.5.26 jackzhang/////////////
		
		
	}
}
