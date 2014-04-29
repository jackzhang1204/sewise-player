/********************************************************************************
 * File        : VolumeLine.as
 * Description : 声音控制条
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 16, 2013 5:52:40 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.vspaas.controlbar {
	//import com.demonsters.debugger.MonsterDebugger;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import utils.Colorer;
	import skins.PlayerEvent;
	
	public class VolumeLine extends MovieClip {
		public static const SOUND_ON:String = "sound_on";
		public static const SOUND_OFF:String = "sound_off";
		
		public var volume:MovieClip;
		public var volumeBg:MovieClip;
		
		/**
		 * 当前音量值
		 */
		private var _volume:Number = 0.6;
		
		public function get vol():Number{
			return _volume;
		}
		
		public function VolumeLine() {
			volumeBg.buttonMode = true;
			volume.width = volumeBg.width * _volume;
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		public function setUiColor(color:uint):void
		{
			Colorer.SetRGB(volumeBg, color);
			Colorer.SetRGB(volume.bg, color);
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			volume.width = this.mouseX;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		private function mouseMoveHandler(e:MouseEvent):void
		{
			if(this.mouseX >=0 && this.mouseX <= volumeBg.width)
			{
				volume.width = this.mouseX;
				_volume = volume.width / volumeBg.width;
				this.dispatchEvent(new Event(PlayerEvent.VOLUME_CHANGE));
			}
		}
		private function mouseUpHandler(e:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			//////////////
			_volume = volume.width / volumeBg.width;
			this.dispatchEvent(new Event(PlayerEvent.VOLUME_CHANGE));
		}
		
	}
}
