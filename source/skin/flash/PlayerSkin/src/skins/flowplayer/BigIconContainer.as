/********************************************************************************
 * File        : BigIconContainer.as
 * Description : 大控制按钮类
 --------------------------------------------------------------------------------
 * Author      : kevinlee
 * Date        : Apr 18, 2013 10:05:12 PM
 * Version     : 1.0
 * Copyright (c) 2013 the SEWISE inc. All rights reserved.
 ********************************************************************************/
package skins.flowplayer {
	import flash.events.Event;
	import skins.PlayerEvent;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;

	public class BigIconContainer extends MovieClip {
		
		public var bigPausePlayBtn:SimpleButton;
		public var bigPlayBtn:SimpleButton;
		
		public function BigIconContainer() {
			bigPausePlayBtn.visible = false;
			bigPausePlayBtn.addEventListener(MouseEvent.CLICK, bigPlayHandler);
			bigPlayBtn.addEventListener(MouseEvent.CLICK, bigPlayHandler);
		}
		
		public function playing():void{
			bigPausePlayBtn.visible = false;
			bigPlayBtn.visible = false;
		}
		
		public function stopped():void{
			bigPausePlayBtn.visible = false;
			bigPlayBtn.visible = true;
		}
		
		public function paused():void{
			bigPlayBtn.visible = false;
			bigPausePlayBtn.visible = true;
		}
		
		private function bigPlayHandler(e:MouseEvent):void{
			this.dispatchEvent(new Event(PlayerEvent.PLAY));
		}
		
		
	}
}
