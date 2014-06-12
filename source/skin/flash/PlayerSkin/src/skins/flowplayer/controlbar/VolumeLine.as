/********************************************************************************
 * File        : VolumeLine.as
 * Description : 声音控制条
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 16, 2013 5:52:40 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.flowplayer.controlbar {
	//import com.demonsters.debugger.MonsterDebugger;
	import skins.PlayerEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	//import interfaces.player.IPlayerMediator;
	import flash.display.MovieClip;

	public class VolumeLine extends MovieClip {
		
		public static const SOUND_ON:String = "sound_on";
		public static const SOUND_OFF:String = "sound_off";
		
		public var volumePoint:MovieClip;
		public var volume:MovieClip;
		public var volumeDragger:MovieClip;
		
		/**
		 * 当前音量值
		 */
		private var _volume:Number = 0.6;
		
		private var _dragTimer:Timer;
		
		public function get vol():Number{
			return _volume;
		}
		
		public function VolumeLine() {
			volumeDragger.buttonMode = true;
			volumeDragger.addEventListener(MouseEvent.CLICK, volumeClickHandler);
			volumeDragger.addEventListener(MouseEvent.MOUSE_OVER, tipHandler);
			volumeDragger.addEventListener(MouseEvent.MOUSE_OUT, tipHandler);
			volumeDragger.addEventListener(MouseEvent.MOUSE_MOVE, tipHandler);
			
			volumePoint.buttonMode = true;
			volumePoint.addEventListener(MouseEvent.MOUSE_DOWN, volumePointHandler);
			
			_dragTimer = new Timer(100);
			_dragTimer.addEventListener(TimerEvent.TIMER, dragTimerHandler);
			
			volumePoint.x = (volumeDragger.width - volumePoint.width) * _volume + volumeDragger.x;
			volume.width = volumePoint.x - volumeDragger.x + volumePoint.width / 2;
		}
		
		/**
		 * 恢复已经设置的默认值
		 */
		public function recover():void{
			this.dispatchEvent(new Event(PlayerEvent.VOLUME_CHANGE));
			//volumePoint.x = (volumeDragger.width - volumePoint.width) * _volume;
			//volume.width = volumePoint.x + volumePoint.width;
			
			volumePoint.x = (volumeDragger.width - volumePoint.width) * _volume + volumeDragger.x;
			volume.width = volumePoint.x - volumeDragger.x + volumePoint.width / 2;
		}
		
		public function close():void{
			//volumePoint.x = 0;
			volumePoint.x = volumeDragger.x;
			
			volume.width = volumePoint.width / 2;
		}
		
		private function volumeClickHandler(e:MouseEvent):void{
			_volume = volumeDragger.mouseX / volumeDragger.width;
			//volumePoint.x = (volumeDragger.width - volumePoint.width) * _volume;
			volumePoint.x = (volumeDragger.width - volumePoint.width) * _volume + volumeDragger.x;
			
			//volume.width = volumePoint.x + volumePoint.width;
			volume.width = volumePoint.x - volumeDragger.x + volumePoint.width / 2;
			
			this.dispatchEvent(new Event(PlayerEvent.VOLUME_CHANGE));
		}
		
		private function volumePointHandler(e:MouseEvent):void{
			this.stage.addEventListener(MouseEvent.MOUSE_UP, vpUpHandler);
			//volumePoint.startDrag(false,new Rectangle(0,0,volumeDragger.width-volumePoint.width,0));
			
			volumePoint.startDrag(false, new Rectangle(volumeDragger.x, volumePoint.y, volumeDragger.width - volumePoint.width, 0));
			_dragTimer.start();
		}
		
		private function vpUpHandler(e:MouseEvent):void{
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, vpUpHandler);
			//_volume = volumePoint.x / (volumeDragger.width - volumePoint.width);
			_volume = (volumePoint.x - volumeDragger.x) / (volumeDragger.width - volumePoint.width);
			
			volumePoint.stopDrag();
			
			_dragTimer.reset();
			
			this.dispatchEvent(new Event(PlayerEvent.VOLUME_CHANGE));
			
			if(_volume>0){
				dispatchEvent(new Event(SOUND_ON));
				return;
			}
			
			if(_volume==0) dispatchEvent(new Event(SOUND_OFF));
			
		}
		
		private function dragTimerHandler(e:TimerEvent):void{
			//volume.width = volumePoint.x + volumePoint.width;
			
			volume.width = volumePoint.x - volumeDragger.x + volumePoint.width / 2;
		}
		
		private function tipHandler(e:MouseEvent):void{
			this.dispatchEvent(e);
		}
		
	}
}
